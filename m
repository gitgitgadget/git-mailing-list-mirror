From: Bryan Larsen <bryanlarsen@yahoo.com>
Subject: [PATCH] stgit: new --message does not work
Date: Wed, 13 Jul 2005 04:38:21 -0400
Message-ID: <20050713083816.18461.32180.sendpatchset@bryan-larsens-ibook-g4.local>
References: <20050713083805.18461.87079.sendpatchset@bryan-larsens-ibook-g4.local>
Cc: Bryan Larsen <bryanlarsen@yahoo.com>, git@vger.kernel.org,
	catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Wed Jul 13 10:38:41 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DsclA-0000kO-KW
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 10:38:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbVGMIiW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 04:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262599AbVGMIiW
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 04:38:22 -0400
Received: from smtp111.mail.sc5.yahoo.com ([66.163.170.9]:61524 "HELO
	smtp111.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S262598AbVGMIiV (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 04:38:21 -0400
Received: (qmail 76983 invoked from network); 13 Jul 2005 08:38:20 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:From:To:Cc:Message-Id:In-Reply-To:References:Subject;
  b=yyQ9eySWrAW4GRZ0IPtzBVP73xrWvQC0vvPhhSz+4VjDv/5ptxJMEiSycvV0rgaBs7hiAVb2qy+kajWho14IiqmMZogvBXvb3RfLkIHsfaZ5dyuHjn1l4Gu/qr0Xa9vVeU0oYYMhLY7IN4peQIRxYMr0l2kccTP6vwPxt/gGvjg=  ;
Received: from unknown (HELO bryan-larsens-ibook-g4.local) (bryanlarsen@69.159.204.165 with plain)
  by smtp111.mail.sc5.yahoo.com with SMTP; 13 Jul 2005 08:38:20 -0000
To: bryan.larsen@gmail.com
In-Reply-To: <20050713083805.18461.87079.sendpatchset@bryan-larsens-ibook-g4.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Stacked GIT: Using the --message option with the new command fails.  Fix it.

Signed-off-by: Bryan Larsen <bryan.larsen@gmail.com>
---

 stgit/stack.py |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -384,6 +384,8 @@ class Series:
             descr = edit_file(None, \
                               'Please enter the description for patch "%s" ' \
                               'above.' % name)
+	else:
+	    descr = message
 
         head = git.get_head()
 
