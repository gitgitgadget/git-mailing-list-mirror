Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D4691F404
	for <e@80x24.org>; Fri, 14 Sep 2018 16:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728050AbeINVfk (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Sep 2018 17:35:40 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37911 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726900AbeINVfk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Sep 2018 17:35:40 -0400
Received: by mail-wm1-f67.google.com with SMTP id t25-v6so2531809wmi.3
        for <git@vger.kernel.org>; Fri, 14 Sep 2018 09:20:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=EGUguclgpj4vUCDDi2+r0OIGyyH3VU8UhA5O7E+zm8E=;
        b=MM7RU0x6o1VRItlrTkWZyUZ3822k3AG/dCb/0EXXYEJeskf5Qc4/8yAlyRpffcG68v
         0mogUlieGaO13YE4BLid77hG+5tcgWc7dxOxhNzqam1Sag841icHQtrHc22P1fXSHyxd
         hNyMDXPB4AA/Ibxvwe7LXbmxRQJz+1lEHfD0DIVFka7ghAV1mokmBFGoX5Srn65SCfUv
         fCPEnTiwn+80eoSG5cbowAR0xCog3i9hr5rVk9oBT5ZsABtXDZIyoOajZSWoaLK8SywP
         l0AQsmmJAwiVIoaXK8F/CDb+bmtvOkfoCHkX3YknJ9BckjYUiRi+DiY9x//VRW/YPRyM
         GwOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=EGUguclgpj4vUCDDi2+r0OIGyyH3VU8UhA5O7E+zm8E=;
        b=L0qzkBGiL8S2I2dmAHzpxzLY+QteYo9f9FhgZxcCooqFXsVpecjjXyTdBc/HN1ODyc
         z4dT6mnSf5ngD+BVfwxik9ISM4lJkkt2tQg1OVpVDIT1mn0MVL7JK/EbJpH/0WEbzpO0
         rVYRI/3YuzWWKjSp8SVBLKIvHyGCm8PBeyLRXDSIKXSBbX7cj8MpFU4xD/w6zV5k9X2m
         d5TjYSizIqqKVp99m8mqhCqeF9CTVXAx258Fd+hat4TtEIJu2e+cooCCqEo3Lg+rdBnu
         NmKKQ4UT3f2LhbCrjeFbgWlTjZgb3OmhobD4QTYMQiIE8d0y41wGd0H4RHVpaA9nEcPd
         OrWA==
X-Gm-Message-State: APzg51DR/jzOqvcHm8fwfg+N4zT/EjluPD85fMCcIOzuOnMdNSj9Z1aJ
        IXWsGajVWDn4wvVgTkR2lwU=
X-Google-Smtp-Source: ANB0VdYW/3oAuoeICDTGkQLtVtBmmyYss9gyhflOavlSb3GoWDPA8DoIHiNKtEEv55sIV+PqLU75Ag==
X-Received: by 2002:a1c:2108:: with SMTP id h8-v6mr3016705wmh.108.1536942027438;
        Fri, 14 Sep 2018 09:20:27 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id g129-v6sm2352332wmf.42.2018.09.14.09.20.26
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 14 Sep 2018 09:20:26 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Ben Peart <peartben@gmail.com>
Cc:     Thomas Gummerer <t.gummerer@gmail.com>,
        Ben Peart <benpeart@microsoft.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Ben Peart <Ben.Peart@microsoft.com>
Subject: Re: [PATCH v1] read-cache: add GIT_TEST_INDEX_VERSION support
References: <20180912212544.33624-1-benpeart@microsoft.com>
        <20180912223101.GA1719@hank.intra.tgummerer.com>
        <4f8b4664-6108-db7f-cb40-2bc55d9edece@gmail.com>
        <20180913215616.GD1719@hank.intra.tgummerer.com>
        <xmqqh8itdp9n.fsf@gitster-ct.c.googlers.com>
        <0a3baaf6-f71b-e8f9-7445-8bf2b5d3513e@gmail.com>
Date:   Fri, 14 Sep 2018 09:20:26 -0700
In-Reply-To: <0a3baaf6-f71b-e8f9-7445-8bf2b5d3513e@gmail.com> (Ben Peart's
        message of "Fri, 14 Sep 2018 09:50:05 -0400")
Message-ID: <xmqqzhwkcaph.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ben Peart <peartben@gmail.com> writes:

>> I think it is OK to make it error only if the old one is set without
>> the new one.  Then people can have _both_ set to the same value
>> during the period in which the topic sails through pu down to next
>> down to master, after seeing an failure once while building and
>> testing 'pu'.
>>
>
> I'll make it a warning if they are both set so that people are
> reminded to remove the old variable and an error if only the old one
> is set so people know to update their environment.

After the topic graduates to a stable release (or two), it would be
a good addition to encourage people to clean things up, of course,
but doing so too early by warning when they are both set is not a
good idea, I would think.  It would bring us back to "the user has
to futz with config.mak every time switching between 'maint' and
'next'".

> I'll combine all these into a single patch series.  It grew as I
> discovered more that needed to be updated.

Thanks. 

 I didn't mind it too much to have them as independent patches.  It
at least helped me forcing myself to give closer look at them ;-)

