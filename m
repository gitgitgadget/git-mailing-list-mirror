Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 640671F462
	for <e@80x24.org>; Wed, 19 Jun 2019 14:26:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729603AbfFSO0Y (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Jun 2019 10:26:24 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33798 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfFSO0X (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Jun 2019 10:26:23 -0400
Received: by mail-qk1-f193.google.com with SMTP id t8so11027632qkt.1
        for <git@vger.kernel.org>; Wed, 19 Jun 2019 07:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=t23b1ujLY3vjBr8hXZxoZhv1jQFPctRaed/IUhGQG7U=;
        b=T/cDeoFRS+95EyMkpN60ZX5MYQWbVwdOAtPvJq9LJ8ifLPQtWsbJ0tCpFYTgchgyTA
         tvf+Tir02LkmjQY1Z7msuuu2TqbZbSOysSr7Y/sD/P5MFE66srzPEWJBHjdyncHMX2Un
         upnVVHgOfWrlbdq/mnEASkMZ3BOgKuKgJT8b6qz1MFG+PRX8V9DlCGb4AK4MWoQ68+Zu
         k19shFEGvLlThatZDvWUmZSzPq2qdQTJJUmdm1qRW2QDPmYp0TsXid1Tv/mEga7cXGD3
         HgUhRsff2fTBuUn4D4s0xihDwf80L+psWCoaD45s2y5279nn08AACqE8JfQ8BcMgDeX+
         0etA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t23b1ujLY3vjBr8hXZxoZhv1jQFPctRaed/IUhGQG7U=;
        b=lT4A0aOuXVFvTF38QgLKTl4twP5244wQ68SnwEgKLxYRHPp1Y2ANWPIkzkiIaSgIgk
         tD1sT3ClpR7hnTbWokSYtXrWcRJWa2PTXkrofoTPVkYRyux/ZkQX3UB1rOgQRIdlINKL
         /jzR09IducnQfoLH/UiujqEmOD9+JeLuoxD+tGEb8p3qsvH4yJ3snkvqD1iFB2T4lMW4
         OTESdJbKmwwaPqsNzxebUraSo2SE8JHTS3qe4UGy9i2ZX4nOeTQZiuHSbcrRHTYQqRRg
         IgBcwj4YB5aap2kBvd9fdGSQrqIBWbLr9Q3NBhM5kZBDE8GvEa0OQ+EKuEmWw/l1H6b9
         tdvQ==
X-Gm-Message-State: APjAAAX0uURzo7PN7PVsH9+oxa7yQTPpzVNqLZ1Ot/FA8vC9cGsXu0fH
        LTx6bjELtjBSAtP/tq6kw2rP/EpQ
X-Google-Smtp-Source: APXvYqydRFgVwiXgl07SxUYtu9UouiyfzRVMOA8k7Hj9zpCVb2H3meglkrWomJdJFPzHseLq46mo/w==
X-Received: by 2002:a37:c408:: with SMTP id d8mr6608353qki.18.1560954381655;
        Wed, 19 Jun 2019 07:26:21 -0700 (PDT)
Received: from [10.0.1.15] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id p23sm9015113qkm.55.2019.06.19.07.26.20
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Jun 2019 07:26:21 -0700 (PDT)
Subject: Re: [PATCH 6/8] read-cache.c: dump "IEOT" extension as json
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <20190619095858.30124-1-pclouds@gmail.com>
 <20190619095858.30124-7-pclouds@gmail.com>
 <8a56ac88-f3b9-c80d-441e-8e74eb64921d@gmail.com>
 <CACsJy8A1Zkkf-QxZSioD61UUj05Xap=f5NJLhOzabVc=dLz25A@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <fd33bf49-3708-63fc-71e3-fe0d599245c2@gmail.com>
Date:   Wed, 19 Jun 2019 10:26:18 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <CACsJy8A1Zkkf-QxZSioD61UUj05Xap=f5NJLhOzabVc=dLz25A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/19/2019 9:24 AM, Duy Nguyen wrote:
> On Wed, Jun 19, 2019 at 8:18 PM Derrick Stolee <stolee@gmail.com> wrote:
>>
>> On 6/19/2019 5:58 AM, Nguyễn Thái Ngọc Duy wrote:> @@ -2266,7 +2271,7 @@ int do_read_index(struct index_state *istate, const char *path, int must_exist)
>>>        * to multi-thread the reading of the cache entries.
>>>        */
>>>       if (extension_offset && nr_threads > 1)
>>> -             ieot = read_ieot_extension(mmap, mmap_size, extension_offset);
>>> +             ieot = read_ieot_extension(mmap, mmap_size, extension_offset, NULL);
>>
>> I tried applying this series on top of v2.22.0 and ran into an issue
>> on this patch, and the message seemed to imply the problem was at this
>> block. I couldn't figure out what was wrong, but maybe the series is
>> based on a different commit?
> 
> it's on 'master', a6a95cd1b4 (The second batch, 2019-06-17). There are
> a couple patches since v2.22.0 that touch read-cache.c, but they don't
> touch these lines explictly...

Thanks, I should have tried from master myself. Starting there worked.
