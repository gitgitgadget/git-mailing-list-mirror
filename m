Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FF89C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 17:15:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348584AbiCHRQe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Mar 2022 12:16:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344409AbiCHRQb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Mar 2022 12:16:31 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B8252E62
        for <git@vger.kernel.org>; Tue,  8 Mar 2022 09:15:32 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id 12so19533310oix.12
        for <git@vger.kernel.org>; Tue, 08 Mar 2022 09:15:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=zDt0FUzfcBbvOIo96P+nCBO/a9VUPRVPdw9ap0jtbXg=;
        b=CWMWegs5mGjzAXfRiBLk4cdSlcsQS0Npx0OFHX/rCXO5Mj91/DKMN1i3tLz3ETOrFW
         7+ChkZLJmsuQgvHBcoRGRJMTKhYHdFDTR/OhZlPCM5Eb+JXMS9g9HhGxvlcQEl8Do8qS
         RuYlNfRM7SfX69K/Olyh2MVsNWUmFbxQBLs9KbMejZoFs3wX0MAAXRSAwnSgOLxiqMDQ
         c9GL9A79xDi5vaxPDswlf4m3ilcHx6C/4G3djbjCL+zli+Y38XCmzRk3lCLnOmzn17SH
         WSDKXbHaifJ0szSw4FA+pt+CxwYMAFZULlGwKqzYkz08HVzLT6NOsZiCCHBoB7KPaAwN
         n5hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=zDt0FUzfcBbvOIo96P+nCBO/a9VUPRVPdw9ap0jtbXg=;
        b=QbgVOPqxI8MZB+rMFBHlS6bFHKkuNoCmvXx9q3wWhMX+16Mhd3QAVj5v/2FFvNGpeo
         Ew7GF45ZQ05ZM0znH8mAmrxoGdSeDcR3+H5HSk04DDY/7xpmzPgMh2THqmzZlhWzWpxy
         Q2OB3a/GRY1SJLlIK2DIokZiEnJZ8ikGbtVe3kE5LUBrlQ7GUoM32NJ5dOHnljwpZ6lL
         8zSOs2jEFdSlthpJss7Rgp7cS4f6lHoFXxBTTu0ANYyLO81qWJoofHJZ1ivVy0Q2H17D
         F2EetfWCexz614CkUeAMUX+Y6g5sKfITtZLeHCGif9+hkuDzjYa45uaHi6Udm84UOJkx
         7jgw==
X-Gm-Message-State: AOAM531TcqWWK8EPJh+0ftavsNeLy2E1D+uSs8dwo96ZUXzuFpga57c7
        MBOY1z1QTnxxZhQCpT1iMLlo
X-Google-Smtp-Source: ABdhPJxocWw9HzctkYFcH6y9ikXarpqaB6IigohoxCEBTMB/dV8HMxLK7O4cUYf1r9WWPgNKurTU/Q==
X-Received: by 2002:a05:6808:19a8:b0:2d5:1d0f:95e3 with SMTP id bj40-20020a05680819a800b002d51d0f95e3mr3366415oib.61.1646759731967;
        Tue, 08 Mar 2022 09:15:31 -0800 (PST)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id t11-20020a4ae40b000000b0031cc933b418sm7245219oov.40.2022.03.08.09.15.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Mar 2022 09:15:31 -0800 (PST)
Message-ID: <ddebc223-1e13-e758-f9b1-d3f23961e459@github.com>
Date:   Tue, 8 Mar 2022 12:15:29 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH 00/25] [RFC] Bundle URIs
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        newren@gmail.com, "Robin H . Johnson" <robbat2@gentoo.org>,
        Teng Long <dyroneteng@gmail.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
 <220224.86czjdb22l.gmgdl@evledraar.gmail.com>
 <15aed4cc-2d16-0b3f-5235-f7858a705c52@github.com>
 <a6981d6e-16b0-b0e1-a94d-a87ec20871bd@github.com>
 <220304.86a6e5g44z.gmgdl@evledraar.gmail.com>
 <1469e420-63e5-e2db-21d5-c70674ab04d5@github.com>
In-Reply-To: <1469e420-63e5-e2db-21d5-c70674ab04d5@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/4/2022 10:12 AM, Derrick Stolee wrote:
> On 3/4/2022 9:49 AM, Ævar Arnfjörð Bjarmason wrote:
>> Also, as noted in the upthread
>> <220224.86czjdb22l.gmgdl@evledraar.gmail.com> it might be useful to chat
>> in a more voice/video medium in parallel (maybe mid-next-week) about the
>> high-level ideas & to get a feel for our goals, conflicts etc. Doing
>> that over very long E-Mail exchanges (and the fault of "long" there is
>> mostly on my side:) can be a bit harder...
> 
> I agree. I we can work out a time in a private thread and I can send
> you a video call invite.

Ævar and I just finished our chat and came away with these two
action items:

1. Ævar will finish prepping his RFC as-is and send it to the list.
   It contains several deeply technical optimizations that are
   critical to how his model works, but could also be used to
   improve scenarios in the table of contents model.

2. Ævar will then do a round of taking both series and combining
   them in a way that allows the union of possible functionality
   to work.

3. As these things come out, I will make it a priority to read the
   patches and provide feedback focusing on high-level concepts
   and ways we can split the future, non-RFC series into chunks
   that provide incremental functionality while keeping review
   easier than reading the whole series.

Thanks,
-Stolee
