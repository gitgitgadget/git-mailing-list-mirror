Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DFB8201CF
	for <e@80x24.org>; Wed, 17 May 2017 10:19:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752330AbdEQKTG (ORCPT <rfc822;e@80x24.org>);
        Wed, 17 May 2017 06:19:06 -0400
Received: from mail-pf0-f171.google.com ([209.85.192.171]:33904 "EHLO
        mail-pf0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751829AbdEQKTF (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 May 2017 06:19:05 -0400
Received: by mail-pf0-f171.google.com with SMTP id 9so5256884pfj.1
        for <git@vger.kernel.org>; Wed, 17 May 2017 03:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=ph7aoTCs5PAXwHLY31tFIIfdF47w6eDfDwJ3LLW37Us=;
        b=VYVchLLM5zvrzpsJovvudJWtihqp3QA6xphLTgESn/UpKJuW0lZsxChg/wryxOlQMI
         VnEtwHRvPjcVSlTE8jBiVj+b7u0Fx/46dOdI9+ySbrG3JFqFMuJNNrakNAbuO892KuxT
         PhHr4igMX4GUW9ny4B1dPBPhPpKGlN+sAVztZDNvwyK9jWG4aTKK1lSHxFLrbQXPN2un
         iXkKSOWke6HKWlH8WengupYvZAISGHlcHJBULbm595quqrjWjBpLbE5mcai/kb4IZnZR
         Mcrd6wArUIrsHukOapSPiPXWYgIc3kkVMJVd76D2zneZKvyv5/LQ1aZvUt/CuuLHwOHN
         YPmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=ph7aoTCs5PAXwHLY31tFIIfdF47w6eDfDwJ3LLW37Us=;
        b=DTamM4f3e5LnARasUyrXDf1DZwr0zDcqbJuek62GScgqsyWRsXrjs93W846RX/Ty5R
         tZtVpkdRraY0RrahbhyUjmngdk2N2R+q1pL596/KjE4AN67oEnULh4edgQrs3ghJyfLi
         Jkffk0GWmOLvJCs50umGakeaA/Nc60W6W/fuhvD5bKwoQZkz0JIUURUAkTOjlmGcJa7A
         m9remeDfWFByfcVf5Vpby9vry5lHVR99/T+H2xviPe4eSTdDPuOH4dpRfdS9F5f44atQ
         wCo5Lg4woflYh8g38KlkdbbW8nR1wKZ6S7k/GlgM9w7z2mXrOGFNRTtmc6zbKwsJNgqj
         n5uw==
X-Gm-Message-State: AODbwcA3a3i0jAs6zTco/vSl0XLHSr4lDywscSaK/7W7hpRj7oj3Ktq6
        7a6sIt7A3gCErw==
X-Received: by 10.98.64.143 with SMTP id f15mr2918504pfd.109.1495016344471;
        Wed, 17 May 2017 03:19:04 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:78bf:56b6:7690:fdbd])
        by smtp.gmail.com with ESMTPSA id v9sm3291375pfa.43.2017.05.17.03.19.03
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 17 May 2017 03:19:03 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Joey Hess <id@joeyh.name>
Subject: Re: [PATCH] tests: add an optional test to test git-annex
References: <20170516175906.hdwn4x5md7dj7fo3@kitenet.net>
        <20170516203712.15921-1-avarab@gmail.com>
        <xmqq7f1gyzep.fsf@gitster.mtv.corp.google.com>
        <CACBZZX4Jppr7ht7m444EjW4CDYX5CMvnxtStH4bF=A19TYKcZg@mail.gmail.com>
Date:   Wed, 17 May 2017 19:19:02 +0900
In-Reply-To: <CACBZZX4Jppr7ht7m444EjW4CDYX5CMvnxtStH4bF=A19TYKcZg@mail.gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Wed, 17 May
 2017 08:47:01
        +0200")
Message-ID: <xmqqbmqrwzu1.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>> Well, it is one thing to place git-annex under CI to make sure its
>> latest and greatest works together well with our latest and greatest
>> (and it may be something we want to see happen), but driving its
>> tests from our testsuite sounds like a tail wagging the dog, at
>> least to me.
>
> To me this is just a question of:
>
> * Is it the case that git-annex tests for a lot of edge cases we don't
> test for: Yes, probably. As evidenced by them spotting this
> regression, and not us.

And I'd encourage them to keep doing so.

> * We can (and should) add a test for the specific breakage we caused
> in 2.13.0, but that's no replacement for other things annex may be
> covering & we may be missing which'll catch future breakages.
>
> * It's a pretty established practice to test a library (git) along
> with its consumers (e.g. annex) before a major release.

I am not so sure about the division of labor.  What you are
advocating would work _ONLY_ if we test with a perfect & bug-free
version of the consumers.  If they are also a moving target, then
I do not think it is worth it.  After all, we are *not* in the
business of testing these consumers.

Unless I misunderstood you and you were saying that we freeze a
version, or a set of versions, of customer that is/are known to pass
their own tests, and test the combination of that frozen version of
the customer with our daily development.  If that is the case, then
I would agree that we are using their test to test us, not them.
But I somehow didn't get that impression, hence my reaction.
