Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A85491F404
	for <e@80x24.org>; Tue, 24 Apr 2018 09:58:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756913AbeDXJ6W (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Apr 2018 05:58:22 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:38381 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756841AbeDXJ6S (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Apr 2018 05:58:18 -0400
Received: by mail-pf0-f195.google.com with SMTP id o76so7114446pfi.5
        for <git@vger.kernel.org>; Tue, 24 Apr 2018 02:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=4yNqcCdg1vbqvJQ0xDCozbFh/yiraEhKfxqx2yxv3ks=;
        b=WFrX/bKXZxeHzBsgvKxPISURVZEVTtdhedEt9k4u05YUJ2s2NacwIq6vu7vEvsk3kj
         yP1oW1eJHDwZPGPE0jloFeopZyjj/Cf7hYAZlcLXdjji++hFaZ2vf0KOF1+t9WCDhKKl
         dovAKPNvkeS7iDsfowepX1JfC0Nvt2qYGy1AHJ2fcbDamtJQ6qayf0P6l/mBhB48j0CE
         tg+bSgFChrOjkYcF2N+3lh10qW/HB0P1JmDi5P/LBHfT67nVz1hb5eGF2cR83kZH1xiN
         QrUeATjV+Rqcg0BIGNyn6OE/3VVO4nVh4ihKrD1UkU36qRH2pkS6tLAVTw1/tnnT/MXE
         tAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=4yNqcCdg1vbqvJQ0xDCozbFh/yiraEhKfxqx2yxv3ks=;
        b=Xvqmixv55+SIaBeugHsJg87GY8jNzbA5UmV+oxOSnNN/rqOq+KUb3ics/X+GQ80yn5
         onw9KEaJu7Y58QohALCXqyBusAlyzIYELFmyAUjUhh0+aThaC7MfV5MxLaI2kYpJJI37
         j0m0HbN1lqnV6IZy/ULcNqucxvPpmPHU/lXu7jd5uQJS8cyiy89+FFlpw94ugAWMWDi/
         xlXI5kLpKZnw0AwfT4fRTRdBbuusqbISGfqpocP3wxxMflZpYyEz+qUzqjjOYPmdX7IF
         DQ2+m6lIxTq4orXdqOkHYQyhED8x/7tyIgafkurfsv7GwVztx7szihytcBh894JDagPi
         t4Hw==
X-Gm-Message-State: ALQs6tBwm2dDsX7q+Yt1EU/y9NfiV782AAz2sxqTrJ26iQPu2T+n/1hu
        9LTm13oqgYip85Le+QF0fj2qEy2vF8DVi0gchKM=
X-Google-Smtp-Source: AIpwx4+Q8bwQ6HjZKiWnqgC17gMrTb0D7pGYtRMRhZhekRl4i7OydGaukrzZIMY1ry1Yt0iVvZEhyiCtfLeypz9uIKI=
X-Received: by 10.98.80.80 with SMTP id e77mr23555965pfb.16.1524563897654;
 Tue, 24 Apr 2018 02:58:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.236.150.4 with HTTP; Tue, 24 Apr 2018 02:58:17 -0700 (PDT)
In-Reply-To: <20180423233951.276447-26-sandals@crustytoothpaste.net>
References: <20180423233951.276447-1-sandals@crustytoothpaste.net> <20180423233951.276447-26-sandals@crustytoothpaste.net>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Tue, 24 Apr 2018 11:58:17 +0200
Message-ID: <CAN0heSoU4wDAcfF_EGYSA4gjbpCgTyk0fGPsmPTwv65FfZCQcg@mail.gmail.com>
Subject: Re: [PATCH 25/41] builtin/receive-pack: avoid hard-coded constants
 for push certs
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
> Use the GIT_SHA1_RAWSZ and GIT_SHA1_HEXSZ macros instead of hard-coding
> the constants 20 and 40.  Switch one use of 20 with a format specifier
> for a hex value to use the hex constant instead, as the original appears
> to have been a typo.
>
> At this point, avoid converting the hard-coded use of SHA-1 to use
> the_hash_algo.  SHA-1, even if not collision resistant, is secure in the
> context in which it is used here, and the hash algorithm of the repo
> need not match what is used here.  When we adopt a new hash algorithm,
> we can simply adopt the new algorithm wholesale here, as the nonce is
> opaque and its length and validity are entirely controlled by the
> server.  Consequently, defer updating this code until that point.
>
> Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
> ---
>  builtin/receive-pack.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index c4272fbc96..5f35596c14 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -454,21 +454,21 @@ static void hmac_sha1(unsigned char *out,
>         /* RFC 2104 2. (6) & (7) */
>         git_SHA1_Init(&ctx);
>         git_SHA1_Update(&ctx, k_opad, sizeof(k_opad));
> -       git_SHA1_Update(&ctx, out, 20);
> +       git_SHA1_Update(&ctx, out, GIT_SHA1_RAWSZ);
>         git_SHA1_Final(out, &ctx);
>  }

Since we do HMAC with SHA-1, we use the functions `git_SHA1_foo()`. Ok.
But then why not just use "20"? Isn't GIT_SHA1_RAWSZ coupled to the
whole hash transition thing? This use of "20" is not, IMHO, the "length
in bytes [...] of an object name" (quoting cache.h).

>  static char *prepare_push_cert_nonce(const char *path, timestamp_t stamp)
>  {
>         struct strbuf buf = STRBUF_INIT;
> -       unsigned char sha1[20];
> +       unsigned char sha1[GIT_SHA1_RAWSZ];
>
>         strbuf_addf(&buf, "%s:%"PRItime, path, stamp);
>         hmac_sha1(sha1, buf.buf, buf.len, cert_nonce_seed, strlen(cert_nonce_seed));;
>         strbuf_release(&buf);
>
>         /* RFC 2104 5. HMAC-SHA1-80 */
> -       strbuf_addf(&buf, "%"PRItime"-%.*s", stamp, 20, sha1_to_hex(sha1));
> +       strbuf_addf(&buf, "%"PRItime"-%.*s", stamp, GIT_SHA1_HEXSZ, sha1_to_hex(sha1));
>         return strbuf_detach(&buf, NULL);
>  }

Same comment here.

Martin
