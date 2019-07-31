Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC4A81F731
	for <e@80x24.org>; Wed, 31 Jul 2019 10:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728067AbfGaKfq (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 06:35:46 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:37905 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbfGaKfp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 06:35:45 -0400
Received: by mail-yw1-f67.google.com with SMTP id f187so24807170ywa.5
        for <git@vger.kernel.org>; Wed, 31 Jul 2019 03:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=YDDVTI/mw1StJWHJ3q2FbgKvZ1j85mACQcTxSkJqZQ8=;
        b=EsXd4jh9Xi8Tr52VB7gdMXTNAZGWKTXJlCxf5G+7P9lgv7dG5PHi2jT6HiKjA0ecln
         Anq1QuzFryshilUva1YTgNcelzx8HHB4W0Yabz4ppEqQ55ZbUkBlFEd4mZlSyIHMrSHT
         glGpnG067jhdXm52zTzwM25LjJqoJfV95yVbg+VplBKOV11nZZYLwvbzI992114P5ejA
         dzYEtFMxRsFWeYNIqgVLcvoPQNwyqfSBtFrMlln3nmjwFPxtys1kRJmFoJ1MRCpS8ulQ
         eksigH2kGIYrcwzA8o2qqWT8/aqznFxwmT33nHGdTyHM9mbMVg6k5GkWszBF9l3I0s66
         t6gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YDDVTI/mw1StJWHJ3q2FbgKvZ1j85mACQcTxSkJqZQ8=;
        b=TOASOj+eLNj5i2L7lARlLlEh7aEBb4eEnHruNJNl65wic3kIQbGlethsZ1S6tYwUea
         ZOeT6O2CVWHKKG9OMa90JFnKY9Hx9nFSdlwo+035Ntxggfee3k2CWkRRn/jkPFI5HT4t
         68EynwaYC4ttVmau9wsuGhdvKB0tIqQX0VSBuGV/YOMFANMUfqizDnP0w7vDXb/x4VL0
         FlOpO/4a09BmL1nT34xENEog1qf5w1LsRIwndwAobJhewd7imqvvZPX8qQHuCAWp233o
         K85JN1qVoaITU2oxgZmajzdnoTMCsc9BJbJmqylnqshKy4XhwlVQ32gz5MMNXjChMHQ9
         mnHw==
X-Gm-Message-State: APjAAAVPQGQTy672n65J3qmFcTNwrSw0IKObAj0HEBcHzoI/OoD4hNx8
        4pOVQac2hcw2kDZjo4/leM8FwUCt
X-Google-Smtp-Source: APXvYqzEP9xnwoVMh+1jgjZpwMyPbpntiQbtit1qRMyLIxZhDmecZbU2faXH0W84ovhuKGZJuHv8RA==
X-Received: by 2002:a81:3308:: with SMTP id z8mr72802902ywz.298.1564569344645;
        Wed, 31 Jul 2019 03:35:44 -0700 (PDT)
Received: from [192.168.1.12] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id 197sm15418174ywb.56.2019.07.31.03.35.43
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Jul 2019 03:35:44 -0700 (PDT)
Subject: Re: [PATCH] t5510-fetch: fix negated 'test_i18ngrep' invocation
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <a4fe71618410bdb188b6850a61ec65e7b4da5897.1560889525.git.gitgitgadget@gmail.com>
 <20190730212915.3509-1-szeder.dev@gmail.com>
 <20190730214000.GT20404@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4305ddb1-304a-d2f1-7bb9-370ee8de7293@gmail.com>
Date:   Wed, 31 Jul 2019 06:35:43 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <20190730214000.GT20404@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/30/2019 5:40 PM, SZEDER Gábor wrote:
> On Tue, Jul 30, 2019 at 11:29:15PM +0200, SZEDER Gábor wrote:
>> The test '--no-show-forced-updates' in 't5510-fetch.sh' added in
>> cdbd70c437 (fetch: add --[no-]show-forced-updates argument,
>> 2019-06-18) runs '! test_i18ngrep ...'.  This is wrong, because when
>> running the test with GIT_TEST_GETTEXT_POISON=true, then
>> 'test_i18ngrep' is basically a noop and always returns with success,
>> the leading ! turns that into a failure, which then fails the test.
>>
>> Use 'test_i18ngrep ! ...' instead.
>>
>> This went unnoticed by our GETTEXT_POISON CI builds, because those
>> builds don't run this test case: in those builds we don't install
>> Apache, and this test comes after 't5510' sources 'lib-httpd.sh',
>> which, consequently, skips all the remaining tests, including this
>> one.
> 
> Hrm...  It looks like there is nothing httpd-specific in this test
> case, at all, so we could run it even if a webserver is not available.
> Moving this test case earlier in the script seems to confirm it, as it
> still succeeds.
> 
> However, I'm not really familiar with this
> '--[no-]show-forced-updates' option, and this is not the time to get
> up to speed, so I would let Derrick to decide and follow up...

I was about to recommend you move the test to before the check for
the changes. I only put the test near the end as I normally don't want
to insert into the middle of a test script.  It makes sense to do so
here.

Thanks,
-Stolee
