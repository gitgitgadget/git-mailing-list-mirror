From: Brian Ewins <brian.ewins@gmail.com>
Subject: [PATCH] git-rebase -i: improve usage message
Date: Thu, 29 Oct 2009 00:02:29 +0000
Message-ID: <1256774549-8191-1-git-send-email-brian.ewins@gmail.com>
Cc: kusmabite@googlemail.com, Brian Ewins <brian.ewins@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 29 01:03:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3ITq-0001CG-CS
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 01:03:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756044AbZJ2ACo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 20:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755503AbZJ2ACo
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 20:02:44 -0400
Received: from mail-ew0-f208.google.com ([209.85.219.208]:42466 "EHLO
	mail-ew0-f208.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755441AbZJ2ACn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 20:02:43 -0400
Received: by ewy4 with SMTP id 4so1321764ewy.37
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 17:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=YyCp1kSElUjtQ6tYZ9lZ9HPOYDncCrqhZqWE8R9gz+k=;
        b=FYkYW5Z6y8cO0AtWq4VtjzhrXPH0bFbiwzuZ9u7AixZ7yv/LyiAw/2UeW92g0Wy5J6
         Ha7q0b4fbPUWZxUuwc6uIIQS9Jf/hT1PWNph6VYyY0tEmyW9i8B1JMTvDUaMmanPgxzB
         0FE/YDU7suzBGVRas7A/+e0MLJuQ+Wv4zpFvc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=xjf/mCtKvcdaOWkTGP/dElHyl6aZ25Bj5UoZWlutdCXd/ApC64OatxXmpYmZngM/D+
         Y8GeFF5KJ8eb9SoI6BCR0KlPyEYIlGQbPVnxJVXaZ1HjWd5rXEs5B/9SwH1bYweK4Ymu
         VOI8LRtDIF+Q6NJBDAZiD42o/BwtcyBAN7uAQ=
Received: by 10.210.4.23 with SMTP id 23mr1548063ebd.96.1256774567046;
        Wed, 28 Oct 2009 17:02:47 -0700 (PDT)
Received: from localhost (cpc1-broo1-0-0-cust121.renf.cable.ntl.com [86.0.196.122])
        by mx.google.com with ESMTPS id 10sm4250212eyz.3.2009.10.28.17.02.46
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 17:02:46 -0700 (PDT)
X-Mailer: git-send-email 1.6.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131540>

The usage message was confusing as it implied that interactive
mode was optional but the default. Change the message to more
appropriately report usage when the -i flag is supplied.
In addition, use the same division into 3 command formats as
the man page.

Signed-off-by: Brian Ewins <brian.ewins@gmail.com>
---
 git-rebase--interactive.sh |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index a1879e3..b988c30 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -12,22 +12,23 @@
 
 OPTIONS_KEEPDASHDASH=
 OPTIONS_SPEC="\
-git-rebase [-i] [options] [--] <upstream> [<branch>]
-git-rebase [-i] (--continue | --abort | --skip)
+git rebase -i [options] [--onto <newbase>] [--] <upstream> [<branch>]
+git rebase -i [options] --onto <newbase> --root [--] [<branch>]
+git rebase (--continue | --abort | --skip)
 --
  Available options are
 v,verbose          display a diffstat of what changed upstream
 onto=              rebase onto given branch instead of upstream
 p,preserve-merges  try to recreate merges instead of ignoring them
 s,strategy=        use the given merge strategy
-m,merge            always used (no-op)
-i,interactive      always used (no-op)
+i,interactive      interactively edit commits. Implies -m.
+m,merge            use merging strategies
+no-verify          override pre-rebase hook from stopping the operation
+root               rebase all reachable commmits up to the root(s)
  Actions:
 continue           continue rebasing process
 abort              abort rebasing process and restore original branch
 skip               skip current patch and continue rebasing process
-no-verify          override pre-rebase hook from stopping the operation
-root               rebase all reachable commmits up to the root(s)
 "
 
 . git-sh-setup
-- 
1.6.5
