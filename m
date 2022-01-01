Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6399C433EF
	for <git@archiver.kernel.org>; Sat,  1 Jan 2022 14:19:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232269AbiAAOPH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Jan 2022 09:15:07 -0500
Received: from mout.web.de ([212.227.15.3]:50163 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232171AbiAAOPG (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Jan 2022 09:15:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1641046480;
        bh=/vJdcwcQDUYCmMDuNr5MnMgDbVWmqFoOjSTm2izlHp4=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Ejm16j+Yt1FXgwXeK3x1eOlbcNpF5WUJyALksnrNoc1P3ftkqV19UHdpUAHKmdHpx
         /0cZ5GsdPqWSxHM1piE5Juj/tGGCLRrtwGn/9s0zDwD36zHh4IwNZBJ3jkYjBidas2
         HhCTbOm8BzxoDkIZl8XNfi8W16Gp1seX4clqCprA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1M4sXj-1n5apb1cEJ-001sWw; Sat, 01
 Jan 2022 15:14:40 +0100
Message-ID: <68377030-f15c-d2f9-faec-c802529c5f46@web.de>
Date:   Sat, 1 Jan 2022 15:14:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v3 05/11] i18n: tag.c factorize i18n strings
Content-Language: en-US
To:     =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
References: <pull.1088.v2.git.1640647437.gitgitgadget@gmail.com>
 <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
 <2d83654c48a75cd50573f472d643851d950ebafc.1640804108.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <2d83654c48a75cd50573f472d643851d950ebafc.1640804108.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:nttgYo4F3qAPUXxuXGtqSNO2OA9VvkmmdjQTZLq/YNHRZWiHmhN
 1rnr25VJLiXJ+JKnPk+2rmiL8JLrj/RGdZ+U9HplDGvnjaF8zIeunrqNf8dSDF4JGPsBUgG
 lTIcSKQA7MbZLEFeRtXMYsZ/g8JO3sHJAQXC1dC+1f3Bb48r6Kw7TZGbfbp33I9D/Jd0vI+
 Wy1Sz6GngDgOvrSHLPM9Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l/HbfHoAca8=:LGbLhq538plhSlFzeBwW9r
 HVxQesGG77mheZQitedc/4pY+R6PO3jV/Nic0c4q2zMXSRTVqw1yFj7i+qUtdYJaaqbK0jd6F
 gEqod8gdBo3MsOy6//DS1fewaBbYOBvT+n/pC/j/PQM7SZ0HLuwYelJ1CjP6umUEToFfo9uxq
 GRqhXe3E0L0kduPITSoQNmxoqaQgUccOxzM9KjI1WS2cvWxa/ooV1Of2hT3E1zKNndkU11d6N
 Vu5erfjC5L3393MU/OLNX+jCTNH3pnw87sqd5xk5mpA9L+zt41pu2xSIJQFCBmVHKF8Wfjgw9
 6HXkapOIw2ZhJbGy+OxjBTpA4jLiBVOJj9qNeVVqymPerQnKBpvMz2d0s626Pxis+rJDJiAC9
 xbSMB930dVxUPHCv8OtNXVcFmTnLDV6m19Z/6EtkZnP5012pPbuV2NQa4Ml7tBQNBmrAZdCpU
 2hwqucupFXUfsHr+Lp1tP2dXRZBa2AYh0Xc3EKa1XhcnEijqTgSegavlkxgJmb2Oa9O7UEFnO
 d9tgYVyRs6igdcrh4dNneFkmXRXq3XKZZ32nQX+UBilab9Qqs5HEW22RdBxiUVTRlu5nSCDtG
 3VSLruPUNmsPPGjdVcFJk6S1SjwdQsZTTaiG6cJPfcjvd/+1g/4WoSP7NbLOo2QWTveeijTy0
 UZ6cnAeabvxKOUuUi5YF1EBY95bOzZUVKQ8SUpdlm0zxVwHbFXcCsf8qIygqmcspk3LvU7Ch4
 lbSOba6llqpCDVKuCplg5mtnLOVJwUX3ZQDuiXy6hn1NaZG2IUZrk4emiHOZoUf4R0cq1ngUs
 2jbPBgjrUL6QbQIonmS8mEdp4zRDvGOxrAJHcx52XXyt3Gro0jEEyMinYYkq1sbqhq1TsZsHY
 EloTi6x1iVbGESc3q/BnoelkfD8J/TKmYYXEKoJPemiHlrli9/sNlywN2iwjM3IAjMmjzcvJV
 ecMmrih/yhFeUOy83rpr5ljJroipjwF28g3ySrz9oKKa8T34s0cv1M+NCpPIwIxq6JoySlqL1
 0rHLwf0BXI0oJyVxUTI5IakuMkkaBpYHHRA3peHdD4fja7BdJbRgrGt+Aobpv011Pg==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 29.12.21 um 19:55 schrieb Jean-No=C3=ABl Avila via GitGitGadget:
> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> ---
>  builtin/tag.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/builtin/tag.c b/builtin/tag.c
> index 6f7cd0e3ef5..c8fcb552ef1 100644
> --- a/builtin/tag.c
> +++ b/builtin/tag.c
> @@ -483,6 +483,7 @@ int cmd_tag(int argc, const char **argv, const char =
*prefix)
>  		OPT_END()
>  	};
>  	int ret =3D 0;
> +	const char *only_in_list =3D NULL;
>
>  	setup_ref_filter_porcelain_msg();
>
> @@ -542,13 +543,15 @@ int cmd_tag(int argc, const char **argv, const cha=
r *prefix)
>  		goto cleanup;
>  	}
>  	if (filter.lines !=3D -1)
> -		die(_("-n option is only allowed in list mode"));
> -	if (filter.with_commit)
> -		die(_("--contains option is only allowed in list mode"));
> -	if (filter.no_commit)
> -		die(_("--no-contains option is only allowed in list mode"));
> -	if (filter.points_at.nr)
> -		die(_("--points-at option is only allowed in list mode"));
> +		only_in_list =3D "-n";
> +	else if (filter.with_commit)
> +		only_in_list =3D "--contains";
> +	else if (filter.no_commit)
> +		only_in_list =3D "--no-contains";
> +	else if (filter.points_at.nr)
> +		only_in_list =3D "--points-at";
> +	if (only_in_list)
> +		die(_("the '%s' option is only allowed in list mode"), only_in_list);
>  	if (filter.reachable_from || filter.unreachable_from)
>  		die(_("--merged and --no-merged options are only allowed in list mode=
"));

Shouldn't these two be changed as well?

>  	if (cmdmode =3D=3D 'd') {

