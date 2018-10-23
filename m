Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F08CA1F453
	for <e@80x24.org>; Tue, 23 Oct 2018 17:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728374AbeJXBhL (ORCPT <rfc822;e@80x24.org>);
        Tue, 23 Oct 2018 21:37:11 -0400
Received: from mail-vk1-f195.google.com ([209.85.221.195]:46749 "EHLO
        mail-vk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727758AbeJXBhL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Oct 2018 21:37:11 -0400
Received: by mail-vk1-f195.google.com with SMTP id l11so527718vki.13
        for <git@vger.kernel.org>; Tue, 23 Oct 2018 10:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=tQ7eYYpfGvwTJcmcY0p1VrtxtJ0tunVzrYC54b7MieQ=;
        b=t5UU5+mBD5GUJ2wSQmUeNLodg3M7uhu/ch/VvwHLNTRZmH6034AT1yyfR9URKpMIcw
         ZEkYC0WCmtXr9t8NSppUInrY2RgsTdxV1QUm3qjU/IAQSNvZ5iWwXIeHIw4BGW7vxrCW
         i8du2+LkBxApmebApeMYe/OfQkgcXFwh8dtB40TEgnSelmkOZkghgZqLE1QVQlDdgSkM
         MC7yYKEWBkmGUc5p25+U8QKzCsTDlm8jtEkjH6/AFoaDrSvAp7c8JibLtR8EQKcKz0pJ
         7J2UQhc05Rj9ETqi83sm5DR8QIDkDArvieC2/5DYdKmyT6zxO8UdtC3am9KcLTm8+5DI
         0PQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=tQ7eYYpfGvwTJcmcY0p1VrtxtJ0tunVzrYC54b7MieQ=;
        b=uVFAcIpdHZvAX5Ck1Dy8p0TdPD4Hbl/Dz1h76oFfOXEUJrHGA1jYrPh0XkgDQYQZz+
         1oIz1XlZwiolEUFmkl/puuQWWyOxErNtt2+pdj3CIje1C/2rXWL2t+rLE8qkyNqcd53S
         UtGf+QC80WvbIYVEKNV+oIiZhm+4NkwiWNNnGoPnG49SBAVknuMN6XkbmdWtkOZDbZAa
         zpT2GrFrD44EDbjgT7xRzbQyIUvnBWORFIIgmHLbeKJA4/n9sovruy2/hVHeRlfZtbKn
         PxfxAaZ7Buh7CuQjEawVB4203/1jC3khQKKNpIHR7QSOpF09NaE9XRu84K+N/Y36t+hj
         DzKw==
X-Gm-Message-State: AGRZ1gKg/NnZcgeFOHFm2lVouJspA5lywdwzuC9XojjgrF/JBSnsLOUZ
        kHtVa5X2/wKJTweZC0sTA4o=
X-Google-Smtp-Source: AJdET5dw9y7VK1bAYT/ztfxFno3iE0xGysze6B2GWr5fFSXtjFJ1n9wHTH3WZkM6GdXfqfa967w2gA==
X-Received: by 2002:a1f:86d1:: with SMTP id i200mr4431761vkd.19.1540314774918;
        Tue, 23 Oct 2018 10:12:54 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id f188-v6sm384314vke.53.2018.10.23.10.12.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Oct 2018 10:12:54 -0700 (PDT)
Subject: Re: [PATCH v3 3/3] reset: warn when refresh_index() takes more than 2
 seconds
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, benpeart@microsoft.com, peff@peff.net,
        sunshine@sunshineco.com
References: <20181017164021.15204-1-peartben@gmail.com>
 <20181022131828.21348-1-peartben@gmail.com>
 <20181022131828.21348-4-peartben@gmail.com>
 <xmqqh8hdtsro.fsf@gitster-ct.c.googlers.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <50195f7a-c452-c784-ab23-d05956d48470@gmail.com>
Date:   Tue, 23 Oct 2018 13:12:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <xmqqh8hdtsro.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 10/22/2018 8:23 PM, Junio C Hamano wrote:
> Ben Peart <peartben@gmail.com> writes:
> 
>> From: Ben Peart <benpeart@microsoft.com>
>>
>> refresh_index() is done after a reset command as an optimization.  Because
>> it can be an expensive call, warn the user if it takes more than 2 seconds
>> and tell them how to avoid it using the --quiet command line option or
>> reset.quiet config setting.
> 
> I am moderately negative on this step.  It will irritate users who
> know about and still choose not to use the "--quiet" option, because
> they want to gain performance in later real work and/or they want to
> know what paths are now dirty.  A working tree that needs long time
> to refresh will take long time to instead do "cached stat info says
> it may be modified so let's run 'diff' for real---we may discover
> that there wasn't any change after all" when a "git diff" is run
> after a "reset --quiet" that does not refresh; i.e. there would be
> valid reasons to run "reset" without "--quiet".
> 
> It feels a bit irresponsible to throw an ad without informing
> pros-and-cons and to pretend that we are advising on BCP.  In
> general, we do *not* advertise new features randomly like this.
> 
> Thanks.  The previous two steps looks quite sensible.
> 

The challenge I'm trying to address is the discoverability of this 
significant performance win.  In earlier review feedback, all mention of 
this option speeding up reset was removed.  I added this patch to enable 
users to find out it even exists as an option.

While I modeled this on the untracked files/--uno and ahead/behind 
logic, I missed adding this to the 'advice' logic so that it can be 
turned off and avoid irritating users.  I'll send an updated patch that 
corrects that.
