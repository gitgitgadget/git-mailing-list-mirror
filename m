Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA2B120A40
	for <e@80x24.org>; Tue,  5 Dec 2017 14:16:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752336AbdLEOQy (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Dec 2017 09:16:54 -0500
Received: from mail-wm0-f68.google.com ([74.125.82.68]:38180 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752415AbdLEOQr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Dec 2017 09:16:47 -0500
Received: by mail-wm0-f68.google.com with SMTP id 64so1534978wme.3
        for <git@vger.kernel.org>; Tue, 05 Dec 2017 06:16:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=MBTlmnCErAVA4YH6Eo2CwwoU6RNgncpaYfyzw0+fSf8=;
        b=t56EK6kDDfVMkkzDvY1BSwiCjK1uWbkEEAVLytNTm9zFpUdD4qp93OKrCKHsQ+xit6
         L5pRfVg0ZRkGpAmU2oAMg6WfXd8F21/4ZO/7htkolydE4asilhXkBI6blwP5x3/qTsrD
         0Q4l0Db70YrQD1otqd5kS9I7fWJaD5T1P2jwk+rrLDd1OfbkvQ0UISkoWjGbX1TF9Wjx
         AxOgzfyx+ZXdhn4OrbnAYGsivNkpxgUn4hSDRtW8VI6Bg5bn9zpk0xBFFPZeHEhn1J6I
         YtVdArPJglLrxn9Mk97wZSpOrA5xpTfcud70oGLKkXxCtiE64e1zOWhmHkiiRQsCxl7s
         Ro0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=MBTlmnCErAVA4YH6Eo2CwwoU6RNgncpaYfyzw0+fSf8=;
        b=Py/CfN4hIVpTQgeUAcasvD1/Ldz7acrohGWKfgf06v8gST9k6Gevsz767cj4XmsSAZ
         IBTXozdMh385jX9wqPFfNfCLKmxkWwxXc8eOPEXyUwYS1QZHz5UkJ0mHaKKoplHrk+6y
         Syid63W0TktzLMWSXiLm6EE3pLDNG/pzeY4m4AqSSDQ63PxG6KhQ1OGWUUVL4Nb70cVH
         9iT6fAmjlTubjry64NjH5lemLcylTO5xsGLuf9q7DA7NAe9KWckl5yLjoT/XrKX9FEgZ
         VADIFjIrutR9VjQg5DZtoH3udYCTrLYvKwfgnefPKFeYHFgNz+FpDub4w9TfuPtyer0z
         EK9w==
X-Gm-Message-State: AJaThX6wyv68JZDKk0DvoU4/ky3biZ2Kx7gU1oaEu4xweHIj8F+TKk1f
        BoHNH2JCxegQApPoLdZD2Bc=
X-Google-Smtp-Source: AGs4zMaeXtTAYclwoPeHwJeN1KU+aiTD8b4pRLEnqMGsOi57voSEOuDKmwFef5jMOW4NZWsaJ9LDTg==
X-Received: by 10.80.205.218 with SMTP id h26mr35313335edj.157.1512483405876;
        Tue, 05 Dec 2017 06:16:45 -0800 (PST)
Received: from evledraar (178-84-79-100.dynamic.upc.nl. [178.84.79.100])
        by smtp.gmail.com with ESMTPSA id h56sm255348ede.45.2017.12.05.06.16.41
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Dec 2017 06:16:41 -0800 (PST)
Received: from avar by evledraar with local (Exim 4.89)
        (envelope-from <avarab@gmail.com>)
        id 1eME1Z-0004rW-4u; Tue, 05 Dec 2017 15:16:41 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, git@vger.kernel.org,
        Takashi Iwai <tiwai@suse.de>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 3/4] Makefile: use the sha1collisiondetection submodule by default
References: <20171128213214.12477-1-avarab@gmail.com> <20171128213214.12477-4-avarab@gmail.com> <20171205070249.GC4788@sigill.intra.peff.net> <87bmjdscdr.fsf@evledraar.booking.com> <xmqqh8t5jp9e.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 9.2 (stretch); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqh8t5jp9e.fsf@gitster.mtv.corp.google.com>
Date:   Tue, 05 Dec 2017 15:16:41 +0100
Message-ID: <87a7yxs1iu.fsf@evledraar.booking.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 05 2017, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:
>
>>> I'm not sure how I feel about this. I see your point that there's no
>>> real value in maintaining two systems indefinitely.  At the same time, I
>>> wonder how much value the submodule strategy is actually bringing us.
>>>
>>> IOW, are we agreed that the path forward is to get everybody using the
>>> submodule?
>> ...
>> In no particular order:
>>
>>  * I don't feel strongly about 2-4/4 in this series. I just hacked this
>>    up because it occurred to me that I'd left this sha1dc stuff in some
>>    in-between state and we'd talked about eventually moving forward with
>>    this.
>
> Good.
>
>>    We've had two releases with the submodule being purely optional, if
>>    we're going to keep it it seems logical to start at least using it by
>>    default.
>
> With a need for a patch like 1/4, I suspect two release cycles is
> way too short for making a move like 2-4/4, though.

You're conflating two unrelated things, which to be fair I'm confusingly
doing by submitting all this together.

1) Since 2.14 we've had the "auto" rule and
   DC_SHA1_SUBMODULE=[YesPlease|auto], so we'll prefer the submodule if
   it's there. So we've been testing if the mere presence of a
   .gitmodules breaks something for someone, seems like it doesn't.

2) Then in the 2.15 release Takashi Iwai submitted a feature to link to
   an external SHA1DC. This is used in the SuSE 2.15 package here:
   http://download.opensuse.org/tumbleweed/repo/src-oss/suse/src/

   However, as you'll see if you extract that package they don't run
   into that bug, because they're building it from a tarball which has
   an empty sha1collisiondetection/ directory as noted in my
   87bmjdscdr.fsf@evledraar.booking.com.

   Takashi *would* run into an error with my 1/4 if he was building from
   git.git, or if "make dist" included sha1collisiondetection/, but I
   don't see a reason to hold anything back back on that account. The
   only users of DC_SHA1_EXTERNAL=YesPlease are going to be packagers
   who know what they're doing, and if we start erroring out for them on
   this obscure option that's going to be trivially solved.

I don't see why this obscure edge case with #2 should keep us from
deciding whatever we'd decide with #1. They're really unrelated, #2
practically speaking only impacts tarball consumers, #1 impacts git.git
users.

It seems logical to me if we're going to move forward with #1 at all by
first making the submodule the default & then depending on how that
turns out making it a hard dependency, we'd do it now.

We'll learn nothing new by shipping a 2.16 with DC_SHA1_SUBMODULE=auto
that we haven't already learned in 2.14 & 2.15.
