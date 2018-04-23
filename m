Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 373E71F424
	for <e@80x24.org>; Mon, 23 Apr 2018 18:20:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932275AbeDWSUc (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 14:20:32 -0400
Received: from mail-qk0-f172.google.com ([209.85.220.172]:37423 "EHLO
        mail-qk0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932109AbeDWSU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 14:20:26 -0400
Received: by mail-qk0-f172.google.com with SMTP id d74so17122788qkg.4
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 11:20:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=9dL3yck+XpLwEoHW4FSMf6pFVDOgC8BViUnPEOgV5o8=;
        b=Mndzzgn62PSQQQjXK+5Ww/JFQNjKretCywwpGlC45HRfF24OQyvAzUjJh7rJViQw2v
         ZWrQpKZd4yaMtHu1vICAH9zr0s49wkrx6vsoj04QWsYIaue1k24XUajcdLpxLRy2FSHJ
         qTSm9hZPHpMWLTNm1GY7JHL13SpbK4q5gQPU1ku9UEL6rqXbRBwum6umF8yKnVT2uJUu
         OdmQjw7Tkfp6/2wPMj5aHHiyq+EYmv5yqkl3qTIVFpWtQ/GxoUiTwIx2Jx1++xWsylK/
         BfD9nNGeJu6qoeqet3p4XOayg27dpygmgK7KSDaGqFGeUzMi0ogeC0+q9H9llF6KY7BI
         jKYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=9dL3yck+XpLwEoHW4FSMf6pFVDOgC8BViUnPEOgV5o8=;
        b=qV2p8bpwUnk2c4Nzc5IbZI9zGjb49RHAtA5wDz6hpHVdwQtgGb2GVBXGRhwWGrzbEB
         k6bVgiEVn1szptRO2RQtmdh4Mq/qFiGBltReVeQ3o6MOsCwKS71oMbNcSIgF4tPZTdaT
         iin+RgxidCLJopxsFe3oJyODhbCHpaCzEBqRtbr18HLYunqvkVPc54cPkrU3vRouw7+6
         1i1FFEwy1Vo1J8yDfWiDN/r0O2FQuX/W332vMGWzZnDQoPN9vBoTbrrfBNSoQezAT3G4
         yYYwwPepx8fGUW44TVKvFZmjabSb6cXD1kpyWX56O2qSbkORZ3RMVXFPAMwFtv+UMPog
         IgGw==
X-Gm-Message-State: ALQs6tBok2pSMY9m3gWtAee+7eo/7rbONJmrf7sQyr7qL/H4Xt5ry3+2
        AStC7hHUdLvZzBcnnO+0F50=
X-Google-Smtp-Source: AB8JxZpkjvM0gQulpkqIPie2kv5Qc293N8j6rrshg08FK64+VNu8gwnul5+RkOEQd4u9jstM5WxokQ==
X-Received: by 10.55.93.71 with SMTP id r68mr24576851qkb.70.1524507625814;
        Mon, 23 Apr 2018 11:20:25 -0700 (PDT)
Received: from localhost.localdomain ([2001:4898:8010:1:1060:bd2c:4297:50e])
        by smtp.gmail.com with ESMTPSA id y6-v6sm10235685qtn.56.2018.04.23.11.20.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Apr 2018 11:20:25 -0700 (PDT)
Subject: Re: [PATCH v1 3/5] mem-pool: fill out functionality
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Jameson Miller <jamill@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
 <20180417163400.3875-5-jamill@microsoft.com>
 <20180420162136.144ac5529072f22067abb3b9@google.com>
 <898c0b43-b090-fb1f-45d5-ea4041843cdb@gmail.com>
 <20180423104931.c465b6a260219c96feba41ff@google.com>
From:   Jameson Miller <jameson.miller81@gmail.com>
Message-ID: <5584faf6-23a0-366a-bd87-cf9e420f212c@gmail.com>
Date:   Mon, 23 Apr 2018 14:20:14 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423104931.c465b6a260219c96feba41ff@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 04/23/2018 01:49 PM, Jonathan Tan wrote:
> On Mon, 23 Apr 2018 13:27:09 -0400
> Jameson Miller <jameson.miller81@gmail.com> wrote:
> 
>>> This seems overly complicated - the struct mem_pool already has a linked
>>> list of pages, so couldn't you create a custom page and insert it behind
>>> the current front page instead whenever you needed a large-size page?
>>
>> Yes - that is another option. However, the linked list of pages includes
>> memory that *could* have space for an allocation, while the "custom"
>> region will never have left over memory that can be used for other
>> allocations. When searching pages for memory to satisfy a request, there
>> is no reason to search through the "custom" pages. There is a trade-off
>> between complexity and implementation, so I am open to suggestions.
>>
>> This was discussed in [1], where it originally was implemented closer to
>> what you describe here.
>>
>>> Also, when combining, there could be some wasted space on one of the
>>> pages. I'm not sure if that's worth calling out, though.
>>
>> Yes, we bring over the whole page. However, these pages are now
>> available for new allocations.
>>
>> [1]
>> https://public-inbox.org/git/xmqqk1u2k91l.fsf@gitster-ct.c.googlers.com/
> 
> Ah, I didn't realize that the plan was to search over all pages when
> allocating memory from the pool, instead of only searching the last
> page. This seems like a departure from the fast-import.c way, where as
> far as I can tell, new_object() searches only one page. If we do plan to
> do this, searching all pages doesn't seem like a good idea to me,
> especially since the objects we're storing in the pool are of similar
> size.

I see. However, the new_object() logic in fast-import is a different 
than the logic mem_pool was abstracting, and is not covered by the 
mem_pool functionality. The behavior of searching over all pages for one 
to satisfy the request existed previously and was not changed in the 
mem_pool implementation.

> 
> If we decide to go ahead with searching all the pages, though, the
> "custom" pages should probably be another linked list instead of an
> array.
> 

This is an option - I went with the current design because we only need 
pointers to a block of memory (as well tracking how large the allocation 
is for verification purposes). We don't necessarily need the extra 
overhead of a structure to track the linked list nodes, when it is 
provided by the existing array manipulation functions. I am open to 
feedback on this point, however.

