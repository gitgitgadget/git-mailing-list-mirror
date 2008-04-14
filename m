From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH] git-gc --prune is deprecated
Date: Mon, 14 Apr 2008 16:17:31 +0400
Message-ID: <1208175451-30669-1-git-send-email-dpotapov@gmail.com>
Cc: Dmitry Potapov <dpotapov@gmail.com>
To: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 14 14:19:01 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlNdo-0008Ej-J0
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 14:18:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753285AbYDNMRk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 08:17:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753239AbYDNMRk
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 08:17:40 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:52876 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753179AbYDNMRj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 08:17:39 -0400
Received: by nf-out-0910.google.com with SMTP id g13so332327nfb.21
        for <git@vger.kernel.org>; Mon, 14 Apr 2008 05:17:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer;
        bh=qOEgSwQJWZfEjg8K/r76coNiecZguP88xFGoG2gL2Wo=;
        b=pnnfWw+PshCJK3SgF4OlbHjY7nmm2/g6ksai3TORNkqQpXt6dOVC0AxZnNVhCbNhwoHlbtbV4xFyOLO+kxOSNRZtge1i1WwvqlmqF8XlrCh1Kc3HWHhK+2UqETjtdhutef7HGRs0IR30f4GWnx8O7mKs5vasyqf+B4R7XlzLlFI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=JphEeLjpitd2HkqOzjIY/yMP1LOaadRJy9xdPAxdwdmBGw10CcCxdk+QymaFx0f0GYwLlf/Gnbi3HBYPit1usTWwdP6VVXn6WPPXAbRU5d9NA/V23Rvy8dLPexx8ZTyZLb6smJhEznNUCWpsI1TrHWOgQ8lLGec/QoxRhG0ON58=
Received: by 10.78.37.7 with SMTP id k7mr4230087huk.25.1208175457061;
        Mon, 14 Apr 2008 05:17:37 -0700 (PDT)
Received: from localhost ( [85.141.236.239])
        by mx.google.com with ESMTPS id g12sm9184725nfb.27.2008.04.14.05.17.34
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 14 Apr 2008 05:17:35 -0700 (PDT)
X-Mailer: git-send-email 1.5.5.21.g03e5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79501>

25ee9731c137d0a24b0f4879eb0b0cce9b77d5b0 made the '--prune' option
deprecated and removed its description from the git-gc man page. This
patch removes all references to this option from the rest of the Git
documentation.
---

References to a non-existing option in the user manual and especially
in Every Day Git, which is intended for beginners, is very confusing.

So, I believe it should be treated as a bug fix and included in maint.

I'll appreciate if someone with better knowledge of git-gc review my
correction.

Thanks,
Dmitry

 Documentation/everyday.txt    |    6 ++----
 Documentation/git-clone.txt   |   10 ++++++----
 Documentation/user-manual.txt |   17 +----------------
 3 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/Documentation/everyday.txt b/Documentation/everyday.txt
index fdbd15a..e598cdd 100644
--- a/Documentation/everyday.txt
+++ b/Documentation/everyday.txt
@@ -48,14 +48,12 @@ $ git gc <3>
 repository health reasonably well.
 <2> check how many loose objects there are and how much
 disk space is wasted by not repacking.
-<3> repacks the local repository and performs other housekeeping tasks. Running
-without `--prune` is a safe operation even while other ones are in progress.
+<3> repacks the local repository and performs other housekeeping tasks.
 
 Repack a small project into single pack.::
 +
 ------------
 $ git gc <1>
-$ git gc --prune
 ------------
 +
 <1> pack all the objects reachable from the refs into one pack,
@@ -182,7 +180,7 @@ $ git pull <3>
 $ git log -p ORIG_HEAD.. arch/i386 include/asm-i386 <4>
 $ git pull git://git.kernel.org/pub/.../jgarzik/libata-dev.git ALL <5>
 $ git reset --hard ORIG_HEAD <6>
-$ git gc --prune <7>
+$ git gc <7>
 $ git fetch --tags <8>
 ------------
 +
diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 9758243..c1bf814 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -65,10 +65,12 @@ OPTIONS
 +
 *NOTE*: this is a possibly dangerous operation; do *not* use
 it unless you understand what it does. If you clone your
-repository using this option, then delete branches in the
-source repository and then run linkgit:git-gc[1] using the
-'--prune' option in the source repository, it may remove
-objects which are referenced by the cloned repository.
+repository using this option and then delete a branch or use
+any other git command that makes any previous existing commit
+unreachable, then after some time linkgit:git-gc[1] may remove
+unreachable objects, and this will break the cloned repository.
+Because some git commands may run git-gc, it may happen at any
+time after gc.pruneExpire time since commits became unreachable.
 
 
 
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 565aeb9..86b91a5 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -1548,22 +1548,7 @@ dangling tree b24c2473f1fd3d91352a624795be026d64c8841f
 
 Dangling objects are not a problem.  At worst they may take up a little
 extra disk space.  They can sometimes provide a last-resort method for
-recovering lost work--see <<dangling-objects>> for details.  However, if
-you wish, you can remove them with linkgit:git-prune[1] or the `--prune`
-option to linkgit:git-gc[1]:
-
--------------------------------------------------
-$ git gc --prune
--------------------------------------------------
-
-This may be time-consuming.  Unlike most other git operations (including
-git-gc when run without any options), it is not safe to prune while
-other git operations are in progress in the same repository.
-
-If linkgit:git-fsck[1] complains about sha1 mismatches or missing
-objects, you may have a much more serious problem; your best option is
-probably restoring from backups.  See
-<<recovering-from-repository-corruption>> for a detailed discussion.
+recovering lost work--see <<dangling-objects>> for details.
 
 [[recovering-lost-changes]]
 Recovering lost changes
-- 
1.5.5.21.g03e5
