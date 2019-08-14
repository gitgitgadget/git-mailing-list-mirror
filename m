Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 243E61F45A
	for <e@80x24.org>; Wed, 14 Aug 2019 18:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728409AbfHNSvS (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Aug 2019 14:51:18 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35773 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbfHNSvS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Aug 2019 14:51:18 -0400
Received: by mail-wr1-f68.google.com with SMTP id k2so100199wrq.2
        for <git@vger.kernel.org>; Wed, 14 Aug 2019 11:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=GMkrCGECGMpuGzPNwhDqa6AY938iOc2anWVkFqCS5Ts=;
        b=dDX3SF0d/6nq0uTsSWU/ksAUiTaYNyaVon9qa1+e1yyngLQq58WACqxk17NQ7kSqHb
         iVMywViVX4BUARq9Ot2uwVRRVg0LiCz1teMO6eCahx5IM1N4Kt7vZnfcktiMYkkO5CO5
         4haakywbjD5pYiKkG8i0XXF8N+ZogKvMKF8XT20bEq+IJVNN45Q/3nH4mh0lIxY+Z+AG
         rbbt8BQI48xgf+e3+akQvcVTxnSOtCAkTOWL00zbwH49fjvMA2qj2N8ZDNd3J2MTZQxT
         4z8eX2LHjAiwnCu7AupDGWGjm4M64yj6C8/5tUsGlzlfMFZP+tj3OybsgbN9ALXlEOmK
         EbQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=GMkrCGECGMpuGzPNwhDqa6AY938iOc2anWVkFqCS5Ts=;
        b=OcWE37naYvvEszgbLceDC93SxVK3YlTm1G0fkCsLgvi0khV4YtLkfRSIdPeOQQnQ/f
         5Jq/lCL/x3Ges2EZfnWAy9i/X2jRpgh8ddFhk9GQZgfhsHcBNZ8bsoWfXlg58yRQN7Cy
         H8gT8z6mOfe/MP8yk8miUuy7MT6BmLpjwsM6WcURa4z9eaVFx2wilpkxdKe5oRSbl3sK
         9ER7yCSLCmoXI9wLoiS2oioeWDnvjC5Lj97MQw7hKiZ3nT8s6FOg8PPLj8gNsFHorICj
         r79Io5CKnUCKx9mR3KC0ioiaUZfuPeMeULwahS3YxyuF+Xi/ryDQKb5ks4o2KaTT2lpC
         qMiA==
X-Gm-Message-State: APjAAAUHBNFEyh4YihjKUhFqkhFbV8nOlkVCKyUpRHtb80DS5fviTIKd
        yFUo4H4A6p/gHu/9lzU8+r4=
X-Google-Smtp-Source: APXvYqx6K2p1c+AhLNRbHJMe1MpYAB8B5YrVaDoh88cJAxV2UlXzSqCLBPhKgAt0fv7li8SWIRS3ag==
X-Received: by 2002:adf:8364:: with SMTP id 91mr1255723wrd.13.1565808676938;
        Wed, 14 Aug 2019 11:51:16 -0700 (PDT)
Received: from [192.168.1.18] (host-78-148-43-8.as13285.net. [78.148.43.8])
        by smtp.gmail.com with ESMTPSA id w13sm1137402wre.44.2019.08.14.11.51.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Aug 2019 11:51:16 -0700 (PDT)
Subject: Re: [GSoC][PATCH v2 5/6] rebase -i: support --ignore-date
To:     Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>
Cc:     Johannes.Schindelin@gmx.de, git@vger.kernel.org,
        martin.agren@gmail.com, newren@gmail.com, t.gummerer@gmail.com
References: <20190806173638.17510-1-rohit.ashiwal265@gmail.com>
 <20190812194301.5655-1-rohit.ashiwal265@gmail.com>
 <20190812194301.5655-6-rohit.ashiwal265@gmail.com>
 <xmqqblws7n8r.fsf@gitster-ct.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <c03439bf-54bf-b53d-9400-bdc4dd2a1309@gmail.com>
Date:   Wed, 14 Aug 2019 19:51:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqblws7n8r.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-HK
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/08/2019 22:45, Junio C Hamano wrote:
> Rohit Ashiwal <rohit.ashiwal265@gmail.com> writes:
> 
>>   --ignore-date::
>> -	This flag is passed to 'git am' to change the author date
>> -	of the rebased commits (see linkgit:git-am[1]).
>> +	Instead of using the given author date, re-set it to the value
>> +	same as committer (current) date. This implies --force-rebase.
> 
> s/to the value same as .* date\./the current time./;
> 
> The more important thing is that we record the current timestamp as
> the author date; that timestamp being very close to the committer
> date of the resulting commit is a mere consequence of the fact that
> we use the current time for committer date and much less important.

That's an important distinction, particularly if GIT_COMMITTER_DATE is 
set in the environment - are we aiming to have the author and committer 
dates match or are we just resetting the author date to now? Rohit - do 
you know which --ignore-date does in the am based rebase?

Best Wishes

Phillip

> 
> Again, I think reset-author-date would be a better synonym to this
> one.
> 
