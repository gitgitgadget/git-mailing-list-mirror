Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EEE6F202A0
	for <e@80x24.org>; Sun, 19 Nov 2017 17:28:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751020AbdKSR2x (ORCPT <rfc822;e@80x24.org>);
        Sun, 19 Nov 2017 12:28:53 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:41509 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbdKSR2w (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Nov 2017 12:28:52 -0500
Received: by mail-pf0-f174.google.com with SMTP id j28so5538054pfk.8
        for <git@vger.kernel.org>; Sun, 19 Nov 2017 09:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=jWbBA3e2gqs0nQZHY6AadyYeKTAQBQW5G0OawrUDa3A=;
        b=EgVg6MDQqM1Rji1uylGOSJepjIv+mHp02G0XZIn3zLMdXaeniI7zoTN0/kE7Bsoj58
         vprnzXehuI9NnZC/t0XfEqokms4dvG6r4qvXbkdD8KQP4aV8W2mqYoN9gw9Ifbhu/Lr2
         YJD25R31jUYDWM5dB6eW+mOTL1N4taFlv2m17JVrF7Ttlhe1ivk3dNI7FvPNwTpOXyhV
         /+dM3Ds9lI5ivTCpfDyQ8rDnzPbaLuJl8n+/c8PD/bwA1CrNGCqoVOWKwjhRoyFIDht4
         2fViQNjCWMZ+QYoV/y0NgSazjjfLILPMI09ly6j2X9HABKZ8XNq5nTEGcFH6wJm38WET
         3sDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=jWbBA3e2gqs0nQZHY6AadyYeKTAQBQW5G0OawrUDa3A=;
        b=B51NwFi79BG7zTPyjXgrjffatbOsDXx5ZZFYpihXJLlzSj/ydwk+89QJxp+7xySRzF
         iXVOWFrAttF982E9MUcsclqmGaHL/1rAbtx8KxP9NWQiQv9OmS5FvjJGwDrQzwYh3GmG
         zTUac5J1/Gyjhc56zVSLkbIl3mWifRwG2PJvAtlynGADjAaj5kJ2FloPVnyLDcg0MjfY
         6MvOe4Z6guV2rpf3kOg6lmHp/nsugCPqdYIIYxMgn0Al/LZqvQvXpU6ayaGmLGxLX3wW
         QcqhnSmDMQkLcfKbIj3Gob8zlZlM9xzaou7QePWvOov1u5O0uyI+3L972rXyawI9G4kq
         OUSw==
X-Gm-Message-State: AJaThX5aPRkNCIi5LlOeBIwCCadmF/7pPDP783q2EzAK4U3dvQz3WJwb
        vJxjOSTl1dymvZ00ImO2PGlUfoh4
X-Google-Smtp-Source: AGs4zMb8h9dtntl0t61bs2KFC5IE873APqQYeRVM+hFiNSALKwMR/KowQZyBwDxrurkqCT04F5xMOA==
X-Received: by 10.159.216.131 with SMTP id s3mr11188597plp.252.1511112531577;
        Sun, 19 Nov 2017 09:28:51 -0800 (PST)
Received: from ?IPv6:2405:204:72c8:8b21:b8b1:7c41:1a33:6334? ([2405:204:72c8:8b21:b8b1:7c41:1a33:6334])
        by smtp.gmail.com with ESMTPSA id s65sm7857834pfk.7.2017.11.19.09.28.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Nov 2017 09:28:50 -0800 (PST)
Subject: Re: [PATCH] git-rebase: clean up dashed-usages in messages
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git mailing list <git@vger.kernel.org>
References: <20171118161810.16494-1-kaartic.sivaraam@gmail.com>
 <xmqq4lprow2i.fsf@gitster.mtv.corp.google.com>
From:   Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Message-ID: <459f9455-5edb-39a2-1511-1590e50d4545@gmail.com>
Date:   Sun, 19 Nov 2017 22:58:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <xmqq4lprow2i.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sunday 19 November 2017 07:42 AM, Junio C Hamano wrote:
>>   test -f "$apply_dir"/applying &&
>> -	die "$(gettext "It looks like git-am is in progress. Cannot rebase.")"
>> +	die "$(gettext "It looks like you are in the middle of an am session. Cannot rebase.")"
> 
> Probably not, as 'am' alone would be confusing.
> 
>      "It looks like 'git am' is in progress. Cannot rebase."
> 
> may be a more sensible improvement.
> 

Let me guess, 'am' alone would be confusing because it follows 'an' in 
the error message. So, the user might mistake it to be some kind of typo 
in the error message. Is that close to why 'am' alone would be confusing?

Anyways, I stole that from a message shown by 'git status',

     "You are in the middle of an am session."

So, does that require a change too?


---
Kaartic

