Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9873C1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 15:42:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbeGLPwO (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 11:52:14 -0400
Received: from mout.gmx.net ([212.227.15.18]:36031 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726703AbeGLPwO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 11:52:14 -0400
Received: from [192.168.0.129] ([37.201.195.126]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MOwbP-1fg5lx3vHj-006KZV; Thu, 12
 Jul 2018 17:41:59 +0200
Date:   Thu, 12 Jul 2018 17:41:42 +0200 (DST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Elijah Newren <newren@gmail.com>
cc:     gitster@pobox.com, git@vger.kernel.org, phillip.wood@dunelm.org.uk,
        sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: Re: [PATCH v3 2/2] Fix use of strategy options with interactive
 rebases
In-Reply-To: <20180627154804.3743-3-newren@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1807121740270.75@tvgsbejvaqbjf.bet>
References: <20180627073623.31725-1-newren@gmail.com> <20180627154804.3743-1-newren@gmail.com> <20180627154804.3743-3-newren@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:1OSO+Cr70z4XKIWKi4Su/e+ew1UTOUUxCtrET+TzSVGsO+6GWaX
 XPxCK71GAU5QrbeW9T1J0o1ff7OuQ8IXcEOIo6FeVJgBMeCEwwINaMCeLfpXzPbhC6aKPZr
 dumIFdH5ZGdo7JSTM09g+VlgVgqeAXveMPaRq3USmZ7AKMIE/i0/yBCBJqWtvwIvCaPAZ2s
 55pNDHr0OVt6+/r/UKHcQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:o3Ip8j5M2wo=:GIoopapke1WsgqewS+dluO
 2ZpxjuPGhRelheCTtK44mroflzleUIqc1ZFEOI6XrTMxylz+lwZrUO0mxiLebjHMwRFWMoQP8
 Ly1WqTWJaoJsjslWug5QmxejF51439dbZSsrfS85EgxAfUcjnVHrtnojUa+q8+OTUsDJIkphU
 DI/S1XAEc+z60b50HACuZzl7NCLldCjneCyFvaQeZc4JV7z22hg+VGE97+mvzUcmWbp4drXMX
 K/PnDGjILaHF7gJ0w0t8gdI59+7B1WndgHjEtrQEcPuslzyKROUhTuU80NEoPB2N7YZV6YotA
 H79D+TE4zRn5gXiNofJZ/ImEsY3RCsqsM6c/1M67FqgZiORc2Z6mjss5mK5NJBrvT024gaCza
 F/O6mLNKEe2rCOzh0XuiaIkUWPeQWgRSm7DaC17LN4qtr3cWJcSeueOnERB7qxhPySIuGw3mc
 0MUAuRuGjSIqiM+s6DyvXimutn+tqI8whVgMpN0ICBKcmWl4F8S+npZ5B5GHIzEHs5Vix8zXc
 djdopdiPFe5UA4KDj5yHriSHZmIeZs3xWxDQcw7cZwVXXPlZzqOG6/X318yDWJNhng48ptT+1
 7K61G5PEY7LhWvUxLGRgMip/Wh4qPdJ9Y1YndOciuAEWY67yvt+Iy0v38S5g/v+uXxoY1/tjR
 LYwE3jKwyyXEKCPot8RGpqPG3YJXhfrpyIlgy0UFEOugJ3vtkTn4wKSOZLcGbUGXO8JCDofS3
 kTg+wpiTKRkOPRg8Y5wokw5/V3kQBc0bFjLZtxNB2BozBV4L8Kdh/jXIzprWDLcrlShv8o+pr
 dqrMgJU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah,

On Wed, 27 Jun 2018, Elijah Newren wrote:

> git-rebase.sh wrote strategy options to .git/rebase/merge/strategy_opts
> in the following format:
>   '--ours'  '--renormalize'
> Note the double spaces.
> 
> git-rebase--interactive uses sequencer.c to parse that file, and
> sequencer.c used split_cmdline() to get the individual strategy options.
> After splitting, sequencer.c prefixed each "option" with a double dash,
> so, concatenating all its options would result in:
>   -- --ours -- --renormalize
> 
> So, when it ended up calling try_merge_strategy(), that in turn would run
>   git merge-$strategy -- --ours -- --renormalize $merge_base -- $head $remote
> 
> instead of the expected/desired
>   git merge-$strategy --ours --renormalize $merge_base -- $head $remote
> 
> Remove the extra spaces so that when it goes through split_cmdline() we end
> up with the desired command line.
> 
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  git-rebase.sh              | 2 +-
>  sequencer.c                | 7 ++++++-
>  t/t3418-rebase-continue.sh | 2 +-
>  3 files changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/git-rebase.sh b/git-rebase.sh
> index 19bdebb480..f3b10c7f62 100755
> --- a/git-rebase.sh
> +++ b/git-rebase.sh
> @@ -328,7 +328,7 @@ do
>  		do_merge=t
>  		;;
>  	--strategy-option=*)
> -		strategy_opts="$strategy_opts $(git rev-parse --sq-quote "--${1#--strategy-option=}")"
> +		strategy_opts="$strategy_opts $(git rev-parse --sq-quote "--${1#--strategy-option=}" | sed -e s/^.//)"

Didn't you mean to use "s/^ *//" instead?

>  		do_merge=t
>  		test -z "$strategy" && strategy=recursive
>  		;;
> diff --git a/sequencer.c b/sequencer.c
> index 5354d4d51e..ef9237c814 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -2206,6 +2206,7 @@ static int populate_opts_cb(const char *key, const char *value, void *data)
>  static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
>  {
>  	int i;
> +	char *strategy_opts_string;
>  
>  	strbuf_reset(buf);
>  	if (!read_oneliner(buf, rebase_path_strategy(), 0))
> @@ -2214,7 +2215,11 @@ static void read_strategy_opts(struct replay_opts *opts, struct strbuf *buf)
>  	if (!read_oneliner(buf, rebase_path_strategy_opts(), 0))
>  		return;
>  
> -	opts->xopts_nr = split_cmdline(buf->buf, (const char ***)&opts->xopts);
> +	strategy_opts_string = buf->buf;
> +	if (*strategy_opts_string == ' ')

I think that this would ideally even be a `while` instead of an `if`.

> +		strategy_opts_string++;
> +	opts->xopts_nr = split_cmdline(strategy_opts_string,
> +				       (const char ***)&opts->xopts);
>  	for (i = 0; i < opts->xopts_nr; i++) {
>  		const char *arg = opts->xopts[i];
>  
> diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
> index 11546d6e14..c145dbac38 100755
> --- a/t/t3418-rebase-continue.sh
> +++ b/t/t3418-rebase-continue.sh
> @@ -74,7 +74,7 @@ test_expect_success 'rebase --continue remembers merge strategy and options' '
>  	test -f funny.was.run
>  '
>  
> -test_expect_failure 'rebase -i --continue handles merge strategy and options' '
> +test_expect_success 'rebase -i --continue handles merge strategy and options' '
>  	rm -fr .git/rebase-* &&
>  	git reset --hard commit-new-file-F2-on-topic-branch &&
>  	test_commit "commit-new-file-F3-on-topic-branch-for-dash-i" F3 32 &&

Thanks!
Dscho
