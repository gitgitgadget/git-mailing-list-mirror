From: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH] Documentation for git-log --follow
Date: Thu, 12 Jul 2007 10:52:30 -0400
Message-ID: <20070712145230.GA21590@dervierte>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 12 16:52:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I9024-0008Cm-G1
	for gcvg-git@gmane.org; Thu, 12 Jul 2007 16:52:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755503AbXGLOwf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Jul 2007 10:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755087AbXGLOwf
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jul 2007 10:52:35 -0400
Received: from py-out-1112.google.com ([64.233.166.178]:54481 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754013AbXGLOwd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jul 2007 10:52:33 -0400
Received: by py-out-1112.google.com with SMTP id d32so323078pye
        for <git@vger.kernel.org>; Thu, 12 Jul 2007 07:52:33 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:subject:message-id:mime-version:content-type:content-disposition:user-agent:from;
        b=ulEZr+j5ET1FGSqmF+ZloYaW8ShKUJJoN4SLWFLifcJJSYRp2/Mv7fBp5jHEDo/iP6gLjQZa/on/JZxAzEyAl/uyIXp0QjhrakXVZ9dHFjbu/6DUxNq6wTib8ohVJ1fuskt2s2La3wQ5E9qBKOBWUBsaO/9G2dTXsj7Z6dAXSco=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:subject:message-id:mime-version:content-type:content-disposition:user-agent:from;
        b=a8mY0OwSkxee+YieptWb86KFX1K9/IRpGLnNzzG/UrMGQX5WAXURBkV8JM0SckB8tUTSSpmu1q3zMambWCSItH9dbsGEEsmLqMTcTYXCwdAZC8vB16x4FkiO3T0E5TjIH7/3y9futm3dxq4dbAFGUeDaUuuvOe2U5Ky5VjbTCUY=
Received: by 10.35.33.15 with SMTP id l15mr1196088pyj.1184251953019;
        Thu, 12 Jul 2007 07:52:33 -0700 (PDT)
Received: from dasbrennen.isa-geek.org ( [74.140.202.39])
        by mx.google.com with ESMTP id 24sm9808562nzn.2007.07.12.07.52.31
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 12 Jul 2007 07:52:31 -0700 (PDT)
Received: by dasbrennen.isa-geek.org (Postfix, from userid 1000)
	id 0EB91CD6DFD; Thu, 12 Jul 2007 10:52:30 -0400 (EDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52295>

After vainly searching the Documentation for how to follow renames, I
finally broke down and grepped the source.  It would appear that Linus
didn't add write and docs for this feature when he wrote it.  The
following patch rectifies that, hopefully sparing future users from
resorting to the source code.

Signed-off-by: Steven Walter <stevenrwalter@gmail.com>
---
 Documentation/git-log.txt |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 7adcdef..63c1dbe 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -61,6 +61,9 @@ include::pretty-options.txt[]
 	the specified paths; this means that "<paths>..." limits only
 	commits, and doesn't limit diff for those commits.
 
+--follow::
+	Continue listing the history of a file beyond renames.
+
 <paths>...::
 	Show only commits that affect the specified paths.
 
@@ -91,6 +94,12 @@ git log -r --name-status release..test::
 	in the "release" branch, along with the list of paths
 	each commit modifies.
 
+git log --follow builtin-rev-list.c::
+
+	Shows the commits that changed builtin-rev-list.c, including
+	those commits that occurred before the file was given its
+	present name.
+
 Discussion
 ----------
 
-- 
1.5.3.rc0
