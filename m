Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 891D01F4C0
	for <e@80x24.org>; Sat, 12 Oct 2019 01:36:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728852AbfJLBg5 (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Oct 2019 21:36:57 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37524 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726829AbfJLBg5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Oct 2019 21:36:57 -0400
Received: by mail-qt1-f193.google.com with SMTP id l49so2613920qtc.4
        for <git@vger.kernel.org>; Fri, 11 Oct 2019 18:36:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JaWnBOwxNvbeqMA9v8xMl042D6zVR2U3n85zzgHOvsA=;
        b=KmsJU+BF0p+dZ5mdhh5U71mnBYBLtw80iSj6uFwGRJ1q/6crYIvX+3v/QKfNdEvZ4c
         zyde+OpJnyvJKha4pLMXIL5/2KxUjl8nFcjY5ydWoRUNZrnDMMWuit9lNeuE2a6vmkZt
         +LxWwLEpB0tPSNrWlrK32sRGJ8iMqSp7MGxisDqBDiGLbTTmlGvfXPbxw5cu0KRxXoDF
         Ws6xTpHimOiqVZg010s96GI8fyhfbAU6vslH6AJyxWZU4ciJdRkrLRRRnJdLn/krV0Eb
         SuGfHbeBXLRBITnwLi6fM9jxLLl7gxnKCrUFCjiYChxzvDtDHDJC3U1cNco1urBhZK3i
         KDuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=JaWnBOwxNvbeqMA9v8xMl042D6zVR2U3n85zzgHOvsA=;
        b=sRV+3HpV2D581gGqhXQP0Nlh9OXkjnLBUygR92uud0T+JwNBhtbm3O+wUQQltJbeVi
         RNqa2rF5BW98SQ2PrV4tLpI2lCkIEjzVZJB1oKXRekhPcr4ojwmT0wO3hbj2ToCbfFjr
         pfSPgaxacaNdIAa4L0FjiFwtqW+/gI0XNm/h1keHVnTkjuWAlFpf8Is1mj8ti42eoITF
         LbOz5KoEXfZyiSlOPUNm+uYmwiF7svjeLYMBw3oZ85sNdrLG4mUvgA6TzP8u9WdZkCVU
         D8G4Tr9ffksvi5Fl7B9d/EMjJppuxIs5bXNStcL2RRPc/9UORRmWsYikS23e0/e5xggK
         uJbg==
X-Gm-Message-State: APjAAAU35pxPEMuJ9GrVHiQHrRDfJ1BUGdUeGNVpYPUfahiqzm2YjYFL
        5udaiHcOLDyBo8KPlmgF7qE=
X-Google-Smtp-Source: APXvYqxRigDxuiHceJka/XSF03ELhWSue+yd94DzYMzufDZORZlPC00ZhKolhRJXZOYFkFvZoNbnHg==
X-Received: by 2002:aed:30d1:: with SMTP id 75mr20534780qtf.163.1570844214863;
        Fri, 11 Oct 2019 18:36:54 -0700 (PDT)
Received: from [10.0.1.21] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id u43sm5711233qte.19.2019.10.11.18.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2019 18:36:53 -0700 (PDT)
Subject: Re: [PATCH 06/11] graph: tidy up display of left-skewed merges
To:     James Coglan <jcoglan@gmail.com>,
        James Coglan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.383.git.gitgitgadget@gmail.com>
 <12c0916cb1ef033f917dc065cc1f18c0477296b8.1570724021.git.gitgitgadget@gmail.com>
 <5c688030-6351-93a3-89bd-e666d02d12d9@gmail.com>
 <494a92ba-00ab-b5d8-ee66-4007647f8483@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ece84770-edcb-e6dd-488e-629cd7d8b698@gmail.com>
Date:   Fri, 11 Oct 2019 21:36:46 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:70.0) Gecko/20100101
 Thunderbird/70.0
MIME-Version: 1.0
In-Reply-To: <494a92ba-00ab-b5d8-ee66-4007647f8483@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/11/2019 12:50 PM, James Coglan wrote:
> On 10/10/2019 18:19, Derrick Stolee wrote:
>> On 10/10/2019 12:13 PM, James Coglan via GitGitGadget wrote:
>>> +++ b/t/t4215-log-skewed-merges.sh
>>> @@ -0,0 +1,42 @@
>>> +#!/bin/sh
>>> +
>>> +test_description='git log --graph of skewed merges'
>>> +
>>> +. ./test-lib.sh
>>> +
>>> +test_expect_success 'setup left-skewed merge' '
>>
>>
>> Could you skew this example to include a left-skewed octopus merge
>> (and use fewer Git processes) with the following:
>>
>> 	git checkout --orphan _a && test_commit A &&
>> 	git switch -c _b _a && test_commit B &&
>> 	git switch -c _c _a && test_commit C &&
>> 	git switch -c _d _a && test_commit D &&	git switch -c _e _b && git merge --no-ff _c _d E &&
>> 	git switch -c _f _a && git merge --no-ff _d -m F &&	git checkout _a && git merge --no-ff _b _c _e _f -m G
>> and I think the resulting output will be:
>>
>> *-----.   G
>> |\ \ \ \
>> | | | | * F
>> | |_|_|/|
>> |/| | | |
>> | | | * | E
>> | |_|/|\|
>> |/| | | |
>> | | |/  * D
>> | |_|__/
>> |/| |
>> | | * C
>> | |/
>> |/|
>> | * B
>> |/
>> * A
> 
> At this point in the history, commit E won't render like that -- this is before the change that flattens edges that fuse with the merge's last parent. I think the display of this history at this point will be:
> 
> 	*-----.   G
> 	|\ \ \ \
> 	| | | | * F
> 	| |_|_|/|
> 	|/| | | |
> 	| | | * |   E
> 	| |_|/|\ \
> 	|/| |/ / /
> 	| | | | /
> 	| | | |/
> 	| | | * D
> 	| |_|/
> 	|/| |
> 	| | * C
> 	| |/
> 	|/|
> 	| * B
> 	|/
> 	* A
> 
> Is there a particular reason for wanting to include this test case? What particular combination of states is it designed to test? (My guess is that it includes an octopus merge where the original test does not.) I'd be happy to add it at the appropriate point in the history if it's adding coverage not provided by the other tests.

Thanks for correcting my test case. It also helps that you would show the change in behavior in your later commits.

My reason to include this test is because it includes a regular merge and an octopus merge, both of which have a skewed render. Many times logic that applies to a normal merge breaks with octopus merges, so I try to include them whenever possible.

Thanks,
-Stolee
