Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0D4261F404
	for <e@80x24.org>; Tue, 17 Apr 2018 18:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752604AbeDQSjp (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Apr 2018 14:39:45 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:34756 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752691AbeDQSjm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Apr 2018 14:39:42 -0400
Received: by mail-qt0-f174.google.com with SMTP id a25so13546156qtm.1
        for <git@vger.kernel.org>; Tue, 17 Apr 2018 11:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8rzDRNttGGLAIKEvH29jfdSRwhTU6hv9CTReVw8ghsk=;
        b=a+1K9iKsOjX1aViDaEiP8EI6xkl7HI2YuU/dbUPbJw5qwpI6zaFYjjqLaPUgGVienC
         7Le0xpQsrkNQOpkWE8LXDncXqqS8Pb/Kr4aC00iCW5Pfj9Fg3ALS8RER8rU8khFxZQum
         Lm/42ECWyK8z5lCJlHNDzKJG0IrFwosKWfRLbHI/U8ZvdFJn3mF1+3lK2tcxORwQ2iax
         RFQAKqB3dDVbKQmj1LlZFdc/1vQ4NFNHCeLFBSsEjr1ZUsgjpt6PC4ov0FSIIEmP0Ibd
         +SSPd3V31KRPg3XpmSY3lLKpckeT6KerPClBWFzl7EnaxFM+UlMLZHw3TJh6kKxHlrIW
         BLGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8rzDRNttGGLAIKEvH29jfdSRwhTU6hv9CTReVw8ghsk=;
        b=GZUzDUDv6fLollJemmsICFA0GY2IuAWkOlGd1dHBleUNcXmlxqLM6X6H5YSynKSW0x
         5qV2gFJ/yzaZTeaRdyIJU5kxegWbFMKNsGsoKq8CxRsk+UKzx3dJ+HZJZiEFyKgsF7P/
         h6NIO5VpDHvHFlMymwIdjLDD46wTsF4FUSmrhqa1IS/l8mfG3MlbrA0ifEbxS7f3Mh/g
         xmXUnT0WyGsScqE+GYHaWRdEPfTVa1AL4orYLzXBKZkap96t/IFLANTU1O4dRQHSpJm+
         cGQiKntNBb1SvNdO7KzCfsIGMCwop9N7Pun8WpBP0/Kv0dF/tVXUBu8djz/U7wCxeYFQ
         1n/w==
X-Gm-Message-State: ALQs6tBVXQPj5wIzprFD+x4qcHEe5OQptWaa1kYJyuFJhh7GlJMEGk/W
        hTnRDv80Hv8vb5v9j0CF224=
X-Google-Smtp-Source: AIpwx4//6VmYV5mU3gRFL60mQSOCeIfC64ce1hP4O4XKpjZ3vcKKDPL1JkKuKeGi1hLotxMl/62GCw==
X-Received: by 10.200.2.74 with SMTP id o10mr605492qtg.355.1523990382035;
        Tue, 17 Apr 2018 11:39:42 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id a20sm10931494qkb.17.2018.04.17.11.39.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 17 Apr 2018 11:39:41 -0700 (PDT)
Subject: Re: [PATCH v1 0/5] Allocate cache entries from memory pool
To:     Jameson Miller <jamill@microsoft.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Cc:     "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>,
        "jonathantanmy@google.com" <jonathantanmy@google.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <d2743302-43dd-da3e-f0ba-55dcb824c0f4@gmail.com>
Date:   Tue, 17 Apr 2018 14:39:41 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180417163400.3875-1-jamill@microsoft.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/17/2018 12:34 PM, Jameson Miller wrote:

> 100K
> 
> Test                                       baseline [4]       block_allocation
>   ------------------------------------------------------------------------------------
> 0002.1: read_cache/discard_cache 1 times   0.03(0.01+0.01)    0.02(0.01+0.01) -33.3%
> 
> 1M:
> 
> Test                                       baseline           block_allocation
>   ------------------------------------------------------------------------------------
> 0002.1: read_cache/discard_cache 1 times   0.23(0.12+0.11)    0.17(0.07+0.09) -26.1%
> 
> 2M:
> 
> Test                                       baseline           block_allocation
>   ------------------------------------------------------------------------------------
> 0002.1: read_cache/discard_cache 1 times   0.45(0.26+0.19)    0.39(0.17+0.20) -13.3%
> 
> 
> 100K is not a large enough sample size to show the perf impact of this
> change, but we can see a perf improvement with 1M and 2M entries.

I see a 33% change with 100K files which is a substantial improvement 
even in the 100K case.  I do see that the actual wall clock savings 
aren't nearly as much with a small repo as it is with the larger repos 
which makes sense.
