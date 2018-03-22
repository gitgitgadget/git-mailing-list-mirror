Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C55111F404
	for <e@80x24.org>; Thu, 22 Mar 2018 16:57:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751854AbeCVQ5x (ORCPT <rfc822;e@80x24.org>);
        Thu, 22 Mar 2018 12:57:53 -0400
Received: from mail-pg0-f68.google.com ([74.125.83.68]:45475 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751761AbeCVQ5s (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Mar 2018 12:57:48 -0400
Received: by mail-pg0-f68.google.com with SMTP id y63so360481pgy.12
        for <git@vger.kernel.org>; Thu, 22 Mar 2018 09:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=y1Dlm7ZuM5QFAjamaKjFkSNzbtewSE0RlPs7BgQChlk=;
        b=h6sNVTBpCMazKlrqYQKSS6f3QW8GhVvGHNzd82HMBPDks1hOEkP/QhaFAGNiLCG8Xr
         yutjLpm45JkQSKLLQ8dPBwvsXhkCNM6iRSg2MxUsxvi7BD4EkKMB+YcEX0YDjgjM4gTW
         6BGjkkw8WIVUF9OAyC9Qy6ENw8/7YsvOWsd7CS3sHoC7NzCCfpO2GRjSfAiXv4Go1s7y
         jOK0C9vRyzqwsydQSi1E0JUPKiQUek920IWO11ZtuShtfPvR5h0rrfWstbfa2jVEkcxH
         YGcwUKWvnJUqd8cChFch36BoAjLrHI+6FPQLVLjqDzTJpbvHBGVy4o1cnsp4aigveWas
         Sjhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=y1Dlm7ZuM5QFAjamaKjFkSNzbtewSE0RlPs7BgQChlk=;
        b=VRB8Sd4LZwzXiFc9A1CHt9Yg+GjFCve/DuHAKUyD56nTP5ou0BTgUA+P/0KKJNX2Ze
         qexa9FCoi5+NtIzTfFXtkUV6NqmUK/Co7N1o1MIxyPjJUZYTQ2Qm7CucOQVqKtyMm+AS
         1/hR8CwqALyTVJHgY6W0P60oLWbqW0UYV0NoqtvZg562muJOz+08fM9AZt9L9YfjaphS
         2FYGTl7gLVsmHjoSIGa44V16Imv3NPBOtxfpskuw6QaMLnETDRcj9Cnq3VXYT3R82E+L
         l2kd9Eh4O93ORtfFQrDMYf1zoOqfSOvhSjVON1lBypLRPY6Xuc/BCSn3cAPtd6UEWhb0
         4CsA==
X-Gm-Message-State: AElRT7EldlYnSEzouaT3BGqxhMRyPbjnatvakrDQ9fk8eAlE1JviPgOL
        0mNtlkfiAidmapG+IGkoXxwPjnhDSl0=
X-Google-Smtp-Source: AG47ELsSC64VQ1qyt8EAv2uXJ3qd7utztXWURe6mw+Irim0VL5+kLn1sGnuEop/nvx+NG/2LjAitSA==
X-Received: by 10.99.97.130 with SMTP id v124mr18371105pgb.351.1521737867024;
        Thu, 22 Mar 2018 09:57:47 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id 2sm15043830pfo.70.2018.03.22.09.57.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 22 Mar 2018 09:57:45 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     Wink Saville <wink@saville.com>, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de, gitster@pobox.com
Subject: [RFC PATCH v3 5/9] Use new functions in git_rebase__interactive
Date:   Thu, 22 Mar 2018 09:57:25 -0700
Message-Id: <387b3dc01562fd30f5894c91109d1a9d00d07720.1521690197.git.wink@saville.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <cover.1521690197.git.wink@saville.com>
References: <cover.1521690197.git.wink@saville.com>
In-Reply-To: <cover.1521690197.git.wink@saville.com>
References: <cover.1521690197.git.wink@saville.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Use initiate_action, setup_reflog_action, init_basic_state,
init_revisions_and_shortrevisions and complete_action.

Signed-off-by: Wink Saville <wink@saville.com>
---
 git-rebase--interactive.sh | 187 ++-------------------------------------------
 1 file changed, 8 insertions(+), 179 deletions(-)

diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
index b72f80ae8..2c10a7f1a 100644
--- a/git-rebase--interactive.sh
+++ b/git-rebase--interactive.sh
@@ -952,120 +952,15 @@ EOF
 }
 
 git_rebase__interactive () {
-	case "$action" in
-	continue)
-		if test ! -d "$rewritten"
-		then
-			exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
-				--continue
-		fi
-		# do we have anything to commit?
-		if git diff-index --cached --quiet HEAD --
-		then
-			# Nothing to commit -- skip this commit
-
-			test ! -f "$GIT_DIR"/CHERRY_PICK_HEAD ||
-			rm "$GIT_DIR"/CHERRY_PICK_HEAD ||
-			die "$(gettext "Could not remove CHERRY_PICK_HEAD")"
-		else
-			if ! test -f "$author_script"
-			then
-				gpg_sign_opt_quoted=${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")}
-				die "$(eval_gettext "\
-You have staged changes in your working tree.
-If these changes are meant to be
-squashed into the previous commit, run:
-
-  git commit --amend \$gpg_sign_opt_quoted
-
-If they are meant to go into a new commit, run:
-
-  git commit \$gpg_sign_opt_quoted
-
-In both cases, once you're done, continue with:
-
-  git rebase --continue
-")"
-			fi
-			. "$author_script" ||
-				die "$(gettext "Error trying to find the author identity to amend commit")"
-			if test -f "$amend"
-			then
-				current_head=$(git rev-parse --verify HEAD)
-				test "$current_head" = $(cat "$amend") ||
-				die "$(gettext "\
-You have uncommitted changes in your working tree. Please commit them
-first and then run 'git rebase --continue' again.")"
-				do_with_author git commit --amend --no-verify -F "$msg" -e \
-					${gpg_sign_opt:+"$gpg_sign_opt"} $allow_empty_message ||
-					die "$(gettext "Could not commit staged changes.")"
-			else
-				do_with_author git commit --no-verify -F "$msg" -e \
-					${gpg_sign_opt:+"$gpg_sign_opt"} $allow_empty_message ||
-					die "$(gettext "Could not commit staged changes.")"
-			fi
-		fi
-
-		if test -r "$state_dir"/stopped-sha
-		then
-			record_in_rewritten "$(cat "$state_dir"/stopped-sha)"
-		fi
-
-		require_clean_work_tree "rebase"
-		do_rest
-		return 0
-		;;
-	skip)
-		git rerere clear
-
-		if test ! -d "$rewritten"
-		then
-			exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
-				--continue
-		fi
-		do_rest
+	initiate_action "$action"
+	ret=$?
+	if test $ret = 0; then
 		return 0
-		;;
-	edit-todo)
-		git stripspace --strip-comments <"$todo" >"$todo".new
-		mv -f "$todo".new "$todo"
-		collapse_todo_ids
-		append_todo_help
-		gettext "
-You are editing the todo file of an ongoing interactive rebase.
-To continue rebase after editing, run:
-    git rebase --continue
-
-" | git stripspace --comment-lines >>"$todo"
-
-		git_sequence_editor "$todo" ||
-			die "$(gettext "Could not execute editor")"
-		expand_todo_ids
-
-		exit
-		;;
-	show-current-patch)
-		exec git show REBASE_HEAD --
-		;;
-	esac
-
-	comment_for_reflog start
-
-	if test ! -z "$switch_to"
-	then
-		GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to"
-		output git checkout "$switch_to" -- ||
-			die "$(eval_gettext "Could not checkout \$switch_to")"
-
-		comment_for_reflog start
 	fi
 
-	orig_head=$(git rev-parse --verify HEAD) || die "$(gettext "No HEAD?")"
-	mkdir -p "$state_dir" || die "$(eval_gettext "Could not create temporary \$state_dir")"
-	rm -f "$(git rev-parse --git-path REBASE_HEAD)"
+	setup_reflog_action
+	init_basic_state
 
-	: > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"
-	write_basic_state
 	if test t = "$preserve_merges"
 	then
 		if test -z "$rebase_root"
@@ -1089,18 +984,8 @@ To continue rebase after editing, run:
 		merges_option="--no-merges --cherry-pick"
 	fi
 
-	shorthead=$(git rev-parse --short $orig_head)
-	shortonto=$(git rev-parse --short $onto)
-	if test -z "$rebase_root"
-		# this is now equivalent to ! -z "$upstream"
-	then
-		shortupstream=$(git rev-parse --short $upstream)
-		revisions=$upstream...$orig_head
-		shortrevisions=$shortupstream..$shorthead
-	else
-		revisions=$onto...$orig_head
-		shortrevisions=$shorthead
-	fi
+	init_revisions_and_shortrevisions
+
 	if test t != "$preserve_merges"
 	then
 		git rebase--helper --make-script ${keep_empty:+--keep-empty} \
@@ -1171,61 +1056,5 @@ To continue rebase after editing, run:
 		done
 	fi
 
-	test -s "$todo" || echo noop >> "$todo"
-	test -z "$autosquash" || git rebase--helper --rearrange-squash || exit
-	test -n "$cmd" && git rebase--helper --add-exec-commands "$cmd"
-
-	todocount=$(git stripspace --strip-comments <"$todo" | wc -l)
-	todocount=${todocount##* }
-
-cat >>"$todo" <<EOF
-
-$comment_char $(eval_ngettext \
-	"Rebase \$shortrevisions onto \$shortonto (\$todocount command)" \
-	"Rebase \$shortrevisions onto \$shortonto (\$todocount commands)" \
-	"$todocount")
-EOF
-	append_todo_help
-	gettext "
-	However, if you remove everything, the rebase will be aborted.
-
-	" | git stripspace --comment-lines >>"$todo"
-
-	if test -z "$keep_empty"
-	then
-		printf '%s\n' "$comment_char $(gettext "Note that empty commits are commented out")" >>"$todo"
-	fi
-
-
-	has_action "$todo" ||
-		return 2
-
-	cp "$todo" "$todo".backup
-	collapse_todo_ids
-	git_sequence_editor "$todo" ||
-		die_abort "$(gettext "Could not execute editor")"
-
-	has_action "$todo" ||
-		return 2
-
-	git rebase--helper --check-todo-list || {
-		ret=$?
-		checkout_onto
-		exit $ret
-	}
-
-	expand_todo_ids
-
-	test -d "$rewritten" || test -n "$force_rebase" ||
-	onto="$(git rebase--helper --skip-unnecessary-picks)" ||
-	die "Could not skip unnecessary pick commands"
-
-	checkout_onto
-	if test -z "$rebase_root" && test ! -d "$rewritten"
-	then
-		require_clean_work_tree "rebase"
-		exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
-			--continue
-	fi
-	do_rest
+	complete_action
 }
-- 
2.16.2

