Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E6DC202AC
	for <e@80x24.org>; Sat,  8 Jul 2017 14:29:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752671AbdGHO25 (ORCPT <rfc822;e@80x24.org>);
        Sat, 8 Jul 2017 10:28:57 -0400
Received: from mail-pg0-f67.google.com ([74.125.83.67]:34276 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752097AbdGHO24 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Jul 2017 10:28:56 -0400
Received: by mail-pg0-f67.google.com with SMTP id j186so7398734pge.1
        for <git@vger.kernel.org>; Sat, 08 Jul 2017 07:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:in-reply-to:subject:references:message-id
         :content-transfer-encoding:mime-version:date:cc;
        bh=QHGWWY22pO6yHqnjSxUDo2s26bU0eajolGp7D1IS4QQ=;
        b=HxHZM3TepICXxdlzUfbRwj4YeUmdcezluP1uMrDDn45sHAbKvYgPa1CrbcFb2FEibl
         ZfEBXM4/kUvzZWA4KNA7aQCyryXP9F1cJcehbS0AFxeuhG2oVEcWo0UhRh5/GEXBS6Zg
         6MwpPs8I9U8Dfxhtaaa0wD9je7kwTQdoCAJdaAhHY1QRwmXGTQq7vRiIK2Khg5wsW1M4
         kLaHZ5ljaTU/5xiaanE8QtD7DlS9SBJ1z06x/lsG06KIIgr7fD1fpdkzAHlZcKiF8Q0F
         Gdd5bsC11JtG+Yh6g8N9Ins2v9TnFl0BwJuxGSy3ESwDHLSe7ObwI77bZ3Pun3AvVrL1
         VHnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:in-reply-to:subject:references
         :message-id:content-transfer-encoding:mime-version:date:cc;
        bh=QHGWWY22pO6yHqnjSxUDo2s26bU0eajolGp7D1IS4QQ=;
        b=QaN8drQRTzjG7uphVuyLp6JKlZduBW9+e7V/Ba7wczekkdD3VjIMTQnDTtkbYgg0LB
         z4LlGOUxfPoUQPOtq3N3JmjPyGJ+cqE1PblACI7RlDEBB8OEigEOjCqUSQpSLRTGdBBd
         vaCaNzb4i55O1nuNUVZqgnsSKCWXD24geqrnBZzuuNpd2C2G81Gx/Zvy8vRWEaQOewwK
         /IiOlrhs6MG6lIjsLGA26NEfiohKT5c9NiE4clvuT+86dNKQKUVQBl1UHdH4nB8Lu07v
         eyVm7PTMzs25n/CBpx2iUMRqER2pHEozJZ2+DU0D6cW5S4Rue/A5Grw6oqjqTM7WQ5P9
         d8zA==
X-Gm-Message-State: AIVw112g4N33F591gfj2yHtMXoO1ThwcXw1orGkzT5aP/cSb4sYVmyqa
        wn0T+MHvWIC1sw==
X-Received: by 10.99.113.11 with SMTP id m11mr6585318pgc.45.1499524135976;
        Sat, 08 Jul 2017 07:28:55 -0700 (PDT)
Received: from ?IPv6:2002:46b5:ad14::d013:3eac:e8fd:319c? ([2002:46b5:ad14:0:d013:3eac:e8fd:319c])
        by smtp.gmail.com with ESMTPSA id z82sm15171979pfk.1.2017.07.08.07.28.55
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sat, 08 Jul 2017 07:28:55 -0700 (PDT)
From:   "Kyle J. McKay" <mackyle@gmail.com>
To:     =?ISO-8859-1?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <eb5e7bb5-d0a9-c8df-e89c-a2bd2430e8b6@web.de>
Subject: Re: [PATCH] urlmatch: use hex2chr() in append_normalized_escapes()
References: <eb5e7bb5-d0a9-c8df-e89c-a2bd2430e8b6@web.de>
Message-Id: <A1589486-3E84-494C-9B8D-3FB1724B3145@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Content-Transfer-Encoding: quoted-printable
Mime-Version: 1.0 (Apple Message framework v936)
Date:   Sat, 8 Jul 2017 07:28:53 -0700
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
X-Mauler: Craptastic (2.936)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jul 8, 2017, at 01:59, Ren=E9 Scharfe wrote:

> Simplify the code by using hex2chr() to convert and check for invalid
> characters at the same time instead of doing that sequentially with
> one table lookup for each.

I think that comment may be a bit misleading as the changes are just
switching from one set of inlines to another.  Essentially the same
sequential check takes place in the hex2chr inlined function which is
being used to replace the "one table lookup for each".  An optimizing
compiler will likely eliminate any difference between the before and
after patch versions.  Nothing immediately comes to mind as an alternate
comment though, so I'm not proposing any changes to the comment.

The before version only requires knowledge of the standards-defined =20
isxdigit
and the hexval function which is Git-specific, but its semantics are =20
fairly
obvious from the surrounding code.

I suspect the casual reader of the function will have to go check and =20=

see
what hex2chr does exactly.  For example, does it accept "0x41" or not?
(It doesn't.)  What does it do with a single hex digit? (An error.)
It does do pretty much the same thing as the code it's
replacing (although that's not immediately obvious unless you go look
at it), so this seems like a reasonable change.

 =46rom the perspective of how many characters the original is versus =
how
many characters the replacement is, it's certainly a simplification.

But from the perspective of a reviewer of the urlmatch functionality
attempting to determine how well the code does or does not match the
respective standards it requires more work.  Now one must examine the
hex2chr function to be certain it doesn't include any extra unwanted
behavior with regards to how well urlmatch complies with the applicable
standards.  And in that sense it is not a simplification at all.

But that's all really just nit picking since hex2chr is a simple
inlined function that's relatively easy to find (and understand).

Therefore I don't have any objections to this change.

Acked-by: Kyle J. McKay

> Signed-off-by: Rene Scharfe <l.s.r@web.de>
> ---
> urlmatch.c | 10 +++++-----
> 1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/urlmatch.c b/urlmatch.c
> index 4bbde924e8..3e42bd7504 100644
> --- a/urlmatch.c
> +++ b/urlmatch.c
> @@ -42,12 +42,12 @@ static int append_normalized_escapes(struct =20
> strbuf *buf,
>
> 		from_len--;
> 		if (ch =3D=3D '%') {
> -			if (from_len < 2 ||
> -			    !isxdigit(from[0]) ||
> -			    !isxdigit(from[1]))
> +			if (from_len < 2)
> 				return 0;
> -			ch =3D hexval(*from++) << 4;
> -			ch |=3D hexval(*from++);
> +			ch =3D hex2chr(from);
> +			if (ch < 0)
> +				return 0;
> +			from +=3D 2;
> 			from_len -=3D 2;
> 			was_esc =3D 1;
> 		}



