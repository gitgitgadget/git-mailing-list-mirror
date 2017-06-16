Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 914B11FA7B
	for <e@80x24.org>; Fri, 16 Jun 2017 21:24:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750981AbdFPVYT (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Jun 2017 17:24:19 -0400
Received: from mail-pg0-f41.google.com ([74.125.83.41]:36193 "EHLO
        mail-pg0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbdFPVYS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jun 2017 17:24:18 -0400
Received: by mail-pg0-f41.google.com with SMTP id u62so5981292pgb.3
        for <git@vger.kernel.org>; Fri, 16 Jun 2017 14:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=VkGdWaFtL+PSORE2KqrvnKuO7c9Pfsk8Bj1cJinw9rQ=;
        b=WvHLbJ6/21hMFblAPV66dLLoZNLGo2pc7gKpUzYNddJv7kXOVJR1oqJT8x6d842no/
         dJAx7P5e6nxA6PluxUu2j/V1woZZl45Ykm02+Lp8UffMhPGgFPCtUiOmDqwoSzgonNA9
         lcTHhHUDkw2mPrewHYNmm/pPWXrKMRBGSFFNwynWk/hG8Q+NwJydq7pZ4vN4hwAA7KXX
         iqyBTsfxgKiwDuGn1Fa513hlcVWwwjTs8fGvmbCpukaivhS9IAkcuRbtx24/Y4BDl7pj
         WhXEHpUkyqI1OxjMKZflubIT3U9nEaRskhCXqLWpGtnxdryTMBjJyuyPMhABd9+v5fOy
         F7Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=VkGdWaFtL+PSORE2KqrvnKuO7c9Pfsk8Bj1cJinw9rQ=;
        b=Y2iBEO9BL4JrQ5e1+Ek4iXJidtqLZ33SNb47WE2IZys5J7c7954XeyCZQy8xoubyMb
         BmE9/s5cX3bj2LLI2lbmMSE65aN0kqBEhcKdJNS4xzda2d3f50oNJNrdFM2ofweQJeYG
         Zmfvp7GYLd9mVdEbu+Xuopq2ceLmLij4KUyLlUwxd8+YU0qQwk7R9YJxJ6ydh5AE3g8N
         1hkIdKMVFleHaYWrfic9GDU72r0GQ5c5K6BMgi9Bc2oz/J8Lo7RjivFUjp4eYh6OpEie
         4DvVu5xB2FNW4qj7gO7rzpdw8TR4MJKt2HLNat35l8VPuB8W3/IizlTrWOPMofH4RRlF
         hUKw==
X-Gm-Message-State: AKS2vOy5hhA/j6ZlGZQtZ/iJA0hCWCJmS4k/nAcB4sDvucI5BW/KIggM
        mx2fHBQ3jyNz8Q==
X-Received: by 10.101.91.197 with SMTP id o5mr13756730pgr.206.1497648257957;
        Fri, 16 Jun 2017 14:24:17 -0700 (PDT)
Received: from aiede.mtv.corp.google.com ([2620:0:100e:402:6ce4:5915:18fd:ad77])
        by smtp.gmail.com with ESMTPSA id i190sm5968478pfc.69.2017.06.16.14.24.16
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 16 Jun 2017 14:24:16 -0700 (PDT)
Date:   Fri, 16 Jun 2017 14:24:14 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Adam Langley <agl@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Mike Hommey <mh@glandium.org>,
        Brandon Williams <bmwill@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>,
        Stefan Beller <sbeller@google.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: Which hash function to use, was Re: RFC: Another proposed hash
 function transition plan
Message-ID: <20170616212414.GC133952@aiede.mtv.corp.google.com>
References: <alpine.DEB.2.21.1.1706152123060.4200@virtualbox>
 <CAL9PXLzhPyE+geUdcLmd=pidT5P8eFEBbSgX_dS88knz2q_LSw@mail.gmail.com>
 <20170615224110.kvrjs3lmwxcoqfaw@genre.crustytoothpaste.net>
 <CACBZZX5Z3kQHe_5TgOeuJSgzuvpQdaLo6RrgX_EvuZfdz856sA@mail.gmail.com>
 <20170616001738.affg4qby7y7yahos@genre.crustytoothpaste.net>
 <87y3ss8n4h.fsf@gmail.com>
 <alpine.DEB.2.21.1.1706161438470.4200@virtualbox>
 <CAL9PXLxMHG1nP5_GQaK_WSJTNKs=_qbaL6V5v2GzVG=9VU2+gA@mail.gmail.com>
 <xmqq37azy7ru.fsf@gitster.mtv.corp.google.com>
 <xmqqr2yjwsb6.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqr2yjwsb6.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>> Adam Langley <agl@google.com> writes:

>>> However, as I'm not a git developer, I've no opinion on whether the
>>> cost of carrying implementations of these functions is worth the speed
>>> vs using SHA-256, which can be assumed to be supported everywhere
>>> already.
>>
>> Thanks.
>>
>> My impression from this thread is that even though fast may be
>> better than slow, ubiquity trumps it for our use case, as long as
>> the thing is not absurdly and unusably slow, of course.  Which makes
>> me lean towards something older/more established like SHA-256, and
>> it would be a very nice bonus if it gets hardware acceleration more
>> widely than others ;-)
>
> Ah, I recall one thing that was mentioned but not discussed much in
> the thread: possible use of tree-hashing to exploit multiple cores
> hashing a large-ish payload.  As long as it is OK to pick a sound
> tree hash coding on top of any (secure) underlying hash function,
> I do not think the use of tree-hashing should not affect which exact
> underlying hash function is to be used, and I also am not convinced
> if we really want tree hashing (some codepaths that deal with a large
> payload wants to stream the data in single pass from head to tail)
> in the context of Git, but I am not a crypto person, so ...

Tree hashing also affects single-core performance because of the
availability of SIMD instructions.

That is how software implementations of e.g. blake2bp-256 and
SHA-256x16[1] are able to have competitive performance with (slightly
better performance than, at least in some cases) hardware
implementations of SHA-256.

It is also satisfying that we have options like these that are faster
than SHA-1.

All that said, SHA-256 seems like a fine choice, despite its worse
performance.  The wide availability of reasonable-quality
implementations (e.g. in Java you can use
'MessageDigest.getInstance("SHA-256")') makes it a very tempting one.

Part of the reason I suggested previously that it would be helpful to
try to benchmark Git with various hash functions (which didn't go over
well, for some reason) is that it makes these comparisons more
concrete.  Without measuring, it is hard to get a sense of the
distribution of input sizes and how much practical effect the
differences we are talking about have.

Thanks,
Jonathan

[1] https://eprint.iacr.org/2012/476.pdf
