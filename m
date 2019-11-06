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
	by dcvr.yhbt.net (Postfix) with ESMTP id C2AC01F454
	for <e@80x24.org>; Wed,  6 Nov 2019 12:30:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731518AbfKFMa0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 6 Nov 2019 07:30:26 -0500
Received: from mout.gmx.net ([212.227.17.20]:41131 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728716AbfKFMa0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Nov 2019 07:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1573043419;
        bh=wkGPOEn3FEVZ0+B+ttoMHvWK2SZQxaWb1pDdhRSUc6w=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=PBqYJLLshJTvHFuT6cjw2puOeN1OU4516/woyb8IDYh41pF2cQzGzu/6flR8fm+6M
         HzEdZrYnUQVp3ddkun6a1Eianptbt+5tbfdyEaeOldxUOqX3QzLjVTznOB08URXN2e
         /ktH7ssMzdmRCMw4pBsKeFg471eY2EFffUt5LEWs=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N3bSt-1hjxLE2fkh-010dbd; Wed, 06
 Nov 2019 13:30:19 +0100
Date:   Wed, 6 Nov 2019 13:30:03 +0100 (CET)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     Erik Chen via GitGitGadget <gitgitgadget@gmail.com>
cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Erik Chen <erikchen@chromium.org>
Subject: Re: [PATCH 1/1] fetch: add trace2 instrumentation
In-Reply-To: <4fdbb9f504ee59e508b7df520f7890e29fbca7df.1572981981.git.gitgitgadget@gmail.com>
Message-ID: <nycvar.QRO.7.76.6.1911061329340.46@tvgsbejvaqbjf.bet>
References: <pull.451.git.1572981981.gitgitgadget@gmail.com> <4fdbb9f504ee59e508b7df520f7890e29fbca7df.1572981981.git.gitgitgadget@gmail.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K1:/IpPGKzSwGtMiPS+8A/p28OD/2h0ePhjeHkdRdIfZvsinztipop
 4ypeK6MlMnOKxYuk44b1jsRKdeJPd671zmeswj0/gKICVN1eaNqFBzawRD7hA8niRghqnqk
 g3acWSDW739v3GcXxcG+yJff+dQxYlQZ1Kc3zMaWLGG40kEZ63cotY93P+nCan7awNtoWAP
 0V3bztAsr7TgVzP6M/8Og==
X-UI-Out-Filterresults: notjunk:1;V03:K0:wXSCeDt9RqM=:MRziod4/pK7KBvJggcw4Kg
 2DBQYJgnn7R0TmI497WrcP3hquh5xdWr52PoT3pRqE5S5Jvwno1cTrnoekQimtOSk9jdzeykj
 6GnkvoH4MvvYSyiWc9mgvMox5w05YYdsO//H59eYbOKGEKZU0KHo3pRj5K5U+YtKcBC/xqo80
 IupmX9Jz2K7J4Z4GqeQbHEqohtNlFeVIfxDFhyjIVsSfccdmsxygJmar+5od5/E4cJ4oI6+Dc
 x10xLYwo5evXAx/v2PBjtwU6wtTu8fFeNl//fznyEQs4sZTjx6pGQbSeXpDbTNAXIWAuJHf92
 Rgxke9bap85RgSZN5SujvKxbhDWIEjFjsc4XjTcZ3BXZ34dWTsdQPu8kTmCM+wojUfayeKOni
 S9Ie5LPyCWMeHh+qY0ybZTZov1ir5oW/AtvaPotzb7gGeEsD254e3eHtLFHNaBsduwHe6rPOx
 0HXQTUdlbuA7RVkI0zdZ2AS5f7zPpTkWJ0tx9edUz2nWPNSywivV9VLvE6Ql5h+3zZY6YNGWG
 glmx3KOXEjaVXjYkFIE2uuoh6AZKeqAGj/emlPwpPTx7vUw+Mb749zL9lZodEpIHdSvAp6d4e
 PsqlPLkD1wyYaBgB/CLIF66a4IIc7fzYf4ZKcyoEyRbllRNcNT6ICORWYFq9fgavNbFnD+PwK
 l3nEm4KkvCol+MtONKYda6DyD5tSFfFtm7u5mEUi8zm1HO9e/2Fds8kv6h2ogXxwAXU7uj0iU
 uWR0F9R8Xwt+5ItpHETtE5VanE1FL1hJzNospCNHAL8y3kftJq6oxtdZFMyN0+Y6CdOWILwFQ
 bXuA49M1wME2qlymuo1hTfEyniDlcHTxMjcd5j/sB5lKtSEuPypbwGt170pGszqHPe3k4EblV
 ozSmMEp9XZXbEHbfM5NclDQNXtEPxpokjhaN5+I1VyQwaOC2QlCgo7k8LE+bNxsp/hyTXs5fx
 vT+BeF0JuHYJZvoL9dkdnpJdQQJJeoMw3+v2MdUPI1wREeH/YVVtky4YT0+OBbEh1b+ES/d0r
 Md7Qp2/XubjLO3HK+JWMStbQJ5KifTJvZIi9mCZZt2/ePyn5cFzwiqUtw9TOTpJTW6N03/9dF
 Y8nLoBnH8kPR6Ty90HKLOIhA2UUFVfxopqzItaK4gpjA8RNafAEzQ3MZlottS1bcvHn62dPGs
 2ZERFXXj/tnQNEkKW2Dhsf5D9SQC0La4yi+x9DSgZYUKIK7sMrYwwZ7z0eatncylC0HmBRcL0
 zqBAFt8Tq98NBh54oRBlRYOj0JVk7/urJ0cyvEN+5skPp65HenX9iOP6m8lQ=
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Erik,

On Tue, 5 Nov 2019, Erik Chen via GitGitGadget wrote:

> From: Erik Chen <erikchen@chromium.org>
>
> Add trace2 regions to fetch-pack.c to better track time spent in the var=
ious
> phases of a fetch:
>
>     * matching common remote and local refs
>     * marking local refs as complete (part of the matching process)
>
> Both of these stages can be slow for repositories with many refs.
>
> Signed-off-by: Erik Chen <erikchen@chromium.org>
> ---
>  fetch-pack.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 0130b44112..f2f3365bbe 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -666,9 +666,10 @@ static void mark_complete_and_common_ref(struct fet=
ch_negotiator *negotiator,
>  	struct ref *ref;
>  	int old_save_commit_buffer =3D save_commit_buffer;
>  	timestamp_t cutoff =3D 0;
> -

I would keep this empty line. Other than that, this patch looks good to
me.

Thanks,
Johannes

>  	save_commit_buffer =3D 0;
>
> +	trace2_region_enter("fetch-pack", "mark_complete_and_common_ref", NULL=
);
> +
>  	for (ref =3D *refs; ref; ref =3D ref->next) {
>  		struct object *o;
>
> @@ -690,6 +691,10 @@ static void mark_complete_and_common_ref(struct fet=
ch_negotiator *negotiator,
>  		}
>  	}
>
> +	/* This block marks all local refs as COMPLETE, and then recursively m=
arks all
> +	 * parents of those refs as COMPLETE.
> +	 */
> +	trace2_region_enter("fetch-pack", "mark_complete_local_refs", NULL);
>  	if (!args->deepen) {
>  		for_each_ref(mark_complete_oid, NULL);
>  		for_each_cached_alternate(NULL, mark_alternate_complete);
> @@ -697,6 +702,7 @@ static void mark_complete_and_common_ref(struct fetc=
h_negotiator *negotiator,
>  		if (cutoff)
>  			mark_recent_complete_commits(args, cutoff);
>  	}
> +	trace2_region_leave("fetch-pack", "mark_complete_local_refs", NULL);
>
>  	/*
>  	 * Mark all complete remote refs as common refs.
> @@ -716,6 +722,7 @@ static void mark_complete_and_common_ref(struct fetc=
h_negotiator *negotiator,
>  	}
>
>  	save_commit_buffer =3D old_save_commit_buffer;
> +	trace2_region_leave("fetch-pack", "mark_complete_and_common_ref", NULL=
);
>  }
>
>  /*
> --
> gitgitgadget
>
