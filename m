Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA40C433EF
	for <git@archiver.kernel.org>; Sun,  2 Jan 2022 17:37:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230114AbiABRhN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Jan 2022 12:37:13 -0500
Received: from mout.web.de ([212.227.15.14]:35509 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229683AbiABRhN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Jan 2022 12:37:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1641145023;
        bh=vhhPzxN9oJRelrtNydfZ9zcXiIJMjcbAJiNrmSg/haY=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=IVtrG+bWX7MARiyfnwAbVCMjFuIoRjwv6U/xofMoawCVD2Lp8iz2D4Km+1ctFpKek
         5F/K87x62WkX4hDHgD6WNyIJ1jzcB9UCm88Xt30ynfPj1g8UQrDovN6c1QYiQvZV8Z
         2Pvdq0aiF47tHjwjMLFkXX+vslCdUFRCASLzh03k=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MIyeU-1mpAIf1lVK-00KmsI; Sun, 02
 Jan 2022 18:37:03 +0100
Message-ID: <657377f3-b751-1863-409c-544b439b544f@web.de>
Date:   Sun, 2 Jan 2022 18:37:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH v4 05/11] i18n: tag.c factorize i18n strings
Content-Language: en-US
To:     =?UTF-8?Q?Jean-No=c3=abl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        =?UTF-8?Q?Jean-No=c3=abl_Avila?= <jn.avila@free.fr>
References: <pull.1088.v3.git.1640804107.gitgitgadget@gmail.com>
 <pull.1088.v4.git.1641143745.gitgitgadget@gmail.com>
 <a9d8a50d66676ea10292e8319e3eacbf7bcd83f5.1641143746.git.gitgitgadget@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <a9d8a50d66676ea10292e8319e3eacbf7bcd83f5.1641143746.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:0jJ8f8VRWqDTaBYvhqamkIR1vS6Oj5xgmFRyZPiVpRP4IOyeY/R
 Qt2nV6bQ1Y5IrSkUFsER9AkZ+gUR5TDBd1kPgnaWmN5jfYgVfu4o3kl/DgK6liNyfZWeapI
 xDNwl0oBWTmSprerZf+mQ5OGmYBs0BEjG2bjEsCQ6F6hb1csQZDVqE19ZZ7QiIAk+d+2Yu8
 AP9qpR0+7M68krSp8pnrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Iu29vfMA30w=:Q1r9MNONWhU5kEgAJHOjoI
 YNmOh4yamHrjUBRpQvRRxrc8DvMi5HktSbyeSdDbi/eQ7b+GsteP81u75IBswqDgPArSV/Fkg
 WfI3ibenVY21xFpTe0Agla9HF7qDd1SDz00khSK/tfTKd5Xnagxbgi42C87XOV0vNEWnlpTaB
 2tOuxs50ttY4492l97jJDQ2xGd8ZZLQ3b+QrQo0mtfkwWT4wK+/rjpsYybf+EXc8ALMJAsRzY
 nCVAorOzsrlDdtzULlZWj265LW1vAiBlxKDubaZ8R0MfmV9U7FqpCqsNZDMdAgxgjR8icO/yY
 xBgvGAwkIUpvG6u0OV1yMifDX6lK5h1kQC8fFK/IVLLmIpl818ywzq8SJOUz64n/NBzB4TCO3
 OWhjpeyV5q7+WhbJ13IvBscJig2ELj4MreBHmcQQ1rSW9PhWHxOZLpBhhMMLhxr8yb5ESxxYq
 wj/vx8hzDpA6WOzxuy6a9c0V1NSJPfSUX0ttLD3DBrhCcrW9lchBnS5DEKwa5hLe18iOdv6sO
 dIN5YjREDMhs2kGry36JkkILCP3IzyEmq5Kfbvk8Xg1Nbc+drXlEw4yqkLoiw8Czyzy5pyMMH
 /HcmxhACenFyisJVTbwB7DncgMgVWUP2qgcBKApCpzg4IZ4ss69s484nkty9aYGgVeh1gJHL/
 hPkVNpVfX1BwUnyPoGrvrqVHcnXVQopvdNGuyK+uZcZ6itzl3AdTEN9jfJ8ICj+5ZBzupuPOQ
 W2wgz+WuyFRVVjEC6jq0VqzCt80GrZq2c/dTqdF+GUP2e6vMEMXwFYL4UST3U8GYMxGJz7/AW
 +CcATwoqYIihtlz8gqRg/xnW5AzrFr+/AZ9cwW+LwokDRoo+LIyGeEBqpXaMFR0+spDCHLIvv
 GhyloTUwl9sawiNpg6/ynvzIK8JpQWLwEoYSMLXu6+sDMIOT3VxGXSifM8ZM/rTDEDhAoq63o
 y0qA1WoFIIOjKraHUf0TzfHXBGB9tpOtyvnjL/t71ibBU6txDAm2ilMsnWnIME2EUe3GILFJ8
 kNNmJMH57Rlfmr+U9L+DS5RjXwD5wOe8Qjv74MkFZ6vOOdrk5lBH6UB02mzFvpCdWw==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 02.01.22 um 18:15 schrieb Jean-No=C3=ABl Avila via GitGitGadget:
> From: =3D?UTF-8?q?Jean-No=3DC3=3DABl=3D20Avila?=3D <jn.avila@free.fr>
>
> Signed-off-by: Jean-No=C3=ABl Avila <jn.avila@free.fr>
> ---
>  builtin/tag.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
>
> diff --git a/builtin/tag.c b/builtin/tag.c
> index dfdcfd37956..82e09c1b83d 100644
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
> @@ -542,15 +543,17 @@ int cmd_tag(int argc, const char **argv, const cha=
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
> -		die(_("--merged and --no-merged options are only allowed in list mode=
"));
> +		die(_("'--merged' and '--no-merged' options are only allowed in list =
mode"));

What I meant in my earlier reply was: Shouldn't --merged and --no-merged
be handled like the other options that require list mode?

	else if (filter.reachable_from)
		only_in_list =3D "--merged";
	else if (filter.unreachable_from)
		only_in_list =3D "--no-merged";

>  	if (cmdmode =3D=3D 'd') {
>  		ret =3D delete_tags(argv);
>  		goto cleanup;
