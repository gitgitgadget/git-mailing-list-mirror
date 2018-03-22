Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2C5231F404
	for <e@80x24.org>; Thu, 22 Mar 2018 16:57:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751819AbeCVQ5r (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 12:57:47 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:40243 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbeCVQ5o (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 12:57:44 -0400
Received: by mail-pf0-f195.google.com with SMTP id v66so1122924pfv.7
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 09:57:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ktEanhrCKDjH5r05rKz4b0VFmGLEMsrrjTt7D6FYcow=;
        b=Kk9Snd4xPJPqRY79aTxE0VGXUltUBjCgH9NGbgJ4Ocx+t6CtUICbxv/PTzaWKQMwMn
         bRHVaio0GYuhc5d2mPhOiIBoAB/Jq0sZ94DjLPwZzZaPKbibFMBdoydWMaDYKl+KZQHL
         3gBk3RsQfjWdcLpM3+23SSSt0qHteAy4R9ykZJOmgTc7zKZJoUrcSCfvuGvW8Dc4NuMX
         TMP5CjPJr9uFPGNLAFSK39ugid3Imvh4roXzvPWYJwbgXczYMpS5f5OB7JmoTaWfqjRG
         YnSaZK3DaLH6ctoJuyF0/Vx552lUiKxiOdufIEaezyskG6BVG1Vxnel9FMNDtkFFNTO+
         rCyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ktEanhrCKDjH5r05rKz4b0VFmGLEMsrrjTt7D6FYcow=;
        b=MXGeu2Q5jNckd8HPlJBP0g2n4VV4lAuoViSLZPKM0R6rNuehE2vcBvp+RFxaoEDnoN
         mc10taoXLW0ml1TQf2iW5qVW5fsF7obmF67J6W93EMaGwZoCcUCjqeLd3svluIWgqfyS
         QwQVAug9gHwLAyK403CbiYh9UV9nKUv4Oqh4rQTlYGDT+W2NmPkY0YKXzfayFb21TLH5
         cdel/kScKVOr992mYrcI1uJIlY1Qu7syPoPl9t6nxZ/4I2LACK0HJjBzav94HGcZmilH
         XaC2igqUciqiQDDStmf7/R48bbaAuMilPDR9GQnSoEzBLsqrftrHujq5lJS30lxmoHFe
         S9Zw==
X-Gm-Message-State: AElRT7HYZ8wKiAiyJ7ZFo4y1d/DI8lHYfb921zPxZaj8O+XIemQqN+ZU
        tly2nNQt+vi2NNdes3nkQlrAFJ/eT44=
X-Google-Smtp-Source: AG47ELsxWOBBxdfX/E7+Wd4MwOYe8tQgnINkV1VUkX9AYZF39V0qtUCzjxvkHlGnC7w6+2UZdoHPwg==
X-Received: by 10.101.76.10 with SMTP id u10mr6326391pgq.445.1521737862506;
        Thu, 22 Mar 2018 09:57:42 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id 2sm15043830pfo.70.2018.03.22.09.57.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Mar 2018 09:57:41 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de, gitster@pobox.com
Subject: [RFC PATCH v3 3/9] Indent function git_rebase__interactive
Date:   Thu, 22 Mar 2018 09:57:23 -0700
Message-Id: <34f2b9350324772dcce9cead650188601a35ac15.1521690197.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521690197.git.wink@saville.com>
References: <cover.1521690197.git.wink@saville.com>
In-Reply-To: <cover.1521690197.git.wink@saville.com>
References: <cover.1521690197.git.wink@saville.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Wink Saville <wink@saville.com>
---
 git-rebase--interactive.sh | 432 ++++++++++++++++++++++-----------------------
 1 file changed, 215 insertions(+), 217 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index 213d75f43..a79330f45 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -741,27 +741,26 @@ get_missing_commit_check_level () {
 }
 
 git_rebase__interactive () {
-
-case "$action" in
-continue)
-	if test ! -d "$rewritten"
-	then
-		exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
-			--continue
-	fi
-	# do we have anything to commit?
-	if git diff-index --cached --quiet HEAD --
-	then
-		# Nothing to commit -- skip this commit
-
-		test ! -f "$GIT_DIR"/CHERRY_PICK_HEAD ||
-		rm "$GIT_DIR"/CHERRY_PICK_HEAD ||
-		die "$(gettext "Could not remove CHERRY_PICK_HEAD")"
-	else
-		if ! test -f "$author_script"
+	case "$action" in
+	continue)
+		if test ! -d "$rewritten"
 		then
-			gpg_sign_opt_quoted=${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")}
-			die "$(eval_gettext "\
+			exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
+				--continue
+		fi
+		# do we have anything to commit?
+		if git diff-index --cached --quiet HEAD --
+		then
+			# Nothing to commit -- skip this commit
+
+			test ! -f "$GIT_DIR"/CHERRY_PICK_HEAD ||
+			rm "$GIT_DIR"/CHERRY_PICK_HEAD ||
+			die "$(gettext "Could not remove CHERRY_PICK_HEAD")"
+		else
+			if ! test -f "$author_script"
+			then
+				gpg_sign_opt_quoted=${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")}
+				die "$(eval_gettext "\
 You have staged changes in your working tree.
 If these changes are meant to be
 squashed into the previous commit, run:
@@ -776,197 +775,197 @@ In both cases, once you're done, continue with:
 
   git rebase --continue
 ")"
-		fi
-		. "$author_script" ||
-			die "$(gettext "Error trying to find the author identity to amend commit")"
-		if test -f "$amend"
-		then
-			current_head=$(git rev-parse --verify HEAD)
-			test "$current_head" = $(cat "$amend") ||
-			die "$(gettext "\
+			fi
+			. "$author_script" ||
+				die "$(gettext "Error trying to find the author identity to amend commit")"
+			if test -f "$amend"
+			then
+				current_head=$(git rev-parse --verify HEAD)
+				test "$current_head" = $(cat "$amend") ||
+				die "$(gettext "\
 You have uncommitted changes in your working tree. Please commit them
 first and then run 'git rebase --continue' again.")"
-			do_with_author git commit --amend --no-verify -F "$msg" -e \
-				${gpg_sign_opt:+"$gpg_sign_opt"} $allow_empty_message ||
-				die "$(gettext "Could not commit staged changes.")"
-		else
-			do_with_author git commit --no-verify -F "$msg" -e \
-				${gpg_sign_opt:+"$gpg_sign_opt"} $allow_empty_message ||
-				die "$(gettext "Could not commit staged changes.")"
+				do_with_author git commit --amend --no-verify -F "$msg" -e \
+					${gpg_sign_opt:+"$gpg_sign_opt"} $allow_empty_message ||
+					die "$(gettext "Could not commit staged changes.")"
+			else
+				do_with_author git commit --no-verify -F "$msg" -e \
+					${gpg_sign_opt:+"$gpg_sign_opt"} $allow_empty_message ||
+					die "$(gettext "Could not commit staged changes.")"
+			fi
 		fi
-	fi
 
-	if test -r "$state_dir"/stopped-sha
-	then
-		record_in_rewritten "$(cat "$state_dir"/stopped-sha)"
-	fi
+		if test -r "$state_dir"/stopped-sha
+		then
+			record_in_rewritten "$(cat "$state_dir"/stopped-sha)"
+		fi
 
-	require_clean_work_tree "rebase"
-	do_rest
-	return 0
-	;;
-skip)
-	git rerere clear
+		require_clean_work_tree "rebase"
+		do_rest
+		return 0
+		;;
+	skip)
+		git rerere clear
 
-	if test ! -d "$rewritten"
-	then
-		exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
-			--continue
-	fi
-	do_rest
-	return 0
-	;;
-edit-todo)
-	git stripspace --strip-comments <"$todo" >"$todo".new
-	mv -f "$todo".new "$todo"
-	collapse_todo_ids
-	append_todo_help
-	gettext "
+		if test ! -d "$rewritten"
+		then
+			exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
+				--continue
+		fi
+		do_rest
+		return 0
+		;;
+	edit-todo)
+		git stripspace --strip-comments <"$todo" >"$todo".new
+		mv -f "$todo".new "$todo"
+		collapse_todo_ids
+		append_todo_help
+		gettext "
 You are editing the todo file of an ongoing interactive rebase.
 To continue rebase after editing, run:
     git rebase --continue
 
 " | git stripspace --comment-lines >>"$todo"
 
-	git_sequence_editor "$todo" ||
-		die "$(gettext "Could not execute editor")"
-	expand_todo_ids
-
-	exit
-	;;
-show-current-patch)
-	exec git show REBASE_HEAD --
-	;;
-esac
-
-comment_for_reflog start
+		git_sequence_editor "$todo" ||
+			die "$(gettext "Could not execute editor")"
+		expand_todo_ids
 
-if test ! -z "$switch_to"
-then
-	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to"
-	output git checkout "$switch_to" -- ||
-		die "$(eval_gettext "Could not checkout \$switch_to")"
+		exit
+		;;
+	show-current-patch)
+		exec git show REBASE_HEAD --
+		;;
+	esac
 
 	comment_for_reflog start
-fi
-
-orig_head=$(git rev-parse --verify HEAD) || die "$(gettext "No HEAD?")"
-mkdir -p "$state_dir" || die "$(eval_gettext "Could not create temporary \$state_dir")"
-rm -f "$(git rev-parse --git-path REBASE_HEAD)"
 
-: > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"
-write_basic_state
-if test t = "$preserve_merges"
-then
-	if test -z "$rebase_root"
+	if test ! -z "$switch_to"
 	then
-		mkdir "$rewritten" &&
-		for c in $(git merge-base --all $orig_head $upstream)
-		do
-			echo $onto > "$rewritten"/$c ||
-				die "$(gettext "Could not init rewritten commits")"
-		done
-	else
-		mkdir "$rewritten" &&
-		echo $onto > "$rewritten"/root ||
-			die "$(gettext "Could not init rewritten commits")"
+		GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to"
+		output git checkout "$switch_to" -- ||
+			die "$(eval_gettext "Could not checkout \$switch_to")"
+
+		comment_for_reflog start
 	fi
-	# No cherry-pick because our first pass is to determine
-	# parents to rewrite and skipping dropped commits would
-	# prematurely end our probe
-	merges_option=
-else
-	merges_option="--no-merges --cherry-pick"
-fi
-
-shorthead=$(git rev-parse --short $orig_head)
-shortonto=$(git rev-parse --short $onto)
-if test -z "$rebase_root"
-	# this is now equivalent to ! -z "$upstream"
-then
-	shortupstream=$(git rev-parse --short $upstream)
-	revisions=$upstream...$orig_head
-	shortrevisions=$shortupstream..$shorthead
-else
-	revisions=$onto...$orig_head
-	shortrevisions=$shorthead
-fi
-if test t != "$preserve_merges"
-then
-	git rebase--helper --make-script ${keep_empty:+--keep-empty} \
-		$revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
-	die "$(gettext "Could not generate todo list")"
-else
-	format=$(git config --get rebase.instructionFormat)
-	# the 'rev-list .. | sed' requires %m to parse; the instruction requires %H to parse
-	git rev-list $merges_option --format="%m%H ${format:-%s}" \
-		--reverse --left-right --topo-order \
-		$revisions ${restrict_revision+^$restrict_revision} | \
-		sed -n "s/^>//p" |
-	while read -r sha1 rest
-	do
 
-		if test -z "$keep_empty" && is_empty_commit $sha1 && ! is_merge_commit $sha1
-		then
-			comment_out="$comment_char "
-		else
-			comment_out=
-		fi
+	orig_head=$(git rev-parse --verify HEAD) || die "$(gettext "No HEAD?")"
+	mkdir -p "$state_dir" || die "$(eval_gettext "Could not create temporary \$state_dir")"
+	rm -f "$(git rev-parse --git-path REBASE_HEAD)"
 
+	: > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"
+	write_basic_state
+	if test t = "$preserve_merges"
+	then
 		if test -z "$rebase_root"
 		then
-			preserve=t
-			for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -s -f2-)
+			mkdir "$rewritten" &&
+			for c in $(git merge-base --all $orig_head $upstream)
 			do
-				if test -f "$rewritten"/$p
-				then
-					preserve=f
-				fi
+				echo $onto > "$rewritten"/$c ||
+					die "$(gettext "Could not init rewritten commits")"
 			done
 		else
-			preserve=f
-		fi
-		if test f = "$preserve"
-		then
-			touch "$rewritten"/$sha1
-			printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
-		fi
-	done
-fi
-
-# Watch for commits that been dropped by --cherry-pick
-if test t = "$preserve_merges"
-then
-	mkdir "$dropped"
-	# Save all non-cherry-picked changes
-	git rev-list $revisions --left-right --cherry-pick | \
-		sed -n "s/^>//p" > "$state_dir"/not-cherry-picks
-	# Now all commits and note which ones are missing in
-	# not-cherry-picks and hence being dropped
-	git rev-list $revisions |
-	while read rev
-	do
-		if test -f "$rewritten"/$rev &&
-		   ! sane_grep "$rev" "$state_dir"/not-cherry-picks >/dev/null
-		then
-			# Use -f2 because if rev-list is telling us this commit is
-			# not worthwhile, we don't want to track its multiple heads,
-			# just the history of its first-parent for others that will
-			# be rebasing on top of it
-			git rev-list --parents -1 $rev | cut -d' ' -s -f2 > "$dropped"/$rev
-			sha1=$(git rev-list -1 $rev)
-			sane_grep -v "^[a-z][a-z]* $sha1" <"$todo" > "${todo}2" ; mv "${todo}2" "$todo"
-			rm "$rewritten"/$rev
+			mkdir "$rewritten" &&
+			echo $onto > "$rewritten"/root ||
+				die "$(gettext "Could not init rewritten commits")"
 		fi
-	done
-fi
+		# No cherry-pick because our first pass is to determine
+		# parents to rewrite and skipping dropped commits would
+		# prematurely end our probe
+		merges_option=
+	else
+		merges_option="--no-merges --cherry-pick"
+	fi
+
+	shorthead=$(git rev-parse --short $orig_head)
+	shortonto=$(git rev-parse --short $onto)
+	if test -z "$rebase_root"
+		# this is now equivalent to ! -z "$upstream"
+	then
+		shortupstream=$(git rev-parse --short $upstream)
+		revisions=$upstream...$orig_head
+		shortrevisions=$shortupstream..$shorthead
+	else
+		revisions=$onto...$orig_head
+		shortrevisions=$shorthead
+	fi
+	if test t != "$preserve_merges"
+	then
+		git rebase--helper --make-script ${keep_empty:+--keep-empty} \
+			$revisions ${restrict_revision+^$restrict_revision} >"$todo" ||
+		die "$(gettext "Could not generate todo list")"
+	else
+		format=$(git config --get rebase.instructionFormat)
+		# the 'rev-list .. | sed' requires %m to parse; the instruction requires %H to parse
+		git rev-list $merges_option --format="%m%H ${format:-%s}" \
+			--reverse --left-right --topo-order \
+			$revisions ${restrict_revision+^$restrict_revision} | \
+			sed -n "s/^>//p" |
+		while read -r sha1 rest
+		do
+
+			if test -z "$keep_empty" && is_empty_commit $sha1 && ! is_merge_commit $sha1
+			then
+				comment_out="$comment_char "
+			else
+				comment_out=
+			fi
+
+			if test -z "$rebase_root"
+			then
+				preserve=t
+				for p in $(git rev-list --parents -1 $sha1 | cut -d' ' -s -f2-)
+				do
+					if test -f "$rewritten"/$p
+					then
+						preserve=f
+					fi
+				done
+			else
+				preserve=f
+			fi
+			if test f = "$preserve"
+			then
+				touch "$rewritten"/$sha1
+				printf '%s\n' "${comment_out}pick $sha1 $rest" >>"$todo"
+			fi
+		done
+	fi
+
+	# Watch for commits that been dropped by --cherry-pick
+	if test t = "$preserve_merges"
+	then
+		mkdir "$dropped"
+		# Save all non-cherry-picked changes
+		git rev-list $revisions --left-right --cherry-pick | \
+			sed -n "s/^>//p" > "$state_dir"/not-cherry-picks
+		# Now all commits and note which ones are missing in
+		# not-cherry-picks and hence being dropped
+		git rev-list $revisions |
+		while read rev
+		do
+			if test -f "$rewritten"/$rev &&
+			   ! sane_grep "$rev" "$state_dir"/not-cherry-picks >/dev/null
+			then
+				# Use -f2 because if rev-list is telling us this commit is
+				# not worthwhile, we don't want to track its multiple heads,
+				# just the history of its first-parent for others that will
+				# be rebasing on top of it
+				git rev-list --parents -1 $rev | cut -d' ' -s -f2 > "$dropped"/$rev
+				sha1=$(git rev-list -1 $rev)
+				sane_grep -v "^[a-z][a-z]* $sha1" <"$todo" > "${todo}2" ; mv "${todo}2" "$todo"
+				rm "$rewritten"/$rev
+			fi
+		done
+	fi
 
-test -s "$todo" || echo noop >> "$todo"
-test -z "$autosquash" || git rebase--helper --rearrange-squash || exit
-test -n "$cmd" && git rebase--helper --add-exec-commands "$cmd"
+	test -s "$todo" || echo noop >> "$todo"
+	test -z "$autosquash" || git rebase--helper --rearrange-squash || exit
+	test -n "$cmd" && git rebase--helper --add-exec-commands "$cmd"
 
-todocount=$(git stripspace --strip-comments <"$todo" | wc -l)
-todocount=${todocount##* }
+	todocount=$(git stripspace --strip-comments <"$todo" | wc -l)
+	todocount=${todocount##* }
 
 cat >>"$todo" <<EOF
 
@@ -975,48 +974,47 @@ $comment_char $(eval_ngettext \
 	"Rebase \$shortrevisions onto \$shortonto (\$todocount commands)" \
 	"$todocount")
 EOF
-append_todo_help
-gettext "
-However, if you remove everything, the rebase will be aborted.
-
-" | git stripspace --comment-lines >>"$todo"
+	append_todo_help
+	gettext "
+	However, if you remove everything, the rebase will be aborted.
 
-if test -z "$keep_empty"
-then
-	printf '%s\n' "$comment_char $(gettext "Note that empty commits are commented out")" >>"$todo"
-fi
+	" | git stripspace --comment-lines >>"$todo"
 
+	if test -z "$keep_empty"
+	then
+		printf '%s\n' "$comment_char $(gettext "Note that empty commits are commented out")" >>"$todo"
+	fi
 
-has_action "$todo" ||
-	return 2
 
-cp "$todo" "$todo".backup
-collapse_todo_ids
-git_sequence_editor "$todo" ||
-	die_abort "$(gettext "Could not execute editor")"
+	has_action "$todo" ||
+		return 2
 
-has_action "$todo" ||
-	return 2
+	cp "$todo" "$todo".backup
+	collapse_todo_ids
+	git_sequence_editor "$todo" ||
+		die_abort "$(gettext "Could not execute editor")"
 
-git rebase--helper --check-todo-list || {
-	ret=$?
-	checkout_onto
-	exit $ret
-}
+	has_action "$todo" ||
+		return 2
 
-expand_todo_ids
+	git rebase--helper --check-todo-list || {
+		ret=$?
+		checkout_onto
+		exit $ret
+	}
 
-test -d "$rewritten" || test -n "$force_rebase" ||
-onto="$(git rebase--helper --skip-unnecessary-picks)" ||
-die "Could not skip unnecessary pick commands"
+	expand_todo_ids
 
-checkout_onto
-if test -z "$rebase_root" && test ! -d "$rewritten"
-then
-	require_clean_work_tree "rebase"
-	exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
-		--continue
-fi
-do_rest
+	test -d "$rewritten" || test -n "$force_rebase" ||
+	onto="$(git rebase--helper --skip-unnecessary-picks)" ||
+	die "Could not skip unnecessary pick commands"
 
+	checkout_onto
+	if test -z "$rebase_root" && test ! -d "$rewritten"
+	then
+		require_clean_work_tree "rebase"
+		exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
+			--continue
+	fi
+	do_rest
 }
-- 
2.16.2

