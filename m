Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC036C48BCF
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 13:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D47AB613BE
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 13:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbhFINRD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 09:17:03 -0400
Received: from mail-qk1-f178.google.com ([209.85.222.178]:33455 "EHLO
        mail-qk1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbhFINRC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 09:17:02 -0400
Received: by mail-qk1-f178.google.com with SMTP id k4so23594664qkd.0
        for <git@vger.kernel.org>; Wed, 09 Jun 2021 06:14:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i+OePMGeba1OJlr4MA+BLf8Bjv9wA9Uq7WPtjOxF/Nc=;
        b=eBRLjUuIbkAB2tOIApEWEXSFU9DJZgTxvN7soMlXWF00uHeMywhOtLvVdxE528lMho
         08ToFkiguRU6bifIZzkIqrZfZuIHdJRM/I7hBGibq/8NEYuaH/YLx5ihJbU4BmxcCgm5
         lwL/SYlhpCGHJma/m2qDu3TRnaXe7g1ei2eypuUpoyugpB5ZTkLonrkqihceXxcovLwV
         iqajfjfkpBvZz4YHpqgCAQxzCK2srgO2NZfkbOsLEnr9oeM/dYw00BhRyK90+RJ/FgC5
         SKGZv6M5Al0JMcKg58Es5XkbsEl1c8R/WH7B/jjIAsPCkTdLA+tw+kr5GsYOJnti2spk
         r7JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i+OePMGeba1OJlr4MA+BLf8Bjv9wA9Uq7WPtjOxF/Nc=;
        b=DlfC0l3Wq9+P0T1SO2rE4x0xNk3gTvS/Abc1oYiOWaOYUUIiEJe/qTAz8es99eotgs
         MclZii5GvVaajwDIwcXpjmSvs6WQInlmFJKI6qvEdJWX+MsKTtB8l0etNyE7ATdKZyNT
         VlXrUnj7G1S/y3/2hAEo0L1Ys/fb4lMvaRB4sO3CRfu9lcmkEXgJUvSyhqszca5VoDtp
         zuoHlltEPXVR8k9GoqAMaE1EEekPuGeaZ3u8OgCPNPLi10man6Hc/B2gTRCXUCEQVNhL
         Gep1zCau5sOsJBW5AmF3ZvipG3WzRdM6AtHgAu4xM+2v35oZohQ9T7hltCbPClfCszai
         Dhsg==
X-Gm-Message-State: AOAM532XDtz9rnQn9pZx3D2T361VhIev6Z2vl7PODuYFbnzLAA7aUcXB
        S4paJ+dN+ZvFtIyZqIqFoUc=
X-Google-Smtp-Source: ABdhPJxlwGG1FZFreuyY2IcLK+1veFj016m4ZiUs9HxKr7sngJ9SsiU+o+1BxgWWg4/1Ho7n0K8tuA==
X-Received: by 2002:a37:a305:: with SMTP id m5mr26023662qke.149.1623244436106;
        Wed, 09 Jun 2021 06:13:56 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:d80d:ae0e:3efe:ebc2? ([2600:1700:e72:80a0:d80d:ae0e:3efe:ebc2])
        by smtp.gmail.com with ESMTPSA id e3sm4541026qts.34.2021.06.09.06.13.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 06:13:55 -0700 (PDT)
Subject: Re: [PATCH 1/4] Documentation: use singular they when appropriate
To:     Junio C Hamano <gitster@pobox.com>,
        "Kerry, Richard" <richard.kerry@atos.net>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        "jrnieder@gmail.com" <jrnieder@gmail.com>,
        "emilyshaffer@google.com" <emilyshaffer@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.975.git.1623085069.gitgitgadget@gmail.com>
 <afc51c5e6edec7935a6d0d0a05d396e11311ca6c.1623085069.git.gitgitgadget@gmail.com>
 <xmqqh7i9rw5o.fsf@gitster.g>
 <AS8PR02MB73029EDC4458F233543106D99C379@AS8PR02MB7302.eurprd02.prod.outlook.com>
 <xmqqczswndsp.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <295beb8b-37ab-dc8e-b0cb-50d3cb07d3cd@gmail.com>
Date:   Wed, 9 Jun 2021 09:13:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <xmqqczswndsp.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/8/2021 7:21 PM, Junio C Hamano wrote:
> "Kerry, Richard" <richard.kerry@atos.net> writes:
> 
>> Or:
>>
>>     `Reviewed-by:`, unlike the other tags, can only be offered by
>>     a reviewer when they are completely satisfied with
>>     the patch.  It is offered only after reviews by
>>     reviewers who are known to be experts in the affected area by
>>     the community members.
>>
>> Sentence one uses singular they to refer to one of a pool of reviewers.  
>> In the second all items are plural.
> 
> Yeah, it reads well, I'd think.
 
I agree. Thanks!

-Stolee
