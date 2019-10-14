Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 62A9D1F4C0
	for <e@80x24.org>; Mon, 14 Oct 2019 13:11:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731123AbfJNNLf (ORCPT <rfc822;e@80x24.org>);
        Mon, 14 Oct 2019 09:11:35 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:33744 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730184AbfJNNLf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Oct 2019 09:11:35 -0400
Received: by mail-wm1-f67.google.com with SMTP id r17so14476070wme.0
        for <git@vger.kernel.org>; Mon, 14 Oct 2019 06:11:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Ew4CTbHhmiyniGRnKVmOQtlMjPkI6btEYV4q/tlD65k=;
        b=rM6QWB9TPNPkaCPl7zlPRZ1a4GXln/Bp9tKzeaZyT0LCjmKT2BNBZXCJPjN04Il8/f
         lX/q8EZGoUiPy1IEwkDwADEM0vgnej3+nQ8n2khPo32h8CnTPnK0N6HRJHvkfh21qufD
         BM4uk5FH61LkHJFo1H0hh2qAeNuN/othPNWj5XwrWnhqvY8CruqFgtBRi1L4CfrSflmg
         uCW/kzlHkYFfm8roIRv3liklZAJJ6CGpRfSkKX5hxlGlkrhfIwH22+MsO1YAwCMDEwYF
         goMO93suzmzGYbBVYsC7WnhezytiTKiqlgufWEM9ZuF7l84NruSU+/YFgz58AH6ArxWh
         joPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ew4CTbHhmiyniGRnKVmOQtlMjPkI6btEYV4q/tlD65k=;
        b=cfZY4NNJIFqk215j72jHN0honp6Rjyrl9Hc6PUDESfivSqREuaVL6HOM156idTYil1
         93V+faQHBQkQnnZyWX14W3QIR/DrQZ9Vx/sEay1q6InpRgH5wJyWFFv4zrpgEDJQ2FA/
         8kPzbqwUa+VtQF/lVmVdY/jkPZYN+T9sSm5wy03LLjBSFvyxsshUUrzP0Xei7vsrIJTr
         EMhW4Hz00mFSI49oIg5t5/qZm7Q3Emhl36J58MfOl2zWFRxkYi5JslRFLXETrA0iVhDL
         ZJZfwGezRSlMgm0cYaqRH4aFj6UKUkPfLB3eg2UGS77GwWmHjd6UBUQqy6HhtjnlvUWQ
         4Ldw==
X-Gm-Message-State: APjAAAWDKWQH1FUFUTaejTOkYRZHHi5s3gXQOUm1MYJMfZwzzjcHhzCk
        6+P3A8ho7t2BAUUZCteHNms=
X-Google-Smtp-Source: APXvYqw6nJrzEWxvyBHFSh4MOhcTfe0OKIRzGQ4HqoxL5Yuy9XI8Hpd1zRFQ2tr9FU6UC2fl+ol1Ow==
X-Received: by 2002:a1c:4e:: with SMTP id 75mr15542908wma.104.1571058693004;
        Mon, 14 Oct 2019 06:11:33 -0700 (PDT)
Received: from liskov.home (host109-157-47-110.range109-157.btcentralplus.com. [109.157.47.110])
        by smtp.gmail.com with ESMTPSA id z13sm11063273wrm.64.2019.10.14.06.11.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Oct 2019 06:11:32 -0700 (PDT)
Subject: Re: [PATCH 06/11] graph: tidy up display of left-skewed merges
To:     Derrick Stolee <stolee@gmail.com>,
        James Coglan via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.383.git.gitgitgadget@gmail.com>
 <12c0916cb1ef033f917dc065cc1f18c0477296b8.1570724021.git.gitgitgadget@gmail.com>
 <5c688030-6351-93a3-89bd-e666d02d12d9@gmail.com>
 <494a92ba-00ab-b5d8-ee66-4007647f8483@gmail.com>
 <ece84770-edcb-e6dd-488e-629cd7d8b698@gmail.com>
From:   James Coglan <jcoglan@gmail.com>
Message-ID: <6c3cb137-7460-b498-4111-40e578a7bd2f@gmail.com>
Date:   Mon, 14 Oct 2019 14:11:31 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <ece84770-edcb-e6dd-488e-629cd7d8b698@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10/2019 02:36, Derrick Stolee wrote:
> On 10/11/2019 12:50 PM, James Coglan wrote:
>> On 10/10/2019 18:19, Derrick Stolee wrote:
>>> On 10/10/2019 12:13 PM, James Coglan via GitGitGadget wrote:
>>>> +++ b/t/t4215-log-skewed-merges.sh
>>>> @@ -0,0 +1,42 @@
>>>> +#!/bin/sh
>>>> +
>>>> +test_description='git log --graph of skewed merges'
>>>> +
>>>> +. ./test-lib.sh
>>>> +
>>>> +test_expect_success 'setup left-skewed merge' '
>>>
>>>
>>> Could you skew this example to include a left-skewed octopus merge
>>> (and use fewer Git processes) with the following:
>>>
>>> 	git checkout --orphan _a && test_commit A &&
>>> 	git switch -c _b _a && test_commit B &&
>>> 	git switch -c _c _a && test_commit C &&
>>> 	git switch -c _d _a && test_commit D &&	git switch -c _e _b && git merge --no-ff _c _d E &&
>>> 	git switch -c _f _a && git merge --no-ff _d -m F &&	git checkout _a && git merge --no-ff _b _c _e _f -m G
>>> and I think the resulting output will be:
>>>
>>> *-----.   G
>>> |\ \ \ \
>>> | | | | * F
>>> | |_|_|/|
>>> |/| | | |
>>> | | | * | E
>>> | |_|/|\|
>>> |/| | | |
>>> | | |/  * D
>>> | |_|__/
>>> |/| |
>>> | | * C
>>> | |/
>>> |/|
>>> | * B
>>> |/
>>> * A
>>
>> At this point in the history, commit E won't render like that -- this is before the change that flattens edges that fuse with the merge's last parent. I think the display of this history at this point will be:
>>
>> 	*-----.   G
>> 	|\ \ \ \
>> 	| | | | * F
>> 	| |_|_|/|
>> 	|/| | | |
>> 	| | | * |   E
>> 	| |_|/|\ \
>> 	|/| |/ / /
>> 	| | | | /
>> 	| | | |/
>> 	| | | * D
>> 	| |_|/
>> 	|/| |
>> 	| | * C
>> 	| |/
>> 	|/|
>> 	| * B
>> 	|/
>> 	* A
>>
>> Is there a particular reason for wanting to include this test case? What particular combination of states is it designed to test? (My guess is that it includes an octopus merge where the original test does not.) I'd be happy to add it at the appropriate point in the history if it's adding coverage not provided by the other tests.
> 
> Thanks for correcting my test case. It also helps that you would show the change in behavior in your later commits.
> 
> My reason to include this test is because it includes a regular merge and an octopus merge, both of which have a skewed render. Many times logic that applies to a normal merge breaks with octopus merges, so I try to include them whenever possible.

Thanks, I've now incorporated your suggested test into my patch. I had to amend it slightly as it turns out the above history is not valid; G is not a possible merge because one of its parents (C) is an ancestor of another (E). The actual example I've added is this:

	*-----.   0_H
	|\ \ \ \
	| | | | * 0_G
	| |_|_|/|
	|/| | | |
	| | | * \   0_F
	| |_|/|\ \
	|/| | | |/
	| | | | * 0_E
	| |_|_|/
	|/| | |
	| | * | 0_D
	| | |/
	| | * 0_C
	| |/
	|/|
	| * 0_B
	|/
	* 0_A

I've also added another commit before beginning this work that adds the example from the cover letter, so you can see it changing with each commit, namely this history:

	*   H
	|\
	| *   G
	| |\
	| | * F
	| | |
	| |  \
	| *-. \   E
	| |\ \ \
	|/ / / /
	| | | /
	| | |/
	| | * D
	| * | C
	| |/
	* | B
	|/
	* A
