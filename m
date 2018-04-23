Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C3CC21F424
	for <e@80x24.org>; Mon, 23 Apr 2018 17:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932109AbeDWR1V (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Apr 2018 13:27:21 -0400
Received: from mail-qt0-f169.google.com ([209.85.216.169]:33347 "EHLO
        mail-qt0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932076AbeDWR1U (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Apr 2018 13:27:20 -0400
Received: by mail-qt0-f169.google.com with SMTP id f16-v6so14807109qth.0
        for <git@vger.kernel.org>; Mon, 23 Apr 2018 10:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=N2DgHhz6j74E9Eibrn8aiK2bUZ56QtOMS8oelb0s6qc=;
        b=EtvrTLLdf/0Or5JyZDV9svKX34IYY8PlFVQY50BNRsbop0iby/T6e1g7usCgUZa6Qk
         d2spfC+t5TsZDnlwSZ98AhU5ruV6ctnbJqkRnd7tFh3Eo5tVp/5fgBJSYxlNZFJKDi6s
         saYIJdqkj+FMawLJxAH28Sj5E5rxDeJ5nrdy9/3uskYgMUf32aWrj9yLuIc+qhe7CLSH
         veolc+sGkvHu3vCKqgN/uM9n0fvdERh6XUd5a2Lej/Zf8M1VvxZahywDbdc84t6PLEG1
         hcLphu4zhbG68+MrqYcTeVdRF06sCw4RdY0ehRefkcJI1TQQB1+hc4/Nfw2wQlMAxaP+
         hGhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=N2DgHhz6j74E9Eibrn8aiK2bUZ56QtOMS8oelb0s6qc=;
        b=pw3LZkKnbwdtC0fh3BGazFSRs8etiWGshCKN8r4xzpxvPJfhCtUs6vV9vdnLsYzIGa
         6pN3Y7k27UMLjH9U9FbzY6UpdrPrK4149IroWxsI9ZOFsdZth4wY3204LEQd+x5R+JIe
         C8Y5jBZKrJb9VPvToGyUVUQqXDO48Xon0XUyfWPsiuCRfe44MrsrE2XKoi//xyVYN67p
         huTfa3LfTGO6j9ZdKVb7wCqOz7ZhEIXtQQECW3yQ3E47kfOp0LxsSfdP4C8CI4x7RAE9
         FFX9N2+oLjVr37xIoRZaLo8gZ9/jHOdG5QuGuFGbw+JHjAKFS5+xewOlv5Dum5/hSqKR
         EUZQ==
X-Gm-Message-State: ALQs6tBucJQEWzdW2EaaLtr/EyOGZAps+cwJx2qJNan84E3/lxF23uFG
        aOlcCdWs2gOpuHjo3OrOc7c=
X-Google-Smtp-Source: AIpwx4/eRJGVlInREbJ/kR/HRgytUg3cCux3ZeB8qhk9J1hVg11IeNML91D7yeOD2TZB/BuAUN+xAw==
X-Received: by 2002:ac8:d44:: with SMTP id r4-v6mr24987111qti.187.1524504440270;
        Mon, 23 Apr 2018 10:27:20 -0700 (PDT)
Received: from localhost.localdomain ([2001:4898:8010:1:1060:bd2c:4297:50e])
        by smtp.gmail.com with ESMTPSA id d4-v6sm10824918qtm.68.2018.04.23.10.27.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Apr 2018 10:27:19 -0700 (PDT)
Subject: Re: [PATCH v1 3/5] mem-pool: fill out functionality
To:     Jonathan Tan <jonathantanmy@google.com>,
        Jameson Miller <jamill@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "pclouds@gmail.com" <pclouds@gmail.com>
References: <20180417163400.3875-1-jamill@microsoft.com>
 <20180417163400.3875-5-jamill@microsoft.com>
 <20180420162136.144ac5529072f22067abb3b9@google.com>
From:   Jameson Miller <jameson.miller81@gmail.com>
Message-ID: <898c0b43-b090-fb1f-45d5-ea4041843cdb@gmail.com>
Date:   Mon, 23 Apr 2018 13:27:09 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180420162136.144ac5529072f22067abb3b9@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 04/20/2018 07:21 PM, Jonathan Tan wrote:
> On Tue, 17 Apr 2018 16:34:42 +0000
> Jameson Miller <jamill@microsoft.com> wrote:
> 
>> @@ -19,8 +19,27 @@ struct mem_pool {
>>   
>>   	/* The total amount of memory allocated by the pool. */
>>   	size_t pool_alloc;
>> +
>> +	/*
>> +	 * Array of pointers to "custom size" memory allocations.
>> +	 * This is used for "large" memory allocations.
>> +	 * The *_end variables are used to track the range of memory
>> +	 * allocated.
>> +	 */
>> +	void **custom, **custom_end;
>> +	int nr, nr_end, alloc, alloc_end;
> 
> This seems overly complicated - the struct mem_pool already has a linked
> list of pages, so couldn't you create a custom page and insert it behind
> the current front page instead whenever you needed a large-size page?

Yes - that is another option. However, the linked list of pages includes 
memory that *could* have space for an allocation, while the "custom" 
region will never have left over memory that can be used for other 
allocations. When searching pages for memory to satisfy a request, there 
is no reason to search through the "custom" pages. There is a trade-off 
between complexity and implementation, so I am open to suggestions.

This was discussed in [1], where it originally was implemented closer to 
what you describe here.

> 
> Also, when combining, there could be some wasted space on one of the
> pages. I'm not sure if that's worth calling out, though.
> 

Yes, we bring over the whole page. However, these pages are now 
available for new allocations.

[1]
https://public-inbox.org/git/xmqqk1u2k91l.fsf@gitster-ct.c.googlers.com/
