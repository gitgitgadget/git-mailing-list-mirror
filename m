From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 2/2] git-rebase.txt: clarify that --abort checks out <branch>
Date: Fri,  1 Jul 2011 22:38:44 -0400
Message-ID: <1309574324-6833-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 02 04:39:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qcq6n-0007xT-Lx
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jul 2011 04:39:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753237Ab1GBCiy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jul 2011 22:38:54 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:58666 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753187Ab1GBCix (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2011 22:38:53 -0400
Received: by mail-vw0-f46.google.com with SMTP id 1so2729076vws.19
        for <git@vger.kernel.org>; Fri, 01 Jul 2011 19:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=6Ri51b3QoT9zw+8/KQbSvBB50ZeZYbwiBdUM/Rd4hOA=;
        b=uL1Hqy0lCugLgqNaEfde5opc40gnYnMKzgIm1aFREwRNpYNQ5QnY7cQhwJIJ2nex9A
         1kiTYpUEK6P4/NyXJTrSlnge+0h1Uz2AjfljpRcI7XoTfoPVuRwbKn8N+rsfJIQy8RsA
         E29kionrruZqJeQNsDt6dfb9S6oH+F9ixYch0=
Received: by 10.221.13.133 with SMTP id pm5mr1425390vcb.40.1309574332996;
        Fri, 01 Jul 2011 19:38:52 -0700 (PDT)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id x15sm735316vcs.32.2011.07.01.19.38.51
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 01 Jul 2011 19:38:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.6.51.g07e0e
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176544>

The description for 'git rebase --abort' currently says:

    Restore the original branch and abort the rebase operation.

The "restore" can be misinterpreted to imply that the original branch
was somehow in a broken state during the rebase operation. It is also
not completely clear what "the original branch" is --- is it the
branch that was checked out before the rebase operation was called or
is the the branch that is being rebased (it is the latter)? Although
both issues are made clear in the DESCRIPTION section, let us also
make the entry in the OPTIONS secion more clear, like so:

    Abort the rebase operation and check out <branch>.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---

This was basically suggested by Jonathan in [1] ('git rebase
--discard'/'git rebase --abort --stay' or whatever it should be
called). Since I have not had much time for Git lately, I thought I
would just post these two patches for now, in case it will take time
before I get a chance to move even the simple work in [1] forward.


 [1] http://thread.gmane.org/gmane.comp.version-control.git/174655/focus=174683



 Documentation/git-rebase.txt |    2 +-
 git-rebase.sh                |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
index a9e0e50..f103eca 100644
--- a/Documentation/git-rebase.txt
+++ b/Documentation/git-rebase.txt
@@ -232,7 +232,7 @@ leave out at most one of A and B, in which case it defaults to HEAD.
 	Restart the rebasing process after having resolved a merge conflict.
 
 --abort::
-	Restore the original branch and abort the rebase operation.
+	Abort the rebase operation and check out <branch>.
 
 --skip::
 	Restart the rebasing process by skipping the current patch.
diff --git a/git-rebase.sh b/git-rebase.sh
index d7855ea..de419ac 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -58,7 +58,7 @@ ignore-whitespace! passed to 'git apply'
 C=!                passed to 'git apply'
  Actions:
 continue!          continue rebasing process
-abort!             abort rebasing process and restore original branch
+abort!             abort rebasing process and check out <branch>
 skip!              skip current patch and continue rebasing process
 "
 . git-sh-setup
-- 
1.7.5.3.640.gd1066
