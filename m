Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A62941F597
	for <e@80x24.org>; Fri,  3 Aug 2018 17:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727616AbeHCS7R (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Aug 2018 14:59:17 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:53994 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727171AbeHCS7R (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Aug 2018 14:59:17 -0400
Received: by mail-it0-f67.google.com with SMTP id 72-v6so9208603itw.3
        for <git@vger.kernel.org>; Fri, 03 Aug 2018 10:02:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9vX3RpYiI71SEnnt+89P9rC6ruEzAujr0yB2a7WMOTM=;
        b=d5QsYX84MIlqnxWrrqrMwvcdfCnPlHaqnjg8RO95rVBp4HEhVp/HlzM703jPxkCrNH
         3apQUwJ/ucoA4TAm1HLFYPY906SlgM8Lgo8sGRG4h+fOnO0U1G7D29/DyzqopJWlGbXX
         BcVNge3hyNhSTRY4SvjsyWN6C6K6MYlATirEs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9vX3RpYiI71SEnnt+89P9rC6ruEzAujr0yB2a7WMOTM=;
        b=LnfTu49dU3jX9XvtV7B9CCXklnCPN+UrwRzqnpce52mojzQ6PVSjeBtiZHQojzoFKs
         WIhGxiuPQqZuFuGIKA3aBGfpfol7JHsDZcgD4PASpRBrNCYNXVwyV92qnUkIV7obDHfa
         qgBbLYt6vHgI6UhSKs4ltb1pLx6O1qI8TW6Z3oLSKiOHP4ViD/3tfNHiQ30rxBLYG2ll
         TIgCwyYRC1uzVkfn0NOoFziIs5cwx2mZeap6RC+tomVnoMRfIFFqSWAh1aG86YpQCjqE
         Ek6hNCemgrsXYkQCJJ8IPdc91n2Z/8YO4qKrdl4rZjDsZv6BGFCz/5n7JK/mQDOSiq6+
         ROBA==
X-Gm-Message-State: AOUpUlGmJ2ibQnPVi1hrQadGYZimlfPyc62yFTibudUwWl4JiqOIgNUh
        rVo1ugSfxTkUT/Q/yH69VdcHndOy+z1km4tqPpQ=
X-Google-Smtp-Source: AAOMgpdC9JWbsC6HYPM2OtWQhibDSodIaAxCak6xpMIbXQOHPCJsfSrPQ0m8ymb3H3jqpoOhXxvmQ+dkN/UU3ittYLE=
X-Received: by 2002:a24:b211:: with SMTP id u17-v6mr6913880ite.1.1533315727690;
 Fri, 03 Aug 2018 10:02:07 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqin53t30d.fsf@gitster-ct.c.googlers.com> <20180726134111.17623-1-avarab@gmail.com>
 <20180803072014.GA256410@aiede.svl.corp.google.com> <xmqq600rz9my.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq600rz9my.fsf@gitster-ct.c.googlers.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 3 Aug 2018 10:01:56 -0700
Message-ID: <CA+55aFwc7UQ61EbNJ36pFU_aBCXGya4JuT-TvpPJ21hKhRengQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] doc hash-function-transition: pick SHA-256 as NewHash
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Edward Thomson <ethomson@edwardthomson.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>, Adam Langley <agl@google.com>,
        keccak@noekeon.org
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 3, 2018 at 9:40 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> > [...]
> >> -  - 20-byte NewHash checksum of all of the above.
> >> +  - 20-byte SHA-256 checksum of all of the above.
> >
> > Likewise.
>
> Hmph, I've always assumed since NewHash plan was written that this
> part was not about tamper resistance but was about bit-flipping
> detection and it was deliberate to stick to 20-byte sum, truncating
> as necessary.

Yeah, in fact, since this was one area where people actually had
performance issues with the hash, it might be worth considering
_weakening_ the hash.

Things like the pack index files (and just the regular file index) are
entirely local, and the SHA1 in those is really just a fancy CRC. It's
really just "good protection against disk corruption" (it happens),
and in fact you cannot use it as protection against active tampering,
since there's no secret there and any active attacker that has access
to your local filesystem could just recompute the hash anyway.

And because they are local anyway and aren't really transported
(modulo "shared repositories" where you use them across users or
legacy rsync-like synchronization), they can be handled separately
from any hashing changes. The pack and index file formats have in fact
been changed before.

It might make sense to either keep it as SHA1 (just to minimize any
changes) or if there are still issues with index file performance it
could even be made to use something fast-but-not-cryptographic like
just making it use crc32().

Remember: one of the original core git design requirements was
"corruption detection".

For normal hashed objects, that came naturally, and the normal object
store additionally has active tamper protection thanks to the
interconnected nature of the hashes and the distribution of the
objects.

But for things like packfiles and the file index, it is just a
separate checksum. There is no tamper protection anyway, since anybody
who can modify them directly can just recompute the hash checksum.

The fact that both of these things used SHA1 was more of a convenience
issue than anything else, and the pack/index file checksum is
fundamentally not cryptographic (but a cryptographic hash is obviously
by definition also a very good corruption detector).

               Linus
