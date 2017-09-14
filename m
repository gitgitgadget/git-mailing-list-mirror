Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8EDF620A21
	for <e@80x24.org>; Thu, 14 Sep 2017 22:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751697AbdINWJ4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Sep 2017 18:09:56 -0400
Received: from mout.gmx.net ([212.227.17.21]:55060 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751594AbdINWJz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2017 18:09:55 -0400
Received: from virtualbox ([37.201.193.73]) by mail.gmx.com (mrgmx103
 [212.227.17.168]) with ESMTPSA (Nemesis) id 0Lcjdr-1dBGhP2Ssp-00k9Xj; Fri, 15
 Sep 2017 00:09:32 +0200
Date:   Fri, 15 Sep 2017 00:09:29 +0200 (CEST)
From:   Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: virtualbox@virtualbox
To:     Jonathan Nieder <jrnieder@gmail.com>
cc:     demerphq <demerphq@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>, jonathantanmy@google.com,
        Jeff King <peff@peff.net>, David Lang <david@lang.hm>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: RFC v3: Another proposed hash function transition plan
In-Reply-To: <20170914184022.GB78683@aiede.mtv.corp.google.com>
Message-ID: <alpine.DEB.2.21.1.1709150008390.219280@virtualbox>
References: <20170304011251.GA26789@aiede.mtv.corp.google.com> <CA+55aFz+gkAsDZ24zmePQuEs1XPS9BP_s8O7Q4wQ7LV7X5-oDA@mail.gmail.com> <20170307001709.GC26789@aiede.mtv.corp.google.com> <xmqqa828733s.fsf@gitster.mtv.corp.google.com> <xmqq1snh29re.fsf@gitster.mtv.corp.google.com>
 <20170911185913.GA5869@google.com> <alpine.DEB.2.21.1.1709131340030.4132@virtualbox> <CANgJU+Wv1nx79DJTDmYE=O7LUNA3LuRTJhXJn+y0L0C3R+YDEA@mail.gmail.com> <20170913225158.GR27425@aiede.mtv.corp.google.com> <alpine.DEB.2.21.1.1709141754240.4132@virtualbox>
 <20170914184022.GB78683@aiede.mtv.corp.google.com>
User-Agent: Alpine 2.21.1 (DEB 209 2017-03-23)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Provags-ID: V03:K0:YWqHKCdrwP7+NCCWmCagC4tlZZkKAK6eP9w6gBacuirDYZYJdPS
 72oNqhVghC1OtUjijD2lEigpSCv+HcSVz5L1zHMeLi7GqAQVQrCyL8DOxWecZk0rDV4SuNw
 FUKjH6DeT09EUYA3t8SA3Fkq9DUhYYGXezMDg4yzfY3yu4rFs7nCi1J1SpXMEvvbQqedCFM
 bpkvt0b8qYyy3CWSMPzug==
X-UI-Out-Filterresults: notjunk:1;V01:K0:cmUYxbdq2x8=:q67Wq3SU4LIiD2Qtb12kIX
 kKemZ5Aqd9F7x54w82XT54STZqgce/V2GVmAjaBx+ZO8nPyjIk6zLatNpjR2gEgRUZ59DRKEL
 d3ET7mL6nron220N2FcKitfHgDWcGFqJ0D24vplb/65OI6fGJVQCJWwo9Amo9wPP3TzI27noL
 4KcSv+ceu2zwBrJ7wR3LgktGDueyXD0yKtnXLID3MLzbe3wuuxH40Bo3MYzzmKnAvG4gZcWZ8
 WQY17E2n/DCAJcZUpKgS/IcD5ne9dSKUD8vLDo8ae/27ywJLV8yvOLip8Txq/JU1UQf7LFpTS
 /79eqY/oLnHd0xZ3RwfFyEZT9FD12DOi4EnspDxFNC3g2zLgJsq7idHZMZcH1xu+7oNV12zy1
 9PeJpV+7OZbdDt+E/6H0ZZSTmv7li4VkoYAPwpdtRwQIM1Y0gzLUA3uHTjB8aJMr8rP50v1Ei
 4yrlZeifaFdTEclns9bUQzZL4qS0NjeHULQqJyd2Al4pL6NVtUXKnB8yqXladew0o1B/luPji
 91/Co0pvCZbjw6+EcEBlVVDGEy9HVD3BcyMuqmD27Sr1eNMY8GqlMshY0NNF8yMrn7U1sKf5u
 erhtDvin46TmneS5qoeemrypvU9+W+3wlNLYppVXb3o5ITjX6V3E3cOj7syCNWRSeJpgdtkQZ
 8xcWY2Pgn+ZTVumYahKT5fKeFWebuXlBTRYYF7lvSucOwnmVF3VbUTiYqY2pwNlebM1mTOFba
 xxiUqXa7C5A6ILTC/iaQg0XKQoBRmaJKfyrgtPKIVcZYj7izKSs5e8/PnSzbcmS3tt8HZWJiC
 wEYQeOPCzp23Qdq42C+YLqtaKRIutsZsST8FQDmnX6c8VPPODY=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Thu, 14 Sep 2017, Jonathan Nieder wrote:

> Johannes Schindelin wrote:
> > On Wed, 13 Sep 2017, Jonathan Nieder wrote:
> 
> >> [3] https://www.imperialviolet.org/2017/05/31/skipsha3.html,
> >
> > I had read this short after it was published, and had missed the updates.
> > One link in particular caught my eye:
> >
> > 	https://eprint.iacr.org/2012/476
> >
> > Essentially, the authors demonstrate that using SIMD technology can speed
> > up computation by factor 2 for longer messages (2kB being considered
> > "long" already). It is a little bit unclear to me from a cursory look
> > whether their fast algorithm computes SHA-256, or something similar.
> 
> The latter: that paper is about a variant on SHA-256 called SHA-256x4
> (or SHA-256x16 to take advantage of newer instructions).  It's a
> different hash function.  This is what I was alluding to at [1].

Thanks for the explanation!

> > As the author of that paper is also known to have contributed to OpenSSL,
> > I had a quick look and it would appear that a comment in
> > crypto/sha/asm/sha256-mb-x86_64.pl speaking about "lanes" suggests that
> > OpenSSL uses the ideas from the paper, even if b783858654 (x86_64 assembly
> > pack: add multi-block AES-NI, SHA1 and SHA256., 2013-10-03) does not talk
> > about the paper specifically.
> >
> > The numbers shown in
> > https://github.com/openssl/openssl/blob/master/crypto/sha/asm/keccak1600-x86_64.pl#L28
> > and in
> > https://github.com/openssl/openssl/blob/master/crypto/sha/asm/sha256-mb-x86_64.pl#L17
> >
> > are sufficiently satisfying.
> 
> This one is about actual SHA-256, but computing the hash of multiple
> streams in a single funtion call.  The paper to read is [2].  We could
> probably take advantage of it for e.g. bulk-checkin and index-pack.
> Most other code paths that compute hashes wouldn't be able to benefit
> from it.

Again, thanks for the explanation.

Ciao,
Dscho

> [1] https://public-inbox.org/git/20170616212414.GC133952@aiede.mtv.corp.google.com/
> [2] https://eprint.iacr.org/2012/371
> 
