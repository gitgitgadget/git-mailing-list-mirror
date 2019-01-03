Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 49E211F6A9
	for <e@80x24.org>; Thu,  3 Jan 2019 07:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbfACHoN (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Jan 2019 02:44:13 -0500
Received: from mail-ot1-f47.google.com ([209.85.210.47]:45937 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726671AbfACHoN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jan 2019 02:44:13 -0500
Received: by mail-ot1-f47.google.com with SMTP id 32so28685050ota.12
        for <git@vger.kernel.org>; Wed, 02 Jan 2019 23:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=mUem3/p/vrvp3emC7ZiGHv2eWPnoVXXhqg8DAF/M89U=;
        b=PQQM1lAo2D06Zhc16ZWGQvNA7g8RqNMKK3fpqpMNp2xOf1ZPU4H6RH3oUk8kmgxYZY
         5ndAfD79dlNc83p2qZ6XL+ptDVvLCUFdTL/F7oe8TIVfNqAgPeatL7FkoqMR8nMcvB7B
         sDkfaEsZIykUu/t3zbljkYt35rX6S/0hRLhg3Xx6gNl2vL0UCFYIJ8V3MmMk0QVzPdEC
         E6J69Jeq1kQdsgq47xTFxgdMFtB9TWSPHSA9snM2XVhA5uqr7kCkP8nwhvgskukCGU1D
         l08y/6ymW5kK6YrHxDWm7KOVEUaWp1ZShE1uWp7VgSrCje8z47wEsO9Z3WmgNcmToF7P
         u/Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=mUem3/p/vrvp3emC7ZiGHv2eWPnoVXXhqg8DAF/M89U=;
        b=XCOBj/yd3NTYbmHidmghM9w/reg7GCpPO9Ovr4b48uwo5KuklodbU6s0jsPeyHmKRq
         W4Kkhcy8PQKXXcwNGLjXdl7OKkTRngU6WhGqHyyeEClnJDYsXg9vUkt0OVd/Q69KH2R7
         dZyXDWqjNnhcSag1l21NO7t6aPr8FtUy/Kcf7wnDM7kNITfU7CmJGJrOutX9IPDmBSd6
         22iK/gQyjaRNcZbLPJ6wWodzjUHQtcEgSOAYoDmvAM+cjuptJltRBNZBpHkvAAp2YBt4
         8QjYuEcOMfuOiY+Ni1GZW5h0SFqPkbmo+cCMA4wkXXJ0zzJ5vAyrD6LB4+OwiF4u2ruS
         pdbw==
X-Gm-Message-State: AJcUukdqYYSJvkrkk7DU8eAqTqrhEKqw6C8duX0xECL8uUl9GchYodYE
        62OcXDVRT8kUhclcRCfNtMZeabF58ooCgj0YT5EKCvF3
X-Google-Smtp-Source: ALg8bN4EEYHXt2U1klHaElm97XNYoWhyZ0fgE0LiAW4jV4SI9ClWQrHLasNzUb4sr65O2dV5CafLeRs1dPnewjTcaYw=
X-Received: by 2002:a9d:748f:: with SMTP id t15mr32453033otk.93.1546501451999;
 Wed, 02 Jan 2019 23:44:11 -0800 (PST)
MIME-Version: 1.0
References: <CAFW+GMDazFSDzBrvzMqaPGwew=+CP7tw7G5FfDqcAUYd3qjPuQ@mail.gmail.com>
 <20190103070744.GA24149@sigill.intra.peff.net>
In-Reply-To: <20190103070744.GA24149@sigill.intra.peff.net>
From:   William Chargin <wchargin@gmail.com>
Date:   Wed, 2 Jan 2019 23:43:55 -0800
Message-ID: <CAFW+GMD9P-E4xCP+K5JAX70a6cgoHUzOXU-Tv3w6yhKGT_GaEg@mail.gmail.com>
Subject: Re: Parsing trailers
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> That's what "%(trailers:only)" does (even if the original separator was
> something else). It also trims any extra whitespace.

Ooh, this is good to know: thanks. (I had found `print_tok_val` in
`trailer.c` and assumed that this was the only place with the output
logic, but I now see that `format_trailer_info` also exists in the same
file.)

> IMHO this is a bug in --parse. It was always meant to give sane,
> normalized output

Okay; this is good to hear. In that case, what would you think about
changing `interpret-trailers` as a whole to always emit colons? (Note
that the command is already lossy: even with no flags, it replaces each
separator character with the first character of `trailer.separators`.)
This has the advantage that we avoid adding a configuration option of
dubious value=E2=80=94it=E2=80=99s not clear to me why a user would actuall=
y _want_ to
change the separator to anything other than a colon. The patch should be
quite simple, too (only tested lightly on my machine):

diff --git a/trailer.c b/trailer.c
index 0796f326b3..722040e48c 100644
--- a/trailer.c
+++ b/trailer.c
@@ -156,7 +156,7 @@ static void print_tok_val(FILE *outfile, const
char *tok, const char *val)
        if (strchr(separators, c))
                fprintf(outfile, "%s%s\n", tok, val);
        else
-               fprintf(outfile, "%s%c %s\n", tok, separators[0], val);
+               fprintf(outfile, "%s: %s\n", tok, val);
 }

Is this veering too much from =E2=80=9Cbug fix=E2=80=9D toward =E2=80=9Cbac=
kward-incompatible
behavior change=E2=80=9D for your comfort?

I agree that either this or your (1) and (2) would eliminate the need
for `-z`, which is nice.

Best,
WC
