Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E440C1F45A
	for <e@80x24.org>; Tue, 13 Aug 2019 20:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726783AbfHMUQj (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Aug 2019 16:16:39 -0400
Received: from mout.gmx.net ([212.227.17.22]:43691 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725944AbfHMUQj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Aug 2019 16:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1565727374;
        bh=5Q19hGiP6MRD4vOH1C0tRZyugbrxQ55/e3F34Bld+XE=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=Agj6fG/ZeP8hRzxRdVpZxK8hZ2gb8RweCHS57Ngl36itqfdNIA5WSrfh5d/c3RhXW
         B/8bj+XSfDugufpOQC6GQspD5PPRmcWS+uRDSqNZipQD4uIFEk5kTLEuUNlzenDbUz
         vKUxqNGYwh3LKAbGDEDW67C5wcun8cWVxSUalxp0=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.2.63] ([77.165.132.136]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MI5UN-1i2KK234oZ-00F9U9; Tue, 13
 Aug 2019 22:16:14 +0200
Date:   Tue, 13 Aug 2019 22:16:11 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Palmer Dabbelt <palmer@sifive.com>
cc:     git@vger.kernel.org, peff@peff.net, e@80x24.org,
        chriscool@tuxfamily.org, gitster@pobox.com,
        jonathantanmy@google.com, tboegi@web.de, bwilliams.eng@gmail.com,
        jeffhost@microsoft.com
Subject: Re: [PATCH v2 5/5] fetch: Make --jobs control submodules and
 remotes
In-Reply-To: <20190812213448.2649-6-palmer@sifive.com>
Message-ID: <nycvar.QRO.7.76.6.1908132212420.656@tvgsbejvaqbjf.bet>
References: <20190812213448.2649-1-palmer@sifive.com> <20190812213448.2649-6-palmer@sifive.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:OSr42gW1oX1t6aL4IIWni1urPsj9E1vA8xHiALKXFv0g2wVi/XT
 nMAVCXjJr7q94uDyab4AbFcYHiOEoRzEVZwGGP96SXBX7bCelYPPlZsbP4PLHhnBBSDFUKa
 KTieBFz6d6y+M5E/UdMU6ttkcfd4+7jFyazuCtD2dA7rPDPH2rmhFKxFHuibzhno3t7udlo
 90PxJoeVIdrgwlXTsVFCA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:t5NKzm8VDlg=:hNdgWkerFd5vuEjYuPwDI3
 +spCy/kUVA3m8LK4umIeVDRKBDn554wmejjfnwaAapK0uRLvzMMQi+JCfiF/deSjRHb6hkhFF
 0WqP8UwizU1uz50Sw6pXOfv6whvyYsQwqgptA+fZUtS3yJiE4cY93tV8NYKDrEmaSY2AN9ZCJ
 1L206eawSg5ViMiG0CDjGvq3kJ3hBLtHluSaIItNwbR3Z4ahB6ZGfPfDafEcBgpmEPatJSrFg
 inVYV70bfuKsw7JKPDXDuX8+2XRDwbSuCxtPkdtdoD341wRsLWdT6tw+Q094XyeZbmFvn/IL+
 1KlmX28vbPZFGqUqhgr3Ea/pRSRBmcuhS6A8tyYh5h3B71prJWWamKLFvLVm2SIvBvt4Ic2J7
 Ym/wVN9hImkPZv1BYspnOnIAEwbG65g7LMBvuYwarjSlikQywBFLL0WEvB9Qj0hqwpO0CFvUP
 hZhTz0UX4AcpJiOkJLhvo3tck4sBUutdZiwYM19s2u6CbIuDBvax+YgKIrX8iapNwKfi3WZWd
 u3itQTtlE+T7pTAkK3/sGZXbRnyZkzsas6jrKqjaAT/V0GaQ1XFAEfhpbjxTleO/zOSvvshRk
 N14l3K89+gWYjfTPYJgU0lcKipKnl97wLydNPywcdvoNixDbDeGz2jaUPYPEPCjHCqMnkk3Pj
 nMGtZcgLAw6V80rbib0JHewN3QJA51KZe8WwH5bftTQ07LROC0be0ZaxQyFs616FsieRz03O6
 1/g6uDb5oapRTw01JPnsZvOft2zemqwUkZ+4npOmu+4eq/jzurTY8nRJVxRqKoClgrXkkSpqe
 Nb32l+5HvceoSTyuwKtzKM+0Wzzo4Ws6CCnrK4ftxI43NsnXpdHXF2z9oRvP8dBUasRNsuWYg
 +Uaq3OhV3jRG9/TwfjMqdHAjIgpq55XILAeQD/TCN8EmNKXIq3txcG+Aep4ITVxFTtnkLxg8+
 hjCL6fcs3XygMH5AxGAZHCeDmMbTf3IaVWBK1LblMqKXb5RPGwxnLi0j2hkCTkgj51PUnud9S
 F2xOvrvhmIclINLD7RYx3AaV8KNJctgRd4F8Zmm9L+1JbpbiuEBZWBh/zlj3KPHfvL4DAX8Ga
 m6SL48dPCTquODyCVvVpdsggVVVXxaipZTsdDaVZmni4lOrFskEXZZ27aekYDQj3lfing97TZ
 8XO3U=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,


On Mon, 12 Aug 2019, Palmer Dabbelt wrote:

> The existing --jobs argument was defined to control the number of jobs
> used for submodule fetching, but it makes more sense to have this
> argument control the number of jobs to be used when fetching from
> multiple remotes as well.
>
> This patch simply changes the --jobs argument parsing code to set both
> max_children_for_{submodules,fetch}, as well as noting this new behavior
> in the documentation.
>
> Signed-off-by: Palmer Dabbelt <palmer@sifive.com>
> ---

I very much miss in this description a reflection of my analysis in
https://public-inbox.org/git/nycvar.QRO.7.76.6.1907191507420.47@tvgsbejvaq=
bjf.bet/

Given that analysis, combined with the fact that the `--jobs` option
tries to control both the `--multiple` and `--recursive-submodules` code
paths in the end, anyway, I do doubt that it makes sense to even
introduce the `--fetch-jobs` and the `--submodule-fetch-jobs` options;
They are probably only confusing and do not add much benefit to the end
user.

Ciao,
Johannes

>  Documentation/fetch-options.txt |  4 ++++
>  builtin/fetch.c                 | 21 ++++++++++++++++++---
>  2 files changed, 22 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-optio=
ns.txt
> index 5836024f1934..0915fd4ed6d5 100644
> --- a/Documentation/fetch-options.txt
> +++ b/Documentation/fetch-options.txt
> @@ -160,6 +160,10 @@ ifndef::git-pull[]
>
>  -j::
>  --jobs=3D<n>::
> +	Number of parallel children to be used for all forms of fetching.
> +	This is the same as passing `--submodule-fetch-jobs=3D<n>` and
> +	`--fetch-jobs=3D<n>`.
> +
>  --submodule-fetch-jobs=3D<n>::
>  	Number of parallel children to be used for fetching submodules.
>  	Each will fetch from different submodules, such that fetching many
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 67d001f3f78b..41498e9efb3b 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -114,6 +114,20 @@ static int git_fetch_config(const char *k, const ch=
ar *v, void *cb)
>  	return git_default_config(k, v, cb);
>  }
>
> +static int parse_jobs_arg(const struct option *opt, const char *arg, in=
t unset)
> +{
> +	int jobs;
> +
> +	jobs =3D atoi(arg);
> +	if (jobs < 1)
> +		die(_("There must be a positive number of jobs"));
> +
> +	max_children_for_submodules =3D jobs;
> +	max_children_for_fetch =3D jobs;
> +
> +	return 0;
> +}
> +
>  static int parse_refmap_arg(const struct option *opt, const char *arg, =
int unset)
>  {
>  	BUG_ON_OPT_NEG(unset);
> @@ -142,12 +156,13 @@ static struct option builtin_fetch_options[] =3D {
>  		    N_("fetch all tags and associated objects"), TAGS_SET),
>  	OPT_SET_INT('n', NULL, &tags,
>  		    N_("do not fetch all tags (--no-tags)"), TAGS_UNSET),
> -	OPT_INTEGER('j', "jobs", &max_children_for_submodules,
> +	{ OPTION_CALLBACK, 'j', "jobs", NULL, N_("jobs"),
> +		    N_("number of parallel tasks to run while fetching"),
> +		    PARSE_OPT_OPTARG, &parse_jobs_arg },
> +	OPT_INTEGER(0, "submodule-fetch-jobs", &max_children_for_submodules,
>  		    N_("number of submodules fetched in parallel")),
>  	OPT_INTEGER(0, "fetch-jobs", &max_children_for_fetch,
>  		    N_("number of remotes fetched in parallel")),
> -	OPT_INTEGER(0, "submodule-fetch-jobs", &max_children_for_submodules,
> -		    N_("number of submodules fetched in parallel")),
>  	OPT_BOOL('p', "prune", &prune,
>  		 N_("prune remote-tracking branches no longer on remote")),
>  	OPT_BOOL('P', "prune-tags", &prune_tags,
> --
> 2.21.0
>
>
