Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B7CDC1F597
	for <e@80x24.org>; Wed,  1 Aug 2018 21:56:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387398AbeHAXnx (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Aug 2018 19:43:53 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:50994 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731954AbeHAXnx (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Aug 2018 19:43:53 -0400
Received: by mail-wm0-f66.google.com with SMTP id s12-v6so257708wmc.0
        for <git@vger.kernel.org>; Wed, 01 Aug 2018 14:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=rzmCQK7/q17Cx6OoMk58tIfVQcwS3lsNxqWvToeb+D8=;
        b=VK2ZdjTBtTV5Vd0K3RgJ94WDi8AqOyU82i/G92t5zEvNi8hcwHg8/iZ8GNrG9CBmmm
         t5uQr0Hc7h6HQzR0qAQc5A897UjzsS4+we4a7FXWPvcWv8kaVVcuGyVDr6aNuf5U16sp
         9au9oe50zE+D5aBFT6ZyYAPN4tNAIAdMrKFo6FLbqqy00mvQHykgx4XklUbAK5Oz61I8
         B7YM1qEnnStxxLewbJx2LG4dKxymYPvZXnfM5JxyC4kEd3ds4RQFGklxSZAV2FPZqPZa
         RVJWEm585bI8kile1UxxcvFIhm5YiUMPoco5OT+zOyon1q67tT3k7JWgiNXFsRHY4gw2
         QR8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=rzmCQK7/q17Cx6OoMk58tIfVQcwS3lsNxqWvToeb+D8=;
        b=qspEJr1SfZy2U0+MhecGiDHbeOH1uE7ZxiSm1LXjyGylxUud3HQTGeujVMwvyyZgEZ
         p1deHm1hQwDOJYYXjji/mrjmJZgXJlN9qgq66z66pcwxJ21RWz5xHThIwwscdgSUbHhM
         lAMKrNcSXTb9jyNVeG5O7M5vGdbjEUAPCx6GunJoKkqtj/XYg/KG6BZMPSHe3wT4rvDN
         5bSTc6sIoTqg0niohTloZrEG77jTtZq/307MIla6W2/vL4tT+01AvY5uKBlGQntUamdE
         VpJxv3du81+mlt9UxMcpbeSDcM5B9+EuznX+rpM7YvbPPlvx6NNixSrGsm0PJeDadg/K
         oKQw==
X-Gm-Message-State: AOUpUlHEF9Sncv4ACMSCsEMuBTJdA+Jl49Zo63TAy8g+heGpxLXjgx8N
        eMLp1bOk/5Kz74pdmWx2r4k=
X-Google-Smtp-Source: AAOMgpdLK56A0jXwx/V2uQ33pBmJazuz9aECoXSfLUikMpnSiCuJYdBo40JjeOJ2rLPvjkKBeWX8fA==
X-Received: by 2002:a1c:f30d:: with SMTP id q13-v6mr176422wmq.36.1533160559417;
        Wed, 01 Aug 2018 14:55:59 -0700 (PDT)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id y191-v6sm149349wmy.4.2018.08.01.14.55.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 01 Aug 2018 14:55:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: ds/reachable (was Re: What's cooking in git.git (Jul 2018, #03; Wed, 25))
References: <xmqqd0vbt14e.fsf@gitster-ct.c.googlers.com>
        <24424e55-7fa8-d05b-bc39-e14b4d5abcb6@gmail.com>
Date:   Wed, 01 Aug 2018 14:55:58 -0700
In-Reply-To: <24424e55-7fa8-d05b-bc39-e14b4d5abcb6@gmail.com> (Derrick
        Stolee's message of "Wed, 1 Aug 2018 16:44:40 -0400")
Message-ID: <xmqqsh3x69ap.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

>>   Stuck in review?
>>   cf. <20180723203500.231932-1-jonathantanmy@google.com>
>
> This comments on the initial values of 'struct ref_filter' (that are
> not used). All we need is the diff below squashed into "test-reach:
> test commit_contains".
>
>>   cf. <20180723204112.233274-1-jonathantanmy@google.com>
> This comment asks why "parse_commit()" instead of
> "parse_commit_or_die()" but the _or_die() would create a change in
> behavior that is not the purpose of the series.
>>   cf. <CAGZ79kb7tWV=cmboA+nsChAUaiC+fVVM-GBCuWfsypC+-wyaVg@mail.gmail.com>
>
> I just responded to Stefan's comment about sorting. I don't believe
> any change is needed. Some tests output multiple results and the order
> is not defined by the method contract, so 'test-tool reach <verb>'
> will always sort the output (by OID).

Just to let everybody know, there is no point responding to all of
"cf. <message>" comments in "What's cooking" report.  Because it is
*NOT* meant as an exhaustive list of things that need to be fixed,
refuting each and every one of them would not make the topic
"objection free" anyway.  The list of cf.'s are there to have just
enough of them to remind me to refrain from merging a topic to
'next' too hurriedly.  The discussion thread in the list archive is
the authoritative record of the discussion; treat "What's cooking"
as my personal note, nothing more.

> (Sorry for the delay. I'm on vacation.)

That's OK, and enjoy your time off.  We are not in a hurry.


> Thanks,
> -Stolee
>
> ---
>
> diff --git a/t/helper/test-reach.c b/t/helper/test-reach.c
> index eb21103998..ca30059117 100644
> --- a/t/helper/test-reach.c
> +++ b/t/helper/test-reach.c
> @@ -117,6 +117,7 @@ int cmd__reach(int ac, const char **av)
>     struct ref_filter filter;
>     struct contains_cache cache;
>     init_contains_cache(&cache);
> +    memset(&filter, 0, sizeof(filter));
>
>     if (ac > 2 && !strcmp(av[2], "--tag"))
>         filter.with_commit_tag_algo = 1;
