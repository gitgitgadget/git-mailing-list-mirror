Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06617C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 13:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236718AbiCDNbT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 08:31:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230046AbiCDNbT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 08:31:19 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A361AF8DE
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 05:30:31 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id s1-20020a056830148100b005acfdcb1f4bso7453235otq.4
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 05:30:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=MKJpi10rA4ExVIBC21PnsOmQLJU0w0dcRLro/nx/uXk=;
        b=f6SqRGb7LnRBYZwaKHLJDFnnM34IFYk61QQgX8WrQJN3JaHpeIC4F2eHLHQkQuiAHo
         wYoE0AqVTzQMdQM3F0OaHADTXbXkGM972c3nziQTsGlBSeP7XCIwcOaCuhJa3thZ38oO
         Z1EHK2WN8dQZhQdiy1Ugycoy2joTC0ZiduzDcUVOV7Ja4UkuQaBHl0q2cqogW44gacE0
         WWpmC6i1wxbHdeS+sk461GOZ3qoS5Es2TxB3rJnkBwCeNBzRAAtljmSEclrJoy5TLPEU
         P3kGp29NHV2U7YJXfzN1pDQazhv0lL2dTBnhmwvgX7UoFJuqHEeFgnfzlVdM/c13NV9S
         U7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=MKJpi10rA4ExVIBC21PnsOmQLJU0w0dcRLro/nx/uXk=;
        b=pZkGhnzqTKQa2lWwriWnuYfkz3yg5vd0LXiiikTnoYfAF7XgJBk0l7fDCZ6Mjgiyus
         DTRYxOt0iCbdG4FWKKqLPVZhwPvDQkY9e82P7ON5IjF0FpMtyKdLatxM0KQQ/aXoLbaF
         EUsJKoEXT/WkXi6tPWy2PIH8HeH0r60iApgcrLj5WVXitdyNrP9ksS+N/IfC3fD/tn9F
         eR31sKs2bDix4sjukayNTk8XajMcSqpj3mPT6JCOVvGxS22Np3two+llHyYmK2oelkcw
         CfGKJTtKFB5eduOiUVflW3jxGaLrHzZ/X0Ljn/C8N9EFeMTuhhHbgcmxQZdcN/rMUsfp
         RTdw==
X-Gm-Message-State: AOAM531kFiNplrMyrnNM6jcQGiRJyNqTSUCMJUmgzjS+FuCrSB3gkH8E
        /TuCVpK+KvhElutqLJH9qIuk
X-Google-Smtp-Source: ABdhPJxW4+IO88dM4D+NA42hvBn03w51cZ+8C07s2M+D7pGfNCqX89KvtTAIy+gIk8aSnmyor2CB8Q==
X-Received: by 2002:a9d:bb4:0:b0:5ad:1287:7a11 with SMTP id 49-20020a9d0bb4000000b005ad12877a11mr22375172oth.166.1646400630998;
        Fri, 04 Mar 2022 05:30:30 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id l84-20020aca3e57000000b002d97bda3872sm2488107oia.55.2022.03.04.05.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Mar 2022 05:30:30 -0800 (PST)
Message-ID: <a6981d6e-16b0-b0e1-a94d-a87ec20871bd@github.com>
Date:   Fri, 4 Mar 2022 08:30:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 00/25] [RFC] Bundle URIs
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
 <220224.86czjdb22l.gmgdl@evledraar.gmail.com>
 <15aed4cc-2d16-0b3f-5235-f7858a705c52@github.com>
In-Reply-To: <15aed4cc-2d16-0b3f-5235-f7858a705c52@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/24/2022 9:11 AM, Derrick Stolee wrote:
> On 2/23/2022 5:17 PM, Ævar Arnfjörð Bjarmason wrote:
>>
>> On Wed, Feb 23 2022, Derrick Stolee via GitGitGadget wrote:

>>> There have been several suggestions to improve Git clone speeds and
>>> reliability by supplementing the Git protocol with static content. The
>>> Packfile URI [0] feature lets the Git response include URIs that point to
>>> packfiles that the client must download to complete the request.
>>>
>>> Last year, Ævar suggested using bundles instead of packfiles [1] [2]. This
>>> design has the same benefits to the packfile URI feature because it offloads
>>> most object downloads to static content fetches. The main advantage over
>>> packfile URIs is that the remote Git server does not need to know what is in
>>> those bundles. The Git client tells the server what it downloaded during the
>>> fetch negotiation afterwards. This includes any chance that the client did
>>> not have access to those bundles or otherwise failed to access them. I
>>> agreed that this was a much more desirable way to serve static content, but
>>> had concerns about the flexibility of that design [3]. I have not heard more
>>> on the topic since October, so I started investigating this idea myself in
>>> December, resulting in this RFC.
>>
>> This timing is both quite fortunate & unfortunate for me, since I'd been
>> blocked / waiting on various things until very recently to submit a
>> non-RFC re-roll of (a larger version of) that series you mentioned from
>> October.
>>
>> I guess the good news is that we'll have at least one guaranteed very
>> interested reviewer for each other's patches, and that the design that
>> makes it into git.git in the end will definitely be well hashed out :)
>>
>> I won't be able to review this in any detail right at this hour, but
>> will be doing so. I'd also like to submit what I've got in some form
>> soon for hashing the two out.
>>
>> It will be some 50+ patches on the ML in total though related to this
>> topic, so I think the two of us coming up with some way to manage all of
>> that for both ourselves & others would be nice. Perhaps we could also
>> have an off-list (video) chat in real time to clarify/discuss various
>> thing related to this.
> 
> I look forward to seeing your full implementation. There are many things
> about your RFC that left me confused and not fully understanding your
> vision.

I am genuinely curious to see your full implementation of bundle URIs.
I've been having trouble joining the Git IRC chats, but I saw from the
logs that you are working on getting patches together.

Do you have an expected timeline on that progress?

I would like to move forward in getting bundle URIs submitted as a full
feature, but it is important to see your intended design so we can take
the best parts of both to create a version that satisfies us both.

Thanks,
-Stolee
