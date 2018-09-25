Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC96A1F453
	for <e@80x24.org>; Tue, 25 Sep 2018 18:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbeIZAWD (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Sep 2018 20:22:03 -0400
Received: from mail-qt1-f177.google.com ([209.85.160.177]:37801 "EHLO
        mail-qt1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbeIZAWC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Sep 2018 20:22:02 -0400
Received: by mail-qt1-f177.google.com with SMTP id n6-v6so14396519qtl.4
        for <git@vger.kernel.org>; Tue, 25 Sep 2018 11:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=fmigE2Gk4pITHd32RkMUlzI4/0Cxruf3iikFOANVDAQ=;
        b=i9C63VCEXlHPFvh/JQPQYDvo6d/2axplvWIVyYlQ7xy6I5ripVRhn4DGXtlRB9523m
         h57OygToSIuoPJbbqywXZXGWCop7Dsf9KHEDQojOD3v6lIO0VAmWOdgVZYly8kVxvkwl
         uAyjqcTn/chtCQyxoEWaPweC58JvgQivi/LoWbfjxcoElGRfRo1GpUe3Qjf2Vlvg5x01
         EZjcsRCiepGc4VFm8Lxt7QRknf8Q3Au6nmMEHjhZKWL0JRXEqLK8hTJaHmbmBXEdg320
         ly7zf3OaaKXvTQx31LePBWQPu4e3Q3A9/gOLE0DJ77Sh5OU1Drv4xPGoBV7EIo7lOtKe
         XzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=fmigE2Gk4pITHd32RkMUlzI4/0Cxruf3iikFOANVDAQ=;
        b=ejCGF7fgbZ6lGvYOyZQ9UxZ81Q9RfeKenPpIElfL55jHOcD6jMP7mTHHMuHWlrV8eT
         paQ0C2jYiASlNW32Xg0ZDarA+KLhSCI/aQfw89aWUp4ZyoIRNWJ28WnCAzRqiD4fytt4
         8u4YhHpbi96vclxvuEYYjf2ongI6NF7DCZy9T2xDpCyUlBtKmbCatxbAjBk5T9Tz7FlH
         9mUt5Ooj4/WYothEpJ4GjMIRsS0OPcUrR6QL2PKJNKVE037caaLcGBJGQuXFZ488IzXX
         umgrzj3NjiLuk3agQReNM7x+61tHodmiXrLzCwjThEgh4QJLsZOujrIxfbqLp39irLqd
         UfZw==
X-Gm-Message-State: ABuFfogdcRag4zMFiqigE85KT318J6d97xxVNkLgdPpQ11ylR9yN6jss
        0v0qhqb/4KUq/w3BNPSepRw=
X-Google-Smtp-Source: ACcGV621ig9PY5frbWtOn9/7dbDa2/R4yBO9vqJAjHu1e54I0DNLwaMl2Ojy0cIG1WBU5gWhyUSHyQ==
X-Received: by 2002:a0c:9141:: with SMTP id q59-v6mr1702931qvq.228.1537899198991;
        Tue, 25 Sep 2018 11:13:18 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:78b6:4100:eb3b:b0cf? ([2001:4898:8010:0:61ec:4100:eb3b:b0cf])
        by smtp.gmail.com with ESMTPSA id v51-v6sm1777143qtc.65.2018.09.25.11.13.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 25 Sep 2018 11:13:17 -0700 (PDT)
Subject: Re: [PATCH] commit-reach: cleanups in can_all_from_reach...
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.39.v4.git.gitgitgadget@gmail.com>
 <20180925132741.223513-1-dstolee@microsoft.com>
 <xmqqwor9pi3i.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <08b67726-8af6-34f9-6c4f-6a1be7d81b90@gmail.com>
Date:   Tue, 25 Sep 2018 14:13:16 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <xmqqwor9pi3i.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/25/2018 2:06 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> @@ -622,10 +623,7 @@ int can_all_from_reach_with_flag(struct object_array *from,
>>   	}
>>   
>>   cleanup:
>> -	for (i = 0; i < nr_commits; i++) {
>> -		clear_commit_marks(list[i], RESULT);
>> -		clear_commit_marks(list[i], assign_flag);
>> -	}
>> +	clear_commit_marks_many(nr_commits, list, RESULT | assign_flag);
>>   	free(list);
>>   
>>   	for (i = 0; i < from->nr; i++)
>>
>> base-commit: 4067a64672f9db8ca38d5a2682a7cdba7938c18b
> This change looks good to me.
>
> This is a tangent, but while re-reading clear_commit_marks() and its
> helpers to refresh my memory, I found that the bottom-most helper in
> the callchain was written in a very confusing way, but it is not a
> fault of this clean-up.  I however suspect that it would not help us
> all that much to use clear_commit_marks_many() with its current
> implementation.  It first clears all commits on the first-parent
> chain from each list[] element, while accumulating the parent
> commits that are yet to be processed in a commit_list in LIFO order,
> and then consumes these accumulated side parents the same way.  We
> probably would benefit by rewriting clear_commit_marks_many() to
> traverse from all the tips given in list[] taking advantage of the
> generation numbers, using a prio queue to manage the commits
> yet-to-be-cleared, or something.

Another commit walk that could be improved by generation numbers? It's 
like my bat-signal!

Thanks for pointing me in that direction. I'll take a look.

-Stolee

