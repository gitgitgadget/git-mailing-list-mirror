Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD66A1F45F
	for <e@80x24.org>; Wed,  8 May 2019 15:52:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726992AbfEHPwu (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 11:52:50 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:43741 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbfEHPwu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 11:52:50 -0400
Received: by mail-qt1-f194.google.com with SMTP id r3so13882390qtp.10
        for <git@vger.kernel.org>; Wed, 08 May 2019 08:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=O/aDiSuabA1UT37pqiZvNnDJtwV7VDCXoIckMsQFjk0=;
        b=DB48ugNRFe2qcEC8JO63VpC6po9oedRiKmtldDYZw/9rAI4WzujGL1/Jm/5UY90ON2
         zQsArDXzQpiGGlzmENHhEOa8eMlQrG9ir8F8EgKd1qXQ1ICNGiLtqQ33Kre6EgW+an3B
         dWMlmdXifQoVJvyi327eo32fE/Mic+ExA864HLyqJG82e0ZUhskzkX9PCs8N2xYdYxht
         NAyd7E9WkMYZ7ll+8UuJlC9kZeGjUy6OJTKzJjBZ7ZeNeqoZnvuFsg1v7JOZmIfSvyl0
         UPzp+V3+uhZ9IoQwh3Ta7JzZWHu0xAgeuyZDrrhOm9aovX26zHO9d+zn9BsYqjbdrmKZ
         PclQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=O/aDiSuabA1UT37pqiZvNnDJtwV7VDCXoIckMsQFjk0=;
        b=PimNEj2CQx1Dnx40XMOqk57DTEfieKUmayUtNgh81HCDnVkkQn4aobYx20Y10OeTn4
         Oj8YnvpahMmhxDf/DWZIafkzZhceZ9DVYydkkLUy3/UyK9QZgp1Xpno4occgqHuEbUgu
         PSKL/3vl0yEjnOR/KTpxH6tiQPxYCSumxjWSeKikrk1APowoz8pYqJDTruQ1YWVX0lz0
         sGS5x9sXYm9+n0+ISAWyQlsYI5cpdIlO3UOfo4vR4QDS6TCu+yQLU83hsLY7vCd588FX
         J60dSK/T0ylIkBsRfgWtbLyGIAMnxaMSwmYTdIDpKZqFEnye5DzPte5pKTIOgzJLDUTO
         Iohg==
X-Gm-Message-State: APjAAAVInHEGeTJjeb0jBYFf2gQZ21I/25ZvwtgjKHv+XD8I8IknQPwp
        oYbRlfm6E8VnzZfSTIFx264MNq0ZQNk=
X-Google-Smtp-Source: APXvYqxWup5azo9lsacQWlUMyiahJYlSh1QqmYbdDIgvUxSdI/OpPoncGeVfyzfe9lJty/mTzI06oQ==
X-Received: by 2002:ac8:7082:: with SMTP id y2mr21736582qto.329.1557330768863;
        Wed, 08 May 2019 08:52:48 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:99f3:ebb2:d83a:c7d8? ([2001:4898:8010:0:8329:ebb2:d83a:c7d8])
        by smtp.gmail.com with ESMTPSA id n66sm9298733qkc.36.2019.05.08.08.52.47
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 08:52:48 -0700 (PDT)
Subject: Re: [PATCH 01/19] revision.h: avoid bit fields in struct rev_info
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20190508111249.15262-1-pclouds@gmail.com>
 <20190508111249.15262-2-pclouds@gmail.com>
 <0509589b-7a92-6c05-e404-65a9b2bf5666@gmail.com>
 <CACsJy8DEjBS-aiWqDe2AU56rJBVZ4Po6c-C7GxR4QDNiGSiZoQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d018ea8c-6f7f-1587-d56b-af3225d6cf0b@gmail.com>
Date:   Wed, 8 May 2019 11:52:47 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8DEjBS-aiWqDe2AU56rJBVZ4Po6c-C7GxR4QDNiGSiZoQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/8/2019 10:41 AM, Duy Nguyen wrote:
> On Wed, May 8, 2019 at 9:07 PM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 5/8/2019 7:12 AM, Nguyễn Thái Ngọc Duy wrote:
>>> Bitfield addresses cannot be passed around in a pointer. This makes it
>>> hard to use parse-options to set/unset them. Turn this struct to
>>> normal integers. This of course increases the size of this struct
>>> multiple times, but since we only have a handful of rev_info variables
>>> around, memory consumption is not at all a concern.
>>
>> I think you are right that this memory trade-off shouldn't be a problem.
>>
>> What worries me instead is that we are using an "internal" data structure
>> for option parsing. Would it make more sense to create a struct for use
>> in the parse_opts method and a method that translates those options into
>> the bitfield in struct rev_info?
> 
> But we are doing that now (option parsing) using the same data
> structure. Why would changing from a custom parser to parse_options()
> affect what fields it should or should not touch in rev_info? Genuine
> question. Maybe you could elaborate more about "internal". I probably
> missed something. Or maybe this is a good opportunity to separate
> intermediate option parsing variables from the rest of rev_info?

You're right. I was unclear.

rev_info stores a lot of data. Some of the fields are important
in-memory structures that are crucial to the workings of revision.c
and are never used by builtin/rev-list.c. Combining this purpose
with the option parsing seems smelly to me.

Thinking more on it, I would prefer a more invasive change that may
pay off in the long term. These options, along with the "starting list"
values, could be extracted to a 'struct rev_options' that contains these
integers and the commit list. Then your option parsing changes could be
limited to a rev_options struct, which is later inserted into a rev_info
struct during setup_revisions().

Generally, the rev_info struct has too many members and could be split
into smaller pieces according to purpose. I created the topo_walk_info
struct as a way to not make the situation worse, but doesn't fix existing
pain.

My ramblings are mostly complaining about old code that grew organically
across many many quality additions. It is definitely hard to understand
the revision-walking code, and perhaps it would be easier to understand
with a little more structure.

The biggest issue with my suggestion is that it requires changing the
consumers of the options, as they would no longer live directly on the
rev_info struct. That would be a big change, even if it could be done
with string replacement.

Thanks,
-Stolee 
