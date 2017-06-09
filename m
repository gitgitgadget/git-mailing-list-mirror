Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5E30A1F8CF
	for <e@80x24.org>; Fri,  9 Jun 2017 13:09:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751560AbdFINJk (ORCPT <rfc822;e@80x24.org>);
        Fri, 9 Jun 2017 09:09:40 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:34136 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751535AbdFINJj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 9 Jun 2017 09:09:39 -0400
Received: by mail-pf0-f171.google.com with SMTP id 15so881619pfc.1
        for <git@vger.kernel.org>; Fri, 09 Jun 2017 06:09:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=i3V4YXRSruBryc0AoCH65GwbtAXZbkV0mszMIXU3H3k=;
        b=Ssiy82OLLeMeBlk7z6QZC70D4xuDQIEiYfmLQbyvD0g4MDF7/R7I+ztqoyF7aIjyKI
         msqXbuUURTtE1UFh92LlXkttSNcEq9VV/3e0NJ28IxhyX2jkIoalv2foazCBazmvMwmP
         ILGNAlULv8B6K1uOgPHDobYoLMbCBoMPM9jghYtlxUhxbrT/pmdQKa0+NPSxglff7mwl
         bErjPwhQk8ytKOTQFuDQ9/mHBcHc3nC/BfbUsj19u3lHWGHEABHKipDQfYIuLGDizrlz
         191ENUPaeUCYpqipLhg9at7DO6WDHJTJDcUnyMeXFarySt+BTnaUafDRyzW/nY2djxNb
         HcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=i3V4YXRSruBryc0AoCH65GwbtAXZbkV0mszMIXU3H3k=;
        b=k2zGgYUVHb5YlkA5EGcbuZJ9z6LACyP99BxwNRD+FOPvrKwRSE2/z6lG66TqHcJOXa
         WUPZeJzPOQo2dDv4/+fj6TpQkafnotffDtYjO0GB5m4DDMaaXvEufQWuAjIOQIuczRNE
         sNSJ2JZPWFNTAw1WI4EomiHmBd635NeBrJ+qjAazUl8Xa3gvSpDLyR5mXYCBpzXzCKcM
         bbEPlDRCtsBfa4/PxVmnBE0ebJRu1/aYYGi3C7xdR6vzLXxgc/wqTloDn4a11VUMV6Vf
         OiD/Pec2yP2zrNlZB646nPegfuVQKfthhEaal2AKGKyRrP9PNoBHSplpxbLvCJQ9gOEc
         qpZg==
X-Gm-Message-State: AODbwcBRzMLgPts2434mMEEzQP2hkDjBMcHFXxqnuXLnusOxmhhYr89c
        M6sXySZGlzqdIGotFQY=
X-Received: by 10.84.239.23 with SMTP id w23mr40332291plk.73.1497013778350;
        Fri, 09 Jun 2017 06:09:38 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:25b5:3bc1:d744:5d92])
        by smtp.gmail.com with ESMTPSA id n71sm3095224pfg.46.2017.06.09.06.09.37
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 09 Jun 2017 06:09:37 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Jeffrey Walton <noloader@gmail.com>,
        =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>,
        J Smith <dark.panda@gmail.com>,
        Victor Leschuk <vleschuk@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH v4 0/8] PCRE v2, PCRE v1 JIT, log -P & fixes
References: <20170601182056.31142-1-avarab@gmail.com>
        <xmqqbmq74773.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1706021803460.171564@virtualbox>
        <CACBZZX7yEs0U4LnULYMGM5CoDCACeh8DM=ONV+UmeM4EQsk7Sw@mail.gmail.com>
        <xmqqshjfuv48.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.21.1.1706071749430.171564@virtualbox>
        <CACBZZX5Mk=TpQ=6YV9upUUgDsoHwzfQA16JAXg+G5=57774Hcw@mail.gmail.com>
Date:   Fri, 09 Jun 2017 22:09:36 +0900
In-Reply-To: <CACBZZX5Mk=TpQ=6YV9upUUgDsoHwzfQA16JAXg+G5=57774Hcw@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 7 Jun
 2017 18:14:28
        +0200")
Message-ID: <xmqqshj971f3.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>>> 'ab/pcre-v2' was marked for 'next' in "What's cookin" a few issues
>>> ago, but I'll keep it in 'pu' to wait for the above---please give me
>>> a go ahead when we all are happy with the topic.  I expect to be
>>> offline in the later part of this week, by the way.
>>
>> It turns out that the entire test suite passes when I enable PCRE2. I will
>> try to make the packages available generally in Git for Windows' SDK
>> tomorrow.
>
> Great to hear, thanks a lot for testing this & packaging pcre2 for Windows.

Same here.  

Thanks for a quick response (sorry for things in my tree being slow;
I was between timezones and expect to recover from the jetlag in the
coming few days, hopefully back to being fully functional next
week).
