Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 889EE1F453
	for <e@80x24.org>; Tue,  2 Oct 2018 14:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbeJBVRy (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Oct 2018 17:17:54 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42283 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbeJBVRy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Oct 2018 17:17:54 -0400
Received: by mail-qt1-f195.google.com with SMTP id z8-v6so2111708qto.9
        for <git@vger.kernel.org>; Tue, 02 Oct 2018 07:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=73L9J3dmxaTGB2lZI/QrluvgT7zSXZ/brxpuqCfzie8=;
        b=KqBQQX4t6Y8PA4sfMJrkvZT0qix4cOyewgaT5ir6m40QyKWoyzS06UplJ8Moz0mp/k
         m2wnnKBtm8QQEdZmDc8UokIIDWt9DLqsQVVCvdTNqrMIWVcJo8K+mZb+ivq1E8inI/TX
         oPn65Th5it3th0A56ZEwm+Q2TZCR2D3mFNmjHfC+5WE8o1cUyB9T5a73AwTE1JSn8iLO
         rIbPjpihboZQjADnY19s+tJnklgKFRoh48dD0uj7YlTkEKIZ0UgjLwtAFkWSufQzcFZw
         0Qa4lqbxL+YEC1dsP9RVfsTYAyKfuppz6orgRoXAlwvnVsk2AMpNIqYUr3Lejl1eQFb7
         VUTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=73L9J3dmxaTGB2lZI/QrluvgT7zSXZ/brxpuqCfzie8=;
        b=iXyUdhIpauZA5XKUJ/d9sIkcLFCm7son8bmGlJlN+36F6vwtYjKqf5bkjm+ucLHFyh
         VClW0wFs+fYEABPRllq3D/YVicqna2Gqa4WzLEm1sUHovS0ch+w+H0DwpHDgNvBkCAoy
         AohCKPM7SP9zwPcUtWQQxlovxjppR3HZIG0x1stOD9IshR97vJ2ovVqAedd6sbqfpNWt
         xLhVgynwvAvb0PMoOUevovergXEAMVKkOdAg54CU3FA21xpTVmG+2sj4xVleAqdj8Gw0
         hEveBw6SMT9I4wDbbiGiJnwJFQmRdlhg78iacJWZbPnz8NVPTY6yENt7RDNMMZgW7QBZ
         8b1w==
X-Gm-Message-State: ABuFfoh/P6+1nbZyi/AyYU2vWwIQ0NIbbWCU9+hfcDv2m6wSfz7UqDZl
        oqGkx3mGt6/mp2Z65fQBUB0=
X-Google-Smtp-Source: ACcGV62LoZB7E7wEtW+8aCu/M+ToMX8kk+kCLRem8iTYjOMo39buWX0T7SPLwXIQ2oJLxeb1JM7nIg==
X-Received: by 2002:ac8:1b87:: with SMTP id z7-v6mr12737878qtj.321.1538490851818;
        Tue, 02 Oct 2018 07:34:11 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id k126-v6sm8684638qkb.91.2018.10.02.07.34.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Oct 2018 07:34:10 -0700 (PDT)
Subject: Re: [PATCH v7 3/7] eoie: add End of Index Entry (EOIE) extension
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, pclouds@gmail.com,
        Ben Peart <benpeart@microsoft.com>
References: <20180823154053.20212-1-benpeart@microsoft.com>
 <20181001134556.33232-1-peartben@gmail.com>
 <20181001134556.33232-4-peartben@gmail.com>
 <20181001151716.GL23446@localhost>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <dd8622f1-9005-a989-6934-2b9cd24c87a9@gmail.com>
Date:   Tue, 2 Oct 2018 10:34:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20181001151716.GL23446@localhost>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/1/2018 11:17 AM, SZEDER Gábor wrote:
> On Mon, Oct 01, 2018 at 09:45:52AM -0400, Ben Peart wrote:
>> From: Ben Peart <benpeart@microsoft.com>
>>
>> The End of Index Entry (EOIE) is used to locate the end of the variable
>> length index entries and the beginning of the extensions. Code can take
>> advantage of this to quickly locate the index extensions without having
>> to parse through all of the index entries.
>>
>> Because it must be able to be loaded before the variable length cache
>> entries and other index extensions, this extension must be written last.
>> The signature for this extension is { 'E', 'O', 'I', 'E' }.
>>
>> The extension consists of:
>>
>> - 32-bit offset to the end of the index entries
>>
>> - 160-bit SHA-1 over the extension types and their sizes (but not
>> their contents).  E.g. if we have "TREE" extension that is N-bytes
>> long, "REUC" extension that is M-bytes long, followed by "EOIE",
>> then the hash would be:
>>
>> SHA-1("TREE" + <binary representation of N> +
>> 	"REUC" + <binary representation of M>)
>>
>> Signed-off-by: Ben Peart <peartben@gmail.com>
> 
> I think the commit message should explicitly mention that this this
> extension
> 
>    - will always be written and why,
>    - but is optional, so other Git implementations not supporting it will
>      have no troubles reading the index,
>    - and that it is written even to the shared index and why, and that
>      because of this the index checksums in t1700 had to be updated.
> 

Sure, I'll add that additional information to the commit message on the 
next spin.
