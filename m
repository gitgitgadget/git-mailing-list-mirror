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
	by dcvr.yhbt.net (Postfix) with ESMTP id E1EEA1F462
	for <e@80x24.org>; Sun,  9 Jun 2019 20:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729916AbfFIUZJ (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Jun 2019 16:25:09 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:44097 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729554AbfFIUZJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Jun 2019 16:25:09 -0400
Received: by mail-ed1-f65.google.com with SMTP id k8so11172516edr.11
        for <git@vger.kernel.org>; Sun, 09 Jun 2019 13:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=y3nUIOqyqsTyHY2YyTjA5EMXqWQGr40llezEKnBQAQs=;
        b=WeztkaXlQ1/IRj5/SIeEOwIzEgFBibx+1IOy70LRhB0NkAbAYDhYVKkNxqISTI+A9T
         99bMpe/2AcneR0RdfKvNVw8MTfIlGijitOHKtx9akKEfNGykjnjJ/Eu3W56XkSFhw67K
         72OeWGTbyMfbmQ1ogLm8eMwT/GEJ4puc0RoHhnWhQaArdwU4kdntN3eWLRyQucb9bRZg
         pUIH71a6Vf0hBVQd56z1rVpZO/4e7rtvpTfkzJfIuCmiZgHAwfnD6vwvS7X9FHZ3+WIv
         kZqpsCmqG5BZnprNt5EDXZnlVlA5qUIYqB1SPrbvRAFzJq3iFvKy+grLsyHQOO1uJrc3
         IcOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=y3nUIOqyqsTyHY2YyTjA5EMXqWQGr40llezEKnBQAQs=;
        b=U9IsQ4iNynad1TBPyRQqWCUf1d2fHibI7stRxCTSb+GW4g4WUif5BY0rZfwDFvCELJ
         wTGeQnK4qXdB1046HTLfbtre41NvLPNp1zNqq9GLzCj6AfmNMUKLDxRF+vb19krm/cgf
         aeZ8i+ofhsQbUjdeIfraY5cAg6ZhJveNooIqLxHc0AcCYdAH01ANEic32Jzcdk2ZUsJu
         FEYzgk2VeZoGyNtFzEa6ZpNJNDa6k0n4m/4Jlsko6nAzjsojgWyE7hKjnxE3GIPqQhtt
         iVIi/dX1Kh5EZtgvt8YN8dvGoSx7F4jrt0hrC5vm5vAzdutnvFTr6HNn4bKPGuFuRY8m
         Q+Fw==
X-Gm-Message-State: APjAAAUnmRjPm62ZhCukDau+x6++MmgC2eF8yuxUUopztAcYecvMkFjP
        8nH4m9bjZmVq0jw8hY71Wq8YFHeYKStupK3keZk=
X-Google-Smtp-Source: APXvYqxH8qoMtCCVvAZWYFKY7q0/GL/g/6JkP1I/czTDRzahAvru7EyyU0dSOlDDd7nO4bMGMVG2MfwQuJ55hSSsMWU=
X-Received: by 2002:a17:906:2594:: with SMTP id m20mr57794164ejb.217.1560111907502;
 Sun, 09 Jun 2019 13:25:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190609044907.32477-1-chriscool@tuxfamily.org>
 <20190609044907.32477-3-chriscool@tuxfamily.org> <20190609092259.GB24208@szeder.dev>
In-Reply-To: <20190609092259.GB24208@szeder.dev>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sun, 9 Jun 2019 22:24:55 +0200
Message-ID: <CAP8UFD2AD9NzOUcLfN+NuWp_9JzwdV9oUo9rGAPXt3EP95=_og@mail.gmail.com>
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

On Sun, Jun 9, 2019 at 11:23 AM SZEDER G=C3=A1bor <szeder.dev@gmail.com> wr=
ote:
>
> On Sun, Jun 09, 2019 at 06:49:06AM +0200, Christian Couder wrote:
> > +
> > +test_oidmap() {
> > +     echo "$1" | test-tool oidmap $3 > actual &&
> > +     echo "$2" > expect &&
>
> Style nit: space between redirection op and filename.

Thanks for spotting this. It's fixed in my current version.

> > +test_oidhash() {
> > +     git rev-parse "$1" | perl -ne 'print hex("$4$3$2$1") . "\n" if m/=
^(..)(..)(..)(..).*/;'
>
> New Perl dependencies always make Dscho sad... :)

Yeah, I was not sure how to do it properly in shell so I was hoping I
would get suggestions about this. Thanks for looking at this!

I could have hardcoded the values as it is done in t0011-hashmap.sh,
but I thought it was better to find a function that does he job.

> So, 'test oidmap' from the previous patch prints the value we want to
> check with:
>
>     printf("%u\n", sha1hash(oid.hash));

Yeah, I did it this way because "test-hashmap.c" does the same kind of
thing to print hashes:

            printf("%u %u %u %u\n",
                   strhash(p1), memhash(p1, strlen(p1)),
                   strihash(p1), memihash(p1, strlen(p1)));

> First, since object ids inherently make more sense as hex values, it
> would be more appropriate to print that hash with the '%x' format
> specifier,

I would be ok with that, but then I think it would make sense to also
print hex values in "test-hashmap.c".

> and then we wouldn't need Perl's hex() anymore, and thus
> could swap the order of the first four bytes in oidmap's hash without
> relying on Perl, e.g. with:
>
>   sed -e 's/^\(..\)\(..\)\(..\)\(..\).*/\4\3\2\1/'
>
> Second, and more importantly, the need for swapping the byte order
> indicates that this test would fail on big-endian systems, I'm afraid.
> So I think we need an additional bswap32() on the printing side,

Ok, but then shouldn't we also use bswap32() in "test-hashmap.c"?

By the way it seems that we use ntohl() or htonl() instead of
bswap32() in the source code.

> and then could further simplify 'test_oidhash':
>
> diff --git a/t/helper/test-oidmap.c b/t/helper/test-oidmap.c
> index 0ba122a264..4177912f9a 100644
> --- a/t/helper/test-oidmap.c
> +++ b/t/helper/test-oidmap.c
> @@ -51,7 +51,7 @@ int cmd__oidmap(int argc, const char **argv)
>
>                         /* print hash of oid */
>                         if (!get_oid(p1, &oid))
> -                               printf("%u\n", sha1hash(oid.hash));
> +                               printf("%x\n", bswap32(sha1hash(oid.hash)=
));
>                         else
>                                 printf("Unknown oid: %s\n", p1);
>
> diff --git a/t/t0016-oidmap.sh b/t/t0016-oidmap.sh
> index 3a8e8bdb3d..9c0d88a316 100755
> --- a/t/t0016-oidmap.sh
> +++ b/t/t0016-oidmap.sh
> @@ -22,10 +22,10 @@ test_expect_success 'setup' '
>  '
>
>  test_oidhash() {
> -       git rev-parse "$1" | perl -ne 'print hex("$4$3$2$1") . "\n" if m/=
^(..)(..)(..)(..).*/;'
> +       git rev-parse "$1" | cut -c1-8
>  }
>
> -test_expect_success PERL 'hash' '
> +test_expect_success 'hash' '

Yeah, I agree that it seems better to me this way.
