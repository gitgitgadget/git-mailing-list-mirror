Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EC1AA1F462
	for <e@80x24.org>; Sun,  9 Jun 2019 21:51:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729517AbfFIVvt (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jun 2019 17:51:49 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:37605 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726211AbfFIVvs (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jun 2019 17:51:48 -0400
Received: by mail-ed1-f68.google.com with SMTP id w13so11441826eds.4
        for <git@vger.kernel.org>; Sun, 09 Jun 2019 14:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=5L4m9sCOnBmyCMGoKd7VbExdcmasadACUd1WpJzhH1Q=;
        b=UApYPhgHHM1o0cQlQiDKbQoxayzGyLNFzG1L/NyKVwcOBdVwErXGQUb5Xx8muFbhmW
         QUgPDkfyp2kUWVMh8zIxzC7wmXIsOVTXqMzFnMDYnZuDrsas//q39vBhlQbzJ7S+QkI1
         40MRcox8DOmVsoNmYqOkjMfm1fli4wQcYtRp6qo1TJRZM583iQw/XHu1f9cJ0IRzFste
         xhWNn3jFLx6GDFs58kKf03Lmrorp5TyMWcfA/zWanyV2Jqakxw7MZVx/99YLY5H3ycj/
         on6Anr3GHHzCcfBMjknjINbjz8EhsfKVwlu1CkVFy0qk1SZfgC2kgPyQ+GF8AA1/a8N7
         rRsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=5L4m9sCOnBmyCMGoKd7VbExdcmasadACUd1WpJzhH1Q=;
        b=OvhdWLgbO1c9q7m3GVAs/CNVqhGKU2FyvEdUqFwkioZa02HJveqq4dkZPFiygRy1fz
         s3Yl0iSRR0HJE8d6Xq46nbggaEOvVmNOizq2ttrkbkGsbAAK2CK8mHYFXCaprO+fiUEF
         6lHUwtvQrsgoL+STqIdBC5P5mfRjTGBGgLwlmlL0C9EG5fw+BO8YcjGb7fgifl/k3Kzy
         xgXRg4QZJ/pwNaipWSvIGRKVCh5wd5PXyh5nhCDRBTxcF7ipNe+qkNi6mPDvwHXCfIpa
         uRHzCQnCwp+3X7UOlleu5lm85jRvE9K9PcVX3/vP2I/EswjwM5IQ5cd+o80jDB9ZM782
         gyNg==
X-Gm-Message-State: APjAAAW4gYBS0nvyvN8vvfQ9x+OBATrwk/C+GcilZn8C652rF2ncO/up
        g+s2XDkYgvqrxNNGonhANnNfJ8sztYFn7tg4DdY=
X-Google-Smtp-Source: APXvYqxFSi9K+o01aPahrb72Uc0YnZRjBgwUFT+lIAWilLTbQIi4OBwxgv7RQPXJ2inWhhaxVxy4BDt41hCGCdakvPM=
X-Received: by 2002:aa7:c5d2:: with SMTP id h18mr69123851eds.110.1560117107034;
 Sun, 09 Jun 2019 14:51:47 -0700 (PDT)
MIME-Version: 1.0
References: <20190609044907.32477-1-chriscool@tuxfamily.org>
 <20190609044907.32477-3-chriscool@tuxfamily.org> <20190609092259.GB24208@szeder.dev>
 <CAP8UFD2AD9NzOUcLfN+NuWp_9JzwdV9oUo9rGAPXt3EP95=_og@mail.gmail.com> <20190609212130.GC24208@szeder.dev>
In-Reply-To: <20190609212130.GC24208@szeder.dev>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 9 Jun 2019 23:51:35 +0200
Message-ID: <CAP8UFD3iDY8gAm09OK2uQzG6bsB+06wVcGC6pjOgttb4sZ9F+w@mail.gmail.com>
Subject: Re: [PATCH 2/3] t: add t0016-oidmap.sh
To:     =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 9, 2019 at 11:21 PM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Sun, Jun 09, 2019 at 10:24:55PM +0200, Christian Couder wrote:
> > On Sun, Jun 9, 2019 at 11:23 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com=
> wrote:
> > >
> > > New Perl dependencies always make Dscho sad... :)
> >
> > Yeah, I was not sure how to do it properly in shell so I was hoping I
> > would get suggestions about this. Thanks for looking at this!
> >
> > I could have hardcoded the values as it is done in t0011-hashmap.sh,
> > but I thought it was better to find a function that does he job.
>
> Well, I'm fine with hardcoding the expected hash values (in network
> byte order) as well, because then we won't add another git process
> upstream of a pipe that would pop up during audit later...

Ok, I think I will do that then.

> > > So, 'test oidmap' from the previous patch prints the value we want to
> > > check with:
> > >
> > >     printf("%u\n", sha1hash(oid.hash));
> >
> > Yeah, I did it this way because "test-hashmap.c" does the same kind of
> > thing to print hashes:
> >
> >             printf("%u %u %u %u\n",
> >                    strhash(p1), memhash(p1, strlen(p1)),
> >                    strihash(p1), memihash(p1, strlen(p1)));
> >
> > > First, since object ids inherently make more sense as hex values, it
> > > would be more appropriate to print that hash with the '%x' format
> > > specifier,
> >
> > I would be ok with that, but then I think it would make sense to also
> > print hex values in "test-hashmap.c".
> >
> > > and then we wouldn't need Perl's hex() anymore, and thus
> > > could swap the order of the first four bytes in oidmap's hash without
> > > relying on Perl, e.g. with:
> > >
> > >   sed -e 's/^\(..\)\(..\)\(..\)\(..\).*/\4\3\2\1/'
> > >
> > > Second, and more importantly, the need for swapping the byte order
> > > indicates that this test would fail on big-endian systems, I'm afraid=
.
> > > So I think we need an additional bswap32() on the printing side,
> >
> > Ok, but then shouldn't we also use bswap32() in "test-hashmap.c"?
>
> No.  The two test scripts/helpers work with different hashes.  t0011
> and 'test-hashmap.c' uses the various FNV-1-based hash functions
> (strhash(), memhash(), ...) to calculate an unsigned int hash of the
> items stored in the hashmap, therefore their hashes will be the same
> regardless of endianness.

I see. Thanks for explaining that.

>  In an oidmap, however, the hash is simply
> the first four bytes of the object id as an unsigned int as is,

Yeah, I had realized that.

Thanks,
Christian.
