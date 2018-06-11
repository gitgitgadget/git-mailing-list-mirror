Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 09B021F403
	for <e@80x24.org>; Mon, 11 Jun 2018 23:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933034AbeFKX1Y (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 19:27:24 -0400
Received: from mail-wm0-f50.google.com ([74.125.82.50]:35030 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932995AbeFKX1X (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 19:27:23 -0400
Received: by mail-wm0-f50.google.com with SMTP id j15-v6so19714259wme.0
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 16:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=TzvJKxlO6WLYAEw/I+dmUo6UYe68Gdep+cIAcUf+O24=;
        b=Zdii7jTxvPMPrpcCqoLfqO0V0WJWLFEqcki/+jUNWzpilsRrZIokfZVDuDqjSkLnSY
         Kas4plYYPugbQUWkBF6NNWni1hv2+KCitvDBK+DbVQMmCRIaSRR4VjBziKryOKPSxzfC
         HhIPR85cC413NGx1bzdk0fmQoSg2hHHnv9LSBBACt6ETEJeDr2AFyrw4PogPIUj1suJN
         PQyn2CC27yamWehZIkwGoR1gz2AYQU4KJetEzSo9CsTYVdGspG+VvEunlQvgokGMLZeX
         LMmbGh/NDPvd/83FakFBFmsFioHT5Y/QCI4LiQql+LUu0uC2lhwvaB+CZk7Bgy786Idc
         +ZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=TzvJKxlO6WLYAEw/I+dmUo6UYe68Gdep+cIAcUf+O24=;
        b=uoTQrZA8W5U5CrTNRMKsUGQJPcrz4LugMd3bZ4n3e5+2GD0VwcHxNt2rz5jCf9ePjq
         gvVHMQBteVv0k3emfwUCPe5aB4oBiJeio8g2XBvXehGScir4IOvLmcLYq0ehGpQhwpxt
         lvn3wXuXr3a4x/GR/QwMaBGcABSuvzl4iGn24xkOcWhM68NXloGjg4q+8xVmzComRalL
         jHQ+1Xg+fV6bXWGjWKGc0IkSEhV+ckZyMfcKm13zCtoh9YS+jaYQJLhAx44KEK8JiO7S
         TV2k2tHMKLMWY+A7yMYyzpvSNahKReqxZA8vWVNnkj7vdu7zdYifMWOUtONcRhYY6fn0
         Pacg==
X-Gm-Message-State: APt69E0Ez5TInVh4/7LGAWnMdXScndYWWVba7rjB7tfn2FDoYOyJWirF
        VB0B3iHOAOyVRid7jmSlEow=
X-Google-Smtp-Source: ADUXVKIzNKk+8xhyyQ+AGm5CwK+Nit6JtXsI7ai2iylTdjMG+QpBkZlPz6XPin57TPZNAbPKLUB8oA==
X-Received: by 2002:a50:8743:: with SMTP id 3-v6mr1027447edv.218.1528759642527;
        Mon, 11 Jun 2018 16:27:22 -0700 (PDT)
Received: from evledraar (dhcp-089-098-184-206.chello.nl. [89.98.184.206])
        by smtp.gmail.com with ESMTPSA id f2-v6sm19083487edq.28.2018.06.11.16.27.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 11 Jun 2018 16:27:21 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        demerphq <demerphq@gmail.com>, agl@google.com, keccak@noekeon.org
Subject: Re: Hash algorithm analysis
References: <20180609205628.GB38834@genre.crustytoothpaste.net>
        <20180609224913.GC38834@genre.crustytoothpaste.net>
        <20180611192942.GC20665@aiede.svl.corp.google.com>
        <CA+55aFw+E9GT7TKC_EgPTVcvHR8HDSipNPa7VQ1ASeL1M68xMQ@mail.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <CA+55aFw+E9GT7TKC_EgPTVcvHR8HDSipNPa7VQ1ASeL1M68xMQ@mail.gmail.com>
Date:   Tue, 12 Jun 2018 01:27:20 +0200
Message-ID: <878t7kx5t3.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 11 2018, Linus Torvalds wrote:

> On Mon, Jun 11, 2018 at 12:29 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>>
>> Yves Orton and Linus Torvalds prefer[5] SHA3 over SHA2 because of how
>> it is constructed.
>
> Yeah, I really think that it's a mistake to switch to something that
> has the same problem SHA1 had.
>
> That doesn't necessarily mean SHA3, but it does mean "bigger
> intermediate hash state" (so no length extension attack), which could
> be SHA3, but also SHA-512/256 or K12.
>
> Honestly, git has effectively already moved from SHA1 to SHA1DC.
>
> So the actual known attack and weakness of SHA1 should simply not be
> part of the discussion for the next hash. You can basically say "we're
> _already_ on the second hash, we just picked one that was so
> compatible with SHA1 that nobody even really noticed.
>
> The reason to switch is
>
>  (a) 160 bits may not be enough
>
>  (b) maybe there are other weaknesses in SHA1 that SHA1DC doesn't catch.
>
>  (c) others?
>
> Obviously all of the choices address (a).

FWIW I updated our docs 3 months ago to try to address some of this:
https://github.com/git/git/commit/5988eb631a

> But at least for me, (b) makes me go "well, SHA2 has the exact same
> weak inter-block state attack, so if there are unknown weaknesses in
> SHA1, then what about unknown weaknesses in SHA2"?
>
> And no, I'm not a cryptographer. But honestly, length extension
> attacks were how both md5 and sha1 were broken in practice, so I'm
> just going "why would we go with a crypto choice that has that known
> weakness? That's just crazy".

What do you think about Johannes's summary of this being a non-issue for
Git in
https://public-inbox.org/git/alpine.DEB.2.21.1.1706151122180.4200@virtualbox/
?

> From a performance standpoint, I have to say (once more) that crypto
> performance actually mattered a lot less than I originally thought it
> would. Yes, there are phases that do care, but they are rare.

One real-world case is rebasing[1]. As noted in that E-Mail of mine a
year ago we can use SHA1DC v.s. OpenSSL as a stand-in for the sort of
performance difference we might expect between hash functions, although
as you note this doesn't account for the difference in length.

With our perf tests, in t/perf on linux.git:

    $ GIT_PERF_LARGE_REPO=~/g/linux GIT_PERF_REPEAT_COUNT=10 GIT_PERF_MAKE_COMMAND='if pwd | grep -q $(git rev-parse origin/master); then make -j8 CFLAGS=-O3 DC_SHA1=Y; else make -j8 CFLAGS=-O3 OPENSSL_SHA1=Y; fi' ./run origin/master~ origin/master -- p3400-rebase.sh
    Test                                                            origin/master~    origin/master
    --------------------------------------------------------------------------------------------------------
    3400.2: rebase on top of a lot of unrelated changes             1.38(1.19+0.11)   1.40(1.23+0.10) +1.4%
    3400.4: rebase a lot of unrelated changes without split-index   4.07(3.28+0.66)   4.62(3.71+0.76) +13.5%
    3400.6: rebase a lot of unrelated changes with split-index      3.41(2.94+0.38)   3.35(2.87+0.37) -1.8%

On a bigger monorepo I have here:

    Test                                                            origin/master~    origin/master
    -------------------------------------------------------------------------------------------------------
    3400.2: rebase on top of a lot of unrelated changes             1.39(1.19+0.17)   1.34(1.16+0.16) -3.6%
    3400.4: rebase a lot of unrelated changes without split-index   6.67(3.37+0.63)   6.95(3.90+0.62) +4.2%
    3400.6: rebase a lot of unrelated changes with split-index      3.70(2.85+0.45)   3.73(2.85+0.41) +0.8%

I didn't paste any numbers in that E-Mail a year ago, maybe I produced
them differently, but this is clerly not that of a "big difference". But
this is one way to see the difference.

> For example, I think SHA1 performance has probably mattered most for
> the index and pack-file, where it's really only used as a fancy CRC.
> For most individual object cases, it is almost never an issue.

Yeah there's lots of things we could optimize there, but we are going to
need to hash things to create the commit in e.g. the rebase case, but
much of that could probably be done more efficiently without switching
the hash.

> From a performance angle, I think the whole "256-bit hashes are
> bigger" is going to be the more noticeable performance issue, just
> because things like delta compression and zlib - both of which are
> very *real* and present performance issues - will have more data that
> they need to work on. The performance difference between different
> hashing functions is likely not all that noticeable in most common
> cases as long as we're not talking orders of magnitude.
>
> And yes, I guess we're in the "approaching an order of magnitude"
> performance difference, but we should actually compare not to OpenSSL
> SHA1, but to SHA1DC. See above.
>
> Personally, the fact that the Keccak people would suggest K12 makes me
> think that should be a front-runner, but whatever. I don't think the
> 128-bit preimage case is an issue, since 128 bits is the brute-force
> cost for any 256-bit hash.
>
> But hey, I picked sha1 to begin with, so take any input from me with
> that historical pinch of salt in mind ;)

1. https://public-inbox.org/git/87tw3f8vez.fsf@gmail.com/
