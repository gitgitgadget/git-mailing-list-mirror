Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D60AB1F404
	for <e@80x24.org>; Fri, 26 Jan 2018 13:08:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751480AbeAZNIQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 08:08:16 -0500
Received: from mail-qt0-f172.google.com ([209.85.216.172]:41904 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbeAZNIQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 08:08:16 -0500
Received: by mail-qt0-f172.google.com with SMTP id i1so1044673qtj.8
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 05:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=l94w+M9jXM99wNfT1/p7zOLmf4R3PyvtsIcqBS9Q/3M=;
        b=ab/iQ5+DPlFn6y6wF5J14LfPiHUjwbANi2EEc6d+GAVBTELEE2EBavdxSauVgns5HF
         K+lidW1rbVEdWyvN3FCOweXPOLEGwUsTGQQsp8ncw0NW9kNToYCJy4juOtg6XYk+lWJG
         FlVA+GmgPOPlToalJlD/JhIMo621j6SPCbyTQlhPQCXFTkxp8r0uKpSWnfaaDxz3TDl3
         25B4IVymJo3afcCDYXXnf+fJpwej0wWYLmOh1GvBKGe1+PZaEmmn17Oezd6vzv0LKfSb
         fTAMEMT5VoZig52txJ20Cj3HL1WfqKNJHtm8GUCdh2uoaVMbtSyytYko6kZ9X2/DSCaK
         3X8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=l94w+M9jXM99wNfT1/p7zOLmf4R3PyvtsIcqBS9Q/3M=;
        b=Q66DuhWEe0xgSTRIUPPe7xGDBQAdd9Wzl27td+Ebr+7PpdiZsbcp3pyoDxAT0PcTFk
         nMTbUampiK82lyJ/3lWSUciwI/Ri8QqY9m6OimXo9QbPejgEoJWU5TJIftYZYqT51Tap
         3X0396cBJdsiBKuEUcJ8XgLvUvpt6ZMDCV58BtT7N/8rb9BM2yjiSoBYBHXDgsq9wYCc
         HgsoNUwlNxqBzKyAI11qMc2i6tP1/Ho/ziYSaOo7iq3MxY7/9YoENwjZZYZMU3ysoNex
         W+dioorvi1s9ytu5N8sOhwZzBkUITsOb+rzTKa68HGRpJs8qjq9Lnm9FCwE31o9U0GpG
         6UlA==
X-Gm-Message-State: AKwxytdrVYnyR2WWlcpFp3EpdnFZp28araW/UYWEqSipqBN6R+2JpYP5
        CaJfiNHqOhOYtS8TBr6QYgY=
X-Google-Smtp-Source: AH8x2245KpxqMkQr9G5Y2mbuhnM64Ihh4FPGKyeyvxLh/vixugJiX3I78jeNm+h1iWdWI9NzfxkAqA==
X-Received: by 10.200.33.195 with SMTP id 3mr22435888qtz.1.1516972095318;
        Fri, 26 Jan 2018 05:08:15 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id p103sm3452464qkp.74.2018.01.26.05.08.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jan 2018 05:08:14 -0800 (PST)
Subject: Re: [PATCH 02/14] packed-graph: add core.graph setting
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
References: <20180125140231.65604-1-dstolee@microsoft.com>
 <20180125140231.65604-3-dstolee@microsoft.com>
 <xmqqvafp8vib.fsf@gitster.mtv.corp.google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <de0577f6-e076-873f-7573-d284423597ae@gmail.com>
Date:   Fri, 26 Jan 2018 08:08:13 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <xmqqvafp8vib.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/25/2018 4:43 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> The packed graph feature is controlled by the new core.graph config
>> setting. This defaults to 0, so the feature is opt-in.
>>
>> The intention of core.graph is that a user can always stop checking
>> for or parsing packed graph files if core.graph=0.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   Documentation/config.txt | 3 +++
>>   cache.h                  | 1 +
>>   config.c                 | 5 +++++
>>   environment.c            | 1 +
>>   4 files changed, 10 insertions(+)
> Before you get too married to the name "graph", is it reasonable to
> assume that the commit ancestry graph is the primary "graph" that
> should come to users' minds when a simple word "graph" is used in
> the context of discussing Git?  I suspect not.
>
> Let's not just call this "core.graph" and "packed-graph", and in
> addition give some adjective before "graph".

I was too focused that I wanted the word "graph" but "graph.c" already 
existed in source root that I came up with "packed-graph.c" just to have 
a separate filename. Clearly, "commit-graph" should be used instead. In 
v2, I'll use "/commit-graph.c" and "/builtin/commit-graph.c".

Thanks,
-Stolee
