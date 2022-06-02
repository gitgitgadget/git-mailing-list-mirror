Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1F8DC43334
	for <git@archiver.kernel.org>; Thu,  2 Jun 2022 15:36:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbiFBPgs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Jun 2022 11:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236498AbiFBPgr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Jun 2022 11:36:47 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40D0E02E
        for <git@vger.kernel.org>; Thu,  2 Jun 2022 08:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1654184201;
        bh=cMBBcEyrU240T5ytUsahaGWqRCWAv1b4PKHdTbR2Vnc=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Yorwo7BbpCQIMG9J2RgpAwzOhRakF3oxI/N5Z26GED7v0U/XMo8PNXWVa7LctVOoL
         Gw9+OoEQyGRdr4lmsvdSlc5d8Zbz73fgDa79l5D1xHXKAyWc/sy1UUWdI2xXIuEaZG
         dM+A+wQMBOcEjcK/kHyZly6XU3vn6t3ZFb4rRloM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.19.206.165] ([89.1.212.145]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mr9Bk-1nTWgB1TLq-00oI28; Thu, 02
 Jun 2022 17:36:41 +0200
Date:   Thu, 2 Jun 2022 17:36:40 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] range-diff: show submodule changes irrespective of
 diff.submodule
In-Reply-To: <pull.1244.git.1653916145441.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2206021724240.349@tvgsbejvaqbjf.bet>
References: <pull.1244.git.1653916145441.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:hn4Kx32Y7/5BjZRJNqZD87iCwcdJbxvSHt58zsIgwti11scTld4
 aWAN5FO68pYFOvMuq6IMmKOR4ZnkTDdf7Y7mxIbaJooRTakts2++wwUI69mi80v1reggu01
 sLgZeaocydQLr+0Hmapj5DyWTg5gpz8konWIzzTafX+QReOT1CTkLUhNnBMJxINneLSVWNo
 UzVEaU3BmjWSudTd8RfZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PEmsE/FnOu0=:4nbnJ3EXEm4ifg7F4Q9GzL
 ER7SVzYmDIRLAF39KxOX91w7ksudTvg9S1vULOGBMHIugGSQ55Ac8F62oVLDOV0Dlx4XM9AKK
 yk81yd83CxWsW5nrndjU1ib/7qP9T20FkqJIf4uTNFNA5/kaeprTzh1RE6sRXtGuKCxiuPX4o
 cZAqUrIq3kpZbtCO5Im+c163ai2mNS8RsInIQA4rcEJt56vnbg5rTeYGh8n5Qsz71hn+1xY0A
 HEoJYeQ57mMWd1aLE8biLrnjnUBHhqFUOKSZtqU+Tlp2BUC7ivz3arqFA6S7COsA1OEh1QErN
 9rVFOZKWRD9vFTctQJAW/TFu0e5NDpsPMTCCwX2ZqqPQMSJdI09AkfPyhfqDAKZzaUOP0hRPa
 AWW2UGBdwYspWaOxUprScft3xOloxYKy7A3yFChH2U71Mc8C0C8K4ipJxyq4mN9A2dXlhwaX4
 XQYND6cnGFtPs2mZyqaeNWDsbcUL9dAl5bKk7wEtJObU3+IMSA/klmUoagbR80wl3za8jtjkn
 voLj6oTCGYwTLZOx31XOhHYw9ex2J1CC4vBcuGBsQliIHRf+OV/K/9ynEDG1K3GbwJ+H1Hfla
 eZb3QzjMVRXycC3lfVDz2Ay23liMkvAcr5b9blU1GWP64txJi5ZnpmkMHzQpTO0s09D+Dten3
 ZHy6Z/oXttBzUwAk7khWSwGgl7iu8mJ7Qq1SMzD/LZzLDVsdjF1yvI8Bbbl8WqFQ15KDywG5k
 tp/dWtxELtbLFQCfRW4zsaZD4lwfmSvyVwvVeT79NY1YjM9itfBfm76UPfW1ShHZ6YpDb6q99
 /WE/KZGlPj3hQqaR2p9qEYx0z2/qW8VwwIl4/VTWPUTe8t2z7CE7q/NqDmSZTd70wWvmPfrpH
 o12x2ScyWjsF3o/RMy6xWJOCjmtRmXrGht8zCobvcF+p5Bo6qninonDaK1soRQX2uib4nLfXT
 82mYdaSNXEf+IO+klvtEv2lv8TIYEjxvRewA8pGGN4gwoqKcaFJMf+2y5R3GqBfYHkHTOruq6
 rbXPIMqK5A2UaNi+tKf+eac3r9qt2rbOF3nhZzOnRxP0syA1WWRzd8eilZtWwMqk2fXqZr6+S
 MkhFRF4WtbeCWsRxHvvmyT4CBbu3RJu8vj84rMxwKIEIxofaa4aAGP9cg==
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Philippe,

On Mon, 30 May 2022, Philippe Blain via GitGitGadget wrote:

> From: Philippe Blain <levraiphilippeblain@gmail.com>
>
> After generating diffs for each range to be compared using a 'git log'
> invocation, range-diff.c::read_patches looks for the "diff --git" header
> in those diffs to recognize the beginning of a new change.
>
> In a project with submodules, and with 'diff.submodule=3Dlog' set in the
> config, this header is missing for the diff of a changed submodule, so
> any submodule changes are quietly ignored in the range-diff.

This means that we can go two ways here: either we explicitly disable
`diff.submodule` for the invocation that is spawned from `range-diff`, or
we allow it but then handle the diff header as expected.

>
> When 'diff.submodule=3Ddiff' is set in the config, the "diff --git" head=
er
> is also missing for the submodule itself, but is shown for submodule
> content changes, which can easily confuse 'git range-diff' and lead to
> errors such as:
>
>     error: git apply: bad git-diff - inconsistent old filename on line 1
>     error: could not parse git header 'diff --git path/to/submodule/and/=
some/file/within
>     '
>     error: could not parse log for '@{u}..@{1}'
>
> Force the submodule diff format to its default ("short") when invoking
> 'git log' to generate the patches for each range, such that submodule
> changes are always shown.

Full disclosure: I do not see much value in range-diffs in the presence of
submodules. Nothing in the design of range-diffs is prepared for
submodules.

But since `--submodules=3Dshort` does not change anything when running
`range-diff` in repositories without submodules, I don't mind this change.

>
> Note that the test must use '--creation-factor=3D100' to force the secon=
d
> commit in the range not to be considered a complete rewrite.

Thank you for this considerate note!

>
> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
> ---
>     range-diff: show submodule changes irrespective of diff.submodule
>
>     This fixes a bug that I reported last summer [1].
>
>     [1]
>     https://lore.kernel.org/git/e469038c-d78c-cd4b-0214-7094746b9281@gma=
il.com/
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1244%2=
Fphil-blain%2Frange-diff-submodule-diff-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1244/phil=
-blain/range-diff-submodule-diff-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1244
>
>  range-diff.c          |  2 +-
>  t/t3206-range-diff.sh | 44 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+), 1 deletion(-)
>
> diff --git a/range-diff.c b/range-diff.c
> index b72eb9fdbee..068bf214544 100644
> --- a/range-diff.c
> +++ b/range-diff.c
> @@ -44,7 +44,7 @@ static int read_patches(const char *range, struct stri=
ng_list *list,
>
>  	strvec_pushl(&cp.args, "log", "--no-color", "-p", "--no-merges",
>  		     "--reverse", "--date-order", "--decorate=3Dno",
> -		     "--no-prefix",
> +		     "--no-prefix", "--submodule=3Dshort",

As I mentioned above, since this does not change anything in the intended
scenarios (i.e. without submodules), I am fine with it.

>  		     /*
>  		      * Choose indicators that are not used anywhere
>  		      * else in diffs, but still look reasonable
> diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
> index e30bc48a290..ac848c42536 100755
> --- a/t/t3206-range-diff.sh
> +++ b/t/t3206-range-diff.sh
> @@ -772,4 +772,48 @@ test_expect_success '--left-only/--right-only' '
>  	test_cmp expect actual
>  '
>
> +test_expect_success 'submodule changes are shown irrespective of diff.s=
ubmodule' '
> +	git init sub-repo &&
> +	test_commit -C sub-repo sub-first &&
> +	sub_oid1=3D$(git -C sub-repo rev-parse HEAD) &&
> +	test_commit -C sub-repo sub-second &&
> +	sub_oid2=3D$(git -C sub-repo rev-parse HEAD) &&
> +	test_commit -C sub-repo sub-third &&
> +	sub_oid3=3D$(git -C sub-repo rev-parse HEAD) &&
> +
> +	git checkout -b main-sub topic &&
> +	git submodule add ./sub-repo sub &&
> +	git -C sub checkout --detach sub-first &&
> +	git add sub &&
> +	git commit -m "add sub" &&

Just a suggestion: use `git commit -m sub-first sub` instead (one `git`
invocation instead of two).

> +	sup_oid1=3D$(git rev-parse --short HEAD) &&
> +	git checkout -b topic-sub &&
> +	git -C sub checkout sub-second &&
> +	git add sub &&
> +	git commit -m "change sub" &&
> +	sup_oid2=3D$(git rev-parse --short HEAD) &&
> +	git checkout -b modified-sub main-sub &&

Another suggestion: instead of naming the branches, use the `sup_oid*`
variables directly.

> +	git -C sub checkout sub-third &&
> +	git add sub &&
> +	git commit -m "change sub" &&
> +	sup_oid3=3D$(git rev-parse --short HEAD) &&
> +
> +	test_config diff.submodule log &&
> +	git range-diff --creation-factor=3D100 topic topic-sub modified-sub >a=
ctual &&
> +	cat >expect <<-EOF &&
> +	1:  $sup_oid1 =3D 1:  $sup_oid1 add sub
> +	2:  $sup_oid2 ! 2:  $sup_oid3 change sub
> +	    @@ Commit message
> +	      ## sub ##
> +	     @@
> +	     -Subproject commit $sub_oid1
> +	    -+Subproject commit $sub_oid2
> +	    ++Subproject commit $sub_oid3
> +	EOF
> +	test_cmp expect actual &&
> +	test_config diff.submodule diff &&
> +	git range-diff --creation-factor=3D100 topic topic-sub modified-sub >a=
ctual &&
> +	test_cmp expect actual
> +'

This test case is very clear and concise, even without my suggested
changes. Therefore, if you want to keep the patch as-is, I am fine with
that, too.

Acked-by: Johannes Schindelin <johannes.schindelin@gmx.de>

Thank you,
Dscho

> +
>  test_done
>
> base-commit: 7a3eb286977746bc09a5de7682df0e5a7085e17c
> --
> gitgitgadget
>
