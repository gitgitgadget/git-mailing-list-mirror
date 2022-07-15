Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433CFC43334
	for <git@archiver.kernel.org>; Fri, 15 Jul 2022 16:52:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234258AbiGOQw4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Jul 2022 12:52:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiGOQwy (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Jul 2022 12:52:54 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2634BD1D
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 09:52:51 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id a9so4151425qtw.10
        for <git@vger.kernel.org>; Fri, 15 Jul 2022 09:52:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ffZD/bc7pcj0GXgrcg+W/tW0akI2Ful53iXzgXfn0yg=;
        b=eT56UDHz/tjU0WC7CGxOMnJItWA99CZU8B7VZiBYrGNBYOYtyuhOqY7ow9Sws/5c87
         JPNd0jK+rTBYiYPVrjoRIKk7UY/hHL2jQU2A73WV7PDjt2h1To1Ixpn3iEmDNDqywJ8S
         8FdjORqnGk5+wlFB1twcE/te9ikCXIZfjUZ5klhMVj4+RQNM8Whl+8Sd1pOjE8v/gPP+
         LQPuHydrU5vi3NRUSFjW91mCfdgBb6w0l6hcB7nvF4wkNBKG5kLANtRiKeXTqo1TQZ0T
         wytD/4IR+NfeuE76sMkLUrNlYoBoXei97T2llAsQ+KfwwLeTqKcJCGHUywkxi9RgUw22
         qfaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ffZD/bc7pcj0GXgrcg+W/tW0akI2Ful53iXzgXfn0yg=;
        b=zk1iBmxF3Z8eG8HaCni7bMZ1tRk+zC3VCCAnrEfIBRrkTOdAIeR1R2ZhakNu1E84UJ
         I18/VJRAoSwJ00KDb7MDHGKmjRHdFuOF/7pzU1IZe7kqufVayJFvCPoKoHACzu4+dmLv
         wUPI+Q90sIpOh9T6tNO3Wh+yzipkj583Lag5oNZs6mf8z9oU4Dfb7ZYKocWk9x0BPTmp
         p0mkYyRGe2Dfz5YYeFQZqeEehNHHANZxbrfb1sw2LonPr6/hfUyfLs+pL3CYxClgndEw
         QWIJ9jQ5m1XJqGBr6Fsqc7wMxt/ArXi9MbB2RKp86nlxAdVI9wvkaSDdsqr6GnIbjz2r
         0MqQ==
X-Gm-Message-State: AJIora8hcC+beeBBBI0iWDatywfajnob28LB6Vv+RHg1nPBZTc53niB5
        F2IUsVIXXn3jBmTJyj7oDlbX
X-Google-Smtp-Source: AGRyM1upxXsUakD3ppvBe/ul4Dxj//iqvkEXy0Y+xYEHEYpULlHGfMDvABcUf1LHHmkvoWhY8SAtOg==
X-Received: by 2002:a05:622a:60b:b0:31d:4455:c630 with SMTP id z11-20020a05622a060b00b0031d4455c630mr12916211qta.216.1657903970187;
        Fri, 15 Jul 2022 09:52:50 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:34ca:20bc:bde7:c407? ([2600:1700:e72:80a0:34ca:20bc:bde7:c407])
        by smtp.gmail.com with ESMTPSA id y206-20020a3764d7000000b006b5652edb93sm4196274qkb.48.2022.07.15.09.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 09:52:49 -0700 (PDT)
Message-ID: <b213abee-430b-0365-7e89-558208f3051a@github.com>
Date:   Fri, 15 Jul 2022 12:52:48 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/2] scalar: convert README.md into a technical design doc
Content-Language: en-US
To:     Victoria Dye <vdye@github.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, gitster@pobox.com
References: <pull.1275.git.1656521925.gitgitgadget@gmail.com>
 <870bd90e47e918f37db5a8d444e5c9a5717f9c17.1656521926.git.gitgitgadget@gmail.com>
 <994f2efd-0789-afad-ba0d-27da9692b289@github.com>
 <ee9ea998-fb9d-1bf0-635a-e1627c7c1c40@github.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ee9ea998-fb9d-1bf0-635a-e1627c7c1c40@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/11/2022 7:05 PM, Victoria Dye wrote:
> Derrick Stolee wrote:
>> On 6/29/2022 12:58 PM, Victoria Dye via GitGitGadget wrote:
>>> From: Victoria Dye <vdye@github.com>

>> It can be helpful to include the details of what steps to take to compile and
>> test the 'scalar' executable. That documentation will then be updated when
>> Scalar moves out of contrib/.
>>
> 
> As part of the move out of 'contrib/', I was planning on having Scalar built
> and installed the same as any built-in (albeit in 'bin/' - like 'gitk',
> 'git-cvsserver', etc. - rather than 'libexec/git-core'). In that case, there
> won't be any special steps needed to build/install 'scalar', so any
> instructions here would be temporary. I could include those instructions in
> the meantime, but with Scalar incomplete, I'm not sure whether that would be
> valuable.

Ok, I think you don't need those extra steps if the plan is to compile and
test by default. I think we might want to consider the installation steps
and whether or not distributors will want to have an opt-in option for the
scalar binary at that point. Fine to leave that until later.

>> You mention "performant" which makes me think that performance tests are intended
>> to be part of this change. It makes me think it would be interesting to have our
>> existing performance tests create a mode where they compare a "vanilla" Git repo
>> to one registered with Scalar, but otherwise runs the same tests already in the
>> t/perf/ test scripts. This is a wide aside so feel free to ignore me.
>>
> 
> This is a really interesting idea! My original plan was to add some basic
> tests around the operations 'scalar' should (directly or indirectly) speed
> up. I think I'll still need to do that anyway (e.g., for things like 'scalar
> clone' vs 'git clone'), but I'll also try to find a (repeatable) way to
> compare standard repo vs. Scalar enlistment performance in the existing perf
> tests.

It's tricky since our performance tests don't clone across a network boundary,
but maybe we could create a new class of tests to operate against a Git server
specified by the tester. Definitely out of scope for this series.

Thanks,
-Stolee
