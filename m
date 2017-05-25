Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7834920285
	for <e@80x24.org>; Thu, 25 May 2017 05:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1034088AbdEYFjx (ORCPT <rfc822;e@80x24.org>);
        Thu, 25 May 2017 01:39:53 -0400
Received: from mail-pf0-f179.google.com ([209.85.192.179]:35986 "EHLO
        mail-pf0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1034084AbdEYFjw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 May 2017 01:39:52 -0400
Received: by mail-pf0-f179.google.com with SMTP id m17so156736891pfg.3
        for <git@vger.kernel.org>; Wed, 24 May 2017 22:39:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=8bqEDABenNn2w23lbltzGWTVvIlWG/FrQYyAG+epOrs=;
        b=Km5NnK0eGcrgjj0FomliPiL+X5UOpyHMiuPXMNJ/5XPmHjvJWbL668pSvDG8XO0F35
         srZcj4KxkEpDUMm8sztVrCQ+xRRpVv15ONdX2U5B/SQ5eCSmf/DbLDFCIKZWz+KUoxv2
         79qTL97cUAuH/H8A3uy7TMsvJDS/LCptN6MdG0EhY4zxRO2uTBSVvH9AuV8z79zjtNyY
         /onf+dpUsz0xCDQFfqjDU8gwbo8ZN3xsEp2jKVFCEXmiFrKaZ5pZR0BuEYag1t7z3AK6
         rC06csSDcs28TWlVRV/QtKUXD7FlWWtHnuZtMBCSJPc7l4LM0Lqdd+TIxxn4cOCseeWt
         oGZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=8bqEDABenNn2w23lbltzGWTVvIlWG/FrQYyAG+epOrs=;
        b=T6I7GlvsPV/KDUXqs9iu6dtwSOfwmTSJR4Afj8pTqzjXyOYpNgtaS8fIqgyaRZVCpM
         j+WfJI+BBVAHEr8bOKaSyGG73fwjKZjwHg+vDwXEGLVsBqDk0VltE4elVZQ0z3GYyt4B
         wQaPexkQMs2fqOig3dnzAt6TpKTcJ2ZgYiJj/sX4v+wN8dxXK65btbNmnIHMMCLjLlAC
         1wkEvMtkoOszScRXPBsXs2HjWjWEvSyYiNz45Cxyz0MenuQeqHr77UC3HKsLsaBEwWuI
         5/DQ692jlAPyHbrjK5//PNN8GD5vFkiokYwHB6G8vF8jFWa+2PBbYN3moKvZVknx4k7g
         pXAg==
X-Gm-Message-State: AODbwcAgNeOcMOGmRhPexqmCLDgnizItwK+hEQBKm3cQ04UatySzkWeq
        aU1RNdZkBV3hfD7XhtNsw5p7AIFxhBUq
X-Received: by 10.98.148.2 with SMTP id m2mr42635596pfe.194.1495690781291;
 Wed, 24 May 2017 22:39:41 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.170.200 with HTTP; Wed, 24 May 2017 22:39:40 -0700 (PDT)
In-Reply-To: <xmqqk255fz7b.fsf@gitster.mtv.corp.google.com>
References: <20170523024048.16879-1-sbeller@google.com/> <20170524214036.29623-1-sbeller@google.com>
 <20170524214036.29623-18-sbeller@google.com> <xmqqk255fz7b.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 24 May 2017 22:39:40 -0700
Message-ID: <CAGZ79kZBOoK2vd5EqottnUr1AYMHa1=TzQB8ga00TehQxgtuhA@mail.gmail.com>
Subject: Re: [PATCHv5 17/17] diff.c: color moved lines differently
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 24, 2017 at 7:27 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Stefan Beller <sbeller@google.com> writes:
>
>> When a patch consists mostly of moving blocks of code around, it can
>> be quite tedious to ensure that the blocks are moved verbatim, and not
>> ...
>> cases. This leads to another thought: We could pass on '--color-moved' to
>> submodules such that they color up moved lines for themselves. If we'd do
>> so only line moves within a repository boundary are marked up.
>>
>> Helped-by: Jonathan Tan <jonathantanmy@google.com>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>>
>> # Conflicts:
>> #     diff.c
>> Signed-off-by: Junio C Hamano <gitster@pobox.com>
>> Signed-off-by: Stefan Beller <sbeller@google.com>
>> ---
>
> Hmph, what are these final lines about?

See the explanation in the patch 16/17.
My guess is that one of us (me) was careless again.

The commented lines are easily produced by git-gui, that
I use. I think it just takes the commit message from the underlying
git-core. But unlike git-core, it doesn't strip off commented lines
as there is no extra information in comments presented.
I wonder how you are the first signoff after the conflict markers
though, as that would hint that you signed off a commit message
with the commented conflict lines first, before I had them.

Puzzeled, will fix in a reroll.

Thanks,
Stefan
