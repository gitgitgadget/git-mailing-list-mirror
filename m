Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 594F5C433EF
	for <git@archiver.kernel.org>; Wed,  4 May 2022 14:11:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348732AbiEDOPB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 4 May 2022 10:15:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239972AbiEDOO7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 May 2022 10:14:59 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C0A5FAB
        for <git@vger.kernel.org>; Wed,  4 May 2022 07:11:22 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j15so2224756wrb.2
        for <git@vger.kernel.org>; Wed, 04 May 2022 07:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3DUPACR40f58Qh021Py0/TQJGeZqXSruUkV4c+P4MIg=;
        b=nH3EFWv8rksmgwwoCnncjN0/Uvq6qgn0ZjqdG9oDaRLFJCpaWnghZu9TDN2NR5+haZ
         JCA1FhqSRGpnXadz2K0sWPtvdGE2MCRnWcuyo7UGA4IyTYTP7jX893Yv7qf/fsRMsbTR
         EmkdcpK6jmayx66IPFDMgwHKFHz07fxu4PbopVSgU5kkDq2G2Gs1l8qHN1aAuuOlNU8y
         GfoKZQnvmpfNZ+d2amgi6syjLIzrGD0s3Vk3uUcXT7JKMjbuUsHeS9i2/aFYq/l4X7BO
         OP+pIYNPi/YijXsQZVgfd0S2JntFtr/K5qq1i4azqgH8IY+KO/aO2up6FQt0vKkO6Rbu
         PMcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3DUPACR40f58Qh021Py0/TQJGeZqXSruUkV4c+P4MIg=;
        b=lLDp6FpQeDk4eP5OW1RNOrH4PsJl7Gd+h4T9DHoKEjEzm/2BU+FIl4pplOhifaD40Z
         VGBFpNQv9+AZzmy+YSPLH3Vn/BhzoewBTu5uXdkvyNRc5AlFPUv5VoMj48Xok6XWhob7
         RcivO6y7HkwhjQn05Rw4RI1d/GqeYaDnMDYef6rQTUDYS/SnWVKG0R+GQ1SZI+E/6gvX
         6TgOvfcmdbncIyuWQGA7F5Gd4FQzyxyZ+MYr61asUVsuH/z3FELLwV6YUKTfUZ8AGZdv
         n3lUCPRSwPPYztePmy0SC0VRTofk/IsSG3/ptfvxHourIVXws4oCJBR3EkEGP41Y1wZG
         iRNA==
X-Gm-Message-State: AOAM53021DzmeeGPIgZGvlWGmajs3JEgv/5Utjn+XSSP9sR+ef5Tt63y
        rWNP0mBx4rTl8ZdmYH1tNc6QdaHQefM=
X-Google-Smtp-Source: ABdhPJx2n60YKTSQzywzGcAQlg6k6iyR+gRil7O+weJc0CrIg2RZcjAxgq8lxAu0CBZ1viB1m0FUoQ==
X-Received: by 2002:a5d:690c:0:b0:20a:d9d1:f5ce with SMTP id t12-20020a5d690c000000b0020ad9d1f5cemr16945616wru.295.1651673481267;
        Wed, 04 May 2022 07:11:21 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.192])
        by smtp.gmail.com with ESMTPSA id p26-20020adfa21a000000b0020c5253d8ecsm11623597wra.56.2022.05.04.07.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 May 2022 07:11:20 -0700 (PDT)
Message-ID: <1e5c95cb-74b7-011f-7597-1639b84e56ff@gmail.com>
Date:   Wed, 4 May 2022 15:11:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 1/3] t: document regression git safe.directory when
 using sudo
Content-Language: en-GB-large
To:     Carlo Arenas <carenas@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, gitster@pobox.com, bagasdotme@gmail.com,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20220428105852.94449-1-carenas@gmail.com>
 <20220503065442.95699-1-carenas@gmail.com>
 <20220503065442.95699-2-carenas@gmail.com>
 <9b92b380-1da1-b76d-1eb4-469aba289694@gmail.com>
 <20220503155649.b4ehcez2ytfwyq6e@carlos-mbp.lan>
 <d54b7672-36ab-a2b8-1a73-7d1a444a5936@gmail.com>
 <CAPUEsphJrD5VUp+QiDFr+rp7MiRrPQO8vO++O-ibXZ+BhC43HQ@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAPUEsphJrD5VUp+QiDFr+rp7MiRrPQO8vO++O-ibXZ+BhC43HQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Carlo

Just a quick reply for now with some brief thoughts - I'll try and 
answer more fully tomorrow.

On 04/05/2022 14:02, Carlo Arenas wrote:
 >[...]
> 
> This is indeed a bug, my intention was that it will be called in every
> request so I need to at least make it "not lazy"

Unfortunately don't think that will work, it just evaluates the 
prerequisite when you define it and uses the cached result for each 
test. (The lazy one evaluates the prerequisite on its first use and then 
caches the result)

>> Making it lazy just means it is evaluated when it is
>> first required rather than when it is defined. You're right that we want
>> to avoid sudo hanging because it is waiting for a password. We should
>> define something like
>>
>> sudo () {
>>          command sudo -n "$@"
>> }
> 
> This gets us half way to what is needed.  Indeed I explicitly use sudo
> -n in the "prerequisite" for this reason, and originally I used a perl
> function that called sudo with a timeout and then killed it after a
> fixed time.
> 
> The problem is we ALSO don't want the tests to fail if sudo suddenly
> decides to ask for a password, so by design I wanted to detect that
> issue in the prerequisite and disable the test instead, which I
> obviously didn't get right.

I don't think we have a mechanism to do that. I think the best we can do 
is just to skip the whole file if the SUDO prerequisite fails. Depending 
on the configuration sudo will delay the expiration of the cache 
password each time it is called. In any case this test file is not going 
to take much time to run so if the prerequisite passes the tests should 
hopefully run before the cached password expires.

Another possibility is to call a function at the start of each test that 
skips the test if 'sudo -n' fails.

> [...] 
> again I think the "we are running things as root folks!!" is enough to
> trigger a "better do not set that IKNOWWHATIAMDOING" variable on me,
> but it might be my sysadmin experience talking.

It is the fact that we're not just changing the uid that is used to run 
the tests but we're changing the environment as well that I think we 
need to call out. It is not obvious that running the tests with a 
different uid will stop $HOME pointing to $TEST_DIRECTORY.


I'll try and get back to you on the other points tomorrow

Best Wishes

Phillip
