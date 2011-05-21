From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH v2 32/48] i18n: git-stash die + gettext messages
Date: Sat, 21 May 2011 18:44:13 +0000
Message-ID: <1306003469-22939-33-git-send-email-avarab@gmail.com>
References: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 21 20:45:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNrBT-0000TI-Rv
	for gcvg-git-2@lo.gmane.org; Sat, 21 May 2011 20:45:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757019Ab1EUSpp convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 21 May 2011 14:45:45 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:42788 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756514Ab1EUSpd (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 May 2011 14:45:33 -0400
Received: by mail-ey0-f174.google.com with SMTP id 24so1444603eyx.19
        for <git@vger.kernel.org>; Sat, 21 May 2011 11:45:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=JBJqYKrsEDYkqzgjMBUVDnLyO0d5D+u463F0vbUPOfM=;
        b=vF9fh6tkitUEjFeMMdrdZAl26ZUZgPoTxIRBdP2bbcHRQFdkqeqfvBrEAulOrDCiej
         2ZA12GzAyCKQlEDP5+RohJh5yXhV+omq9t2jEsQJNBk4IczfXqOavDkFBziA8EKKUUId
         F7mDNdq7PJ6WLspGHO0t1nQCdBI7Htpu3aFFU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=qAMD54ios4iciEkSmx0ocms/RbckPYNoWHFZvdVjPZRSdywgSn7WzjVqRuxor+sM0D
         Q4QVfXoARmXKxxpkKH54f1262pYxzk8qcNG2fQNHyz5m31hvbrdKgMIHgKSELciVUmuY
         eERsOLsqO/uwErpI/Vq0LN7USmmPpQmXXEfWs=
Received: by 10.213.3.6 with SMTP id 6mr604316ebl.146.1306003532348;
        Sat, 21 May 2011 11:45:32 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id y14sm1130434eeh.3.2011.05.21.11.45.30
        (version=SSLv3 cipher=OTHER);
        Sat, 21 May 2011 11:45:31 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1
In-Reply-To: <1306003469-22939-1-git-send-email-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174133>

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
---
 git-stash.sh |   36 ++++++++++++++++++------------------
 1 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/git-stash.sh b/git-stash.sh
index c3ca7a1..5789215 100755
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
@@ -172,7 +172,7 @@ save_stash () {
 		exit 0
 	fi
 	test -f "$GIT_DIR/logs/$ref_stash" ||
-		clear_stash || die "Cannot initialize stash"
+		clear_stash || die "$(gettext "Cannot initialize stash")"
=20
 	create_stash "$stash_msg"
=20
@@ -180,7 +180,7 @@ save_stash () {
 	: >>"$GIT_DIR/logs/$ref_stash"
=20
 	git update-ref -m "$stash_msg" $ref_stash $w_commit ||
-		die "Cannot save the current status"
+		die "$(gettext "Cannot save the current status")"
 	say Saved working directory and index state "$stash_msg"
=20
 	if test -z "$patch_mode"
@@ -193,7 +193,7 @@ save_stash () {
 		fi
 	else
 		git apply -R < "$TMP-patch" ||
-		die "Cannot remove worktree changes"
+		die "$(gettext "Cannot remove worktree changes")"
=20
 		if test "$keep_index" !=3D "t"
 		then
@@ -288,7 +288,7 @@ parse_flags_and_rev()
=20
 	case $# in
 		0)
-			have_stash || die "No stash found."
+			have_stash || die "$(gettext "No stash found.")"
 			set -- ${ref_stash}@{0}
 		;;
 		1)
@@ -336,11 +336,11 @@ apply_stash () {
=20
 	assert_stash_like "$@"
=20
-	git update-index -q --refresh || die 'unable to refresh index'
+	git update-index -q --refresh || die "$(gettext "unable to refresh in=
dex")"
=20
 	# current index state
 	c_tree=3D$(git write-tree) ||
-		die 'Cannot apply a stash in the middle of a merge'
+		die "$(gettext "Cannot apply a stash in the middle of a merge")"
=20
 	unstashed_index_tree=3D
 	if test -n "$INDEX_OPTION" && test "$b_tree" !=3D "$i_tree" &&
@@ -348,9 +348,9 @@ apply_stash () {
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
@@ -376,7 +376,7 @@ apply_stash () {
 			git diff-index --cached --name-only --diff-filter=3DA $c_tree >"$a"=
 &&
 			git read-tree --reset $c_tree &&
 			git update-index --add --stdin <"$a" ||
-				die "Cannot unstage modified files"
+				die "$(gettext "Cannot unstage modified files")"
 			rm -f "$a"
 		fi
 		squelch=3D
@@ -417,7 +417,7 @@ drop_stash () {
 }
=20
 apply_to_branch () {
-	test -n "$1" || die 'No branch name specified'
+	test -n "$1" || die "$(gettext "No branch name specified")"
 	branch=3D$1
 	shift 1
=20
--=20
1.7.5.1
