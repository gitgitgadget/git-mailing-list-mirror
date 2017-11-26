Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 00A6F20A41
	for <e@80x24.org>; Sun, 26 Nov 2017 23:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752084AbdKZXBg (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 18:01:36 -0500
Received: from mail-wr0-f169.google.com ([209.85.128.169]:34227 "EHLO
        mail-wr0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752056AbdKZXBe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 18:01:34 -0500
Received: by mail-wr0-f169.google.com with SMTP id k18so19787082wre.1
        for <git@vger.kernel.org>; Sun, 26 Nov 2017 15:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=blZ4Tm32z8hSwHRl43703eZOs5aTk/ZlzOah8dMU6YE=;
        b=toUFbimAcBTp4b62VtaaSoeFs1CHDAVBbVlYCTOOact9vID4JZDkql7R3+SegevfTj
         XqfLMaefeKYdNB+iiYhaLqnfAhCMMLwFYCFTYyUh6uUkKFAvbUk59z98Si2tyl5L2LNJ
         9iUp0r5HgIqigLH10g757fuDQHVWk7DtkccCBVI1O7KYlB4xqAoEWOQA/D55See/YUDv
         SSoUATg+8X4I1Zk2Ef4Q8cgq5Gh3OWotJx8qzt+qLz1xp2L3BOmGYrD/6BvOA8BNuIRQ
         u+dUDrtcmv0h7c2zfkDh2vwGTSeiKZNzdNHVgeKgoXgMVU+709GQ9n7f8PVAEJqR00NP
         aKYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=blZ4Tm32z8hSwHRl43703eZOs5aTk/ZlzOah8dMU6YE=;
        b=Uaf+YcDdHoSk0+EV/LgBTZ5BaYNlFGqx1WXYPaUx7xPVH5LWnsc3FT8z13OwrsCgqy
         AT6K2phFVSb7i+RS4maiV9E6iyPnf8yDEWdd3sY8QXXBo1b3/DDWJGpUakfbX1zr5qbZ
         bC6PyaqLrqQ3bn4xlAu/Jod5/EddxDU1UICuS/u48aUVYMVzItkWseBxbnRd/+XwS0tA
         d7MxlutqV3Q2h/laU0xyyzREJWoFAZAI3IhR3xsuKKgHJbhNxoi++pPb08C4szC1zr1d
         5yiJUSFvxNZtXadS/oU1mSN5cozbyv9AXlITZ4XhdFsRWksjX6lStQBxOCMKKUjp/mq6
         lP+g==
X-Gm-Message-State: AJaThX4y9Da4sFszqwJHBnSLG9JZWy22csd68P6KxnomcuL8SVZ8Sc7q
        t8e/auMmmLCJNTQhQtupajo=
X-Google-Smtp-Source: AGs4zMbPKThNXfNF7sjzzh0K+Y1bpqK5D2LX5iKtwx1N4lnwuBzcmq5j/5CGP+MXN3gWwl26VVESxQ==
X-Received: by 10.223.187.207 with SMTP id z15mr29549736wrg.168.1511737293427;
        Sun, 26 Nov 2017 15:01:33 -0800 (PST)
Received: from [192.168.5.102] (cable-24-135-61-30.dynamic.sbb.rs. [24.135.61.30])
        by smtp.gmail.com with ESMTPSA id o48sm10617171wrf.85.2017.11.26.15.01.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Nov 2017 15:01:32 -0800 (PST)
Subject: [SCRIPT/RFC 3/3] git-commit--onto-parent.sh
From:   Igor Djordjevic <igor.d.djordjevic@gmail.com>
To:     git@vger.kernel.org
Cc:     Johannes Sixt <j6t@kdbg.org>,
        Nikolay Shustov <nikolay.shustov@gmail.com>,
        Johannes Schneider <mailings@cedarsoft.com>,
        Patrik Gornicz <patrik-git@mail.pgornicz.com>,
        Martin Waitz <tali@admingilde.org>,
        Shawn Pearce <spearce@spearce.org>,
        Sam Vilain <sam@vilain.net>, Jakub Narebski <jnareb@gmail.com>
References: <8998e832-f49f-4de4-eb8d-a7934fba97b5@gmail.com>
Message-ID: <7ea28777-1e68-09e3-5f39-4ca0291e3f36@gmail.com>
Date:   Sun, 26 Nov 2017 23:45:10 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <8998e832-f49f-4de4-eb8d-a7934fba97b5@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Finally, "git-commit--onto-parent.sh"[*1*] shows an initial script 
version for you to examine, test out and hopefully comment on :)

Especially interesting part might be index-only three-way file merge, 
through usage of "git-merge-one-file--cached" script. Of course, this 
still only works for some trivial resolutions, where in case of more 
complex ones, involving unresolved conflicts, we back-out and fail. 
Still, it should be more powerful than `git-apply`.

Consider this proof of concept and work in progress, an idea where 
I`d like feedback on everything you come up with or find interesting, 
even parameter name possibly used instead of "--onto-parent" (and its 
short version), or approach in general.

For example, it might make sense to separate commit creation (on 
current HEAD`s parent) and its actual re-merging into integration 
test branch, where "--remerge" (or something) parameter would be used 
on top of "--onto-parent" to trigger both, if/when desired.

Another direction to think in might be introducing more general 
"--onto" parameter, too (or instead), without "parent" restriction, 
allowing to record a commit on top of any arbitrary commit (other 
than HEAD). This could even be defaulted to "git commit <commit-ish>" 
(no option needed), where current "git commit" behaviour would then 
just be a special case of omitted <commit-ish> defaulting to HEAD, 
aligning well with other Git commands sharing the same behaviour.

Alas, rewind to present...

Please do note that I`m still relatively new to Git, and pretty new 
to both Linux and scripting in general (on Windows as well), and the 
whole concept of open-source software contributing, even, so please 
bare with me (or at least don`t get upset too much, lol), and do feel 
free to share your thoughts and remarks, even the trivial or harsh 
ones -- I`m grateful to learn and expand my knowledge, hopefully 
producing something useful in return :) Heck, might be I`m totally 
off-track here as well.

p.s. For some context - nowadays I mostly work in Delphi, and 
occasionally in C#, though through last 20 years I`ve been involved 
with C, Pascal, Basic, but also PHP, JavaScript, and whatnot - even 
good old assembly from time to time, when needed :)

Regards, Buga

[*1*] "git-commit--onto-parent.sh", probably too heavily commented in 
 the first place, but as I`m new to everything here I kind of feel the 
 plain words might unfortunately describe my intention a bit better 
 than my code, for now at least.
--- 8< ---
#!/bin/sh
#
# Copyright (c) 2017 Igor Djordjevic

i=$#
while test $i != 0
do
	#
	# Parameter parsing might be uninteresting here, as the whole
	# script is currently just a wrapper around `git commit`, for a
	# functionality that conceptually belongs there directly.
	#
	case "$1" in
	--onto-parent=*)
		onto_parent="${1#*=}"

		shift && i=$(expr $i - 1)
		;;
	--onto-parent)
		shift && i=$(expr $i - 1)
		onto_parent="$1"

		shift && i=$(expr $i - 1)
		;;
	-a|--a|--al|--all)
		all=t

		#
		# For now, `git commit` "--all" option is special-cased in
		# terms of being stripped out of the original command line
		# (to be passed to `git commit`) and processed manually, as
		# once commit is to be made, due to states of index and
		# working tree, "--all" is most probably NOT what the user
		# wants nor expects ;)
		#
		shift && i=$(expr $i - 1)
		;;
	*)
		# parameters to pass down to `git commit`
		set -- "$@" "$1"
		shift && i=$(expr $i - 1)
		;;
	esac
done

main () {
	#
	# Store current HEAD (ref or commit) and verify that
	# --onto-parent is valid and amongst its parents.
	#
	head="$(git symbolic-ref --short --quiet HEAD)" ||
	head="$(git rev-parse HEAD^0)" &&
	verify_onto_parent "$head" "$onto_parent" || exit 1

	#
	# As both HEAD and "--onto-parent" could be refs, where underlying
	# commits could change, store original commits for later parents
	# processing, getting updated parent list for new/updated
	# merge commit.
	#
	head_commit="$(git rev-parse "$head"^0)" &&
	onto_parent_commit="$(git rev-parse "$onto_parent"^0)" || exit 1

	#
	# Custom processing of stripped "--all" parameter - if we were to
	# just pass it to `git commit`, "--all" would most probably yield
	# an unexpected result in the eyes of the user, as it would include
	# _all changes from all the other merge commit parents as well_,
	# not just the changes we may actually wanted to "push down"
	# (commit) onto specified parent (what would `git diff` show),
	# due to state of index and working tree at the time of commit.
	#
	if test -n "$all"
	then
		git add --update
	fi

	#
	# Abort if no cached changes, nothing to be committed.
	#
	git diff --cached --quiet
	if test $? -eq 0
	then
		printf >&2 '%s\n' "error: no changes added to commit"
		exit 1
	fi

	#
	# Backup current index to be restored (and committed) in the end.
	#
	merge_index="$(git write-tree)" || exit 1

	#
	# Reset index to destination parent (without touching working
	# tree), and try applying cached changes.
	#
	# In case changes do not apply cleanly onto desired parent, abort.
	#
	apply_changes "$head_commit" "$onto_parent_commit" "$merge_index" "$onto_parent" || exit 1

	#
	# Move HEAD to specified parent (without touching working tree)
	# to prepare to record a commit there, and make the commit,
	# passing parameters through to `git commit`.
	#
	# In case of error, or when `git commit` didn`t actually make
	# the commit, like when --dry-run parameter is provided (for
	# example), abort, as there is nothing to do - no new commit, no
	# need to produce the "updated" merge commit, either.
	#
	# Note that we don`t abort right away, as restoring original
	# index and HEAD position is needed all the same, so we
	# potentially abort only once that is done, a bit further below.
	#
	# [ This is something that could be thought of a bit more,
	# might be forbidding passing through of some `git commit`
	# parameters in the first place, like --dry-run...? ]
	#
	move_head "$onto_parent" &&
	git commit "$@"
	if test $? -ne 0 || {
		new_parent_commit="$(git rev-parse HEAD^0)"
		test "$new_parent_commit" = "$onto_parent_commit"
	}
	then
		no_commit=t
	fi

	#
	# Remove entry from HEAD reflog, not to pollute it with
	# uninteresting in-between steps we take, leaking implementation
	# details to end user.
	#
	# We do left it inside corresponding branch reflog where commit
	# is made (if $onto_parent was a branch), though, as that`s where
	# it still matters.
	#
	git reflog delete HEAD@{0}

	#
	# Restore original index state and move HEAD to original position,
	# (still not touching working tree), aborting if previously
	# signalled.
	#
	git read-tree --reset "$merge_index" &&
	move_head "$head" &&
	test -z "$no_commit" || exit 1

	#
	# Drop original HEAD merge commit to have it replaced by
	# upcoming "updated" merge commit.
	#
	# This step is needed for eventually getting an expected merge
	# message out of "git fmt-merge-msg", as it seems HEAD dependent
	# as well, beside being input format picky already...?
	#
	#git update-ref --create-reflog -m "reset: moving to HEAD^" HEAD HEAD^ || exit 1
	reflog_ref="$(git symbolic-ref --short --quiet HEAD)"
	git update-ref HEAD HEAD^ || exit 1

	#
	# Remove both HEAD and underlying reference reflog entries this
	# time, as here we really want to mask previous step completely,
	# being taken just to satisfy "git fmt-merge-msg" expectations.
	#
	if test -n "$reflog_ref"
	then
		git reflog delete "$reflog_ref"@{0}
	fi
	git reflog delete HEAD@{0}

	#
	# Prepare "updated" merge commit message and parent list.
	#
	if test -n "$(git rev-parse --verify --quiet $head_commit^2^{commit})"
	then
		merge_parents="$(get_merge_parents "$head_commit" "$onto_parent" "$onto_parent_commit" "$new_parent_commit")" &&
		merge_message="$(get_merge_message "$merge_parents")" || exit 1
	else
		#
		# As we`re actually selling the option as "--onto-parent" and
		# not "--onto-MERGE-parent", we might as well properly support
		# a special case where HEAD commit is not a merge.
		#
		# Existing HEAD commit will come after commit to be made,
		# basically being kind of rebased onto new commit (but still
		# not touching working tree), where we can then also reuse
		# original HEAD commit authorship, and message, too (instead
		# of building a merge one).
		#
		merge_parents="$new_parent_commit" &&
		merge_message="$(git show -s --format=%B "$head_commit")" &&
		reuse_authorship $head_commit || exit 1
	fi
	merge_parent_commits="$(get_merge_parent_commits "$merge_parents")" &&

	#
	# Do the actual commit, updating HEAD accordingly.
	#
	merge_commit="$(printf '%s\n' "$merge_message" |
	git commit-tree "$merge_index" $merge_parent_commits)" &&
	git update-ref --create-reflog -m "$merge_message" HEAD "$merge_commit" || exit 1
}

verify_onto_parent () {
	#
	# $1 starting point head (ref or commit)
	# $2 parent of $1 to commit onto (ref or commit)
	#
	local head="$1"
	local onto_parent="$2"

	if test -z "$onto_parent"
	then
		printf >&2 '%s\n' "error: no parent provided"
		printf >&2 '%s\n' "(use \"--onto-parent <commit-ish>\""
		return 1;
	fi

	if test -z "$(git rev-parse --verify --quiet "$onto_parent"^{commit})"
	then
		printf >&2 '%s\n' "error: '$onto_parent' not valid commit object"
		return 1
	fi

	local onto_parent_commit="$(git rev-parse "$onto_parent"^0)"
	for parent_commit in $(git rev-parse $head^@)
	do
		if test "$parent_commit" = "$onto_parent_commit"
		then
			return 0
		fi
	done

	printf >&2 '%s\n' "error: '$onto_parent' not parent of '$head'"
	return 1
}

apply_changes () {
	#
	# $1 original/starting point HEAD commit
	# $2 parent commit of $1 to apply changes to
	# $3 index with changes on top of $1 to apply/merge onto $2
	# $4 original parameter value of $2 (ref or commit), used for
	#    prettier message only
	#
	local head_commit="$1"
	local onto_parent_commit="$2"
	local merge_index="$3"
	local onto_parent="$4"

	git read-tree --reset $onto_parent_commit &&

	#
	# Attempt simple patching first - take differences between
	# $head_commit and $merge_index and try applying to current index
	# (previously reset to $onto_parent_commit).
	#
	git diff-tree --binary --patch --find-renames --find-copies $head_commit $merge_index |
	git apply --cached 2>/dev/null &&
	return 0

	printf '%s\n' "Unable to apply cleanly onto '$onto_parent', trying simple merge"

	#
	# A bit more aggressive approach - try merging with resolving
	# trivial conflicts on tree level only (involving file as a whole,
	# no conflicts inside file itself).
	#
	# Note that we take $head_commit as merge-base, producing such
	# three-way merge result that basically all changes between
	# $onto_parent_commit and $head_commit are reversed, as they`re
	# also included inside $merge_index, where only differences
	# between $head_commit and $merge_index are applied (in a
	# three-way merge manner) to $onto_parent_commit, being exactly
	# what we want here.
	#
	git read-tree -i -m --aggressive $head_commit $onto_parent_commit $merge_index || exit 1
	git write-tree >/dev/null 2>&1 &&
	return 0

	printf '%s\n' "Simple merge did not work, trying automatic merge"

	#
	# Final attempt - try merging with resolving trivial conflicts on
	# file level, too (conflicts inside file itself).
	#
	# Notice usage of "git-merge-one-file--cached" script here, being
	# a slightly tweaked version of original "git-merge-one-file",
	# not touching working tree but stuffing trivial three-way
	# file merge resolution back into index directly.
	#
	# If still left with conflicts that need to be resolved manually,
	# abort... and go home, you`re drunk.
	#
	if ! git merge-index -o git-merge-one-file--cached -a
	then
		# abort, cleanup
		git read-tree --reset $merge_index
		exit 1
	fi
}

move_head () {
	#
	# $1 destination ref or commit
	#
	# Move HEAD to $1 without touching the working tree.
	#
	# Kind of "soft checkout", where original "git checkout" touches
	# the working tree, and "git reset --soft" does not move HEAD,
	# both undesired here.
	#
	local destination="$1"

	local destination_commit="$(git rev-parse --verify --quiet $destination^0)" ||
	{
		printf >&2 '%s\n' "fatal: invalid reference: $destination"
		return 1
	}
	#local reflog_message="$(get_checkout_reflog_message $destination)"
	local destination_ref="$(git rev-parse --symbolic-full-name $destination)"

	case "$destination_ref" in
	refs/heads/*)
		# can`t use "update-ref --no-deref" as it writes commit only,
		# instead of ref, essentially detaching HEAD to that commit
		#git symbolic-ref -m "$reflog_message" HEAD "$destination_ref"
		git symbolic-ref HEAD "$destination_ref"
		;;
	refs/tags/*|\
	refs/remotes/*|\
	"")
		# can`t use "symbolic-ref" as it refuses to write commit only,
		# expecting a valid ref instead (value inside "refs/")
		#git update-ref --create-reflog -m "$reflog_message" --no-deref HEAD "$destination_commit"
		git update-ref --no-deref HEAD "$destination_commit"

		# mask this step as end-user uninteresting implementation detail
		git reflog delete HEAD@{0}
		;;
	*)
		printf >&2 '%s\n' "fatal: invalid reference: $destination_ref"
		return 1
		;;
	esac

	return 0
}

get_merge_parents () {
	#
	# $1 original/starting point HEAD commit
	# $2 parent of $1 to commit onto (ref or commit)
	# $3 original commit of $2 (if $2 is ref, otherwise equals $2)
	# $4 new commit (onto $2, to be new merge parent)
	#
	# Walk original merge commit parents to find the one we`re posting
	# onto (or amending, even), and update/replace it accordingly with
	# new commit, becoming a new parent of upcoming new/updated merge
	# commit.
	#
	# Where possible, prefer taking ref over commit, making for a
	# prettier merge commit message.
	#
	local head_commit="$1"
	local onto_parent="$2"
	local onto_parent_old_commit="$3"
	local new_parent_commit="$4"
	local merge_parents=

	local onto_parent_new_commit="$(git rev-parse $onto_parent^0)"

	for parent_commit in $(git rev-parse $head_commit^@)
	do
		local merge_parent=

		if test "$parent_commit" = "$onto_parent_old_commit"
		then
			if test "$onto_parent_new_commit" = "$new_parent_commit"
			then
				# $onto_parent is a branch (updateable ref)
				merge_parent="$onto_parent"
			else
				merge_parent="$new_parent_commit"
			fi
		else
			parent_ref="$(git for-each-ref --points-at $parent_commit --count=1 --format="%(refname)")"
			if test -n "$parent_ref"
			then
				merge_parent="$parent_ref"
			else
				merge_parent="$parent_commit"
			fi
		fi

		# echo to flatten whitespace
		merge_parents="$(echo $merge_parents $merge_parent)"
	done

	if test -n "$merge_parents"
	then
		printf '%s\n' "$merge_parents"
		return 0
	else
		return 1
	fi
}

get_merge_message () {
	#
	# $@ merge_parents
	#
	# Provide to-be merge commit message using
	# existing `git fmt-merge-msg` machinery.
	#
	local merge_heads="$(get_merge_heads $@)" &&
	local merge_message="$(printf "$merge_heads" | git fmt-merge-msg)"

	if test -n "$merge_message"
	then
		printf '%s\n' "$merge_message"
		return 0
	else
		return 1
	fi
}

get_merge_heads () {
	#
	# $@ merge_parents
	#
	# Provide input for `git fmt-merge-msg` to get
	# nicely formatted merge commit message.
	#
	# Final result loosely mimics FETCH_HEAD file layout.
	#
	local merge_heads=
	local merge_head=

	#
	# Skip the first parent, as that is the original merge
	# destination, where we`re only interested in parents to be
	# merged into it.
	#
	shift

	for merge_parent in $@
	do
		local merge_parent_ref="$(git rev-parse --symbolic-full-name $merge_parent)"
		local merge_parent_commit="$(git rev-parse $merge_parent)"

		case "$merge_parent_ref" in
		refs/heads/*)
			merge_head="$merge_parent_commit\t\tbranch '${merge_parent_ref#refs/heads/}' of ."
			;;
		refs/tags/*)
			merge_head="$merge_parent_commit\t\ttag '${merge_parent_ref#refs/tags/}' of ."
			;;
		refs/remotes/*)
			merge_head="$merge_parent_commit\t\tremote-tracking branch '${merge_parent_ref#refs/remotes/}' of ."
			;;
		*)
			merge_head="$merge_parent_commit\t\t'$(git rev-parse --short $merge_parent_commit)' of ."
			;;
		esac

		merge_heads="$merge_heads$merge_head\n"
	done

	if test -n "$merge_heads"
	then
		# '\n' already appended
		printf '%s' "$merge_heads"
		return 0
	else
		return 1
	fi
}

reuse_authorship () {
	#
	# $1 commit to reuse authorship from
	#
	local commit="$1"

	GIT_AUTHOR_NAME="$(git show -s --format=%an $commit)"
	GIT_AUTHOR_EMAIL="$(git show -s --format=%ae $commit)"
	GIT_AUTHOR_DATE="$(git show -s --format=%at $commit)"

	export GIT_AUTHOR_NAME GIT_AUTHOR_EMAIL GIT_AUTHOR_DATE
}

get_merge_parent_commits () {
	#
	# $@ merge_parents (might contain ref)
	#
	# Provide to-be merge commit parent parameters
	# in format suitable for `git commit-tree`.
	#
	local merge_parent_commits=

	for merge_parent in $@
	do
		merge_parent_commits="$(printf '%s\n' "$merge_parent_commits -p $(git rev-parse $merge_parent^0)")"
	done

	if test -n "$merge_parent_commits"
	then
		printf '%s\n' "$merge_parent_commits"
		return 0
	else
		return 1
	fi
}

get_checkout_reflog_message () {
	#
	# $1 destination ref or commit
	#
	local destination="$1"
	local source=

	source="$(git symbolic-ref --short --quiet HEAD)" ||
	source="$(git rev-parse HEAD^0)"

	printf '%s' "checkout: moving from $source to $destination"
}

main "$@"
