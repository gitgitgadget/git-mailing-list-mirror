From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 35/51] i18n: git-stash die + gettext messages
Date: Sun,  3 Apr 2011 16:45:59 +0000
Message-ID: <1301849175-1697-36-git-send-email-avarab@gmail.com>
References: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 03 18:48:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q6QTI-0005RJ-Q8
	for gcvg-git-2@lo.gmane.org; Sun, 03 Apr 2011 18:48:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753084Ab1DCQrH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 3 Apr 2011 12:47:07 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:45462 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753023Ab1DCQrF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Apr 2011 12:47:05 -0400
Received: by eyx24 with SMTP id 24so1503007eyx.19
        for <git@vger.kernel.org>; Sun, 03 Apr 2011 09:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=Fpm5VIA2R1V7UQyEN0CL3uk66hZDoiv3tIFd9W8OdPA=;
        b=wlIFxHuAcbH2z2ewLYhHC5Owh5S4GQduY8wzGKFN1HXD9FAC4dIj2tEeqZeihW1/bL
         WPdFOcSK9axfxaTF5REDLeuiOqWFbXdEB2e16Q2VSIDgIOFsXFDus731Yp84OwfkV3Q9
         47B68Aikrxbt6+Xong+Hblx7d+YSRzUy+/AM8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=kJ//ufwWECpHEoZDfhI6mrfA3zomdJXN+X2MKHFIAkq/2YMRWnf9t9GbAPj1C2d+bU
         OAZoi6cy+hBn531UPq+3LfM2ZtSU1CzJSqUK9vTFgIH9SksGA7ZJQThgWcON+dIgDoVT
         N/eYhVElDQI2hfX0pBZTVWT8CH2quDmB0pVho=
Received: by 10.213.25.79 with SMTP id y15mr3188046ebb.41.1301849223852;
        Sun, 03 Apr 2011 09:47:03 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id w59sm2750567eeh.24.2011.04.03.09.47.02
        (version=SSLv3 cipher=OTHER);
        Sun, 03 Apr 2011 09:47:03 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1301849175-1697-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170731>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 1fe8918..753ddf2 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -40,7 +40,7 @@ no_changes () {
 clear_stash () {
 	if test $# !=3D 0
 	then
-		die "git stash clear with parameters is unimplemented"
+		die "$(gettext "git stash clear with parameters is unimplemented")"
 	fi
 	if current=3D$(git rev-parse --verify $ref_stash 2>/dev/null)
 	then
@@ -62,7 +62,7 @@ create_stash () {
 	then
 		head=3D$(git rev-list --oneline -n 1 HEAD --)
 	else
-		die "You do not have the initial commit yet"
+		die "$(gettext "You do not have the initial commit yet")"
 	fi
=20
 	if branch=3D$(git symbolic-ref -q HEAD)
@@ -77,7 +77,7 @@ create_stash () {
 	i_tree=3D$(git write-tree) &&
 	i_commit=3D$(printf 'index on %s\n' "$msg" |
 		git commit-tree $i_tree -p $b_commit) ||
-		die "Cannot save the current index state"
+		die "$(gettext "Cannot save the current index state")"
=20
 	if test -z "$patch_mode"
 	then
@@ -91,7 +91,7 @@ create_stash () {
 			git write-tree &&
 			rm -f "$TMPindex"
 		) ) ||
-			die "Cannot save the current worktree state"
+			die "$(gettext "Cannot save the current worktree state")"
=20
 	else
=20
@@ -104,14 +104,14 @@ create_stash () {
=20
 		# state of the working tree
 		w_tree=3D$(GIT_INDEX_FILE=3D"$TMP-index" git write-tree) ||
-		die "Cannot save the current worktree state"
+		die "$(gettext "Cannot save the current worktree state")"
=20
 		git diff-tree -p HEAD $w_tree > "$TMP-patch" &&
 		test -s "$TMP-patch" ||
-		die "No changes selected"
+		die "$(gettext "No changes selected")"
=20
 		rm -f "$TMP-index" ||
-		die "Cannot remove temporary index (can't happen)"
+		die "$(gettext "Cannot remove temporary index (can't happen)")"
=20
 	fi
=20
@@ -124,7 +124,7 @@ create_stash () {
 	fi
 	w_commit=3D$(printf '%s\n' "$stash_msg" |
 		git commit-tree $w_tree -p $b_commit -p $i_commit) ||
-		die "Cannot record working tree state"
+		die "$(gettext "Cannot record working tree state")"
 }
=20
 save_stash () {
@@ -171,7 +171,7 @@ save_stash () {
 		exit 0
 	fi
 	test -f "$GIT_DIR/logs/$ref_stash" ||
-		clear_stash || die "Cannot initialize stash"
+		clear_stash || die "$(gettext "Cannot initialize stash")"
=20
 	create_stash "$stash_msg"
=20
@@ -179,7 +179,7 @@ save_stash () {
 	: >>"$GIT_DIR/logs/$ref_stash"
=20
 	git update-ref -m "$stash_msg" $ref_stash $w_commit ||
-		die "Cannot save the current status"
+		die "$(gettext "Cannot save the current status")"
 	say Saved working directory and index state "$stash_msg"
=20
 	if test -z "$patch_mode"
@@ -192,7 +192,7 @@ save_stash () {
 		fi
 	else
 		git apply -R < "$TMP-patch" ||
-		die "Cannot remove worktree changes"
+		die "$(gettext "Cannot remove worktree changes")"
=20
 		if test -z "$keep_index"
 		then
@@ -287,7 +287,7 @@ parse_flags_and_rev()
=20
 	case $# in
 		0)
-			have_stash || die "No stash found."
+			have_stash || die "$(gettext "No stash found.")"
 			set -- ${ref_stash}@{0}
 		;;
 		1)
@@ -347,11 +347,11 @@ apply_stash () {
=20
 	git update-index -q --refresh &&
 	git diff-files --quiet --ignore-submodules ||
-		die 'Cannot apply to a dirty working tree, please stage your changes=
'
+		die "$(gettext "Cannot apply to a dirty working tree, please stage y=
our changes")"
=20
 	# current index state
 	c_tree=3D$(git write-tree) ||
-		die 'Cannot apply a stash in the middle of a merge'
+		die "$(gettext "Cannot apply a stash in the middle of a merge")"
=20
 	unstashed_index_tree=3D
 	if test -n "$INDEX_OPTION" && test "$b_tree" !=3D "$i_tree" &&
@@ -359,9 +359,9 @@ apply_stash () {
 	then
 		git diff-tree --binary $s^2^..$s^2 | git apply --cached
 		test $? -ne 0 &&
-			die 'Conflicts in index. Try without --index.'
+			die "$(gettext "Conflicts in index. Try without --index.")"
 		unstashed_index_tree=3D$(git write-tree) ||
-			die 'Could not save index tree'
+			die "$(gettext "Could not save index tree")"
 		git reset
 	fi
=20
@@ -387,7 +387,7 @@ apply_stash () {
 			git diff-index --cached --name-only --diff-filter=3DA $c_tree >"$a"=
 &&
 			git read-tree --reset $c_tree &&
 			git update-index --add --stdin <"$a" ||
-				die "Cannot unstage modified files"
+				die "$(gettext "Cannot unstage modified files")"
 			rm -f "$a"
 		fi
 		squelch=3D
@@ -425,7 +425,7 @@ drop_stash () {
 }
=20
 apply_to_branch () {
-	test -n "$1" || die 'No branch name specified'
+	test -n "$1" || die "$(gettext "No branch name specified")"
 	branch=3D$1
 	shift 1
=20
--=20
1.7.4.1
