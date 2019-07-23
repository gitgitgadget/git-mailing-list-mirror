Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MALFORMED_FREEMAIL,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BE26C1F461
	for <e@80x24.org>; Tue, 23 Jul 2019 15:04:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388489AbfGWPEv (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Jul 2019 11:04:51 -0400
Received: from mout.gmx.net ([212.227.15.18]:40431 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731767AbfGWPEu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Jul 2019 11:04:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1563894278;
        bh=/zNW+yl6KHkrHX+shX1xR8uClvVB5sg+OYOeAata8a0=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=UdxzdIVR9lBFlyyWVPUYTOphE259PM/HnzuK+tFc2yxuGLcQkOn4mDx+cENgt7GT2
         Fo4dBNJdcJqBPHMJImX+cpil1j6h5OelW7M0OwGja1g3RuZjnW7C53Nm2LW00Va2vc
         zvWGCxiNfFm8Vhp/7qHsqI2l3l3VUVYVMHYQJslg=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.192.51]) by mail.gmx.com (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMGRA-1i5xad47Da-00JLq0; Tue, 23
 Jul 2019 17:04:38 +0200
Date:   Tue, 23 Jul 2019 17:04:36 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Johannes.Schindelin@gmx.de, peff@peff.net,
        jnareb@gmail.com, pclouds@gmail.com, carenas@gmail.com,
        avarab@gmail.com, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 3/5] repo-settings: parse core.untrackedCache
In-Reply-To: <47ae3e7d4d765a00d14e8892db88a8936d56591b.1563818059.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1907231656580.21907@tvgsbejvaqbjf.bet>
References: <pull.292.git.gitgitgadget@gmail.com> <47ae3e7d4d765a00d14e8892db88a8936d56591b.1563818059.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:cr80RbHLvXmUYoAPzu/QuCJLr3DKTtQk89WnacANCu/CggFQuFS
 WSCzvT/vqEmsTifBGkamwHVP5bYzbqQCKKX5qIIKt/X46YJ3ywppu5L3Lm494gWluXwxJGq
 H4L5uJoIyMh/hOfjqBj39p0sRO6I3nACWSvR1NizrizJbaH+BP7htg3DygKjYl5VQXtO/Hg
 Q7PGfnL6a2ENKvEISMnxA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YWBXajWS3k4=:7TEeMXiJMeXoe3Yfbb+skF
 2n3toQUEoASFU/KOvct8E0b37nf8xgjhLYujZVjdcDhZyEe9pDcnO/eMyik+UvHq/9/1u0Uak
 9OuKQYXzz1CdsRaVUgsbbqeOFHZwEShEUo2uW1nTpz6tGeNH3oXL9oDFqOj8ufnMFmPIuR15E
 jVjWr4tttV9Ssxv6uDjH2R66sTWhz4lcDFO0jutAXSHqo372gslHV1o/g5ze4aSloyrfMKf6R
 Pf878Ig2v790VF3EUtEHviA0+cetAGxkfOpnDps6JPLIFnzftWAzJhNMZoRjNTypJOxtmHIPL
 IoIcR9RMP+OOPojoHG79WScDsqJB1wbZ9ZC0FnLoRYdLlVtJg404UjQziiDzkdTLl9bmj9g2L
 00KvKdCejXxWpoa7OrLfD4x0DzPyhqffEsIgq1P3hjM0hWo/Ab6/ULrUNCwLEOR7YtXXzwQrD
 n9IottGKcscZVN7wRtg7a4TVjFR4xgMZMzQhcwW/Iil348TQESvSUFh2ABgMM4peupeBtcsm9
 KJ7j813HV4eCsgjMg2RNZpsREOkvg3HAGauMLxm2VWUN7ywp+mBBHrvu8oKSEwszGClkCY7JU
 Dk+UnCFSfhWBTsWJ9MfrxTeZ7/ni2pTRfCVqvqfqi1Jv4ZO2lMv8/duBiSZeyjjdlGPC5EybP
 aI+RDdasKfLujAcqmjVDkRt1R4vLAo/VH49qdgXyOtd0gU9ZjDqCy0n1E0vNe756h6WM/sPnY
 ugC4EZPx/o51N8wBwlcsFry1opIYdpMH2d0MHQphp3qtgXeVp5voKG5Dp9Lm/LdSKWdGN6V/0
 C4o4UT99gpwWxWb+F7QfceLX1ywLmlc/N1ZfFKZ4LYGBfyVwQqzp8IviXdTM9DkmH6VglVaei
 HsFJ+Ocg2AiaN8LyQgNToFHEiXZHTubP8zlw72FrZav22y1YDUxqIDI9e+XnMSN6ykRSCx7uG
 bQuCEao6Wy8CvNPaJ3plIjk9u6x6Lo050SHtLZGHDdl1bFKU62kPsz+aSf5UWLcExCnut+Oy3
 bfw/p7SPU2C0Y/bZ3MEbP4ql4mTspBcLKKzM6CErq5E05WJuke3aiQTfZBv7xWxss9dFf3Tx3
 EpOfb3qYhO3eQ5YLb27Ya1BE/xQVte10bfS
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stolee,

On Mon, 22 Jul 2019, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
>
> The core.untrackedCache config setting is slightly complicated,
> so clarify its use and centralize its parsing into the repo
> settings.
>
> The default value is "keep" (returned as -1), which persists the
> untracked cache if it exists.
>
> If the value is set as "false" (returned as 0), then remove the
> untracked cache if it exists.
>
> If the value is set as "true" (returned as 1), then write the
> untracked cache and persist it.
>
> Instead of relying on magic values of -1, 0, and 1, split these
> options into bitflags CORE_UNTRACKED_CACHE_KEEP and
> CORE_UNTRACKED_CACHE_WRITE. This allows the use of "-1" as a
> default value. After parsing the config options, if the value is
> unset we can initialize it to CORE_UNTRACKED_CACHE_KEEP.

Nice!

> [...]
> diff --git a/read-cache.c b/read-cache.c
> index ee1aaa8917..e67e6f6e3e 100644
> --- a/read-cache.c
> +++ b/read-cache.c
> @@ -1846,18 +1846,17 @@ static void check_ce_order(struct index_state *i=
state)
>
>  static void tweak_untracked_cache(struct index_state *istate)
>  {
> -	switch (git_config_get_untracked_cache()) {
> -	case -1: /* keep: do nothing */
> -		break;
> -	case 0: /* false */
> +	struct repository *r =3D the_repository;
> +
> +	prepare_repo_settings(r);
> +
> +	if (!(r->settings->core_untracked_cache & CORE_UNTRACKED_CACHE_KEEP)) =
{
>  		remove_untracked_cache(istate);
> -		break;
> -	case 1: /* true */
> -		add_untracked_cache(istate);
> -		break;
> -	default: /* unknown value: do nothing */
> -		break;
> +		return;
>  	}
> +
> +	if (r->settings->core_untracked_cache & CORE_UNTRACKED_CACHE_WRITE)
> +		add_untracked_cache(istate);

This changes the flow in a subtle way: in the
`CORE_UNTRACKED_CACHE_WRITE` case, we used to _not_ remove the untracked
cache, but now we do.

I _think_ what you would want to do is replace the `!(..._KEEP)`
condition by `..._REMOVE`.

>  }
>
>  static void tweak_split_index(struct index_state *istate)
> diff --git a/repo-settings.c b/repo-settings.c
> index f328602fd7..807c5a29d6 100644
> --- a/repo-settings.c
> +++ b/repo-settings.c
> @@ -30,6 +30,20 @@ static int git_repo_config(const char *key, const cha=
r *value, void *cb)
>  		rs->index_version =3D git_config_int(key, value);
>  		return 0;
>  	}
> +	if (!strcmp(key, "core.untrackedcache")) {
> +		int bool_value =3D git_parse_maybe_bool(value);
> +		if (bool_value =3D=3D 0)
> +			rs->core_untracked_cache =3D 0;
> +		else if (bool_value =3D=3D 1)
> +			rs->core_untracked_cache =3D CORE_UNTRACKED_CACHE_KEEP |
> +						   CORE_UNTRACKED_CACHE_WRITE;
> +		else if (!strcasecmp(value, "keep"))
> +			rs->core_untracked_cache =3D CORE_UNTRACKED_CACHE_KEEP;
> +		else
> +			error(_("unknown core.untrackedCache value '%s'; "
> +				"using 'keep' default value"), value);
> +		return 0;
> +	}
>
>  	return 1;
>  }
> @@ -46,6 +60,13 @@ void prepare_repo_settings(struct repository *r)
>  	r->settings->gc_write_commit_graph =3D -1;
>  	r->settings->pack_use_sparse =3D -1;
>  	r->settings->index_version =3D -1;
> +	r->settings->core_untracked_cache =3D -1;

At this point at the latest, I am starting to wonder whether it would
not make more sense to use `memset(..., -1, sizeof(struct
repo_settings)` instead.

>
>  	repo_config(r, git_repo_config, r->settings);
> +
> +	/* Hack for test programs like test-dump-untracked-cache */
> +	if (ignore_untracked_cache_config)
> +		r->settings->core_untracked_cache =3D CORE_UNTRACKED_CACHE_KEEP;
> +	else
> +		UPDATE_DEFAULT(r->settings->core_untracked_cache, CORE_UNTRACKED_CACH=
E_KEEP);
>  }
> diff --git a/repo-settings.h b/repo-settings.h
> index 1151c2193a..bac9b87d49 100644
> --- a/repo-settings.h
> +++ b/repo-settings.h
> @@ -1,11 +1,15 @@
>  #ifndef REPO_SETTINGS_H
>  #define REPO_SETTINGS_H
>
> +#define CORE_UNTRACKED_CACHE_WRITE (1 << 0)
> +#define CORE_UNTRACKED_CACHE_KEEP (1 << 1)

I think it would read even nicer as an enum. In any case, using `1<<1`
suggests that this is a bit field, but I don't think that is what we
actually want here. Instead, what `core_untracked_cache` seems to be (at
least from my point of view) is a mode, where any two modes are mutually
exclusive.

For example, what is the difference between `(_KEEP | _WRITE)` and
`(_WRITE)` supposed to be? That the latter writes a fresh untracked
cache without looking at the previous one? That's not how the existing
code behaves, though...

Ciao,
Dscho

> +
>  struct repo_settings {
>  	int core_commit_graph;
>  	int gc_write_commit_graph;
>  	int pack_use_sparse;
>  	int index_version;
> +	int core_untracked_cache;
>  };
>
>  struct repository;
> --
> gitgitgadget
>
>
