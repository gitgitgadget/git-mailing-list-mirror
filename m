Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AAB0C433EF
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 16:14:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346673AbiARQOJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 11:14:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347337AbiARQM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 11:12:27 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05D7FC0617AA
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 08:11:31 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id s9so29137815oib.11
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 08:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=p2ersfLpcArjQdEIyzmfhW1WwYI9FDAVAb6Fef+PURg=;
        b=YovuofxzHfhk0I4idMZ3ASidYPhb5nBRygY6wATJRrbBQj+MTJMGctlk8/elLOu2U2
         f4NT/Vaij91RGW4t0wSSSqZXXDnvIvOXdh2iQNEuHKYaUY3hSK9RDQ5kIaxnH8BZEGBU
         JVdftuPQ6MP5UgcjPvTBhc9XBo9O/KP6QRL/kCegatN1EPI1dMDHwxAfkZxcP8ObW9+9
         2D3zj8zwQaZ4924Ez1cHeveLrpCRMBOzPysk5+PKKqjDLZ0RcRFDbFu1OrTIgNzxNGyM
         2EhuX35WRnzLUj5ZaC5NwxLfxCuDemY5lA6O3jD7tjlHjgdCuVGOaJb50wYX+iZwXdKq
         PFQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=p2ersfLpcArjQdEIyzmfhW1WwYI9FDAVAb6Fef+PURg=;
        b=YiI9RSVIoDmGXY+sUGF5MxPfEp/PvHPjI23JS+3xi/jE/Xth45oG3e+pctXKocz0pW
         JtsJ1XTmahC1gMuOKTfHWpEUgl/nx1JbbhP/eXOIFlfRk8UQyFs2eBvqVMGPjakc/NHE
         K3JR1y42hnKi85MJXkxYnHKwGg/bqzkI4/I+WTa5fyJvkUcvO+qVpgmL/92P+FiFmJ8g
         XGSiazcBfuIlD9AJlgXne1m89HbwgSPYAntSJSb0vt6xPxcnOc3zvmihi1OB3uFQQ7CJ
         77nrtBHOHmqMBPT5kdnM1mwyjh99Y/NGzhuDSLRHM0/wAb52c3yPtY0B28/ZvbBQsE8T
         bDUQ==
X-Gm-Message-State: AOAM531w66yUJvMkp8kZkLmA5BzeNm0JbUNUFjnVdu2PvidNHfEUNhtf
        h8ptUlWj5GECHT+FhgHRyhek6BzSCfA=
X-Google-Smtp-Source: ABdhPJxD9qGxNnbJimKCRrkPJnHzHn0lp6CftjKgjM7RlP8euvaHJJgCmeul9GOkdEib1RN02BrxFQ==
X-Received: by 2002:a05:6808:1405:: with SMTP id w5mr4801819oiv.50.1642522290331;
        Tue, 18 Jan 2022 08:11:30 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:113f:db67:413a:89ca? ([2600:1700:e72:80a0:113f:db67:413a:89ca])
        by smtp.gmail.com with ESMTPSA id l8sm2680497oot.19.2022.01.18.08.11.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Jan 2022 08:11:29 -0800 (PST)
Message-ID: <0d6269b5-95ea-c2cd-6e5f-f10e874525d5@gmail.com>
Date:   Tue, 18 Jan 2022 11:11:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: Mistakes in the stalled category?
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Glen Choo <chooglen@google.com>
References: <xmqq35lrf8g4.fsf@gitster.g>
 <CABPp-BFj8NyXG6cQPJeDE46eicbfnP=TgEirRZVcnMM+YNG7OQ@mail.gmail.com>
 <xmqqlezh98uj.fsf@gitster.g> <xmqqiluk4wo4.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqiluk4wo4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/15/2022 2:38 PM, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
>> Elijah Newren <newren@gmail.com> writes:
>>
>>>> [Stalled]
>>>>
>>>> * ds/sparse-checkout-requires-per-worktree-config (2021-12-21) 5 commits
>>
>> [Stalled] being early in the report is primarily a way to remind us
>> that an update is overdue.
>>
>> <1db0f601-4769-15c0-cd58-ecddfa1fc9d5@gmail.com> is what prompted me
>> to consider that I can put it on backburner and spend my time on
>> other topics.
> 
> The pushout of 'seen' I did after -rc1 last night included this
> topic again; https://github.com/git/git/actions/runs/1700157728
> 
> The CI job triggered Leak Sanitizer in "git init" (the first thing
> tests do is to prepare a test repository with working tree, so there
> may be other new breakages, but we wouldn't know) and broke CI.
> 
> This morning, just to test, I ejected this topic from 'seen' and
> pushed it out; https://github.com/git/git/actions/runs/1702373554
> 
> As the only difference between these two runs is this topic, it may
> be worth looking into locating and fixing new leaks introduced by
> it.

Thanks for pointing this out. I will work to fix this leak in the
next version. Feel free to eject it until the new version is
available.

Thanks,
-Stolee
