Return-Path: <SRS0=3/hf=DT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2EBC433E7
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 11:17:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 917F62076E
	for <git@archiver.kernel.org>; Mon, 12 Oct 2020 11:16:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="h/7KTmbu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387635AbgJLLQ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Oct 2020 07:16:58 -0400
Received: from mout.gmx.net ([212.227.15.15]:56791 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387597AbgJLLQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Oct 2020 07:16:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1602501292;
        bh=JCWks76MJBEFrDTJ3cSsMxTqDYUOKYc4FIwB1MtP0sg=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=h/7KTmbuNJasDP7Kx25Aa3i5QwIukIo+oHUQIeawoB9GR7QJis4y41fYNV+Ua5y+4
         k5qCADItLq/nN/hHoGWlopM9v8yd+wgeoGMao1LsecdAuddQdtD6iwpoQMh/uvom4G
         6xhblqBZQmFaSX1B/FUyGlTvnemhcp5k0Q7qxEMI=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [172.20.73.169] ([89.1.215.146]) by mail.gmx.com (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M3UUy-1kSTks1Yxu-000Zdr; Mon, 12
 Oct 2020 13:14:52 +0200
Date:   Mon, 12 Oct 2020 13:14:50 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Micha=C5=82_K=C4=99pie=C5=84?= <michal@isc.org>
cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 1/3] merge-base, xdiff: zero out xpparam_t
 structures
In-Reply-To: <20201012091751.19594-2-michal@isc.org>
Message-ID: <nycvar.QRO.7.76.6.2010121313020.50@tvgsbejvaqbjf.bet>
References: <20201001120606.25773-1-michal@isc.org> <20201012091751.19594-1-michal@isc.org> <20201012091751.19594-2-michal@isc.org>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1277350703-1602501292=:50"
X-Provags-ID: V03:K1:bJbi0yUs4HOyNRG9FPIW9OgnC0UuueiOO1iKIC7SkmZxeM8/FRm
 Wd2Q5s3UnhID9IwJjcXTWJJRHu+71NymalwWXFqUZJPzFMJINnm5tsLD/2cjxXynr7cOlDK
 xtKvE50MZAg7EtvF5TbwJzkyhd/JPYHdu1NeZX81zsgVFfL6qLwCACYkHjkeIxK9QTgd1Bc
 cIyIFuCh+G368osxhNKAw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:b4zYqgZgkqk=:wE0Qa7TlfYCFS3aYUKcBD4
 gUZfZ0248M7SEqZjVD32SwZKu6AWHp90zHgaKjW4TNkq4JEIcuFjd3NnaMjODWd9jE1PL/8dD
 IPlkW0jpyXEJHfD4FxSkSbLqVdfasUp0KVyJ11/Q1Y95vYq4ro9e7PsYyFeYTcOF7R/VcCMSG
 AGBoMZk1u0D3uBZc2U40hDi3gA+6ynANfEjZ8D9doIouVFG5Xo0jm6KBJV16ugTVzh1JpgSob
 /2lHwEz4+GdSryw+YhDi8vjT99eckVP43mBAdgrg5B3JuIR01M9XcDp/8trTujECqNJVM7pwC
 P7pKTRHhse/HNoQ65Arh7BiJcYA+luGL6KpcNAFV+1wGHVCdk3r0nwJWKoHeF5Au85CHXOWuA
 VBd5bTsUolTkSrpEICH9ExvQMZTo2xnMLyfpR8LnLlu8JQmwrsFaD6QX/meVR4JFjgYM0ZPyy
 Uuh/vtAer9+lBwQxfh2eeBWMWYplU4HjsO47plo1SHiYb84aHhdD4oyTTHUI+Cl1cBPajaJwM
 jHcGsG/nhPt5ak87Q0kzi9EfuD0ebh7PVGRJNK8r7I+wN5HkS3xw6l3LugHMOcgBh5j9/4ko9
 B9kkFvNd74D5n4wpFZQzs7JK8en22oVUOf37YlEPhj1717t+GxYCfjo2DcPm1/ydN1fjHLtZf
 /No6sVBAx123U0YbubomkzH32Gp6sSgvzmi9zRrwZ/DZW7yYInpxMVheI3CErR8GyABd7/BNe
 XJBwZmKpAm2hbxk7UH7s8vrdsFPlwiuyDtN5MalWDPStVFjORWpZpwd1WrxfRx6BFzt40Dnib
 rX2QEJDzRQmk/MwPfXEvyZ9/KdaK9KgZQwtowoyztobyydn0jnAkFpuUgyyItn1qvU91CFdGC
 P4VssUnP8iYfmWWOARxmEGc7OUFsEIDX3v+Za+6RYaEQ8L4D3ZW2nBTT5J/61yBaIZcj0odUs
 oFUeQnSK9AzdeglHsm+Ic4LKg+MvRySvH7P8E6CxtKGEIBFFXbn4peFANLiUuw75ILKSVc3+2
 K81AYIYuUdQjWfQZWeqA2nTbJ0EJktXqMCU4X7OsUV0fBhKB+B3nbnrrCLqPX28CmS6P9QUxB
 dBki5S7gpyjrW548QHB/ubNiEzuy6T9XwfEMKaTdW5XaFf2x6B3DUHo9u47GWIe2Y0OqEv4Sg
 55qNovL2sUwse6alvphP484p5wSF9OgC/g0AxYWOp8UpRpmau8DO48j8BKzGhRsoS5NZ8bjBJ
 YrTHD9QFRGEoOLJdo8iQsgMPX/lgZkgDt5/aczA==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1277350703-1602501292=:50
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Micha=C5=82,

On Mon, 12 Oct 2020, Micha=C5=82 K=C4=99pie=C5=84 wrote:


> diff --git a/xdiff/xhistogram.c b/xdiff/xhistogram.c
> index c7b35a9667..e694bfd9e3 100644
> --- a/xdiff/xhistogram.c
> +++ b/xdiff/xhistogram.c
> @@ -235,6 +235,8 @@ static int fall_back_to_classic_diff(xpparam_t const=
 *xpp, xdfenv_t *env,
>  		int line1, int count1, int line2, int count2)
>  {
>  	xpparam_t xpparam;
> +
> +	memset(&xpparam, 0, sizeof(xpparam));

A slightly more elegant way to do this would be

	xpparam_t xpparam =3D { 0l };

Or even

	xpparam_t xpparam =3D XPPARAM_T_INIT;

with

	#define XPPARAM_T_INIT { 0l, NULL, 0 }

in `xdiff/xdiff.h`.

Thanks,
Dscho

>  	xpparam.flags =3D xpp->flags & ~XDF_DIFF_ALGORITHM_MASK;
>
>  	return xdl_fall_back_diff(env, &xpparam,
> diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
> index 3c5601b602..20699a6f60 100644
> --- a/xdiff/xpatience.c
> +++ b/xdiff/xpatience.c
> @@ -318,6 +318,8 @@ static int fall_back_to_classic_diff(struct hashmap =
*map,
>  		int line1, int count1, int line2, int count2)
>  {
>  	xpparam_t xpp;
> +
> +	memset(&xpp, 0, sizeof(xpp));
>  	xpp.flags =3D map->xpp->flags & ~XDF_DIFF_ALGORITHM_MASK;
>
>  	return xdl_fall_back_diff(map->env, &xpp,
> --
> 2.28.0
>
>
>

--8323328-1277350703-1602501292=:50--
