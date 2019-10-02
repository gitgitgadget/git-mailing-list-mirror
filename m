Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A235C1F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 15:56:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728916AbfJBP4s (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 11:56:48 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44888 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726157AbfJBP4s (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 11:56:48 -0400
Received: by mail-pg1-f195.google.com with SMTP id i14so12040310pgt.11
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 08:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=BZQBCUHCiIGrNL/4/KsZ1OIGbe+ABWcOPMdmIwCbnd4=;
        b=XwQgFvulMjAL3JIq+nYprcejlgwLt+AqcwNCcdr8a1Ss2lQFTZNUJuKiet62d4GzVA
         V2liQRMXi6iXW3rBFOaLl+tFSlPd573EFgqv2T9+uI65Me+URFyn3cDYQ5nI019/sjhb
         28qMNYmcJTdgTi2a9m6mCksZHxhCIekMBvmruOthCqRdEO5vxybKVr19UKboTR7D+E1B
         X3CCZC6cXcXt6mUnqypjy+8XhAWEUl7jmTJdU9/WhQ1kZZw/TQ7SgcvBMqVwgR2hFBnM
         VzHHVxQPFhSjJubeaoOE5xMaNcMb2a7BToXO7y/A2fTI9GkcoXrgTchlHHl7UdWnm4jV
         ANKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=BZQBCUHCiIGrNL/4/KsZ1OIGbe+ABWcOPMdmIwCbnd4=;
        b=OezOAgjpFQW96jacOBs92c7Da8QQoIjFn/1k9OR/fZEUxAmYoXZfr3d91QXDtY5WCh
         VOnncrcDfmRNMbce+DVi5KTyT8qWsyxrtDdnfCoRtrt4C4gdihcTu8J4LLhzYOSokN2k
         e67EmhVyXSqWLE9/NN70SrjVKq7fHvTMby8JWASMQKxuifWIYwvXjo8fIwDonDxF+bNl
         zEkx2VFIp8rTRego8z2MfiCRq7JNp1qoy4+05j34e3Dqs85eT8I80TXGe3cGBvEMRn/g
         j4LuMkTtCSgHG89DOZE8xoYKEw3WKKl3NwwHtUcyoxja9CwkYrVYoZFkKNO1znxbvj3t
         R2yg==
X-Gm-Message-State: APjAAAUwYcWXnAV7lFLxusBD0k+7iHYs+FNOPEEKYsjNFgV/TxxffX4C
        0lzv4LxF8V1+Lx8kO/lTWDUzRCKY
X-Google-Smtp-Source: APXvYqzK6Vs1EAgcZxECUfZD4zrg3o4KxbweYT5hfZnH/DysqbSYl0qiCt8+jOCbyZ947ReZAPA9Nw==
X-Received: by 2002:a63:ee03:: with SMTP id e3mr2405837pgi.95.1570031808014;
        Wed, 02 Oct 2019 08:56:48 -0700 (PDT)
Received: from GVFSs-MBP.guest.corp.microsoft.com ([2001:4898:80e8:3:cd32:1847:435d:97e])
        by smtp.gmail.com with ESMTPSA id t125sm19558900pfc.80.2019.10.02.08.56.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 08:56:47 -0700 (PDT)
Subject: Re: [PATCH v2 1/6] midx: add MIDX_PROGRESS flag <snip>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        William Baker via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, stolee@gmail.com, jeffhost@microsoft.com,
        William Baker <William.Baker@microsoft.com>
References: <pull.337.git.gitgitgadget@gmail.com>
 <pull.337.v2.git.gitgitgadget@gmail.com>
 <6badd9ceaf4851b2984e78a5cfd0cb8ec0c810f5.1568998427.git.gitgitgadget@gmail.com>
 <20190921121104.GA6787@szeder.dev>
 <xmqqlfu9krzv.fsf@gitster-ct.c.googlers.com>
 <2de6b236-7bd8-256b-7d8f-911d63a47498@gmail.com>
 <xmqqsgobg0rv.fsf@gitster-ct.c.googlers.com>
 <xmqqlfu3eigp.fsf@gitster-ct.c.googlers.com>
From:   William Baker <williamtbakeremail@gmail.com>
Message-ID: <8ec5513c-fcfa-bc55-5d73-6aa6528ac4dc@gmail.com>
Date:   Wed, 2 Oct 2019 08:56:45 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <xmqqlfu3eigp.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/2/19 12:04 AM, Junio C Hamano wrote>>
>> Well, if you write
>>
>> 	enum { BIT_0 = 1, BIT_1 = 2, BIT_3 = 4 } var;
>>
>> it's pretty much a promise that the normal value for the var is one
>> of these listed values to your readers.
> 
> ... that is why compilers give a warning when you write
> 
> 	switch (var) {
> 	case ...:
> 	...
> 	}
> 
> and do not have case arms for all the declared enum values without
> having the 'default' arm.
> 

Thanks for all of the details and feedback here.  I can leave the
flag as-is (and not switch to enum).

Thanks,
William
