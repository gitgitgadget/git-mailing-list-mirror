Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3C4E01F404
	for <e@80x24.org>; Tue, 20 Mar 2018 20:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751542AbeCTUpT (ORCPT <rfc822;e@80x24.org>);
        Tue, 20 Mar 2018 16:45:19 -0400
Received: from mail-pl0-f41.google.com ([209.85.160.41]:35877 "EHLO
        mail-pl0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbeCTUpR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Mar 2018 16:45:17 -0400
Received: by mail-pl0-f41.google.com with SMTP id 61-v6so1756343plf.3
        for <git@vger.kernel.org>; Tue, 20 Mar 2018 13:45:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=saville-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ks76oU7dsHBJDp0qXaU79LEGMxdeReeJelJLsT0uzGw=;
        b=af3TPZ/YKc2V/ByurqBl9GIpn8Yfb8ZnL3G0tbyTajrSezZDz8ZfZb6COmMn7EQwvM
         0wbQhVBQQ9aEjH236fDVnRwNSI+8AchjhRPDiXpvM/kViml/kqL8nTaKUTcZMC6JuTVx
         beSNhq49WoERH+JisqD1U7dHqdsEm8WqQbzdELd2oC1iIFdL1qKCO9sxQZ/tyPma31d7
         ozRoLJ9Rqy9FFkAtmGELV9gSX6IOKciVVMOI+GOQv9+dAF5AI+zAuNoc4skrX+e3fFGu
         e6gqccbDdcAsAm8J9wWXbZCjzpvXNrmUgG9h30Y0pO4BiV90fubRC8WqQPcCYlycZK++
         fCig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ks76oU7dsHBJDp0qXaU79LEGMxdeReeJelJLsT0uzGw=;
        b=ENLHmDUDqkl9GJgZB9CWvpqJDPdhCtVqCqF/AZQDN+fQVzVwlmlhfMkF2f2zYQM9hH
         GbVx8JQpLSaZSZSAuyDZLusFm2a5HE5iHtfuMA+2405tvEsCIVwLHJ7CkzN+E8n41UVa
         69oX1/yKOuT+5xUw/NS17finjN1d28ALGdmrxSA6inl7rU9b42HtQWE1d+e9gZx/fGtw
         pfB/LkOgdyr3GVMa4f4Stus/fiJKVpA+IrIkN8NEU9d2uLMvVR4pkcoiwNQKElQ5NPpN
         fk8busl1gbGYb83NCRS5B/QS/ReNdRBKrXPxra4I1FEVPgwv0ZGBnGD3Kmf3+BR920wd
         xlKQ==
X-Gm-Message-State: AElRT7EXpbKrCqOxxcw9Wnb7myf47/j+zV4jmKlulOWuE9dvxo+tCxu/
        6ajRi6n0b3mB18dAUEx3sKQe7p7fHAw=
X-Google-Smtp-Source: AG47ELusJCgDV1E7MZQmLoPGgPnWX3J/srm3skAePxPXbmrcirV4DpsKVoqw8nAiAxZNEGO11byngg==
X-Received: by 2002:a17:902:2f:: with SMTP id 44-v6mr18066893pla.187.1521578714965;
        Tue, 20 Mar 2018 13:45:14 -0700 (PDT)
Received: from wink-desktop.hsd1.ca.comcast.net ([2601:647:cb02:7980:314d:6e5e:475c:ebd3])
        by smtp.gmail.com with ESMTPSA id m18sm4180259pgu.51.2018.03.20.13.45.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Mar 2018 13:45:13 -0700 (PDT)
From:   Wink Saville <wink@saville.com>
To:     git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de, Wink Saville <wink@saville.com>
Subject: [RFC PATCH 1/3] rebase-interactive: create git-rebase--interactive--lib.sh
Date:   Tue, 20 Mar 2018 13:45:05 -0700
Message-Id: <20180320204507.12623-2-wink@saville.com>
X-Mailer: git-send-email 2.16.2
In-Reply-To: <20180320204507.12623-1-wink@saville.com>
References: <20180320204507.12623-1-wink@saville.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Create a library that can be used for interactive rebasing by
separate scripts. In particular, the current git-rebase--interactive.sh
will be reduced to a single function which uses the library and a new
file, git-rebase--interactive--preserve-merges.sh will also be a single
function that uses the library.

Signed-off-by: Wink Saville <wink@saville.com>
---
 .gitignore                      |   1 +
 Makefile                        |   1 +
 git-rebase--interactive--lib.sh | 944 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 946 insertions(+)
 create mode 100644 git-rebase--interactive--lib.sh

diff --git a/.gitignore b/.gitignore
index 833ef3b0b..4ea246780 100644
--- a/.gitignore
+++ b/.gitignore
@@ -116,6 +116,7 @@
 /git-rebase--am
 /git-rebase--helper
 /git-rebase--interactive
+/git-rebase--interactive--lib
 /git-rebase--merge
 /git-receive-pack
 /git-reflog
diff --git a/Makefile b/Makefile
index de4b8f0c0..f13540da6 100644
--- a/Makefile
+++ b/Makefile
@@ -567,6 +567,7 @@ SCRIPT_LIB += git-mergetool--lib
 SCRIPT_LIB += git-parse-remote
 SCRIPT_LIB += git-rebase--am
 SCRIPT_LIB += git-rebase--interactive
+SCRIPT_LIB += git-rebase--interactive--lib
 SCRIPT_LIB += git-rebase--merge
 SCRIPT_LIB += git-sh-setup
 SCRIPT_LIB += git-sh-i18n
diff --git a/git-rebase--interactive--lib.sh b/git-rebase--interactive--lib.sh
new file mode 100644
index 000000000..0cb902f98
--- /dev/null
+++ b/git-rebase--interactive--lib.sh
@@ -0,0 +1,944 @@
+#!/bin/sh
+# This shell script fragment is sourced by git-rebase--interactive
+# and git-rebase--interactive--preserve-merges in suppor of the
+# interactive mode.  "git rebase --interactive" makes it easy
+# to fix up commits in the middle of a series and rearrange commits.
+#
+# Copyright (c) 2006 Johannes E. Schindelin
+#
+# The original idea comes from Eric W. Biederman, in
+# https://public-inbox.org/git/m1odwkyuf5.fsf_-_@ebiederm.dsl.xmission.com/
+#
+
+# The file containing rebase commands, comments, and empty lines.
+# This file is created by "git rebase -i" then edited by the user.  As
+# the lines are processed, they are removed from the front of this
+# file and written to the tail of $done.
+todo="$state_dir"/git-rebase-todo
+
+# The rebase command lines that have already been processed.  A line
+# is moved here when it is first handled, before any associated user
+# actions.
+done="$state_dir"/done
+
+# The commit message that is planned to be used for any changes that
+# need to be committed following a user interaction.
+msg="$state_dir"/message
+
+# The file into which is accumulated the suggested commit message for
+# squash/fixup commands.  When the first of a series of squash/fixups
+# is seen, the file is created and the commit message from the
+# previous commit and from the first squash/fixup commit are written
+# to it.  The commit message for each subsequent squash/fixup commit
+# is appended to the file as it is processed.
+#
+# The first line of the file is of the form
+#     # This is a combination of $count commits.
+# where $count is the number of commits whose messages have been
+# written to the file so far (including the initial "pick" commit).
+# Each time that a commit message is processed, this line is read and
+# updated.  It is deleted just before the combined commit is made.
+squash_msg="$state_dir"/message-squash
+
+# If the current series of squash/fixups has not yet included a squash
+# command, then this file exists and holds the commit message of the
+# original "pick" commit.  (If the series ends without a "squash"
+# command, then this can be used as the commit message of the combined
+# commit without opening the editor.)
+fixup_msg="$state_dir"/message-fixup
+
+# $rewritten is the name of a directory containing files for each
+# commit that is reachable by at least one merge base of $head and
+# $upstream. They are not necessarily rewritten, but their children
+# might be.  This ensures that commits on merged, but otherwise
+# unrelated side branches are left alone. (Think "X" in the man page's
+# example.)
+rewritten="$state_dir"/rewritten
+
+dropped="$state_dir"/dropped
+
+end="$state_dir"/end
+msgnum="$state_dir"/msgnum
+
+# A script to set the GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
+# GIT_AUTHOR_DATE that will be used for the commit that is currently
+# being rebased.
+author_script="$state_dir"/author-script
+
+# When an "edit" rebase command is being processed, the SHA1 of the
+# commit to be edited is recorded in this file.  When "git rebase
+# --continue" is executed, if there are any staged changes then they
+# will be amended to the HEAD commit, but only provided the HEAD
+# commit is still the commit to be edited.  When any other rebase
+# command is processed, this file is deleted.
+amend="$state_dir"/amend
+
+# For the post-rewrite hook, we make a list of rewritten commits and
+# their new sha1s.  The rewritten-pending list keeps the sha1s of
+# commits that have been processed, but not committed yet,
+# e.g. because they are waiting for a 'squash' command.
+rewritten_list="$state_dir"/rewritten-list
+rewritten_pending="$state_dir"/rewritten-pending
+
+# Work around Git for Windows' Bash whose "read" does not strip CRLF
+# and leaves CR at the end instead.
+cr=$(printf "\015")
+
+strategy_args=${strategy:+--strategy=$strategy}
+test -n "$strategy_opts" &&
+eval '
+	for strategy_opt in '"$strategy_opts"'
+	do
+		strategy_args="$strategy_args -X$(git rev-parse --sq-quote "${strategy_opt#--}")"
+	done
+'
+
+GIT_CHERRY_PICK_HELP="$resolvemsg"
+export GIT_CHERRY_PICK_HELP
+
+comment_char=$(git config --get core.commentchar 2>/dev/null)
+case "$comment_char" in
+'' | auto)
+	comment_char="#"
+	;;
+?)
+	;;
+*)
+	comment_char=$(echo "$comment_char" | cut -c1)
+	;;
+esac
+
+warn () {
+	printf '%s\n' "$*" >&2
+}
+
+# Output the commit message for the specified commit.
+commit_message () {
+	git cat-file commit "$1" | sed "1,/^$/d"
+}
+
+orig_reflog_action="$GIT_REFLOG_ACTION"
+
+comment_for_reflog () {
+	case "$orig_reflog_action" in
+	''|rebase*)
+		GIT_REFLOG_ACTION="rebase -i ($1)"
+		export GIT_REFLOG_ACTION
+		;;
+	esac
+}
+
+setup_reflog_action () {
+	comment_for_reflog start
+
+	if test ! -z "$switch_to"
+	then
+		GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $switch_to"
+		output git checkout "$switch_to" -- ||
+			die "$(eval_gettext "Could not checkout \$switch_to")"
+
+		comment_for_reflog start
+	fi
+}
+
+last_count=
+mark_action_done () {
+	sed -e 1q < "$todo" >> "$done"
+	sed -e 1d < "$todo" >> "$todo".new
+	mv -f "$todo".new "$todo"
+	new_count=$(( $(git stripspace --strip-comments <"$done" | wc -l) ))
+	echo $new_count >"$msgnum"
+	total=$(($new_count + $(git stripspace --strip-comments <"$todo" | wc -l)))
+	echo $total >"$end"
+	if test "$last_count" != "$new_count"
+	then
+		last_count=$new_count
+		eval_gettext "Rebasing (\$new_count/\$total)"; printf "\r"
+		test -z "$verbose" || echo
+	fi
+}
+
+# Put the last action marked done at the beginning of the todo list
+# again. If there has not been an action marked done yet, leave the list of
+# items on the todo list unchanged.
+reschedule_last_action () {
+	tail -n 1 "$done" | cat - "$todo" >"$todo".new
+	sed -e \$d <"$done" >"$done".new
+	mv -f "$todo".new "$todo"
+	mv -f "$done".new "$done"
+}
+
+append_todo_help () {
+	gettext "
+Commands:
+p, pick = use commit
+r, reword = use commit, but edit the commit message
+e, edit = use commit, but stop for amending
+s, squash = use commit, but meld into previous commit
+f, fixup = like \"squash\", but discard this commit's log message
+x, exec = run command (the rest of the line) using shell
+d, drop = remove commit
+
+These lines can be re-ordered; they are executed from top to bottom.
+" | git stripspace --comment-lines >>"$todo"
+
+	if test $(get_missing_commit_check_level) = error
+	then
+		gettext "
+Do not remove any line. Use 'drop' explicitly to remove a commit.
+" | git stripspace --comment-lines >>"$todo"
+	else
+		gettext "
+If you remove a line here THAT COMMIT WILL BE LOST.
+" | git stripspace --comment-lines >>"$todo"
+	fi
+}
+
+make_patch () {
+	sha1_and_parents="$(git rev-list --parents -1 "$1")"
+	case "$sha1_and_parents" in
+	?*' '?*' '?*)
+		git diff --cc $sha1_and_parents
+		;;
+	?*' '?*)
+		git diff-tree -p "$1^!"
+		;;
+	*)
+		echo "Root commit"
+		;;
+	esac > "$state_dir"/patch
+	test -f "$msg" ||
+		commit_message "$1" > "$msg"
+	test -f "$author_script" ||
+		get_author_ident_from_commit "$1" > "$author_script"
+}
+
+die_with_patch () {
+	echo "$1" > "$state_dir"/stopped-sha
+	git update-ref REBASE_HEAD "$1"
+	make_patch "$1"
+	die "$2"
+}
+
+exit_with_patch () {
+	echo "$1" > "$state_dir"/stopped-sha
+	git update-ref REBASE_HEAD "$1"
+	make_patch $1
+	git rev-parse --verify HEAD > "$amend"
+	gpg_sign_opt_quoted=${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")}
+	warn "$(eval_gettext "\
+You can amend the commit now, with
+
+	git commit --amend \$gpg_sign_opt_quoted
+
+Once you are satisfied with your changes, run
+
+	git rebase --continue")"
+	warn
+	exit $2
+}
+
+die_abort () {
+	apply_autostash
+	rm -rf "$state_dir"
+	die "$1"
+}
+
+has_action () {
+	test -n "$(git stripspace --strip-comments <"$1")"
+}
+
+is_empty_commit() {
+	tree=$(git rev-parse -q --verify "$1"^{tree} 2>/dev/null) || {
+		sha1=$1
+		die "$(eval_gettext "\$sha1: not a commit that can be picked")"
+	}
+	ptree=$(git rev-parse -q --verify "$1"^^{tree} 2>/dev/null) ||
+		ptree=4b825dc642cb6eb9a060e54bf8d69288fbee4904
+	test "$tree" = "$ptree"
+}
+
+is_merge_commit()
+{
+	git rev-parse --verify --quiet "$1"^2 >/dev/null 2>&1
+}
+
+# Run command with GIT_AUTHOR_NAME, GIT_AUTHOR_EMAIL, and
+# GIT_AUTHOR_DATE exported from the current environment.
+do_with_author () {
+	(
+		export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
+		"$@"
+	)
+}
+
+git_sequence_editor () {
+	if test -z "$GIT_SEQUENCE_EDITOR"
+	then
+		GIT_SEQUENCE_EDITOR="$(git config sequence.editor)"
+		if [ -z "$GIT_SEQUENCE_EDITOR" ]
+		then
+			GIT_SEQUENCE_EDITOR="$(git var GIT_EDITOR)" || return $?
+		fi
+	fi
+
+	eval "$GIT_SEQUENCE_EDITOR" '"$@"'
+}
+
+pick_one () {
+	ff=--ff
+
+	case "$1" in -n) sha1=$2; ff= ;; *) sha1=$1 ;; esac
+	case "$force_rebase" in '') ;; ?*) ff= ;; esac
+	output git rev-parse --verify $sha1 ||
+		die "$(eval_gettext "Invalid commit name: \$sha1")"
+
+	if is_empty_commit "$sha1"
+	then
+		empty_args="--allow-empty"
+	fi
+
+	test -d "$rewritten" &&
+		pick_one_preserving_merges "$@" && return
+	output eval git cherry-pick $allow_rerere_autoupdate $allow_empty_message \
+			${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
+			"$strategy_args" $empty_args $ff "$@"
+
+	# If cherry-pick dies it leaves the to-be-picked commit unrecorded.
+	# Reschedule previous task so this commit is not lost.
+	ret=$?
+	case "$ret" in [01]) ;; *) reschedule_last_action ;; esac
+	return $ret
+}
+
+pick_one_preserving_merges () {
+	fast_forward=t
+	case "$1" in
+	-n)
+		fast_forward=f
+		sha1=$2
+		;;
+	*)
+		sha1=$1
+		;;
+	esac
+	sha1=$(git rev-parse $sha1)
+
+	if test -f "$state_dir"/current-commit && test "$fast_forward" = t
+	then
+		while read current_commit
+		do
+			git rev-parse HEAD > "$rewritten"/$current_commit
+		done <"$state_dir"/current-commit
+		rm "$state_dir"/current-commit ||
+		    die "$(gettext \
+			"Cannot write current commit's replacement sha1")"
+	fi
+
+	echo $sha1 >> "$state_dir"/current-commit
+
+	# rewrite parents; if none were rewritten, we can fast-forward.
+	new_parents=
+	pend=" $(git rev-list --parents -1 $sha1 | cut -d' ' -s -f2-)"
+	if test "$pend" = " "
+	then
+		pend=" root"
+	fi
+	while [ "$pend" != "" ]
+	do
+		p=$(expr "$pend" : ' \([^ ]*\)')
+		pend="${pend# $p}"
+
+		if test -f "$rewritten"/$p
+		then
+			new_p=$(cat "$rewritten"/$p)
+			# If the todo reordered commits, and our parent is
+			# marked for rewriting, but hasn't been gotten to yet,
+			# assume the user meant to drop it on top of the
+			# current HEAD
+			if test -z "$new_p"
+			then
+				new_p=$(git rev-parse HEAD)
+			fi
+
+			test $p != $new_p && fast_forward=f
+			case "$new_parents" in
+			*$new_p*)
+				;; # do nothing; that parent is already there
+			*)
+				new_parents="$new_parents $new_p"
+				;;
+			esac
+		else
+			if test -f "$dropped"/$p
+			then
+				fast_forward=f
+				replacement="$(cat "$dropped"/$p)"
+				test -z "$replacement" && replacement=root
+				pend=" $replacement$pend"
+			else
+				new_parents="$new_parents $p"
+			fi
+		fi
+	done
+	case $fast_forward in
+	t)
+		output warn "$(eval_gettext "Fast-forward to \$sha1")"
+		output git reset --hard $sha1 ||
+			die "$(eval_gettext "Cannot fast-forward to \$sha1")"
+		;;
+	f)
+		first_parent=$(expr "$new_parents" : ' \([^ ]*\)')
+
+		if [ "$1" != "-n" ]
+		then
+			# detach HEAD to current parent
+			output git checkout $first_parent 2> /dev/null ||
+			   die "$(eval_gettext "Cannot move HEAD to \$first_parent")"
+		fi
+
+		case "$new_parents" in
+		' '*' '*)
+			test "a$1" = a-n && die "$(eval_gettext "Refusing to squash a merge: \$sha1")"
+
+			# redo merge
+			author_script_content=$(get_author_ident_from_commit $sha1)
+			eval "$author_script_content"
+			msg_content="$(commit_message $sha1)"
+			# No point in merging the first parent, that's HEAD
+			new_parents=${new_parents# $first_parent}
+			merge_args="--no-log --no-ff"
+			if ! do_with_author output eval \
+				git merge ${gpg_sign_opt:+$(git rev-parse \
+					--sq-quote "$gpg_sign_opt")} \
+				$allow_rerere_autoupdate "$merge_args" \
+				"$strategy_args" \
+				-m "$(git rev-parse --sq-quote "$msg_content")" \
+				"$new_parents"
+			then
+				printf "%s\n" "$msg_content" > "$GIT_DIR"/MERGE_MSG
+				die_with_patch $sha1 "$(eval_gettext "Error redoing merge \$sha1")"
+			fi
+			echo "$sha1 $(git rev-parse HEAD^0)" >> "$rewritten_list"
+			;;
+		*)
+			output eval git cherry-pick $allow_rerere_autoupdate \
+				$allow_empty_message \
+				${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
+				"$strategy_args" "$@" ||
+				die_with_patch $sha1 "$(eval_gettext "Could not pick \$sha1")"
+			;;
+		esac
+		;;
+	esac
+}
+
+this_nth_commit_message () {
+	n=$1
+	eval_gettext "This is the commit message #\${n}:"
+}
+
+skip_nth_commit_message () {
+	n=$1
+	eval_gettext "The commit message #\${n} will be skipped:"
+}
+
+update_squash_messages () {
+	if test -f "$squash_msg"; then
+		mv "$squash_msg" "$squash_msg".bak || exit
+		count=$(($(sed -n \
+			-e "1s/^$comment_char[^0-9]*\([0-9][0-9]*\).*/\1/p" \
+			-e "q" < "$squash_msg".bak)+1))
+		{
+			printf '%s\n' "$comment_char $(eval_ngettext \
+				"This is a combination of \$count commit." \
+				"This is a combination of \$count commits." \
+				$count)"
+			sed -e 1d -e '2,/^./{
+				/^$/d
+			}' <"$squash_msg".bak
+		} >"$squash_msg"
+	else
+		commit_message HEAD >"$fixup_msg" ||
+		die "$(eval_gettext "Cannot write \$fixup_msg")"
+		count=2
+		{
+			printf '%s\n' "$comment_char $(gettext "This is a combination of 2 commits.")"
+			printf '%s\n' "$comment_char $(gettext "This is the 1st commit message:")"
+			echo
+			cat "$fixup_msg"
+		} >"$squash_msg"
+	fi
+	case $1 in
+	squash)
+		rm -f "$fixup_msg"
+		echo
+		printf '%s\n' "$comment_char $(this_nth_commit_message $count)"
+		echo
+		commit_message $2
+		;;
+	fixup)
+		echo
+		printf '%s\n' "$comment_char $(skip_nth_commit_message $count)"
+		echo
+		# Change the space after the comment character to TAB:
+		commit_message $2 | git stripspace --comment-lines | sed -e 's/ /	/'
+		;;
+	esac >>"$squash_msg"
+}
+
+peek_next_command () {
+	git stripspace --strip-comments <"$todo" | sed -n -e 's/ .*//p' -e q
+}
+
+# A squash/fixup has failed.  Prepare the long version of the squash
+# commit message, then die_with_patch.  This code path requires the
+# user to edit the combined commit message for all commits that have
+# been squashed/fixedup so far.  So also erase the old squash
+# messages, effectively causing the combined commit to be used as the
+# new basis for any further squash/fixups.  Args: sha1 rest
+die_failed_squash() {
+	sha1=$1
+	rest=$2
+	mv "$squash_msg" "$msg" || exit
+	rm -f "$fixup_msg"
+	cp "$msg" "$GIT_DIR"/MERGE_MSG || exit
+	warn
+	warn "$(eval_gettext "Could not apply \$sha1... \$rest")"
+	die_with_patch $sha1 ""
+}
+
+flush_rewritten_pending() {
+	test -s "$rewritten_pending" || return
+	newsha1="$(git rev-parse HEAD^0)"
+	sed "s/$/ $newsha1/" < "$rewritten_pending" >> "$rewritten_list"
+	rm -f "$rewritten_pending"
+}
+
+record_in_rewritten() {
+	oldsha1="$(git rev-parse $1)"
+	echo "$oldsha1" >> "$rewritten_pending"
+
+	case "$(peek_next_command)" in
+	squash|s|fixup|f)
+		;;
+	*)
+		flush_rewritten_pending
+		;;
+	esac
+}
+
+do_pick () {
+	sha1=$1
+	rest=$2
+	if test "$(git rev-parse HEAD)" = "$squash_onto"
+	then
+		# Set the correct commit message and author info on the
+		# sentinel root before cherry-picking the original changes
+		# without committing (-n).  Finally, update the sentinel again
+		# to include these changes.  If the cherry-pick results in a
+		# conflict, this means our behaviour is similar to a standard
+		# failed cherry-pick during rebase, with a dirty index to
+		# resolve before manually running git commit --amend then git
+		# rebase --continue.
+		git commit --allow-empty --allow-empty-message --amend \
+			   --no-post-rewrite -n -q -C $sha1 &&
+			pick_one -n $sha1 &&
+			git commit --allow-empty --allow-empty-message \
+				   --amend --no-post-rewrite -n -q -C $sha1 \
+				   ${gpg_sign_opt:+"$gpg_sign_opt"} ||
+				   die_with_patch $sha1 "$(eval_gettext "Could not apply \$sha1... \$rest")"
+	else
+		pick_one $sha1 ||
+			die_with_patch $sha1 "$(eval_gettext "Could not apply \$sha1... \$rest")"
+	fi
+}
+
+do_next () {
+	rm -f "$msg" "$author_script" "$amend" "$state_dir"/stopped-sha || exit
+	read -r command sha1 rest < "$todo"
+	case "$command" in
+	"$comment_char"*|''|noop|drop|d)
+		mark_action_done
+		;;
+	"$cr")
+		# Work around CR left by "read" (e.g. with Git for Windows' Bash).
+		mark_action_done
+		;;
+	pick|p)
+		comment_for_reflog pick
+
+		mark_action_done $sha1 "$rest"
+		do_pick $sha1 "$rest"
+		record_in_rewritten $sha1
+		;;
+	reword|r)
+		comment_for_reflog reword
+
+		mark_action_done
+		do_pick $sha1 "$rest"
+		git commit --amend --no-post-rewrite ${gpg_sign_opt:+"$gpg_sign_opt"} \
+			$allow_empty_message || {
+			warn "$(eval_gettext "\
+Could not amend commit after successfully picking \$sha1... \$rest
+This is most likely due to an empty commit message, or the pre-commit hook
+failed. If the pre-commit hook failed, you may need to resolve the issue before
+you are able to reword the commit.")"
+			exit_with_patch $sha1 1
+		}
+		record_in_rewritten $sha1
+		;;
+	edit|e)
+		comment_for_reflog edit
+
+		mark_action_done
+		do_pick $sha1 "$rest"
+		sha1_abbrev=$(git rev-parse --short $sha1)
+		warn "$(eval_gettext "Stopped at \$sha1_abbrev... \$rest")"
+		exit_with_patch $sha1 0
+		;;
+	squash|s|fixup|f)
+		case "$command" in
+		squash|s)
+			squash_style=squash
+			;;
+		fixup|f)
+			squash_style=fixup
+			;;
+		esac
+		comment_for_reflog $squash_style
+
+		test -f "$done" && has_action "$done" ||
+			die "$(eval_gettext "Cannot '\$squash_style' without a previous commit")"
+
+		mark_action_done
+		update_squash_messages $squash_style $sha1
+		author_script_content=$(get_author_ident_from_commit HEAD)
+		echo "$author_script_content" > "$author_script"
+		eval "$author_script_content"
+		if ! pick_one -n $sha1
+		then
+			git rev-parse --verify HEAD >"$amend"
+			die_failed_squash $sha1 "$rest"
+		fi
+		case "$(peek_next_command)" in
+		squash|s|fixup|f)
+			# This is an intermediate commit; its message will only be
+			# used in case of trouble.  So use the long version:
+			do_with_author output git commit --amend --no-verify -F "$squash_msg" \
+				${gpg_sign_opt:+"$gpg_sign_opt"} $allow_empty_message ||
+				die_failed_squash $sha1 "$rest"
+			;;
+		*)
+			# This is the final command of this squash/fixup group
+			if test -f "$fixup_msg"
+			then
+				do_with_author git commit --amend --no-verify -F "$fixup_msg" \
+					${gpg_sign_opt:+"$gpg_sign_opt"} $allow_empty_message ||
+					die_failed_squash $sha1 "$rest"
+			else
+				cp "$squash_msg" "$GIT_DIR"/SQUASH_MSG || exit
+				rm -f "$GIT_DIR"/MERGE_MSG
+				do_with_author git commit --amend --no-verify -F "$GIT_DIR"/SQUASH_MSG -e \
+					${gpg_sign_opt:+"$gpg_sign_opt"} $allow_empty_message ||
+					die_failed_squash $sha1 "$rest"
+			fi
+			rm -f "$squash_msg" "$fixup_msg"
+			;;
+		esac
+		record_in_rewritten $sha1
+		;;
+	x|"exec")
+		read -r command rest < "$todo"
+		mark_action_done
+		eval_gettextln "Executing: \$rest"
+		"${SHELL:-/bin/sh}" -c "$rest" # Actual execution
+		status=$?
+		# Run in subshell because require_clean_work_tree can die.
+		dirty=f
+		(require_clean_work_tree "rebase" 2>/dev/null) || dirty=t
+		if test "$status" -ne 0
+		then
+			warn "$(eval_gettext "Execution failed: \$rest")"
+			test "$dirty" = f ||
+				warn "$(gettext "and made changes to the index and/or the working tree")"
+
+			warn "$(gettext "\
+You can fix the problem, and then run
+
+	git rebase --continue")"
+			warn
+			if test $status -eq 127		# command not found
+			then
+				status=1
+			fi
+			exit "$status"
+		elif test "$dirty" = t
+		then
+			# TRANSLATORS: after these lines is a command to be issued by the user
+			warn "$(eval_gettext "\
+Execution succeeded: \$rest
+but left changes to the index and/or the working tree
+Commit or stash your changes, and then run
+
+	git rebase --continue")"
+			warn
+			exit 1
+		fi
+		;;
+	*)
+		warn "$(eval_gettext "Unknown command: \$command \$sha1 \$rest")"
+		fixtodo="$(gettext "Please fix this using 'git rebase --edit-todo'.")"
+		if git rev-parse --verify -q "$sha1" >/dev/null
+		then
+			die_with_patch $sha1 "$fixtodo"
+		else
+			die "$fixtodo"
+		fi
+		;;
+	esac
+	test -s "$todo" && return
+
+	comment_for_reflog finish &&
+	newhead=$(git rev-parse HEAD) &&
+	case $head_name in
+	refs/*)
+		message="$GIT_REFLOG_ACTION: $head_name onto $onto" &&
+		git update-ref -m "$message" $head_name $newhead $orig_head &&
+		git symbolic-ref \
+		  -m "$GIT_REFLOG_ACTION: returning to $head_name" \
+		  HEAD $head_name
+		;;
+	esac && {
+		test ! -f "$state_dir"/verbose ||
+			git diff-tree --stat $orig_head..HEAD
+	} &&
+	{
+		test -s "$rewritten_list" &&
+		git notes copy --for-rewrite=rebase < "$rewritten_list" ||
+		true # we don't care if this copying failed
+	} &&
+	hook="$(git rev-parse --git-path hooks/post-rewrite)"
+	if test -x "$hook" && test -s "$rewritten_list"; then
+		"$hook" rebase < "$rewritten_list"
+		true # we don't care if this hook failed
+	fi &&
+		warn "$(eval_gettext "Successfully rebased and updated \$head_name.")"
+
+	return 1 # not failure; just to break the do_rest loop
+}
+
+# can only return 0, when the infinite loop breaks
+do_rest () {
+	while :
+	do
+		do_next || break
+	done
+}
+
+expand_todo_ids() {
+	git rebase--helper --expand-ids
+}
+
+collapse_todo_ids() {
+	git rebase--helper --shorten-ids
+}
+
+# Switch to the branch in $into and notify it in the reflog
+checkout_onto () {
+	GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name"
+	output git checkout $onto || die_abort "$(gettext "could not detach HEAD")"
+	git update-ref ORIG_HEAD $orig_head
+}
+
+get_missing_commit_check_level () {
+	check_level=$(git config --get rebase.missingCommitsCheck)
+	check_level=${check_level:-ignore}
+	# Don't be case sensitive
+	printf '%s' "$check_level" | tr 'A-Z' 'a-z'
+}
+
+init_basic_state () {
+	orig_head=$(git rev-parse --verify HEAD) || die "$(gettext "No HEAD?")"
+	mkdir -p "$state_dir" || die "$(eval_gettext "Could not create temporary \$state_dir")"
+	rm -f "$(git rev-parse --git-path REBASE_HEAD)"
+
+	: > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"
+	write_basic_state
+}
+
+# Initiate an action which is first parameter.
+# Returns 0 if the action was able to complete
+# or 1 if further processing is required.
+initiate_action () {
+	case $1 in
+	continue)
+		if test ! -d "$rewritten"
+		then
+			exec git rebase--helper ${force_rebase:+--no-ff} $allow_empty_message \
+				--continue
+		fi
+		# do we have anything to commit?
+		if git diff-index --cached --quiet HEAD --
+		then
+			# Nothing to commit -- skip this commit
+			test ! -f "$GIT_DIR"/CHERRY_PICK_HEAD ||
+			rm "$GIT_DIR"/CHERRY_PICK_HEAD ||
+			die "$(gettext "Could not remove CHERRY_PICK_HEAD")"
+		else
+			if ! test -f "$author_script"
+			then
+				gpg_sign_opt_quoted=${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")}
+				die "$(eval_gettext "\
+You have staged changes in your working tree.
+If these changes are meant to be
+squashed into the previous commit, run:
+
+  git commit --amend \$gpg_sign_opt_quoted
+
+If they are meant to go into a new commit, run:
+
+  git commit \$gpg_sign_opt_quoted
+
+In both cases, once you're done, continue with:
+
+  git rebase --continue
+")"
+			fi
+			. "$author_script" ||
+				die "$(gettext "Error trying to find the author identity to amend commit")"
+			if test -f "$amend"
+			then
+				current_head=$(git rev-parse --verify HEAD)
+				test "$current_head" = $(cat "$amend") ||
+				die "$(gettext "\
+You have uncommitted changes in your working tree.
+Please commit them first and then run:
+    'git rebase --continue' again.")"
+				do_with_author git commit --amend --no-verify \
+				    -F "$msg" \
+				    -e ${gpg_sign_opt:+"$gpg_sign_opt"} \
+				    $allow_empty_message ||
+				die "$(gettext "Could not commit staged changes.")"
+			else
+				do_with_author git commit --no-verify \
+				    -F "$msg" \
+				    -e ${gpg_sign_opt:+"$gpg_sign_opt"} \
+				    $allow_empty_message ||
+				die "$(gettext "Could not commit staged changes.")"
+			fi
+		fi
+
+		if test -r "$state_dir"/stopped-sha
+		then
+			record_in_rewritten "$(cat "$state_dir"/stopped-sha)"
+		fi
+
+		require_clean_work_tree "rebase"
+		do_rest
+		return 0 # done
+		;;
+	skip)
+		git rerere clear
+
+		if test ! -d "$rewritten"
+		then
+			exec git rebase--helper ${force_rebase:+--no-ff} \
+				$allow_empty_message --continue
+		fi
+		do_rest
+		return 0 # done
+		;;
+	edit-todo)
+		git stripspace --strip-comments <"$todo" >"$todo".new
+		mv -f "$todo".new "$todo"
+		collapse_todo_ids
+		append_todo_help
+		gettext "
+You are editing the todo file of an ongoing interactive rebase.
+To continue rebase after editing, run:
+    git rebase --continue
+
+	" | git stripspace --comment-lines >>"$todo"
+
+		git_sequence_editor "$todo" ||
+			die "$(gettext "Could not execute editor")"
+		expand_todo_ids
+
+		exit
+		;;
+	show-current-patch)
+		exec git show REBASE_HEAD --
+		;;
+	*)
+		return 1 # continue
+		;;
+	esac
+}
+
+# Complete the action
+complete_action() {
+
+	test -s "$todo" || echo noop >> "$todo"
+	test -z "$autosquash" || git rebase--helper --rearrange-squash || exit
+	test -n "$cmd" && git rebase--helper --add-exec-commands "$cmd"
+
+	todocount=$(git stripspace --strip-comments <"$todo" | wc -l)
+	todocount=${todocount##* }
+
+	cat >>"$todo" <<EOF
+
+$comment_char $(eval_ngettext \
+	"Rebase \$shortrevisions onto \$shortonto (\$todocount command)" \
+	"Rebase \$shortrevisions onto \$shortonto (\$todocount commands)" \
+	"$todocount")
+EOF
+
+	append_todo_help
+	gettext "
+However, if you remove everything, the rebase will be aborted.
+
+" | git stripspace --comment-lines >>"$todo"
+
+	if test -z "$keep_empty"
+	then
+		printf '%s\n' "$comment_char \
+		    $(gettext "Note that empty commits are commented out")" \
+		    >>"$todo"
+	fi
+
+	has_action "$todo" ||
+		return 2
+
+	cp "$todo" "$todo".backup
+	collapse_todo_ids
+	#dbg_pause "invoke git_sequence_editor"
+	git_sequence_editor "$todo" ||
+		die_abort "$(gettext "Could not execute editor")"
+
+	has_action "$todo" ||
+		return 2
+
+	git rebase--helper --check-todo-list || {
+		ret=$?
+		checkout_onto
+		exit $ret
+	}
+
+	expand_todo_ids
+
+	test -d "$rewritten" || test -n "$force_rebase" ||
+	onto="$(git rebase--helper --skip-unnecessary-picks)" ||
+	die "Could not skip unnecessary pick commands"
+
+	checkout_onto
+
+	if test -z "$rebase_root" && test ! -d "$rewritten"
+	then
+		require_clean_work_tree "rebase"
+		exec git rebase--helper ${force_rebase:+--no-ff} \
+			$allow_empty_message --continue
+	else
+		do_rest
+	fi
+}
-- 
2.16.2

