Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82F511F461
	for <e@80x24.org>; Mon, 24 Jun 2019 17:47:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728043AbfFXRrg (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Jun 2019 13:47:36 -0400
Received: from mout.gmx.net ([212.227.15.19]:52871 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726351AbfFXRrg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jun 2019 13:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1561398451;
        bh=Y6q9NZanMe3ORb5icwV9gZJzE3AF64JKOyJZjkXG1Bk=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=NuH35OkeXe7+iQG4mceN7i6s8lGqV58dVZrwCmwNo4q+S+2wy2Iha4ORtwPA9X1Vt
         I73OrDrFBJN59sC9VxsOVuCK52c2dVDOSvW3jqBB5+ozhPnSz1897uOcSTgQp8Iayd
         KRSCTxtPcsYBOlZJvKWaOyklKt0kckcvtITEHt3U=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.129] ([37.201.192.51]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MaJ7v-1i2PO33syj-00WJCM; Mon, 24
 Jun 2019 19:47:31 +0200
Date:   Mon, 24 Jun 2019 19:47:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Morian Sonnet <moriansonnet@gmail.com>
cc:     Morian Sonnet <MorianSonnet@googlemail.com>, git@vger.kernel.org,
        gitgitgadget@gmail.com, gitster@pobox.com, sunshine@sunshineco.us,
        Morian Sonnet <moriansonnet@googlemail.com>
Subject: Re: [PATCH] submodule foreach: fix recursion of options
In-Reply-To: <20190624154750.19842-2-MorianSonnet@googlemail.com>
Message-ID: <nycvar.QRO.7.76.6.1906241947210.44@tvgsbejvaqbjf.bet>
References: <20190624154050.9943-2-MorianSonnet@googlemail.com> <20190624154750.19842-2-MorianSonnet@googlemail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:t1oITel17RL0EKvIjZIBTZ1KaOiHjUDy+PXz+REC8rDw8qoCAcQ
 vHNZCCOekledh3e7BkQJcP7+dM4rFPB6sVTGNpY4DO0Xtnc0TT6GmE04dEu8HN5WkPXIBJi
 mnR700Wk/Te3wXKBC3elzi8modh6waVLODgPpTQVrPerv2w2bWrGXW4jQfgtHGikHzhvQQ2
 S19+QSey+jt6440WUCWsA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/qrJslIcEzU=:BPTYprqtoCoVqaEP5d25GR
 S6GZvFq10c69sWzKVazJsKYLRZOTEf4X+S2x/z1wTxVmAxJeZpPUrs5gGWKz6rAziZXX4tkz5
 npSyF4Jmy2CpJSQZiY/gClfhJgL+624Fqt3W9hHJS1fbG7otYbbKfPTkoUUQ/F0hSvAm67k0X
 rbHNmiuJDQ/2BrQ3z4lyVWW9y36wzgITyZwr8vefWwjh6ivUKlE5copXLKm/iRzA4mzq/B+81
 a7Y74/B6Npr7MnltjkG1GSAkpY7aY/M7kbLoPkaZdc8aW/PY1KXR0U+HSRLd24z0U7a3iC4xa
 6n+ACcBy1moiuhH9A72V5FINC2w1Gs7/0sssmjyt7OzaqhM2fscTn2UIa/5sXGlrzMW6x2SF6
 hgsmeo6NADdUxU4QVvh73HHlyKuEjRvEgPAG+m33djvffz2oGAWnvvBUPcfFJZWu+aJGtRSC5
 ajPfqvo7gCAwWtkAAITvuz2NyrpfMejeffKsQZS19jaEMFmkquRw6z+Ihjtl4XlL489+NPw+g
 jX8bMGuO6ynl6+g6nmQVJAXgaccbeAiqS67aEu2lOmpbW3dA4zXY77vZCWzO+cO6d8JjdDuxP
 VegfZkiFElxJnKhB3ok1p+4Wdmbst4wLjC9oE+mCLz14hwMSmiche+1NC54jt0ak2nKJ1+THj
 M9Qh4PmQChyleCVBtc0VUHTz8eW6ayQ7f4KP0pz9VNhKVFdQqQ2mmSZHkqK5wg7Q7DRl0GRs6
 XHiGnfGSew+gFwq3464d80UqixobRqRv2jskZ4Hfoxo6FMEXOb4eq1OUXYpCNFI1WTokZB9Qz
 fTRJJy142OIfVjLuxQoArCQM5XutFuKO36Rp2fO2i2xrRnUDi0C62F3GaFr8vtCTmICIQ+P0Q
 IzmW9QZFPOqDpsxBgSLYIbPDpVaDjABB0SZabkXHXQtI/OdJkKv93cqd1c0vstGv998drJLF8
 SGJcG4+4T+5hQxoJxi/CiM94GosSvzu3cwlCS8CUejKriYr/OV2oL
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Morian,

On Mon, 24 Jun 2019, Morian Sonnet wrote:

> Calling
>
>     git submodule foreach --recursive <subcommand> --<option>
>
> leads to an error stating that the option --<option> is unknown to
> submodule--helper. That is of course only, when <option> is not a valid
> option for git submodule foreach.
>
> The reason for this is, that above call is internally translated into a
> call to submodule--helper:
>
>     git submodule--helper foreach --recursive \
>         -- <subcommand> --<option>
>
> This call starts by executing the subcommand with its option inside the
> first first level submodule and continues by calling the next iteration
> of the submodule foreach call
>
>     git --super-prefix <submodulepath> submodule--helper \
>       foreach --recursive <subcommand> --<option>
>
> inside the first level submodule. Note that the double dash in front of
> the subcommand is missing.
>
> This problem starts to arise only recently, as the
> PARSE_OPT_KEEP_UNKNOWN flag for the argument parsing of git submodule
> foreach was removed in commit a282f5a906. Hence, the unknown option is
> complained about now, as the argument parsing is not properly ended by
> the double dash.
>
> This commit fixes the problem by adding the double dash in front of the
> subcommand during the recursion.
>
> Signed-off-by: Morian Sonnet <moriansonnet@googlemail.com>

This version indeed addresses all my outstanding comments. Thank you!
Johannes

> ---
>  builtin/submodule--helper.c  | 1 +
>  t/t7407-submodule-foreach.sh | 7 +++++++
>  2 files changed, 8 insertions(+)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 0bf4aa088e..afaf0819c9 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -540,6 +540,7 @@ static void runcommand_in_submodule_cb(const struct =
cache_entry *list_item,
>  		if (info->quiet)
>  			argv_array_push(&cpr.args, "--quiet");
>
> +		argv_array_push(&cpr.args, "--");
>  		argv_array_pushv(&cpr.args, info->argv);
>
>  		if (run_command(&cpr))
> diff --git a/t/t7407-submodule-foreach.sh b/t/t7407-submodule-foreach.sh
> index 706ae762e0..43da184d40 100755
> --- a/t/t7407-submodule-foreach.sh
> +++ b/t/t7407-submodule-foreach.sh
> @@ -421,4 +421,11 @@ test_expect_success 'option-like arguments passed t=
o foreach commands are not lo
>  	test_cmp expected actual
>  '
>
> +test_expect_success 'option-like arguments passed to foreach recurse co=
rrectly' '
> +  git -C clone2 submodule foreach --recursive "echo be --an-option" > e=
xpected &&
> +  git -C clone2 submodule foreach --recursive echo be --an-option > act=
ual &&
> +  grep -e "--an-option" expected &&
> +  test_cmp expected actual
> +'
> +
>  test_done
> --
> 2.20.1
>
>
