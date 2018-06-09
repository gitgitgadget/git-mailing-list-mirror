Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.5 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_WEB shortcircuit=no
	autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 27EA51F403
	for <e@80x24.org>; Sat,  9 Jun 2018 22:11:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753401AbeFIWEg (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Jun 2018 18:04:36 -0400
Received: from mout.gmx.net ([212.227.15.18]:44969 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753383AbeFIWEf (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Jun 2018 18:04:35 -0400
Received: from [192.168.0.129] ([37.201.195.106]) by mail.gmx.com (mrgmx002
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MDQUP-1fTBfk3Jvx-00Gm9z; Sun, 10
 Jun 2018 00:04:29 +0200
Date:   Sun, 10 Jun 2018 00:04:13 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     git@vger.kernel.org, gitster@pobox.com, alban.gruin@gmail.com
Subject: Re: [RFC PATCH 2/3] rebase: Implement --merge via
 git-rebase--interactive
In-Reply-To: <20180607171344.23331-3-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1806092348390.77@tvgsbejvaqbjf.bet>
References: <CABPp-BGxaroePB6aKWAkZeADLB7VE3y1CPy2RyNwpn=+C01g3A@mail.gmail.com> <20180607171344.23331-1-newren@gmail.com> <20180607171344.23331-3-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:PMk7wOHjdLpW64UsHAGZG5haOksa5aMYEZ4VpMqL/9nxREWJcpm
 jjscCWgSeij0mQasSRsC2G6e6I1vdOFsuXEWQ89bNXborxgpC+fNAHnjKpGuDqep4ydakQ5
 3iXC/GIXSo94/JksoGFET28bDXe5NO4uLsOgzMWP3z1ai1L78w3SnsFNrUagcSVVM4aQjQk
 M8VWn3MBDDv9YT6O6rVLA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:GNOhLP1WEP0=:xW54+7l/z4+aSl2zLRZbOy
 oe0HPvYmE0oUGjjLU8CSqDaaHkKLv5Tg//Cht0vsFIEvehUnH/6Zs7RPihOi43bLlgYDydqkj
 4NjnuVStKcf7wJrxH5HSOFlSfKjCloBm1WPvaWJB/FtNT6V5nN7YteVwARo1EZcLMEyF96feo
 RNM0GBtbAZz0tUkHajvenfQXD+NGFcvc3+d4Uc8LsDX5akke57xybAk6mX3wspNXadv1XA4v7
 nzFRaeTfnVZqZoqrGBqGYVYLbW+1S9gp1vlovkfTR59a4oqFx/h+LOunCMFT88ySQ5seJRCd2
 Y/2o1IYznprtlt81ycRok97nbh+yjqG7Pqq2JBE9bBnzn/0kIOijVJqpC3UQC9OsyZaWNjPEF
 3Rj3B823CiZMKBYntp33fRW945YhiGmGfy+N9+n/TxbzS/WV3iuuslhKHSIm//DZ2fGFK1myJ
 mSvWP2lmJ02d+bS6oelHuZ9uvcUNtb2uwjIv+GeWKLLw40Wps4gVhDEhsA1EfcSzwhh7VB4xm
 SUYkYDFE8p3BkkFXib1w36L2F/6hLhvQCAtMO56qJ8tfkJUiyCwv3eXvcmD7oZFrRJAbvsNSY
 MVbnj+HBNAmkVpvf7I+FrgDWv/RV+DJys4PAd74St39PMgRuQUJXI7hMq0tbkE86xKX/uKvQO
 5HBPSYyxAtHriRroceDt6xwLgRa07yjyre8uHsf2UDMyHN3CVqftsXgZK2Q1T9MvJgw4acooL
 DVI4MWM5MAUZ3Tm93xiht5Cs3fXZ9tRPopXYqIQLygW2Kt9bfn276xnpnRre51RXNyFXylj9q
 v8pGi3a
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Thu, 7 Jun 2018, Elijah Newren wrote:

> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 451252c173..28d1658d7a 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -275,6 +275,10 @@ branch on top of the <upstream> branch.  Because of this, when a merge
>  conflict happens, the side reported as 'ours' is the so-far rebased
>  series, starting with <upstream>, and 'theirs' is the working branch.  In
>  other words, the sides are swapped.
> ++
> +This uses the `--interactive` machinery internally, and as such,
> +anything that is incompatible with --interactive is incompatible
> +with this option.

I am not sure I like this change, as it describes an implementation detail
that users should neither know, nor care about, nor rely on.

> @@ -328,8 +332,8 @@ which makes little sense.
>  	and after each change.  When fewer lines of surrounding
>  	context exist they all must match.  By default no context is
>  	ever ignored.
> -	Incompatible with the --merge and --interactive options, or
> -	anything that implies those options or their machinery.
> +	Incompatible with the --interactive option, or anything that
> +	uses the `--interactive` machinery.
>  
>  -f::
>  --force-rebase::
> @@ -361,15 +365,15 @@ default is `--no-fork-point`, otherwise the default is `--fork-point`.
>  --whitespace=<option>::
>  	These flag are passed to the 'git apply' program
>  	(see linkgit:git-apply[1]) that applies the patch.
> -	Incompatible with the --merge and --interactive options, or
> -	anything that implies those options or their machinery.
> +	Incompatible with the --interactive option, or anything that
> +	uses the `--interactive` machinery.
>  
>  --committer-date-is-author-date::
>  --ignore-date::
>  	These flags are passed to 'git am' to easily change the dates
>  	of the rebased commits (see linkgit:git-am[1]).
> -	Incompatible with the --merge and --interactive options, or
> -	anything that implies those options or their machinery.
> +	Incompatible with the --interactive option, or anything that
> +	uses the `--interactive` machinery.
>  
>  --signoff::
>  	Add a Signed-off-by: trailer to all the rebased commits. Note

For above-mentioned reason, I'd suggest dropping these three hunks.

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 1f2401f702..dcc4a26a78 100644
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
> @@ -885,7 +885,10 @@ init_basic_state () {
>  	mkdir -p "$state_dir" || die "$(eval_gettext "Could not create temporary \$state_dir")"
>  	rm -f "$(git rev-parse --git-path REBASE_HEAD)"
>  
> -	: > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"
> +	if test -n "$actually_interactive"
> +	then
> +		: > "$state_dir"/interactive || die "$(gettext "Could not mark as interactive")"
> +	fi

Do we really care at this stage? IOW what breaks if we still write that
file, even in --merge mode?

> diff --git a/git-rebase.sh b/git-rebase.sh
> index b639c0d4fe..5ac1dee30b 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -239,12 +239,10 @@ then
>  	state_dir="$apply_dir"
>  elif test -d "$merge_dir"
>  then
> +	type=interactive
>  	if test -f "$merge_dir"/interactive
>  	then
> -		type=interactive
>  		interactive_rebase=explicit
> -	else
> -		type=merge
>  	fi
>  	state_dir="$merge_dir"
>  fi

This makes me think even more that we don't care...

> @@ -481,13 +479,16 @@ then
>  	test -z "$interactive_rebase" && interactive_rebase=implied
>  fi
>  
> +actually_interactive=
>  if test -n "$interactive_rebase"
>  then
>  	type=interactive
> +	actually_interactive=t
>  	state_dir="$merge_dir"
>  elif test -n "$do_merge"
>  then
> -	type=merge
> +	interactive_rebase=implied
> +	type=interactive
>  	state_dir="$merge_dir"
>  else
>  	type=am
> @@ -501,17 +502,11 @@ fi
>  
>  if test -n "$git_am_opt"; then
>  	incompatible_opts=`echo "$git_am_opt" | sed -e 's/ -q//'`
> -	if test -n "$interactive_rebase"
> +	if test -n "$incompatible_opts"

Did you not mean to turn this into a test for actually_interactve ||
do_merge?

>  	then
> -		if test -n "$incompatible_opts"
> +		if test -n "$actually_interactive" || test "$do_merge"

This could now be combined with the previous if (and the `-n` could be
added to the latter test):

	if test -n "$actually_interactive" -o -n "$do_merge" &&
		test -n "$incompatible_opts"

The indentation would change, but this hunk is already confusing to read,
anyway, so...

>  		then
> -			die "$(gettext "error: cannot combine interactive options (--interactive, --exec, --rebase-merges, --preserve-merges, --keep-empty, --root + --onto) with am options ($incompatible_opts)")"
> -		fi
> -	fi
> -	if test -n "$do_merge"; then
> -		if test -n "$incompatible_opts"
> -		then
> -			die "$(gettext "error: cannot combine merge options (--merge, --strategy, --strategy-option) with am options ($incompatible_opts)")"
> +			die "$(gettext "error: cannot combine am options ($incompatible_opts) with either interactive or merge options")"
>  		fi
>  	fi
>  fi
> @@ -660,7 +655,7 @@ require_clean_work_tree "rebase" "$(gettext "Please commit or stash them.")"
>  # but this should be done only when upstream and onto are the same
>  # and if this is not an interactive rebase.
>  mb=$(git merge-base "$onto" "$orig_head")
> -if test "$type" != interactive && test "$upstream" = "$onto" &&
> +if test -z "$actually_interactive" && test "$upstream" = "$onto" &&
>  	test "$mb" = "$onto" && test -z "$restrict_revision" &&
>  	# linear history?
>  	! (git rev-list --parents "$onto".."$orig_head" | sane_grep " .* ") > /dev/null
> @@ -704,6 +699,22 @@ then
>  	GIT_PAGER='' git diff --stat --summary "$mb" "$onto"
>  fi
>  
> +if test -z "$actually_interactive"
> +then
> +	# If the $onto is a proper descendant of the tip of the branch, then
> +	# we just fast-forwarded.
> +	if test "$mb" = "$orig_head"
> +	then

Likewise, this would be easier to read as

	if test -z "$actually_interactive" && test "$mb" = "$orig_head"

Also: how certain are we that "$mb" does not start with a dash? We may
have to use the `test a"$mb" = a"$orig_head"` trick here... But I guess
this is moved code, so if it is buggy, it was buggy before.

> +		say "$(eval_gettext "Fast-forwarded \$branch_name to \$onto_name.")"
> +		GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name" \
> +			git checkout -q "$onto^0" || die "could not detach HEAD"
> +		git update-ref ORIG_HEAD $orig_head
> +		move_to_original_branch
> +		finish_rebase
> +		exit 0
> +	fi
> +fi
> +
>  test "$type" = interactive && run_specific_rebase
>  
>  # Detach HEAD and reset the tree
> @@ -713,16 +724,6 @@ GIT_REFLOG_ACTION="$GIT_REFLOG_ACTION: checkout $onto_name" \
>  	git checkout -q "$onto^0" || die "could not detach HEAD"
>  git update-ref ORIG_HEAD $orig_head
>  
> -# If the $onto is a proper descendant of the tip of the branch, then
> -# we just fast-forwarded.
> -if test "$mb" = "$orig_head"
> -then
> -	say "$(eval_gettext "Fast-forwarded \$branch_name to \$onto_name.")"
> -	move_to_original_branch
> -	finish_rebase
> -	exit 0
> -fi
> -
>  if test -n "$rebase_root"
>  then
>  	revisions="$onto..$orig_head"
> diff --git a/t/t3406-rebase-message.sh b/t/t3406-rebase-message.sh
> index 0392e36d23..04d6c71899 100755
> --- a/t/t3406-rebase-message.sh
> +++ b/t/t3406-rebase-message.sh
> @@ -17,14 +17,9 @@ test_expect_success 'setup' '
>  	git tag start
>  '
>  
> -cat >expect <<\EOF
> -Already applied: 0001 A
> -Already applied: 0002 B
> -Committed: 0003 Z
> -EOF
> -
>  test_expect_success 'rebase -m' '
>  	git rebase -m master >report &&
> +	>expect &&
>  	sed -n -e "/^Already applied: /p" \
>  		-e "/^Committed: /p" report >actual &&
>  	test_cmp expect actual

This might be called a regression... I don't know any user of `git rebase
-m`, but I guess if I was one, I would like to keep seeing those messages.

It *should* be relatively easy to tell the sequencer.c to issue these
messages, I think. But it would be more work.

> diff --git a/t/t3421-rebase-topology-linear.sh b/t/t3421-rebase-topology-linear.sh
> index 99b2aac921..911ef49f70 100755
> --- a/t/t3421-rebase-topology-linear.sh
> +++ b/t/t3421-rebase-topology-linear.sh
> @@ -111,7 +111,7 @@ test_run_rebase () {
>  	"
>  }
>  test_run_rebase success ''
> -test_run_rebase failure -m
> +test_run_rebase success -m
>  test_run_rebase success -i
>  test_run_rebase success -p
>  
> @@ -126,7 +126,7 @@ test_run_rebase () {
>  	"
>  }
>  test_run_rebase success ''
> -test_run_rebase failure -m
> +test_run_rebase success -m
>  test_run_rebase success -i
>  test_run_rebase success -p
>  
> @@ -141,7 +141,7 @@ test_run_rebase () {
>  	"
>  }
>  test_run_rebase success ''
> -test_run_rebase failure -m
> +test_run_rebase success -m
>  test_run_rebase success -i
>  test_run_rebase success -p
>  
> @@ -284,7 +284,7 @@ test_run_rebase () {
>  	"
>  }
>  test_run_rebase success ''
> -test_run_rebase failure -m
> +test_run_rebase success -m
>  test_run_rebase success -i
>  test_run_rebase success -p
>  
> @@ -315,7 +315,7 @@ test_run_rebase () {
>  	"
>  }
>  test_run_rebase success ''
> -test_run_rebase failure -m
> +test_run_rebase success -m
>  test_run_rebase success -i
>  test_run_rebase failure -p

Neat!

> diff --git a/t/t3425-rebase-topology-merges.sh b/t/t3425-rebase-topology-merges.sh
> index 846f85c27e..cd505c0711 100755
> --- a/t/t3425-rebase-topology-merges.sh
> +++ b/t/t3425-rebase-topology-merges.sh
> @@ -72,7 +72,7 @@ test_run_rebase () {
>  }
>  #TODO: make order consistent across all flavors of rebase
>  test_run_rebase success 'e n o' ''
> -test_run_rebase success 'e n o' -m
> +test_run_rebase success 'n o e' -m
>  test_run_rebase success 'n o e' -i
>  
>  test_run_rebase () {
> @@ -89,7 +89,7 @@ test_run_rebase () {
>  }
>  #TODO: make order consistent across all flavors of rebase
>  test_run_rebase success 'd e n o' ''
> -test_run_rebase success 'd e n o' -m
> +test_run_rebase success 'd n o e' -m
>  test_run_rebase success 'd n o e' -i
>  
>  test_run_rebase () {
> @@ -106,7 +106,7 @@ test_run_rebase () {
>  }
>  #TODO: make order consistent across all flavors of rebase
>  test_run_rebase success 'd e n o' ''
> -test_run_rebase success 'd e n o' -m
> +test_run_rebase success 'd n o e' -m
>  test_run_rebase success 'd n o e' -i

Nice!

>  test_expect_success "rebase -p is no-op in non-linear history" "
> diff --git a/t/t5407-post-rewrite-hook.sh b/t/t5407-post-rewrite-hook.sh
> index 9b2a274c71..145c61251d 100755
> --- a/t/t5407-post-rewrite-hook.sh
> +++ b/t/t5407-post-rewrite-hook.sh
> @@ -120,6 +120,7 @@ test_expect_success 'git rebase -m --skip' '
>  	git rebase --continue &&
>  	echo rebase >expected.args &&
>  	cat >expected.data <<-EOF &&
> +	$(git rev-parse C) $(git rev-parse HEAD^)
>  	$(git rev-parse D) $(git rev-parse HEAD)
>  	EOF
>  	verify_hook_input

This is a bit sad, because it seems to suggest that we now do more
unnecessary work here, or is my reading incorrect?

Thanks,
Dscho
