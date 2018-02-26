Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A9E2F1F576
	for <e@80x24.org>; Mon, 26 Feb 2018 11:25:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752803AbeBZLZ4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 26 Feb 2018 06:25:56 -0500
Received: from mail-ot0-f173.google.com ([74.125.82.173]:33920 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752131AbeBZLZz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Feb 2018 06:25:55 -0500
Received: by mail-ot0-f173.google.com with SMTP id n74so12834391ota.1
        for <git@vger.kernel.org>; Mon, 26 Feb 2018 03:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=Zj8ov7QBvYsz/IeVg/19JK3Renkx2yc03cfvd/TZGZ8=;
        b=UsntRBlQ7sl2UuuPAsFB0zjZ1N1pq5qzgObj7KGT5WZYG3ob3Gtjq/Uy9OUS7JsDI1
         EUuKPtQ3o2dEPo/Z8gcPUolB2IVBXKnvNy7KRQDARPP1VNvrZMyECDf6hpSTd+0sCc0G
         AZwPbAHuAreDghhQFsi+QWNPsbhxv9/gPxX+smeNUjrafgScjdpOjVfevridKao2q8M6
         yihF5YiAICnJg5z1ANeWKFjDRfO0mHeZqox6kXKrM6RYDv/SNcZ1W8lGIOlKip7pXTKT
         aBpA+wIR0SN5ji1q8I9mSe0Jur8Go/yng2lDYwj2o0NBjbkJSN3GNAW2vQAa2YZcbX76
         2r7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=Zj8ov7QBvYsz/IeVg/19JK3Renkx2yc03cfvd/TZGZ8=;
        b=NAXVt+MZ11omN6diA4YXkRuEydoesqaVPyPJ0lH6hxABgzjSJls/H3hphZDtv7llxi
         I/ByBgQtOkbO6eFpeHc7RxNP9VgGYQLE6w5fhmGOpQFwCZB+0/usyW/iifj3Teh5PObn
         xEB4hXUKqTv9rYRvmORv+Rw/8cd5LxbH27erxDSUb7j2UEjBdlzUD4cEaHt5wjeoqYiw
         oRU3Q/r0vdsTAEnTEQtchY4Ob7FaKtOi8uSY+kCwBMYF6cImleJXNPts+JKQGFopaxOS
         AA3OQPe1sqizjuTjgXDcQHP9FSPD4OLgq+PLI1Tx5AaLFiKJDjrGEQNTFh0o/3PixgWY
         oTow==
X-Gm-Message-State: APf1xPBCr0w8b/gSkB5oyTJm4vDJO4t6PWUdfVuzmZvFo3x+8P4mQ9BQ
        hu3rfb3b5nikmbRf9IaDMx7nHokhMaX5XJ0FYK8=
X-Google-Smtp-Source: AG47ELu+uMCY+AIpTL1USAw62DZtAaJvKPOeQb8X4DmJn/loMlwlgCPX672TUxiOBZz2jJuIusQO7RjZx/X7Q0y6Oig=
X-Received: by 10.157.85.214 with SMTP id z22mr7750227oti.75.1519644355196;
 Mon, 26 Feb 2018 03:25:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.74.25.140 with HTTP; Mon, 26 Feb 2018 03:25:24 -0800 (PST)
In-Reply-To: <20180225211212.477570-6-sandals@crustytoothpaste.net>
References: <20180225211212.477570-1-sandals@crustytoothpaste.net> <20180225211212.477570-6-sandals@crustytoothpaste.net>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Mon, 26 Feb 2018 18:25:24 +0700
Message-ID: <CACsJy8AnTp1kzwUbAY_9XKg=A6Mo0gUa8o_dimx=+c1rFqu16w@mail.gmail.com>
Subject: Re: [PATCH v2 05/36] resolve-undo: convert struct resolve_undo_info
 to object_id
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Patryk Obara <patryk.obara@gmail.com>,
        Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 26, 2018 at 4:11 AM, brian m. carlson
<sandals@crustytoothpaste.net> wrote:
> @@ -44,7 +44,7 @@ void resolve_undo_write(struct strbuf *sb, struct string_list *resolve_undo)
>                 for (i = 0; i < 3; i++) {
>                         if (!ui->mode[i])
>                                 continue;
> -                       strbuf_add(sb, ui->sha1[i], 20);
> +                       strbuf_add(sb, ui->oid[i].hash, the_hash_algo->rawsz);
>                 }
>         }
>  }
> @@ -89,7 +89,7 @@ struct string_list *resolve_undo_read(const char *data, unsigned long size)
>                                 continue;
>                         if (size < 20)
>                                 goto error;
> -                       hashcpy(ui->sha1[i], (const unsigned char *)data);
> +                       hashcpy(ui->oid[i].hash, (const unsigned char *)data);
>                         size -= 20;
>                         data += 20;
>                 }

Here we see the same pattern again, but this time the @@ lines give
better context: these are actually hash I/O. Maybe it's about time we
add

int oidwrite(char *, size_t , const struct object_id *);
// optionally, void strbuf_addoid(struct strbuf *, const struct object_id *);
int oidread(struct object_id *, const char *, size_t);

for conversion from between an object_id in memory and on disk? It
would probably be a straight memcpy for all hash algorithms so we
don't really need new function pointers in git_hash_algo for this.
-- 
Duy
