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
	by dcvr.yhbt.net (Postfix) with ESMTP id 29D971F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 11:13:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbfJNLNf (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 07:13:35 -0400
Received: from mout.gmx.net ([212.227.17.21]:53933 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731767AbfJNLNe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 07:13:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1571051607;
        bh=K/KXhAsqoqL6DvYi1D9Xxf2AfJU3+9GHGse+ZYkj5Mo=;
        h=X-UI-Sender-Class:Date:From:To:cc:Subject:In-Reply-To:References;
        b=g4a6vd6CZDCt6CFFsWw0M6Fn/SuguCElx4SbhLExnKlvNkMa94QuvhbHWhirCInnp
         uAc5Z5Br8VqmZIPa05JBq8J+ZzrMgwzxekvyTOxTj3QUez2VcsDGznRx3vr2BMIXbV
         kIje1Dedxe/2cTXKumRikKD/z0DDS7jW7/ZNMgsE=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.0.213] ([37.201.195.166]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M7JzQ-1iPRvv0Xhk-007mTS; Mon, 14
 Oct 2019 13:13:27 +0200
Date:   Mon, 14 Oct 2019 13:13:08 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@gitforwindows.org
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?Q?Nguy=E1=BB=85n_Th=C3=A1i_Ng=E1=BB=8Dc_Duy?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] column: use utf8_strnwidth() to strip out ANSI color
 escapes
In-Reply-To: <9b3f6960-ea75-c3a7-3a24-0554320bb359@web.de>
Message-ID: <nycvar.QRO.7.76.6.1910141312010.46@tvgsbejvaqbjf.bet>
References: <9b3f6960-ea75-c3a7-3a24-0554320bb359@web.de>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-2045229942-1571051607=:46"
X-Provags-ID: V03:K1:T7Lyoak6tT4UjgCaff2Z7Ib2cewKgSIn6f5aLa43ll5i0FcYTAu
 ojDxGMqZRZw8Rl5QOL+FvOIecue+Lj8DCou2sn920vPorlKV1QcmYLPLPCrCCB1I5ylSXVV
 GkxoX2f87vgwtFHkWt/1jHzqJx1Art6aX5vDBJLrqM7MAw1VDweAePdf8feQIfOjLaPf/ZM
 9QdP5aaGEXDzkKaAaYsNA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Y+IJpzz1ghU=:siOu5VJwsIwM403lu7gMOb
 ENBJhV4CGxLvVxY15KbAg+FZNei056xboIfZMWXLEpm8NBg13Vc7NGdU03mTsWb74HACMDNS1
 Q2GqCTK1YCsXu2XUAub+7gUfG70Ip6yr2nbcpFEHAtv1T5HgOBc4dhzDtYc46JsxncG+6/VDN
 RqKxc0ZLOcbdIfdUFgcyzuzjMqn+M7GtVlMXScUwiuaL58abvrzd7G8IWt/wA8bkDA6wQy5D1
 TPC8tGfVZOeRBu8uYQluQBxugV1nLfn5VJ+9VoJuasEQFAs43xFj1wJ3QZ/3bn4Hv6FQ/mtRp
 9KhlOZRXgcQ7hWpCuyhPwRgxhiad9rmfec1sYUouvEBPWVfb4ald2K1HPlgx90W+/4JRJ6NTr
 dqEwl1rOvKfGrFUGUwf2+hQs0V3w2G9agMjJZ79Ddhq1hyoyJZQxK9pYqwP0Pj0w8as1uIUO8
 /8gPxuusGi0X3bbdh/++uwUZojUb4ILmojO9pUTTZhxwyxoPfWONjiQuouYB+ajBgZC1BUMDg
 CPYWhUQm101OICkEirdP/G60z4yXOtUIRVpBnX+neRIoBPc65x3KYsYuj/ytRKV8UvQAw3pQI
 MFEUeE482z0u1skoRTmiVvlS6FRzQ3vlG/4IciPZf5DNbM+HGG5DdoZ1mtEDRU9qLYrUOTD7E
 YPubdE5lIv4ApGjIAHELHaTM6BG/ODVlvRIZmVLhtYUwLTNhjQpDPxUjdttM3LT3gHMVhIsE8
 eWZd9JGYP9MXYzup4drqomvF91uZ1gyLMq/7PHZA62EAsHrnmZlPAfkjGNBTmtnEx2nMt8oVd
 I9B6rs53QtPYAGw2tl6j7xBaZCrJvBzPJUF86iz891TSZGFw8AvNFT4CE5hddKyqNDHjaT6Jq
 T64t5fYF7IQX/QE/UXJ5FKmmD6WxLWQhYUgGJyhjrEuWE9mn6TOzDedmOQlG9fChp+xIHVDYb
 6z8hZHwacPx6JOALy6ZmdSVeXfDJPIQ258IHYQSQCeWlBMlWIs/agdaVqBowr2+5ETQ/k0a1b
 3ydQnF2bQR1Fy6qPMQ6tsOduZvAkdrGvPfgDNRKYaiIVtzayxDYjsSp/wkUq2STvrMlLNpSdk
 CPMU7y3++l77ksibeYk1+/UZqyi8I4jEh4YZus2FE1vwVyrVFzRKVPU6OFyzV1RKW1HV0cHJs
 /U2OHyZmkyR3rsw72FuZop8v3mrKwqmIuhFoSc4Y1G/FxP3Rev99GLc05Bcf3A6rn9/GQhuV2
 ENRvd+XkmBbHz25QotAoF6IY+ULawNtBezTtI7xcurVlhEy/SXR/gU3yzjD4=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-2045229942-1571051607=:46
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Ren=C3=A9,

On Sun, 13 Oct 2019, Ren=C3=A9 Scharfe wrote:

> Make use of utf8_strnwidth()'s feature to skip ANSI escape sequences
> instead of open-coding it.  This shortens the code and makes it more
> consistent.

Sounds good.

> This changes the behavior, though: The old code skips all kinds of
> Control Sequence Introducer sequences, while utf8_strnwidth() only skips
> the Select Graphic Rendition kind, i.e. those ending with "m".  They are
> used for specifying color and font attributes like boldness.  The only
> other kind of escape sequence we print in Git is Erase in Line, ending
> with "K".  That's not used for columnar output, so this difference
> actually doesn't matter here.

Arguably, the "Erase in Line" thing should re-set the width to 0, no?
But as you say, this is not needed for this patch.

Thanks,
Dscho

>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  column.c | 13 +------------
>  1 file changed, 1 insertion(+), 12 deletions(-)
>
> diff --git a/column.c b/column.c
> index 7a17c14b82..4a38eed322 100644
> --- a/column.c
> +++ b/column.c
> @@ -23,18 +23,7 @@ struct column_data {
>  /* return length of 's' in letters, ANSI escapes stripped */
>  static int item_length(const char *s)
>  {
> -	int len, i =3D 0;
> -	struct strbuf str =3D STRBUF_INIT;
> -
> -	strbuf_addstr(&str, s);
> -	while ((s =3D strstr(str.buf + i, "\033[")) !=3D NULL) {
> -		int len =3D strspn(s + 2, "0123456789;");
> -		i =3D s - str.buf;
> -		strbuf_remove(&str, i, len + 3); /* \033[<len><func char> */
> -	}
> -	len =3D utf8_strwidth(str.buf);
> -	strbuf_release(&str);
> -	return len;
> +	return utf8_strnwidth(s, -1, 1);
>  }
>
>  /*
> --
> 2.23.0
>

--8323328-2045229942-1571051607=:46--
