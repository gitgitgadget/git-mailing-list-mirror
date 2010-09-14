From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH/RFC 04/20] gettextize: git-stash die + gettext messages
Date: Tue, 14 Sep 2010 13:52:04 +0000
Message-ID: <1284472340-7049-5-git-send-email-avarab@gmail.com>
References: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 14 15:53:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OvVwm-0004Ln-2f
	for gcvg-git-2@lo.gmane.org; Tue, 14 Sep 2010 15:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752860Ab0INNwy convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 14 Sep 2010 09:52:54 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:48443 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752816Ab0INNww (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Sep 2010 09:52:52 -0400
Received: by mail-ww0-f44.google.com with SMTP id 20so136386wwd.1
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 06:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=AN+G/Q+8wJXyVO/2yrptNBUzLBeYuDiUJ17p18oR7aw=;
        b=UOI4S2i1E4kKYG2I6FQ+wTUGqmn+1vLCrtbwQt9aeAV1LtYms+UXZr1uRLghsO50qy
         SfEQt4dD4wq2xYDQgP032y8aNUivjvdwdeTBOZ4DkarbZ22+VwvzJqlVO0NbpUpHBGT9
         40YIGx+ixlaPr3qF01kYER8Bd6DJVTcPJOerI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=jtsCuarQ6Vt96mNgJnWhuw8EvzmPkhgG0vHfVC+xpDfuB8yWppYwibu2Ox5VjspOco
         L2aCDKXa/j3pqxHwA5KMcJOQhpN0wL7R7H5yH0jH6J2DPVx8NR2bnc4f/KUELGJcC0hk
         /00IGOqXtH0CQih4lb64ccncWy8KkU7d2dwJo=
Received: by 10.227.129.84 with SMTP id n20mr44338wbs.61.1284472371861;
        Tue, 14 Sep 2010 06:52:51 -0700 (PDT)
Received: from v.nix.is (v.nix.is [109.74.193.250])
        by mx.google.com with ESMTPS id v11sm158854weq.16.2010.09.14.06.52.50
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 14 Sep 2010 06:52:50 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.rc1.234.g8dc15
In-Reply-To: <1284472340-7049-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156178>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index 78f392a..3a0f917 100755
--- a/git-stash.sh
+++ b/git-stash.sh
@@ -38,7 +38,7 @@ no_changes () {
 clear_stash () {
 	if test $# !=3D 0
 	then
-		die "git stash clear with parameters is unimplemented"
+		die "$(gettext "git stash clear with parameters is unimplemented")"
 	fi
 	if current=3D$(git rev-parse --verify $ref_stash 2>/dev/null)
 	then
@@ -60,7 +60,7 @@ create_stash () {
 	then
 		head=3D$(git rev-list --oneline -n 1 HEAD --)
 	else
-		die "You do not have the initial commit yet"
+		die "$(gettext "You do not have the initial commit yet")"
 	fi
=20
 	if branch=3D$(git symbolic-ref -q HEAD)
@@ -75,7 +75,7 @@ create_stash () {
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
 			rm -f "$TMP-index"
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
@@ -294,7 +294,7 @@ parse_flags_and_rev()
=20
 	case $# in
 		0)
-			have_stash || die "No stash found."
+			have_stash || die "$(gettext "No stash found.")"
 			set -- ${ref_stash}@{0}
 		;;
 		1)
@@ -354,11 +354,11 @@ apply_stash () {
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
@@ -366,9 +366,9 @@ apply_stash () {
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
@@ -394,7 +394,7 @@ apply_stash () {
 			git diff-index --cached --name-only --diff-filter=3DA $c_tree >"$a"=
 &&
 			git read-tree --reset $c_tree &&
 			git update-index --add --stdin <"$a" ||
-				die "Cannot unstage modified files"
+				die "$(gettext "Cannot unstage modified files")"
 			rm -f "$a"
 		fi
 		squelch=3D
@@ -432,7 +432,7 @@ drop_stash () {
 }
=20
 apply_to_branch () {
-	test -n "$1" || die 'No branch name specified'
+	test -n "$1" || die "$(gettext "No branch name specified")"
 	branch=3D$1
 	shift 1
=20
--=20
1.7.3.rc1.234.g8dc15
