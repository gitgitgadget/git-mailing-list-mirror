Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBF81ECAAD1
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 09:17:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233873AbiIAJRn (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 05:17:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbiIAJRm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 05:17:42 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3D11208C6
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 02:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1662023854;
        bh=4ILvPmAyj2Th1HIstNv3BIi04QIRdeUB/T9Sa8QfVDo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=FrHcHGnw5AkZD/1O2p3+GvZUpRyoqkXs9IA3mksti0jbV654vcdhLHoRG75QeHw0d
         xRXYtVyyjCn8PKZ69iV00k2flB8frIS1B0ZwUqHyzN2+b22WvXCdF8FyZkuOdmAhvk
         XsfyOn1/uZY8gattx/Ojkw99CRX4d6F3JfHtckWs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.220.106] ([213.196.212.69]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mk0JW-1pDyMQ2srA-00kRKm; Thu, 01
 Sep 2022 11:17:34 +0200
Date:   Thu, 1 Sep 2022 11:17:33 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, derrickstolee@github.com, gitster@pobox.com,
        Victoria Dye <vdye@github.com>,
        Johannes Schindelin <johasc@microsoft.com>
Subject: Re: [PATCH 4/8] scalar: implement the `help` subcommand
In-Reply-To: <46d0fddfe8fbc2c568cb5a3d14594276db2bc1a9.1661961746.git.gitgitgadget@gmail.com>
Message-ID: <12037768-r742-rs85-3406-rp790p5p3r8n@tzk.qr>
References: <pull.1341.git.1661961746.gitgitgadget@gmail.com> <46d0fddfe8fbc2c568cb5a3d14594276db2bc1a9.1661961746.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:T7PZbxsdvBuR3Bkc0ju3M2dwNbPXz+f+5pxAbWMUqus0o8muEOu
 FEIxaxo3S/gdZ21cBBJ5tSxmidPWS/BbKfeLCMc4ayIZF3lnQqG4p5awOY9d9AT6oiQF6Fv
 Ja9yUJ1eszeXMrs507hlEDMZdT7XdeouAHsOETm9sCcjMgyQsHVRLd1xQk6CFLVOuJrKFYl
 I4IpTKHoJ6PFd3fvuvKZQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:n2OdTah+p38=:lBTLSLBOMLfYJ61cqubOhy
 9r8VWl+BaAtqlCJlZ98fuJXCRvLeTJZrtbVyYnxRSrINn6cUR77V2hLrxj8qMXPqSoiMK0JGC
 b8SgxOoCN5TNAKcTZvpRuHuhyLoR7J0fwHYkG7pgpUNFljhgcjxKQKTz5o7fcp0MHHhFYQOTj
 mSdrHPwueyWrXrI1VsWJWH/ZbgN/e9NwMzevq6As1+Os33am1PXXw7Ze/bZtUIg3ytbQUyssR
 9O4gqAKpmlufHwvFkf15cTFH2vEns4v7Db3rc10m7KAwD3u5pJUykRFJxM3MxoJJFynkD7RGd
 xvrG8MWik6p5ZzLbndHQRWrLgd+k7UBoGLMmAzXeGu5hjGFWuflbQ6TEKgpEvnwS89wIH7x16
 pmMON0/mfcjGdg674d6ORg6acXXYlJgJhF646pH2DBri+88xgg4g9r/ONQb7Pe5S1HPPNVN/k
 ihqh2HIFrIGWwZvTz1ChesPb4GMk47TE1AsjpcW1QvQTLqp4KRio9B/0oylrAyNHeE+Cd8t1P
 QphvLKI781yk/nhjN/PVfCfGtLShtcXk1aeCCJXfi/Rlwv9HwEc3DjjE73kwIHM1wScSgYaNH
 vq87WgotzNZHNDrZ2Z6Hcwdqtwwb+obPwhhvYR9XoA1cf61QqgvwTJCC9uLedFH3zoj4lSifl
 ivr5RXCu1zRg35N30UC7XSGE1+ZiGxIVyoBOIEmkjCxgobMshciv2Cfwr6CaM9drc8iHFpruc
 /SNcwhyoGT0fJLVYq6UjFYArfZR5X/lnxdA7TXElB9vdXF1oH/3zQbbnevT/SgtUH9+L62bW8
 AY4xzRNTL9B/53ebUxpEHUKQTyOHUe6uaZhBAuLhDmHzNVIDHeOdkZZ/GDD0VBLC3nT6LO8xj
 RlH8gG/D5ST4Gi0Wkp0u8aMLWL1AyMHMI/83IDYwxmQ7/jXOx9ooPmMgkda12H1AdvpEJVC5L
 6yhr7rdB/oQGmiU9bJTGTUP7FENU6zoAr8ptwsCZpc1540vAKigNu69azhCR0epcuAU+hvYyT
 QP4FWPf3Z0iIgmm0j0+0KesWZiH8AME1knG5/c4o8uwft3QsY4frNIwr3apQ3BvwMHD2cjvfu
 2SbIsvVhNCT9rOJLr9D4PKWKQ3fLIfRyVprulXQsyEGEB0S/z7PIn7L92MriSYXw2QW6YLGqB
 EMv2+M4KmjM7/GV42N0nBju012
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Victoria,

On Wed, 31 Aug 2022, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johasc@microsoft.com>
>
> It is merely handing off to `git help scalar`.
>
> Signed-off-by: Johannes Schindelin <johasc@microsoft.com>
> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  scalar.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/scalar.c b/scalar.c
> index 642d16124eb..675d7a6b0a9 100644
> --- a/scalar.c
> +++ b/scalar.c
> @@ -819,6 +819,25 @@ static int cmd_delete(int argc, const char **argv)
>  	return res;
>  }
>
> +static int cmd_help(int argc, const char **argv)
> +{
> +	struct option options[] =3D {
> +		OPT_END(),
> +	};
> +	const char * const usage[] =3D {
> +		N_("scalar help"),
> +		NULL
> +	};
> +
> +	argc =3D parse_options(argc, argv, NULL, options,
> +			     usage, 0);
> +
> +	if (argc !=3D 0)
> +		usage_with_options(usage, options);
> +
> +	return run_git("help", "scalar", NULL);
> +}
> +
>  static int cmd_version(int argc, const char **argv)
>  {
>  	int verbose =3D 0, build_options =3D 0;
> @@ -858,6 +877,7 @@ static struct {
>  	{ "run", cmd_run },
>  	{ "reconfigure", cmd_reconfigure },
>  	{ "delete", cmd_delete },
> +	{ "help", cmd_help },

Marking this as a tangent ("optional", as some peeps suggested in the Git
standup on IRC [*1*]) with the suggestion to follow up _after_ this here
patch series is done cooking, i.e. once it hits the main branch:

We probably want to migrate `scalar.c` to use the `OPT_SUBCOMMAND` API.

But as I said, please not in this here patch series, so as to separate
concerns properly.

Thanks,
Dscho

>  	{ "version", cmd_version },
>  	{ "diagnose", cmd_diagnose },
>  	{ NULL, NULL},
> --
> gitgitgadget

Footnote *1*:
https://colabti.org/irclogger/irclogger_log/git-devel?date=3D2022-08-29#l5=
0
