Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C1E941F42D
	for <e@80x24.org>; Tue, 24 Apr 2018 09:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756256AbeDXJuS (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 05:50:18 -0400
Received: from mail-pf0-f194.google.com ([209.85.192.194]:38361 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756126AbeDXJuR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 05:50:17 -0400
Received: by mail-pf0-f194.google.com with SMTP id o76so7097995pfi.5
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 02:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=PhWxhaF77a1vdj2+LWIIAzkcSl34ZiR8SGfFXWFPFTo=;
        b=KHKnLM5/VpuQ8HHBMpox5sASzhygVIgxn/+Y0fjtuyB4/R4Esv3KEnB7i+Ix5xD0Pl
         HyioLzYtsCMXAXwhaPWs3olxeMWN/Rdzt8gGmL4HOWdUcl8fBzllwQ2f89njFSF9O24T
         OxTS5OQXTKdBZSTZvCDHo+wVRYimp1oG9dkY0z+V5LloEh7fq+ht5lvWgK9dcL1Sqb4A
         fWaKjsh+U2w1McTMGQt1kBYVmht9oq3zsqhqXq4adFfW/YUiwfHKiHViHh6hp4GybhNJ
         OtjTnBDLK8H+/nOoWwarFwRt0T7rubMVGoQr1SN5l0T3nZKAOrxS9RiICYeDSpT7hkeU
         rB4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=PhWxhaF77a1vdj2+LWIIAzkcSl34ZiR8SGfFXWFPFTo=;
        b=KL+dezMF+JC5CoAZNMGxkt7EuRHLt2wDnaVLXEmfdKDQAiXMD5PQQX+oR1ccc1dOTT
         0LfCukvLg26pXpuRwr0mBq5x4pgf2MSkVpkxhG6u1CtgMwc6r/L5+w35JnlEoSGICIVf
         lvFg+EfNdgnqT1ApcZK9+yaBd/AZOb1MGw7sBDC06fUKh3oz9Fx8Sd5PbJhKfvJA0vLO
         hLcGFafb3kbSxDXBKjoYHo596zv9yKWVYDTQoU6Eff0B6FkVPJ3/g/HI0zaRfaJv943u
         qBwS4xatPy2BV9EeeSXaD3lLyfJci8Udcq5S2u1xGk1/Kuxphw7EMCpD4aBICIuw85jx
         AKTg==
X-Gm-Message-State: ALQs6tAU2nVzvJO62PI1aBc66v7qPtCWP/neKTjY3f8+bPmTqhNGG5Mb
        IURffzQXDnNqa+NNcvjj6Zx62B7gnc4LXX1bPuc=
X-Google-Smtp-Source: AIpwx4+Si8zEFJYtthEwqlYodwgktjr7LyElHVfpCQDoTEbby+tmfCcMMfWEwjz9iY/14/ttDbEmKI//jlicwfJUybc=
X-Received: by 10.101.88.140 with SMTP id d12mr19561412pgu.408.1524563416955;
 Tue, 24 Apr 2018 02:50:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.150.4 with HTTP; Tue, 24 Apr 2018 02:50:15 -0700 (PDT)
In-Reply-To: <20180423233951.276447-19-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net> <20180423233951.276447-19-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 24 Apr 2018 11:50:16 +0200
Message-ID: <CAN0heSouHbAj8TbiROe=XRsBJ788Vi6P4a_Wvv=7OrdsXqQXHw@mail.gmail.com>
Subject: Re: [PATCH 18/41] index-pack: abstract away hash function constant
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24 April 2018 at 01:39, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> The code for reading certain pack v2 offsets had a hard-coded 5
> representing the number of uint32_t words that we needed to skip over.
> Specify this value in terms of a value from the_hash_algo.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/index-pack.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index d81473e722..c1f94a7da6 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1543,12 +1543,13 @@ static void read_v2_anomalous_offsets(struct packed_git *p,
>  {
>         const uint32_t *idx1, *idx2;
>         uint32_t i;
> +       const uint32_t hashwords = the_hash_algo->rawsz / sizeof(uint32_t);

Should we round up? Or just what should we do if a length is not
divisible by 4? (I am not aware of any such hash functions, but one
could exist for all I know.) Another question is whether such an
index-pack v2 will ever contain non-SHA-1 oids to begin with. I can't
find anything suggesting that it could, but this is unfamiliar code to
me.

>         /* The address of the 4-byte offset table */
>         idx1 = (((const uint32_t *)p->index_data)
>                 + 2 /* 8-byte header */
>                 + 256 /* fan out */
> -               + 5 * p->num_objects /* 20-byte SHA-1 table */
> +               + hashwords * p->num_objects /* object ID table */
>                 + p->num_objects /* CRC32 table */
>                 );
