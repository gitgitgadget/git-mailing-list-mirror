Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7194E1F453
	for <e@80x24.org>; Fri, 28 Sep 2018 07:53:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728977AbeI1OQN (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Sep 2018 10:16:13 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:38120 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728887AbeI1OQN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Sep 2018 10:16:13 -0400
Received: by mail-lf1-f65.google.com with SMTP id g89-v6so4257491lfl.5
        for <git@vger.kernel.org>; Fri, 28 Sep 2018 00:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+AmNIfNdlll/57C/sjAPEPsI2l76HgOQ/rNHMEhr77s=;
        b=YK6G/k0IC88OhkJIxg4w5G1u3xwxcnTw2kAQmZ7HbqhiJHT6Fyuy+jAABaliISj9u/
         LG6P4mYisWqMC4OfraXSiuMqseF2vbHjpsxHMMEoaRZuOdaZ1Aubbt/hdWlG8GrnaTvM
         OVjSlxoK/v1y7z6JMbcHWQbjBREMwkgaG8Tac=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+AmNIfNdlll/57C/sjAPEPsI2l76HgOQ/rNHMEhr77s=;
        b=pioxBmDZTWRirohN7KT+98ArTYhrmdoppYtTwAOaYpLpXNba8M965DKfcx6zHS+iWl
         dT77y6xAQfF2r7OZfVgqvlagNSBf7AVYN/umoGlNWVROfxeWuVk3N+49LFKBUPM0i7Ps
         p5CswjmV6rjBDb7DTzcsoCUU1b+sGiSMClD2ocNU3b8iYQfV38uyZp2dVAO4ElO681dx
         X8jz+8YZdDS+h6mGIqruWoOdNy8vQWR79XiSm25u1lSRyG92xxh7Ld2uPRVCcSE0keVo
         2OmwE/vZEfUIyOem/k73klI4p6nIHmcC1NXgZuxqtiqO7zZUoKlx+er5LI6x0k1DVXnQ
         tDKA==
X-Gm-Message-State: ABuFfoh1DESWJBK7dSFyuJ23K/e12hXvlleEtwgt270d7Oerx6cEgIeZ
        O2GbvDD6AwAnwN1c4rMXgc30GsqccMuqWBVq
X-Google-Smtp-Source: ACcGV60PDmAinuagzJgSNpvOEKSVv9XT10mzgNdJZqO7h/5pZYwki7qf07MGyD2hNXVQtAPQGBZGSQ==
X-Received: by 2002:a19:f8d:: with SMTP id 13-v6mr9369157lfp.107.1538121222820;
        Fri, 28 Sep 2018 00:53:42 -0700 (PDT)
Received: from [192.168.43.23] (77.241.135.131.mobile.3.dk. [77.241.135.131])
        by smtp.gmail.com with ESMTPSA id b62-v6sm885463ljf.7.2018.09.28.00.53.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Sep 2018 00:53:42 -0700 (PDT)
Subject: Re: [PATCH] help: allow redirecting to help for aliased command
To:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20180926102636.30691-1-rv@rasmusvillemoes.dk>
 <xmqqzhw4mgq3.fsf@gitster-ct.c.googlers.com> <20180926181251.GB63889@syl>
From:   Rasmus Villemoes <rv@rasmusvillemoes.dk>
Message-ID: <1e2397b4-7113-fc27-8d0d-485323144dbc@rasmusvillemoes.dk>
Date:   Fri, 28 Sep 2018 09:53:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180926181251.GB63889@syl>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2018-09-26 20:12, Taylor Blau wrote:
> 
> In the case where you are scripting (and want to know what 'git co'
> means for programmatic usage), I think that there are two options. One,
> which you note above, is the 'git -c help.followAlias=false ...'
> approach, which I don't think is so bad for callers, given the tradeoff.
> 
> Another way to go is 'git config alias.co', which should provide the
> same answer. I think that either would be fine.

The latter seems much more robust, since that will also tell you
precisely whether co is an alias at all, and you don't have to parse
-h/--help output (stripping out the 'is aliased to...' stuff, which
might be complicated by i18n etc. etc.). So I don't think we should
worry too much about scripted use of -h/--help.

Rasmus
