Return-Path: <SRS0=kZBr=7E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E59C433DF
	for <git@archiver.kernel.org>; Fri, 22 May 2020 13:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 970332070A
	for <git@archiver.kernel.org>; Fri, 22 May 2020 13:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="Uo29E++Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729940AbgEVNOM (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 May 2020 09:14:12 -0400
Received: from mout.gmx.net ([212.227.15.15]:50471 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729334AbgEVNOL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 May 2020 09:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1590153249;
        bh=TbrRZAc6zXUVnnovGByW0fRm3oSAmc8LWEro2Wg7fPY=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Uo29E++Y3g17aZNq5NESN2aEQl5vqFDRZGAKfHh1Stb2Cnr/QHWQ8/VVZUDSINWM7
         LnSKoSnoAXHTZZE7LEOdw/AUWCLd/T9lzdb+7du9CVTVMhBc8pSKaPB1vg7L91qOUm
         J8y/b1Sstm3Auk7FPXfvxouS8aFiNdKHn8FwdtcI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.23.211.123] ([213.196.213.226]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MTABZ-1jTZrb41V9-00UXVW; Fri, 22
 May 2020 15:14:09 +0200
Date:   Fri, 22 May 2020 15:14:06 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Miriam Rubio <mirucam@gmail.com>
cc:     git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH v3 01/12] bisect--helper: fix `cmd_*()` function switch
 default return
In-Reply-To: <20200423070704.39872-2-mirucam@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.2005221513060.56@tvgsbejvaqbjf.bet>
References: <20200423070704.39872-1-mirucam@gmail.com> <20200423070704.39872-2-mirucam@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:N823eEZQsUA+tSyxzxGcLBMiEk5dppcKv9T1IanxPgXsRxvJxpX
 AsqsGGixiA77DCeNAofCy3st066KHpNxJnYkHkHcKfn3aFG74U0V8Zf5fzqoLQlq1p26//T
 kg1rnvUN1KK+J8+6nDyaC5PNO6HKzpEKK4fVROIai5kLEJJGZ7jK56lJ5ftsbizQS44BvJT
 J/fkEnV4LwhAWlpOzbaAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:+xEqEuJ+xkk=:odZQNHlWjHbw5Um85QOYIn
 oyNZMZgZy9ISaSGaHvc145MEHW59SmY3Z5Onv2rskE2oCBlVOXFJeHdUpNE/xkW+lLrP+GIO8
 c3gmlnHTqAw84V4Ns+fzGCMUWkCPshEITn8vqYZhkKBTDOQQkF+5e5RqFydBZG594l+NapWf6
 +Ap/KU+7cMuh1nCf3TPs7zTzVKmCpVvpxdwd831GYYYgXgWO57YQZXXba9UIBDVavCuI/Ynkx
 OCIJJ6DH5d4yszZ0H0uEoQAEFI0NdtXAZkishfwMikFjfrahdt4czX+P3W3tRvtIe70I4vKCu
 2fH8XT7DZEvYtlTn4P/J9gCmnnmcqUxV/EIZhT2Y3e94ZZhr0ZE8K7ayI6XqAMEsBXlG/tQn+
 +iAd2SB2dI6bOmYYNRlkCGmIjLWPMcQ9dMcACYuMaT+fqtgT6wcfQ0bmkW0rwBEUh5Y3/LoEP
 nQev8tiYHmEr760DyPdFHJtBLLqKeeWcOJNLrPHb9eP9U+bwiojlfDTvpBUvz7qA7QADqsPcW
 J+A8mq1JixfawLJDwgOja0mK+23P1LWtb5ozK74R71ev4JDpxftvHeT7KpIQzjYFI85PcfbNc
 Y4mx2YcABS9rYh6ehvMGQLPRiSCLajUjuvN9YD0LNL5onNSBnom0kjp8Rd+SVYSSuEzIk5VQr
 yUdhYLTp/Jk3ECJ0UMLtiV+q1k486vFj5Qyy+wY2nVOlbuD6vXlBcHdY6cnBWctDjXQY1HKWg
 op8PLY4M/HEQfN0B4TT9NihXRxIX+LH6cLFSv+dTgd/JxcQuL1RezcsYzcIdGS8uJC4xLRS70
 HOCDIcWyR04S9iAOvnBPy76Djw835WD6mtwKzWsoGZ2ujIuCrSlFbimlOkGMFjEZDlxCCVwC/
 OyYj8cDrKQGTsD3jEb8w7IznhPRtTi0uD7+jv7O680zsCE2gTvcqH3UHDSp8LGxGBHTF56lH+
 YCUr3RrxSlYigkmo/abmqNG0SICXcywtMOF+S0pw2qTnxbslKXRZYBobKhHCqsfDeNPQaDRu6
 Q3Yn+JRIe6PE6muAAQc9XbaDLTAqHuJqiBPiHfSO1BReqGIjddkBExTCi8/cWt/3Y8ZbKJyTj
 p1FYQq3BmdsBOgx/9NBjFQZ1qtt+zWC0HFPtIc1OAfLt8gLvQjbPb9G6CubZ+Ff7fIqcKBdpx
 bjrtWhtk0AGfXAwi/AG04CvlahncXQbERH/9rYSImL1c/elDdr1VgpYejRT6mWOXTFz4nrUYf
 CB/0P5LceIiwmp69d
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Miriam,

On Thu, 23 Apr 2020, Miriam Rubio wrote:

> In a `cmd_*()` function, return `error()` cannot be used
> because that translates to `-1` and `cmd_*()` functions need
> to return exit codes.
>
> Let's fix switch default return.

I think there is an even stronger argument for not returning here: it
actually _would_ be a bug, not a user error, if the `default` branch was
reached.

The patch looks good.

Ciao,
Dscho

>
> Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> Mentored-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> Signed-off-by: Miriam Rubio <mirucam@gmail.com>
> ---
>  builtin/bisect--helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
> index c1c40b516d..a81a2c76ff 100644
> --- a/builtin/bisect--helper.c
> +++ b/builtin/bisect--helper.c
> @@ -711,7 +711,7 @@ int cmd_bisect__helper(int argc, const char **argv, =
const char *prefix)
>  		res =3D bisect_start(&terms, no_checkout, argv, argc);
>  		break;
>  	default:
> -		return error("BUG: unknown subcommand '%d'", cmdmode);
> +		BUG("unknown subcommand %d", (int)cmdmode);
>  	}
>  	free_terms(&terms);
>
> --
> 2.25.0
>
>
