Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26E2320285
	for <e@80x24.org>; Sun, 27 Aug 2017 18:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751263AbdH0SV4 (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Aug 2017 14:21:56 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:37618 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751252AbdH0SVz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Aug 2017 14:21:55 -0400
Received: by mail-wr0-f195.google.com with SMTP id p14so2907847wrg.4
        for <git@vger.kernel.org>; Sun, 27 Aug 2017 11:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8g8s2yDK/IVlO/c5SMjIzLl75p91cPlpl6Ge+3u89yI=;
        b=LdvO1SK2rlcUxXHtKnNCggq9js5nUg8id+utb0gV3RSxRO5Lh7hz15LCJBdf8ZAAIv
         /stSE6cvIBHOhOvG2VC2SmFPeXki4t4slOzgFslP92SVuBA5ot8liQ6pGXw++1pj54Z0
         8UWk1BeTeHwjR8dXJqboLm193k8pSHHZ8o+s6AuhRw4ijIpsHEqCTdeWUfMrCHTU1dL1
         v3sadJlBTjKnPP2lnXpWlz0i2ptHjnYsaeDuGQW2r3L6PiR8k/vANpPNgmAtNJMfXgTp
         8UoQ6IUAxvnqTZmrk2PM5MzwDJotazqsR9EWg35YnaluhYjZUCUJNHQJOKDoM0Y+zBkf
         4Ijw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=8g8s2yDK/IVlO/c5SMjIzLl75p91cPlpl6Ge+3u89yI=;
        b=EfhcRKdCqyG7j1DtMusrJzKsUR95iMGgFly40VBGG1WYEbLjN61c9ZGZMMvSIDuLTl
         DxHA+DMOesNKK/970JbxSs1Q8z+cKnresyA91E6bcabHHoB2UzG4qdwddavlP2BrkkFl
         9/HyEd6hEViMLAmzUyJ9slBaK4nuBMlnasL4zl7NV0gL5gRpNJ6t+9BpTx2QUmmWRJnA
         C2EONaQ28j+i3U3aEr4w0Yq90eQGwfu9KAAZqjjtPxx+/nRdYBVjLnX59RuC0ebU1nI2
         LIiWMEyeQff8eJxNrqjU/v1KsBXb3Ycf+llnAR6+ZBtlUjdVVORkzr95MrI94e4+H3am
         0Q3g==
X-Gm-Message-State: AHYfb5jfQOk8mUbQwYOhtnxLE8qNUoHEaxGEZlAMDQjsKJwumF/U+IIb
        uaF4E8Q+lMaQWg==
X-Received: by 10.223.139.90 with SMTP id v26mr1475785wra.208.1503858114686;
        Sun, 27 Aug 2017 11:21:54 -0700 (PDT)
Received: from [10.32.248.91] (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id l4sm10993164wrb.70.2017.08.27.11.21.52
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 27 Aug 2017 11:21:53 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
Subject: Re: [PATCH] pkt-line: re-'static'-ify buffer in packet_write_fmt_1()
From:   Lars Schneider <larsxschneider@gmail.com>
In-Reply-To: <20170827073732.546-1-martin.agren@gmail.com>
Date:   Sun, 27 Aug 2017 20:21:54 +0200
Cc:     Git Users <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9E4606AF-8814-42DE-8D3A-3A15C1B1723C@gmail.com>
References: <20170827073732.546-1-martin.agren@gmail.com>
To:     =?utf-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
X-Mailer: Apple Mail (2.3124)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


> On 27 Aug 2017, at 09:37, Martin =C3=85gren <martin.agren@gmail.com> =
wrote:
>=20
> The static-ness was silently dropped in commit 70428d1a5 ("pkt-line: =
add
> packet_write_fmt_gently()", 2016-10-16). As a result, for each call to
> packet_write_fmt_1, we allocate and leak a buffer.

Oh :-( Thanks for detecting and fixing the leak.

How did you actually find it? Reading the code or did you use some
tool?


> We could keep the strbuf non-static and instead make sure we always
> release it before returning (but not before we die, so that we don't
> touch errno). That would also prepare us for threaded use. But until
> that needs to happen, let's just restore the static-ness so that we =
get
> back to a situation where we (eventually) do not continuosly keep
> allocating memory.
>=20
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
> I waffled between "fixing the memory leak" by releasing the buffer and
> "fixing the static-ness" as in this patch. I can see arguments both =
ways
> and don't have any strong opinion.
>=20
> pkt-line.c | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/pkt-line.c b/pkt-line.c
> index 7db911957..f364944b9 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -136,9 +136,10 @@ static void format_packet(struct strbuf *out, =
const char *fmt, va_list args)
> static int packet_write_fmt_1(int fd, int gently,
> 			      const char *fmt, va_list args)
> {
> -	struct strbuf buf =3D STRBUF_INIT;
> +	static struct strbuf buf =3D STRBUF_INIT;
> 	ssize_t count;
>=20
> +	strbuf_reset(&buf);
> 	format_packet(&buf, fmt, args);
> 	count =3D write_in_full(fd, buf.buf, buf.len);
> 	if (count =3D=3D buf.len)
> --=20
> 2.14.1.151.g45c1275a3.dirty

Looks good to me!

- Lars=
