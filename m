Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 86BC91F404
	for <e@80x24.org>; Wed, 21 Mar 2018 19:42:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752974AbeCUTmg (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Mar 2018 15:42:36 -0400
Received: from mail-wr0-f181.google.com ([209.85.128.181]:42946 "EHLO
        mail-wr0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752946AbeCUTmf (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Mar 2018 15:42:35 -0400
Received: by mail-wr0-f181.google.com with SMTP id s18so6382758wrg.9
        for <git@vger.kernel.org>; Wed, 21 Mar 2018 12:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=qg9MFc7c65Aj53e4gWNCDxCo34nPVj6gjU4TWy9EoBo=;
        b=mE205ZArS8HciDeoQpU3f85jO/hmIXBHcmo+UXSamuLpJSxYvWo6T05O4acYDspfOe
         sK1spUQgRhUj2shYOB2n9nGz8NLhfXyeVo96vXkXoQUR+FpywCI9lQwzkBMho4xYRXcD
         FdpYir5GtT2wTA4WeLfAR9a8i5v/d7vdYSrvBEXqFP42rYXmWKLeQfNNpLjQ7IM1SnNL
         c7PPXuajOPo4vs4RWoaxexMjpYFXPw3vS07qLX6MojK+YTikqb5QrLqGr3cvceqI22Jf
         L0eh00ugJEPS1C2ro1hZ/yY53VCMdhCsvmK0EgTZoCM80WagxyQTEG5SQeUnV9Biatgz
         2j5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=qg9MFc7c65Aj53e4gWNCDxCo34nPVj6gjU4TWy9EoBo=;
        b=pWtFBdVKmcKm0S64by7W/mlYhNDVNmlmFcgt4QhMhTx7BIB9WGZry7T/Yvhve+rpT8
         RKjynpBK9Dm/u234h1siA0KKUqHevxkutoZtD1QLPUaaN2XjAAxP0F3tsnaXF/HdfrTv
         Ggg2NQ54qv13hwkobVCySIW6smUx0h55wPQjvARPiizmzPA0Y7Kez68wNn7wzwEYetRb
         JgGztJcYQ3TrBAJAJhKYhpS/YOGD3xNlG2NZ0rFyZchVUxYBbYoMOb/Ef/kcOYSGnMR7
         SnKTYoKKVNn0GQpqjDMyD6fWKqtDnbz+wDB11LlnvQTUuasNlOU9G2kvGbW0j61MexIG
         E5Ng==
X-Gm-Message-State: AElRT7EwDOpW68+4WpHAT/PH057cHakjgyDQSxUyo6ofcHNW3m9n0zVo
        +DVmSnwQhcgFBRhzC5152dE=
X-Google-Smtp-Source: AG47ELtBS/FQIFgv1UcBQo7YCE9szq9+4nKv6e6oyRSO23XSecPZz/IBgUL8Gq6mSv4Gj9jEIx3o/A==
X-Received: by 10.223.142.164 with SMTP id q33mr17006070wrb.72.1521661353549;
        Wed, 21 Mar 2018 12:42:33 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 69sm7097758wmn.9.2018.03.21.12.42.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 21 Mar 2018 12:42:32 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Wink Saville <wink@saville.com>
Cc:     git@vger.kernel.org, sunshine@sunshineco.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [RFC PATCH v2 1/1] rebase-interactive: Add git_rebase__interactive__preserve_merges
References: <cover.1521653702.git.wink@saville.com>
        <CAPig+cSm3kHF_hTRKutCCNsY82sE3xZfXJkQsKi+zedq9rdnPw@mail.gmail.com>
        <cover.1521653702.git.wink@saville.com>
        <c169a69be3c61fd1e90eaf79febccef2afdfbd3b.1521653702.git.wink@saville.com>
Date:   Wed, 21 Mar 2018 12:42:32 -0700
In-Reply-To: <c169a69be3c61fd1e90eaf79febccef2afdfbd3b.1521653702.git.wink@saville.com>
        (Wink Saville's message of "Wed, 21 Mar 2018 10:44:38 -0700")
Message-ID: <xmqqy3ilnrkn.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Wink Saville <wink@saville.com> writes:

> Refactor git_rebase__interactive__preserve_merges out of
> git_rebase__interactive resulting in fewer conditionals making
> both routines are simpler.
>
> Changed run_specific_rebase in git-rebase to dispatch to the appropriate
> function after sourcing git-rebase--interactive.
> ---

I think this will become (more) reviewable if it is split into two
patches (at least).  A preliminary patch that does the style changes
and line wrapping (left below) as step #1, and all the rest on top
as step #2.

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 331c8dfea..65ff75654 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -1,5 +1,7 @@
> -# This shell script fragment is sourced by git-rebase to implement
> -# its interactive mode.  "git rebase --interactive" makes it easy
> +#!/bin/sh

Addition of #! implies that this might be invoked as the top-level
script; is that the case now?  I did not get such an impression from
the proposed log message and it is still always dot-sourced (in
which case #! gives a wrong signal to the readers).

> +# This shell script fragment is sourced by git-rebase--interactive
> +# and git-rebase--interactive--preserve-merges in support of the
> +# interactive mode.  "git rebase --interactive" makes it easy
>  # to fix up commits in the middle of a series and rearrange commits.
>  #
>  # Copyright (c) 2006 Johannes E. Schindelin
> @@ -7,6 +9,7 @@
>  # The original idea comes from Eric W. Biederman, in
>  # https://public-inbox.org/git/m1odwkyuf5.fsf_-_@ebiederm.dsl.xmission.com/
>  #
> +
>  # The file containing rebase commands, comments, and empty lines.

Why?

> @@ -274,7 +290,8 @@ pick_one () {
>  
>  	case "$1" in -n) sha1=$2; ff= ;; *) sha1=$1 ;; esac
>  	case "$force_rebase" in '') ;; ?*) ff= ;; esac
> -	output git rev-parse --verify $sha1 || die "$(eval_gettext "Invalid commit name: \$sha1")"
> +	output git rev-parse --verify $sha1 ||
> +		die "$(eval_gettext "Invalid commit name: \$sha1")"

Just linewrapping.

> @@ -287,8 +304,8 @@ pick_one () {
>  			${gpg_sign_opt:+$(git rev-parse --sq-quote "$gpg_sign_opt")} \
>  			"$strategy_args" $empty_args $ff "$@"
>  
> -	# If cherry-pick dies it leaves the to-be-picked commit unrecorded. Reschedule
> -	# previous task so this commit is not lost.
> +	# If cherry-pick dies it leaves the to-be-picked commit unrecorded.
> +	# Reschedule previous task so this commit is not lost.

Ditto.

> @@ -307,17 +324,15 @@ pick_one_preserving_merges () {
>  	esac
>  	sha1=$(git rev-parse $sha1)
>  
> -	if test -f "$state_dir"/current-commit
> +	if test -f "$state_dir"/current-commit && test "$fast_forward" = t
>  	then
> -		if test "$fast_forward" = t
> -		then
> -			while read current_commit
> -			do
> -				git rev-parse HEAD > "$rewritten"/$current_commit
> -			done <"$state_dir"/current-commit
> -			rm "$state_dir"/current-commit ||
> -				die "$(gettext "Cannot write current commit's replacement sha1")"
> -		fi
> +		while read current_commit
> +		do
> +			git rev-parse HEAD > "$rewritten"/$current_commit
> +		done <"$state_dir"/current-commit
> +		rm "$state_dir"/current-commit ||
> +		    die "$(gettext \
> +			"Cannot write current commit's replacement sha1")"
>  	fi

Good code simplification that turns

	if A
		if B
			do this thing
		fi
	fi

into

	if A & B
		do this thing
	fi

> @@ -337,10 +352,10 @@ pick_one_preserving_merges () {
>  		if test -f "$rewritten"/$p
>  		then
>  			new_p=$(cat "$rewritten"/$p)
> -
> -			# If the todo reordered commits, and our parent is marked for
> -			# rewriting, but hasn't been gotten to yet, assume the user meant to
> -			# drop it on top of the current HEAD
> +			# If the todo reordered commits, and our parent is
> +			# marked for rewriting, but hasn't been gotten to yet,
> +			# assume the user meant to drop it on top of the
> +			# current HEAD

Just line wrapping.

> @@ -379,7 +394,7 @@ pick_one_preserving_merges () {
>  		then
>  			# detach HEAD to current parent
>  			output git checkout $first_parent 2> /dev/null ||
> -				die "$(eval_gettext "Cannot move HEAD to \$first_parent")"
> +			   die "$(eval_gettext "Cannot move HEAD to \$first_parent")"
>  		fi

Ditto.

> @@ -553,7 +568,7 @@ do_next () {
>  	pick|p)
>  		comment_for_reflog pick
>  
> -		mark_action_done
> +		mark_action_done $sha1 "$rest"

This demands more attention from the readers than all the changes we
have seen so far which were just line wrapping and whitespace
changes.  That is why it is better to leave these changes to a
separate patch after preliminary clean-up.  It allows reviewers'
eyes coast over the clean-up step, and then lets them focus on the
more "meaningful" changes  like this one.

> @@ -637,7 +652,7 @@ you are able to reword the commit.")"
>  		read -r command rest < "$todo"
>  		mark_action_done
>  		eval_gettextln "Executing: \$rest"
> -		"${SHELL:-@SHELL_PATH@}" -c "$rest" # Actual execution
> +		"${SHELL:-/bin/sh}" -c "$rest" # Actual execution

Why?  This change is not justified in the proposed log message.

