Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN:  
X-Spam-Status: No, score=-2.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 033A21F405
	for <e@80x24.org>; Mon, 17 Dec 2018 23:14:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbeLQXO4 (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Dec 2018 18:14:56 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:36666 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726397AbeLQXO4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Dec 2018 18:14:56 -0500
Received: by mail-pg1-f194.google.com with SMTP id n2so6844751pgm.3
        for <git@vger.kernel.org>; Mon, 17 Dec 2018 15:14:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=zsWMNT0twg7U61WU72SkwOeGCYT7u/nn3M/S9ggQOPY=;
        b=d6a5mBB8q+66shmr4V3WxKMYltomXtR4OaM+9a5uAycM8v+N0GTSRJoAVLCNDvXEUB
         g5vuMC3h0Dpr7d8wv94cftj9VLHnmhKJy/kTZenKzmFXdmt5LEOLpuQMObgx19WRva1F
         nd7IyjLm81QJXxT7pBNoxWhBHNzabU3V9lcWeoemFiitt051Ul9sQn83WzqKwdTvDMnZ
         PsOMafUi/AcmcdI51ydbS4zsIknAo4usF+Y+L0+Z3Elp3esQtRLzAhCiUZ1V1iEJp3LO
         RgCqqWuNQ2dFCkOXrUcYv8na1yMJBYoQspdmThIsLmFjFYmfxlt/ixwReWzrmDS1XVGd
         Tl2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=zsWMNT0twg7U61WU72SkwOeGCYT7u/nn3M/S9ggQOPY=;
        b=RKvGJtppuzs31Hgbr2AkNAz2U/sD78uGZO4S4oLRnBXgWZNcZ4IEre5bWB5ZZUJGwS
         8JZEhxl6nTKOUlNwft48KtmRCmYvwfICb2/KJp9Q6Q1XEbYLIbY/95ekU1NuarPA437i
         MBXQRJGNbneQ0vJu3bSTp61pLwek2hzcMQ6NLkclPJ7Wt7qkVXllm2U8O7m8laJhMxZn
         9v3de93V+IthSLcCpi295K938UzPy9H7rDPs0BuGVzeMBi9u2MTPZJEJFlUfD8QbZsiG
         2T5xzXptW2aM0gL/UC8/Jk7toz1CD4mtL0kXecwcDk5rJuwnkLfMH4AiqbHqO/WmgG0b
         Ekvg==
X-Gm-Message-State: AA+aEWZskR3t3RQrDaou1MPA4kbBjquoUn25u58U6YVtjPnBa6vo+DaJ
        losI/Zt20bplL1qHay1HpuuF5MPg
X-Google-Smtp-Source: AFSGD/VZa2LgtACtyTvB7Xpl+RouWSK6A/nqz4L0PNDIuvq6lnliBlYZfryNCmIyA9jvp1BRivyARg==
X-Received: by 2002:a62:9719:: with SMTP id n25mr622854pfe.240.1545088495130;
        Mon, 17 Dec 2018 15:14:55 -0800 (PST)
Received: from google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id m198sm25593836pga.10.2018.12.17.15.14.53
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 17 Dec 2018 15:14:54 -0800 (PST)
Date:   Mon, 17 Dec 2018 15:14:52 -0800
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 8/8] tests: mark tests broken under
 GIT_TEST_PROTOCOL_VERSION=2
Message-ID: <20181217231452.GA13835@google.com>
References: <xmqqimzygmz6.fsf@gitster-ct.c.googlers.com>
 <20181213155817.27666-9-avarab@gmail.com>
 <87pnu51kac.fsf@evledraar.gmail.com>
 <20181214101232.GC13465@sigill.intra.peff.net>
 <87o99o1iot.fsf@evledraar.gmail.com>
 <20181217195713.GA10673@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181217195713.GA10673@sigill.intra.peff.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Jeff King wrote:
> On Fri, Dec 14, 2018 at 11:55:30AM +0100, Ævar Arnfjörð Bjarmason wrote:

>> More importantly this bypasses the security guarantee we've had with the
>> default of uploadpack.allowAnySHA1InWant=false.
>
> IMHO those security guarantees there are overrated (due to delta
> guessing attacks, though things are not quite as bad if the attacker
> can't actually push to the repo).

Do you have a proof of concept for delta guessing?  My understanding
was that without using a broken hash (e.g. uncorrected SHA-1), it is
not feasible to carry out.

JGit checks delta bases in received thin packs for reachability as
well.

> But I agree that people do assume it's the case. I was certainly
> surprised by the v2 behavior, and I don't remember that aspect being
> discussed.

IMHO it's a plain bug (either in implementation or documentation).

[...]
>> I'm inclined to say that in the face of that "SECURITY" section we
>> should just:
>>
>>  * Turn on uploadpack.allowReachableSHA1InWant for v0/v1 by
>>    default. Make saying uploadpack.allowReachableSHA1InWant=false warn
>>    with "this won't work, see SECURITY...".
>>
>>  * The uploadpack.allowTipSHA1InWant setting will also be turned on by
>>    default, and will be much faster, since it'll just degrade to
>>    uploadpack.allowReachableSHA1InWant=true and we won't need any
>>    reachability check. We'll also warn saying that setting it is
>>    useless.
>
> No real argument from me. I have always thought those security
> guarantees were BS.

This would make per-branch ACLs (as implemented both by Gerrit and
gitolite) an essentially useless feature, so please no.

I would be all for changing the default, but making turning off
allowReachableSHA1InWant an unsupported deprecated thing is a step too
far, in my opinion.

Is there somewhere that we can document these kinds of invariants or
goals so that we don't have to keep repeating the same discussions?

Thanks,
Jonathan
