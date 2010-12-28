From: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
Subject: [PATCH 08/31] rebase: align variable names
Date: Tue, 28 Dec 2010 10:30:25 +0100
Message-ID: <1293528648-21873-9-git-send-email-martin.von.zweigbergk@gmail.com>
References: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Dec 28 16:33:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PXbYh-0005Wr-Q1
	for gcvg-git-2@lo.gmane.org; Tue, 28 Dec 2010 16:33:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753855Ab0L1Pco (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Dec 2010 10:32:44 -0500
Received: from mail-qy0-f174.google.com ([209.85.216.174]:43383 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696Ab0L1Pch (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Dec 2010 10:32:37 -0500
Received: by mail-qy0-f174.google.com with SMTP id 19so11285887qyj.19
        for <git@vger.kernel.org>; Tue, 28 Dec 2010 07:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=9Q9cpidvteWcvJTwiRWNXoERoXUeN2A4PHF0RBiaNBI=;
        b=VAjlyr54FCOU7KP9Hi+zSUr3f73oY89WK6ja86EYIAQWXXr4KZ3sidcdOyRGx1GU/o
         hfoFDI5L/nnFsILjXVjDL+Uzma8J30P/wpeK4Ew/5Nl4t41AeKAuW58juz4sBbfJCuij
         lKWChdYdItY5H/DinC2y2mFEVY8TzpRdk9/44=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=GG/ZzblfwpAWLqM9DxrMgOtLGyVvIhuhX6f0KPPYRuAKF4Pf8ozxdcPg0xgXr9xGWt
         5RA5czQdHbkOQO5C1O8ccBF5VGLTYPIZIaVe3WIUXXtgcwBM+TZwwLdNRVUVyzRsk9Ea
         7PknL+FC7eebwawEv7hVHqdPmfoeXFmbZRYjs=
Received: by 10.224.74.77 with SMTP id t13mr12888951qaj.217.1293550357216;
        Tue, 28 Dec 2010 07:32:37 -0800 (PST)
Received: from localhost.localdomain (modemcable151.183-178-173.mc.videotron.ca [173.178.183.151])
        by mx.google.com with ESMTPS id s10sm6222962qco.35.2010.12.28.07.32.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Dec 2010 07:32:36 -0800 (PST)
X-Mailer: git-send-email 1.7.3.2.864.gbbb96
In-Reply-To: <1293528648-21873-1-git-send-email-martin.von.zweigbergk@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164247>

Use the same names for variables that git-rebase--interactive.sh will
soon inherit from git-rebase.sh.

Signed-off-by: Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
---
 git-rebase--interactive.sh |  138 ++++++++++++++++++++++----------------------
 git-rebase.sh              |    8 +-
 2 files changed, 73 insertions(+), 73 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 8cbdd3f..310d80e 100755
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -77,7 +77,7 @@ FIXUP_MSG="$DOTEST"/message-fixup
 
 # $REWRITTEN is the name of a directory containing files for each
 # commit that is reachable by at least one merge base of $HEAD and
-# $UPSTREAM. They are not necessarily rewritten, but their children
+# $upstream. They are not necessarily rewritten, but their children
 # might be.  This ensures that commits on merged, but otherwise
 # unrelated side branches are left alone. (Think "X" in the man page's
 # example.)
@@ -105,15 +105,15 @@ AMEND="$DOTEST"/amend
 REWRITTEN_LIST="$DOTEST"/rewritten-list
 REWRITTEN_PENDING="$DOTEST"/rewritten-pending
 
-PRESERVE_MERGES=
-STRATEGY=
-ONTO=
-VERBOSE=
+preserve_merges=
+strategy=
+onto=
+verbose=
 OK_TO_SKIP_PRE_REBASE=
-REBASE_ROOT=
-AUTOSQUASH=
-test "$(git config --bool rebase.autosquash)" = "true" && AUTOSQUASH=t
-NEVER_FF=
+rebase_root=
+autosquash=
+test "$(git config --bool rebase.autosquash)" = "true" && autosquash=t
+force_rebase=
 
 GIT_CHERRY_PICK_HELP="\
 hint: after resolving the conflicts, mark the corrected paths
@@ -125,7 +125,7 @@ warn () {
 }
 
 output () {
-	case "$VERBOSE" in
+	case "$verbose" in
 	'')
 		output=$("$@" 2>&1 )
 		status=$?
@@ -177,7 +177,7 @@ mark_action_done () {
 	then
 		last_count=$count
 		printf "Rebasing (%d/%d)\r" $count $total
-		test -z "$VERBOSE" || echo
+		test -z "$verbose" || echo
 	fi
 }
 
@@ -228,11 +228,11 @@ do_with_author () {
 pick_one () {
 	ff=--ff
 	case "$1" in -n) sha1=$2; ff= ;; *) sha1=$1 ;; esac
-	case "$NEVER_FF" in '') ;; ?*) ff= ;; esac
+	case "$force_rebase" in '') ;; ?*) ff= ;; esac
 	output git rev-parse --verify $sha1 || die "Invalid commit name: $sha1"
 	test -d "$REWRITTEN" &&
 		pick_one_preserving_merges "$@" && return
-	if test -n "$REBASE_ROOT"
+	if test -n "$rebase_root"
 	then
 		output git cherry-pick "$@"
 		return
@@ -339,7 +339,7 @@ pick_one_preserving_merges () {
 			# No point in merging the first parent, that's HEAD
 			new_parents=${new_parents# $first_parent}
 			if ! do_with_author output \
-				git merge $STRATEGY -m "$msg" $new_parents
+				git merge $strategy -m "$msg" $new_parents
 			then
 				printf "%s\n" "$msg" > "$GIT_DIR"/MERGE_MSG
 				die_with_patch $sha1 "Error redoing merge $sha1"
@@ -618,11 +618,11 @@ skip_unnecessary_picks () {
 		# fd=3 means we skip the command
 		case "$fd,$command" in
 		3,pick|3,p)
-			# pick a commit whose parent is current $ONTO -> skip
+			# pick a commit whose parent is current $onto -> skip
 			sha1=${rest%% *}
 			case "$(git rev-parse --verify --quiet "$sha1"^)" in
-			"$ONTO"*)
-				ONTO=$sha1
+			"$onto"*)
+				onto=$sha1
 				;;
 			*)
 				fd=1
@@ -641,7 +641,7 @@ skip_unnecessary_picks () {
 	mv -f "$TODO".new "$TODO" &&
 	case "$(peek_next_command)" in
 	squash|s|fixup|f)
-		record_in_rewritten "$ONTO"
+		record_in_rewritten "$onto"
 		;;
 	esac ||
 	die "Could not skip unnecessary pick commands"
@@ -650,17 +650,17 @@ skip_unnecessary_picks () {
 # check if no other options are set
 is_standalone () {
 	test $# -eq 2 -a "$2" = '--' &&
-	test -z "$ONTO" &&
-	test -z "$PRESERVE_MERGES" &&
-	test -z "$STRATEGY" &&
-	test -z "$VERBOSE"
+	test -z "$onto" &&
+	test -z "$preserve_merges" &&
+	test -z "$strategy" &&
+	test -z "$verbose"
 }
 
 get_saved_options () {
-	test -d "$REWRITTEN" && PRESERVE_MERGES=t
-	test -f "$DOTEST"/strategy && STRATEGY="$(cat "$DOTEST"/strategy)"
-	test -f "$DOTEST"/verbose && VERBOSE=t
-	test -f "$DOTEST"/rebase-root && REBASE_ROOT=t
+	test -d "$REWRITTEN" && preserve_merges=t
+	test -f "$DOTEST"/strategy && strategy="$(cat "$DOTEST"/strategy)"
+	test -f "$DOTEST"/verbose && verbose=t
+	test -f "$DOTEST"/rebase-root && rebase_root=t
 }
 
 # Rearrange the todo list that has both "pick sha1 msg" and
@@ -827,11 +827,11 @@ first and then run 'git rebase --continue' again."
 	-s)
 		case "$#,$1" in
 		*,*=*)
-			STRATEGY="-s "$(expr "z$1" : 'z-[^=]*=\(.*\)') ;;
+			strategy="-s "$(expr "z$1" : 'z-[^=]*=\(.*\)') ;;
 		1,*)
 			usage ;;
 		*)
-			STRATEGY="-s $2"
+			strategy="-s $2"
 			shift ;;
 		esac
 		;;
@@ -839,29 +839,29 @@ first and then run 'git rebase --continue' again."
 		# we use merge anyway
 		;;
 	-v)
-		VERBOSE=t
+		verbose=t
 		;;
 	-p)
-		PRESERVE_MERGES=t
+		preserve_merges=t
 		;;
 	-i)
 		# yeah, we know
 		;;
 	--no-ff)
-		NEVER_FF=t
+		force_rebase=t
 		;;
 	--root)
-		REBASE_ROOT=t
+		rebase_root=t
 		;;
 	--autosquash)
-		AUTOSQUASH=t
+		autosquash=t
 		;;
 	--no-autosquash)
-		AUTOSQUASH=
+		autosquash=
 		;;
 	--onto)
 		shift
-		ONTO=$(parse_onto "$1") ||
+		onto=$(parse_onto "$1") ||
 			die "Does not point to a valid commit: $1"
 		;;
 	--)
@@ -872,27 +872,27 @@ first and then run 'git rebase --continue' again."
 	shift
 done
 
-test -z "$REBASE_ROOT" -a $# -ge 1 -a $# -le 2 ||
-test ! -z "$REBASE_ROOT" -a $# -le 1 || usage
+test -z "$rebase_root" -a $# -ge 1 -a $# -le 2 ||
+test ! -z "$rebase_root" -a $# -le 1 || usage
 test -d "$DOTEST" &&
 	die "Interactive rebase already started"
 
 git var GIT_COMMITTER_IDENT >/dev/null ||
 	die "You need to set your committer info first"
 
-if test -z "$REBASE_ROOT"
+if test -z "$rebase_root"
 then
-	UPSTREAM_ARG="$1"
-	UPSTREAM=$(git rev-parse --verify "$1") || die "Invalid base"
-	test -z "$ONTO" && ONTO=$UPSTREAM
+	upstream_arg="$1"
+	upstream=$(git rev-parse --verify "$1") || die "Invalid base"
+	test -z "$onto" && onto=$upstream
 	shift
 else
-	UPSTREAM=
-	UPSTREAM_ARG=--root
-	test -z "$ONTO" &&
-	die "You must specify --onto when using --root"
+	upstream=
+	upstream_arg=--root
+	test -z "$onto" &&
+		die "You must specify --onto when using --root"
 fi
-run_pre_rebase_hook "$UPSTREAM_ARG" "$@"
+run_pre_rebase_hook "$upstream_arg" "$@"
 
 comment_for_reflog start
 
@@ -912,49 +912,49 @@ git symbolic-ref HEAD > "$DOTEST"/head-name 2> /dev/null ||
 	echo "detached HEAD" > "$DOTEST"/head-name
 
 echo $HEAD > "$DOTEST"/head
-case "$REBASE_ROOT" in
+case "$rebase_root" in
 '')
 	rm -f "$DOTEST"/rebase-root ;;
 *)
 	: >"$DOTEST"/rebase-root ;;
 esac
-echo $ONTO > "$DOTEST"/onto
-test -z "$STRATEGY" || echo "$STRATEGY" > "$DOTEST"/strategy
-test t = "$VERBOSE" && : > "$DOTEST"/verbose
-if test t = "$PRESERVE_MERGES"
+echo $onto > "$DOTEST"/onto
+test -z "$strategy" || echo "$strategy" > "$DOTEST"/strategy
+test t = "$verbose" && : > "$DOTEST"/verbose
+if test t = "$preserve_merges"
 then
-	if test -z "$REBASE_ROOT"
+	if test -z "$rebase_root"
 	then
 		mkdir "$REWRITTEN" &&
-		for c in $(git merge-base --all $HEAD $UPSTREAM)
+		for c in $(git merge-base --all $HEAD $upstream)
 		do
-			echo $ONTO > "$REWRITTEN"/$c ||
+			echo $onto > "$REWRITTEN"/$c ||
 				die "Could not init rewritten commits"
 		done
 	else
 		mkdir "$REWRITTEN" &&
-		echo $ONTO > "$REWRITTEN"/root ||
+		echo $onto > "$REWRITTEN"/root ||
 			die "Could not init rewritten commits"
 	fi
 	# No cherry-pick because our first pass is to determine
 	# parents to rewrite and skipping dropped commits would
 	# prematurely end our probe
 	MERGES_OPTION=
-	first_after_upstream="$(git rev-list --reverse --first-parent $UPSTREAM..$HEAD | head -n 1)"
+	first_after_upstream="$(git rev-list --reverse --first-parent $upstream..$HEAD | head -n 1)"
 else
 	MERGES_OPTION="--no-merges --cherry-pick"
 fi
 
 SHORTHEAD=$(git rev-parse --short $HEAD)
-SHORTONTO=$(git rev-parse --short $ONTO)
-if test -z "$REBASE_ROOT"
-	# this is now equivalent to ! -z "$UPSTREAM"
+SHORTONTO=$(git rev-parse --short $onto)
+if test -z "$rebase_root"
+	# this is now equivalent to ! -z "$upstream"
 then
-	SHORTUPSTREAM=$(git rev-parse --short $UPSTREAM)
-	REVISIONS=$UPSTREAM...$HEAD
+	SHORTUPSTREAM=$(git rev-parse --short $upstream)
+	REVISIONS=$upstream...$HEAD
 	SHORTREVISIONS=$SHORTUPSTREAM..$SHORTHEAD
 else
-	REVISIONS=$ONTO...$HEAD
+	REVISIONS=$onto...$HEAD
 	SHORTREVISIONS=$SHORTHEAD
 fi
 git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
@@ -963,17 +963,17 @@ git rev-list $MERGES_OPTION --pretty=oneline --abbrev-commit \
 	sed -n "s/^>//p" |
 while read -r shortsha1 rest
 do
-	if test t != "$PRESERVE_MERGES"
+	if test t != "$preserve_merges"
 	then
 		printf '%s\n' "pick $shortsha1 $rest" >> "$TODO"
 	else
 		sha1=$(git rev-parse $shortsha1)
-		if test -z "$REBASE_ROOT"
+		if test -z "$rebase_root"
 		then
 			preserve=t
 			for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -s -f2-)
 			do
-				if test -f "$REWRITTEN"/$p -a \( $p != $ONTO -o $sha1 = $first_after_upstream \)
+				if test -f "$REWRITTEN"/$p -a \( $p != $onto -o $sha1 = $first_after_upstream \)
 				then
 					preserve=f
 				fi
@@ -990,7 +990,7 @@ do
 done
 
 # Watch for commits that been dropped by --cherry-pick
-if test t = "$PRESERVE_MERGES"
+if test t = "$preserve_merges"
 then
 	mkdir "$DROPPED"
 	# Save all non-cherry-picked changes
@@ -1016,7 +1016,7 @@ then
 fi
 
 test -s "$TODO" || echo noop >> "$TODO"
-test -n "$AUTOSQUASH" && rearrange_squash "$TODO"
+test -n "$autosquash" && rearrange_squash "$TODO"
 cat >> "$TODO" << EOF
 
 # Rebase $SHORTREVISIONS onto $SHORTONTO
@@ -1044,8 +1044,8 @@ git_editor "$TODO" ||
 has_action "$TODO" ||
 	die_abort "Nothing to do"
 
-test -d "$REWRITTEN" || test -n "$NEVER_FF" || skip_unnecessary_picks
+test -d "$REWRITTEN" || test -n "$force_rebase" || skip_unnecessary_picks
 
-output git checkout $ONTO || die_abort "could not detach HEAD"
+output git checkout $onto || die_abort "could not detach HEAD"
 git update-ref ORIG_HEAD $HEAD
 do_rest
diff --git a/git-rebase.sh b/git-rebase.sh
index 1cb0564..dc133e3 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -42,7 +42,7 @@ When you have resolved this problem run \"git rebase --continue\".
 If you would prefer to skip this patch, instead run \"git rebase --skip\".
 To restore the original branch and stop rebasing run \"git rebase --abort\".
 "
-unset newbase
+unset onto
 strategy=recursive
 strategy_opts=
 do_merge=
@@ -245,7 +245,7 @@ do
 		;;
 	--onto)
 		test 2 -le "$#" || usage
-		newbase="$2"
+		onto="$2"
 		shift
 		;;
 	-M|-m|--m|--me|--mer|--merg|--merge)
@@ -425,7 +425,7 @@ then
 	unset root_flag
 	upstream_arg="$upstream_name"
 else
-	test -z "$newbase" && die "--root must be used with --onto"
+	test -z "$onto" && die "--root must be used with --onto"
 	unset upstream_name
 	unset upstream
 	root_flag="--root"
@@ -433,7 +433,7 @@ else
 fi
 
 # Make sure the branch to rebase onto is valid.
-onto_name=${newbase-"$upstream_name"}
+onto_name=${onto-"$upstream_name"}
 case "$onto_name" in
 *...*)
 	if	left=${onto_name%...*} right=${onto_name#*...} &&
-- 
1.7.3.2.864.gbbb96
