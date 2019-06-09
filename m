Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C5021F462
	for <e@80x24.org>; Sun,  9 Jun 2019 21:21:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729402AbfFIVVg (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jun 2019 17:21:36 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:36072 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728868AbfFIVVg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jun 2019 17:21:36 -0400
Received: by mail-wm1-f66.google.com with SMTP id u8so6333302wmm.1
        for <git@vger.kernel.org>; Sun, 09 Jun 2019 14:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LLocvdNWmb/LbxyMbnABNDQBnKwxUF+HAIBOL8d4YQM=;
        b=a5qPcHzMbO89Iob6C3YT0EMYJzrxjJCSHPViiEjewiPZ1jd1J9F91Ra4jSpCjlQYmF
         m1niSo6DcHniQrtnt9KJkbCqcXUTAz31WlTbEmn6aabFkrhAb3drbIG1/rn+pK9OfNqd
         N+7NWgxLWHXois3ACDa56osr26CRFxJ4lFZ88DoCt6W675dGRTVqW6PsWM9JKEQbuNvw
         R5HL3sPhMBda/3ve5QuENhxQTpJBAgVTLfFFN6B8RuwHELfm1FuwvUGdJfVkoPmprVBg
         pSXORB+hEHB9e47+0kdRCFiAPlHjMqF6ohIxU5/z5ZdGsC0wAClX7b9gbxnoFFi3uVka
         Qm2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LLocvdNWmb/LbxyMbnABNDQBnKwxUF+HAIBOL8d4YQM=;
        b=t1nKB5eLraL3Ra7FwDF8YkOANqxEsAYZ2bc558eeIwg8CBAITP6X80qEeaqQK+szHM
         D9cw7NI9ltbY30UI9k3wH6LAluRord7vRSuPizJHKFn0fOIYhoKzAm+hu0e9MJJKq6xs
         MpZkiLYJVd7mOgJaR4GOE6jaUkwDbWSmlpOzT4TMnRGxz7lLPN303WZGgtA/ngZizoue
         NPlkXxp4ouHQgnFh0zl5RIDbvLz5asn3/pipfFV+zybvmUHBRSfdTHmMcmQF5qQmZ9tn
         bEFMQe15kI6KEVY2hYbMz1VYxHZiM/eRzNx95ixPr2yGvTt0hYQ28w7XV+Jmw+PTv5g/
         ZjSQ==
X-Gm-Message-State: APjAAAV/kRjoeZpuHaa3AzxToCaQpIOjQQ6JR7px8i8vyOVG72du90Bx
        VdTAHmDjwAQ0Ny3y7U6Xdo4=
X-Google-Smtp-Source: APXvYqwxfzp+TNU2vd7+Ev8NPDnvnBzgVDF9r4XAsavR7KEbxY4uwaV8UcWVypK9RwcqVJQGC+SiFw==
X-Received: by 2002:a7b:c7d8:: with SMTP id z24mr11282270wmk.10.1560115293581;
        Sun, 09 Jun 2019 14:21:33 -0700 (PDT)
Received: from szeder.dev (x4db5757b.dyn.telefonica.de. [77.181.117.123])
        by smtp.gmail.com with ESMTPSA id v15sm8249324wrt.25.2019.06.09.14.21.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Jun 2019 14:21:32 -0700 (PDT)
Date:   Sun, 9 Jun 2019 23:21:30 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Brandon Williams <bmwill@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/3] t: add t0016-oidmap.sh
Message-ID: <20190609212130.GC24208@szeder.dev>
References: <20190609044907.32477-1-chriscool@tuxfamily.org>
 <20190609044907.32477-3-chriscool@tuxfamily.org>
 <20190609092259.GB24208@szeder.dev>
 <CAP8UFD2AD9NzOUcLfN+NuWp_9JzwdV9oUo9rGAPXt3EP95=_og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD2AD9NzOUcLfN+NuWp_9JzwdV9oUo9rGAPXt3EP95=_og@mail.gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 09, 2019 at 10:24:55PM +0200, Christian Couder wrote:
> On Sun, Jun 9, 2019 at 11:23 AM SZEDER Gábor <szeder.dev@gmail.com> wrote:
> >
> > On Sun, Jun 09, 2019 at 06:49:06AM +0200, Christian Couder wrote:
> > > +
> > > +test_oidmap() {
> > > +     echo "$1" | test-tool oidmap $3 > actual &&
> > > +     echo "$2" > expect &&
> >
> > Style nit: space between redirection op and filename.
> 
> Thanks for spotting this. It's fixed in my current version.
> 
> > > +test_oidhash() {
> > > +     git rev-parse "$1" | perl -ne 'print hex("$4$3$2$1") . "\n" if m/^(..)(..)(..)(..).*/;'
> >
> > New Perl dependencies always make Dscho sad... :)
> 
> Yeah, I was not sure how to do it properly in shell so I was hoping I
> would get suggestions about this. Thanks for looking at this!
> 
> I could have hardcoded the values as it is done in t0011-hashmap.sh,
> but I thought it was better to find a function that does he job.

Well, I'm fine with hardcoding the expected hash values (in network
byte order) as well, because then we won't add another git process
upstream of a pipe that would pop up during audit later...

> > So, 'test oidmap' from the previous patch prints the value we want to
> > check with:
> >
> >     printf("%u\n", sha1hash(oid.hash));
> 
> Yeah, I did it this way because "test-hashmap.c" does the same kind of
> thing to print hashes:
> 
>             printf("%u %u %u %u\n",
>                    strhash(p1), memhash(p1, strlen(p1)),
>                    strihash(p1), memihash(p1, strlen(p1)));
> 
> > First, since object ids inherently make more sense as hex values, it
> > would be more appropriate to print that hash with the '%x' format
> > specifier,
> 
> I would be ok with that, but then I think it would make sense to also
> print hex values in "test-hashmap.c".
> 
> > and then we wouldn't need Perl's hex() anymore, and thus
> > could swap the order of the first four bytes in oidmap's hash without
> > relying on Perl, e.g. with:
> >
> >   sed -e 's/^\(..\)\(..\)\(..\)\(..\).*/\4\3\2\1/'
> >
> > Second, and more importantly, the need for swapping the byte order
> > indicates that this test would fail on big-endian systems, I'm afraid.
> > So I think we need an additional bswap32() on the printing side,
> 
> Ok, but then shouldn't we also use bswap32() in "test-hashmap.c"?

No.  The two test scripts/helpers work with different hashes.  t0011
and 'test-hashmap.c' uses the various FNV-1-based hash functions
(strhash(), memhash(), ...) to calculate an unsigned int hash of the
items stored in the hashmap, therefore their hashes will be the same
regardless of endianness.  In an oidmap, however, the hash is simply
the first four bytes of the object id as an unsigned int as is, and
look at how sha1hash() does it, and indeed at the last sentence of the
comment in front of it:

 * [...] Note that
 * the results will be different on big-endian and little-endian
 * platforms, so they should not be stored or transferred over the net.
 */
static inline unsigned int sha1hash(const unsigned char *sha1)
{
        /*
         * Equivalent to 'return *(unsigned int *)sha1;', but safe on
         * platforms that don't support unaligned reads.
         */
        unsigned int hash;
        memcpy(&hash, sha1, sizeof(hash));
        return hash;
}

> By the way it seems that we use ntohl() or htonl() instead of
> bswap32() in the source code.

OK.

> > and then could further simplify 'test_oidhash':
> >
> > diff --git a/t/helper/test-oidmap.c b/t/helper/test-oidmap.c
> > index 0ba122a264..4177912f9a 100644
> > --- a/t/helper/test-oidmap.c
> > +++ b/t/helper/test-oidmap.c
> > @@ -51,7 +51,7 @@ int cmd__oidmap(int argc, const char **argv)
> >
> >                         /* print hash of oid */
> >                         if (!get_oid(p1, &oid))
> > -                               printf("%u\n", sha1hash(oid.hash));
> > +                               printf("%x\n", bswap32(sha1hash(oid.hash)));
> >                         else
> >                                 printf("Unknown oid: %s\n", p1);
> >
> > diff --git a/t/t0016-oidmap.sh b/t/t0016-oidmap.sh
> > index 3a8e8bdb3d..9c0d88a316 100755
> > --- a/t/t0016-oidmap.sh
> > +++ b/t/t0016-oidmap.sh
> > @@ -22,10 +22,10 @@ test_expect_success 'setup' '
> >  '
> >
> >  test_oidhash() {
> > -       git rev-parse "$1" | perl -ne 'print hex("$4$3$2$1") . "\n" if m/^(..)(..)(..)(..).*/;'
> > +       git rev-parse "$1" | cut -c1-8
> >  }
> >
> > -test_expect_success PERL 'hash' '
> > +test_expect_success 'hash' '
> 
> Yeah, I agree that it seems better to me this way.
