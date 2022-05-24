Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CA59C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 20:56:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241763AbiEXU4u (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 16:56:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237956AbiEXU4p (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 16:56:45 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 610F529811
        for <git@vger.kernel.org>; Tue, 24 May 2022 13:56:44 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id g21so7181463qtg.5
        for <git@vger.kernel.org>; Tue, 24 May 2022 13:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=87jcWkzlEwJJleTf3RFBrfSEHvdhGVwPasMgrbRCM4M=;
        b=N+3SZbXgQEn/XQjDgq/kPOIvSbKv/VmdbqGh5sux/4u/74qbqv7FW3dgW6JuFCyUpV
         OSEpzVbSPF0iquv87FQ3mUZCGQ7xhmg4Wb+TEyoztP/Pf3tHMJHORdO30MXcEQp/7SFr
         EHEiGiSwYKVI5dJNQR7FYnA8USFgc4Z+sUCEVNOWbYdCvkJw1Y0gbn18UpBkH76jm4RN
         PAtsPmGXIS5OTJM/Jq2/Y0Xm9Q5xbet9SZD3HzYqfRzdbwKjmxgBVA5dxZJ1BTHx2RA+
         k78mTzlo3l9Xk8Pfduq302XJR4Xkx6/p44O+OWZVZ3pvbQPASNinHF2hdDkCMUDgP9B2
         t+uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=87jcWkzlEwJJleTf3RFBrfSEHvdhGVwPasMgrbRCM4M=;
        b=5mL1LLHInKSvnDEWdd2QE07kTzp9YdQigbcAGIsTWrImGg+orRXbAQPtv1AkX5vHw9
         S2jOuqusmQpkpqpKe/AasN05PvxbSIFbz4gNi5fE8ZXKZziQBiKFYTnI8uQb6GDvGsYb
         78tHdfzjsync9YgeEni8x+VdKL7Jpae4fdEhbcYO+6TX1ijk+mdxV61avXfXrHNIuzgc
         Bc7jZoWTcBZnHVxyX46JucteertsIHxUnaX238YhkpghGfg4zUEQTYxgkHyTbWQuonnn
         dWLkJXK3LhM2J8LY+zspc+U6VeDsklIowR/B1AHCZOz7MEFzPeyEhbF1/LdkAKFExr5k
         Fwbg==
X-Gm-Message-State: AOAM530e5VfwchJ0Eo3tc5lICMN90m4kBPkmjDEm4x0HKn+R+KVcw1c8
        lhoT4toD3Lbjuj34BEWQu5I9g47u2dX/Pw==
X-Google-Smtp-Source: ABdhPJxdjKP05qMk2bXcNQXZ0boOhJ2CNh4floNH2yK7g/GEfAXObsoSWSJjVj47Owm5qiEh0Adzpg==
X-Received: by 2002:a05:622a:1181:b0:2f9:3050:ec82 with SMTP id m1-20020a05622a118100b002f93050ec82mr11975510qtk.202.1653425803492;
        Tue, 24 May 2022 13:56:43 -0700 (PDT)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id 128-20020a370c86000000b0069fc13ce23dsm145229qkm.110.2022.05.24.13.56.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 13:56:43 -0700 (PDT)
Subject: Re: [PATCH] ci: update Cirrus-CI image to FreeBSD 13.0
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?Q?Carlo_Marcelo_Arenas_Bel=c3=b3n?= <carenas@gmail.com>,
        Ed Maste <emaste@FreeBSD.org>
References: <20220524165823.18804-1-levraiphilippeblain@gmail.com>
 <220524.86czg2wx4a.gmgdl@evledraar.gmail.com>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <447b2a41-e48f-e5cd-8e55-262df2facc22@gmail.com>
Date:   Tue, 24 May 2022 16:56:41 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <220524.86czg2wx4a.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar,

Le 2022-05-24 à 15:24, Ævar Arnfjörð Bjarmason a écrit :
> 
> On Tue, May 24 2022, Philippe Blain wrote:
> 
>> The FreeBSD CI build (on Cirrus-CI) has been failing in
>> 't9001-send-email.sh' for quite some time, with an error from the
>> runtime linker relating to the Perl installation:
>>
>>     ld-elf.so.1: /usr/local/lib/perl5/5.32/mach/CORE/libperl.so.5.32: Undefined symbol "strerror_l@FBSD_1.6"
>>
>> The first instance is in t9001.6 but it fails similarly in several tests
>> in this file.
>>
>> The FreeBSD image we use is FreeBSD 12.2, which is unsupported since
>> March 31st, 2022 [1]. Switching to a supported version, 13.0,
>> makes this error disappear [2].
>>
>> Change the image we use to FreeBSD 13.0.
>>
>> [1] https://www.freebsd.org/security/unsupported/
>> [2] https://lore.kernel.org/git/9cc31276-ab78-fa8a-9fb4-b19266911211@gmail.com/
>>
>> Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
>> ---
>>
>>     Here is a proper patch following my earlier mail [1].
>>     
>>     [1] https://lore.kernel.org/git/CAPUEspgdAos4KC-3AwYDd5p+u0hGk73nGocBTFFSR7VB9+M5jw@mail.gmail.com/T/#t
>>
>>  .cirrus.yml | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/.cirrus.yml b/.cirrus.yml
>> index e114ffee1a..20c85eef81 100644
>> --- a/.cirrus.yml
>> +++ b/.cirrus.yml
>> @@ -9,7 +9,7 @@ freebsd_12_task:
>>      DEFAULT_TEST_TARGET: prove
>>      DEVELOPER: 1
>>    freebsd_instance:
>> -    image_family: freebsd-12-2
>> +    image_family: freebsd-13-0
>>      memory: 2G
>>    install_script:
>>      pkg install -y gettext gmake perl5
>>
>> base-commit: 7a3eb286977746bc09a5de7682df0e5a7085e17c
> 
> This may or may not be a good idea, I've got no about about this CI
> setup & what FreeBSD version we'd prefer.
> 
> But that you're seeing this in t9001-send-email.sh in particular
> suggests that perl isn't broken in general, as we hard depend on it in a
> bunch of places in the test suite.
> 
> Rather, it's some more advanced Perl usage.
> 
> So aside from this switch perhaps we'd like to have a more specific
> prereq for those send-email tests than just "PERL", which is controlled
> by our "NO_PERL" build-time setting, i.e. to actually probe if Perl
> works.

OK... I see what you mean, but I do not know enough about Perl or 
FreeBSD to know if this makes sense or not. My gut feeling was that
the system 'perl' package was somehow broken on that particular image.

As I wrote in my reply to Carlo, just switching to FreeBSD 12.3 also
makes the error disappear.

> 
> The error you quote doesn't tell us anything about where it happened,
> which aside from anything else would be useful to have in the commit
> message. I.e. what command did we run when this failed, and did other
> perl commands before that (either in that test, or others) work?
> 

OK, I can mention the invocation that triggers that error.

