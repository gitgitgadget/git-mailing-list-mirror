From: Romain Bignon <romain@peerfuse.org>
Subject: [PATCH] use -q instead of redirect to /dev/null for git update-index
Date: Sun, 21 Mar 2010 11:53:47 +0100
Message-ID: <1269168827-18694-1-git-send-email-romain@peerfuse.org>
Cc: gitster@pobox.com, Romain Bignon <romain@peerfuse.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 21 11:54:32 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtIng-0002WO-3S
	for gcvg-git-2@lo.gmane.org; Sun, 21 Mar 2010 11:54:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752665Ab0CUKyR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Mar 2010 06:54:17 -0400
Received: from smtp4-g21.free.fr ([212.27.42.4]:53876 "EHLO smtp4-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752152Ab0CUKyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Mar 2010 06:54:16 -0400
Received: from smtp4-g21.free.fr (localhost [127.0.0.1])
	by smtp4-g21.free.fr (Postfix) with ESMTP id 9B74A4C8128;
	Sun, 21 Mar 2010 11:54:09 +0100 (CET)
Received: from vuginas.vaginus.org (put92-1-81-57-125-104.fbx.proxad.net [81.57.125.104])
	by smtp4-g21.free.fr (Postfix) with ESMTP id B9F3B4C8174;
	Sun, 21 Mar 2010 11:54:06 +0100 (CET)
Received: from rom1 by vuginas.vaginus.org with local (Exim 4.71)
	(envelope-from <rom1@vuginas.vaginus.org>)
	id 1NtIn6-0004uo-73; Sun, 21 Mar 2010 11:53:56 +0100
X-Mailer: git-send-email 1.7.0.2.323.g0d092.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142816>

Signed-off-by: Romain Bignon <romain@peerfuse.org>
---
 fixup-builtins |    2 +-
 git-rebase.sh  |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fixup-builtins b/fixup-builtins
index 63dfa4c..172dbf6 100755
--- a/fixup-builtins
+++ b/fixup-builtins
@@ -12,5 +12,5 @@ done
 
 sed -i 's/git merge-one-file/git-merge-one-file/g
 s/git rebase-todo/git-rebase-todo/g' $(git ls-files '*.sh')
-git update-index --refresh >& /dev/null
+git update-index --refresh -q
 exit 0
diff --git a/git-rebase.sh b/git-rebase.sh
index fb4fef7..c814c30 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -389,7 +389,7 @@ else
 fi
 
 # The tree must be really really clean.
-if ! git update-index --ignore-submodules --refresh > /dev/null; then
+if ! git update-index --ignore-submodules --refresh -q; then
 	echo >&2 "cannot rebase: you have unstaged changes"
 	git diff-files --name-status -r --ignore-submodules -- >&2
 	exit 1
-- 
1.7.0
