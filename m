Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7DBDB1F453
	for <e@80x24.org>; Fri,  3 May 2019 15:12:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728182AbfECPMB (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 11:12:01 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:37921 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbfECPMB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 11:12:01 -0400
Received: by mail-qt1-f196.google.com with SMTP id d13so7082958qth.5
        for <git@vger.kernel.org>; Fri, 03 May 2019 08:11:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KhImMBDu0XVtSnPoyxOiumkOcQy0GRjNRfjBKsDNTzo=;
        b=uu/i2nG72O17Uaj9kr8QPKbD8p0rGEGttr+ttPEQxMUgqM1Iqb4N7Y0j/f1aETFb/K
         QU+t1eYLYSpvZYOnpsDLChXE1RwmvrEgwQdIUgHbTooUff0LTpvoE5lAfL0FJmSV3ryY
         o8i2QwcfTrRQAAamGdiSrKKwh2jyJXMhRu7J++TB3pN316Z63QuCB1oTjCceODRbOTQI
         wHdJWvkAcggVdq/LNGcvy7/HgDhLpKv6G5CQrm095DMy+bvbIvn/vnKKyed/oWe65Zri
         WugF2hNtL7oPJ9e07yOq3f255h5DEcADL/EKOc4Jf2cNVCBWpjLIrsihvWB/CeIL0Vk7
         R4zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KhImMBDu0XVtSnPoyxOiumkOcQy0GRjNRfjBKsDNTzo=;
        b=CGINawYg1ZW6y6QfYQmqkyc9jsagCVCaRmH+AgXdtiXlDHZz0+64yO+c3ZBJUo+Vjs
         ChIHjcHqQRjlw/yezLDqg1fc6vgG2GBx8t5QQV1B0tM7ZxoSjAeWnKxJH6yEz3Bds7VA
         ajVAuNvhRSGiXGUQzQnIiN2enDkNIvxTXq5R22DJV6AUWHDPkBGg0RP7+lvxomFCfvap
         piINlH8HTDtxqzXTfscIqSeX8ft65Oz9jI9q2DAygNp7GwPggxXTEwLJ4fPNjrF0YIdB
         nqAHA3yNVUNP+venYgo/lFNSQNRr5YtsLNXVvEewTON3q+QkK9VYscDUbBSPvOTESl1j
         WtQw==
X-Gm-Message-State: APjAAAUk5wn7Pv/yKNqS5pU0xVkGQf9M3nhv6qoyO31fHh77DhHy8obk
        GXMxywAv+NtfR9y4ZyCfgsI=
X-Google-Smtp-Source: APXvYqxfWsKYdBDTEK7neZ4BV0W3vVwwlY7Xypyym7I1O4r0SgnDuTRBsi3evmnwMAuA5VGzmeb7wQ==
X-Received: by 2002:ac8:1ae1:: with SMTP id h30mr8656735qtk.208.1556896299001;
        Fri, 03 May 2019 08:11:39 -0700 (PDT)
Received: from [10.0.1.13] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id n201sm1217984qka.10.2019.05.03.08.11.37
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 08:11:37 -0700 (PDT)
Subject: Re: [PATCH v3 0/6] Create commit-graph file format v2
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, sandals@crustytoothpaste.net,
        Junio C Hamano <gitster@pobox.com>
References: <pull.112.v2.git.gitgitgadget@gmail.com>
 <pull.112.v3.git.gitgitgadget@gmail.com> <87lfzprkfc.fsf@evledraar.gmail.com>
 <bb0c22f9-9d0b-0fa6-e826-8e2ac146c6f9@gmail.com>
 <87h8acivkh.fsf@evledraar.gmail.com>
 <04ac97c5-ab2b-2b23-4c84-8ed8aab0e2f5@gmail.com>
 <20190503141613.GG14763@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <284b3398-0b7f-c51b-3417-af7ab521cf9d@gmail.com>
Date:   Fri, 3 May 2019 11:11:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:67.0) Gecko/20100101
 Thunderbird/67.0
MIME-Version: 1.0
In-Reply-To: <20190503141613.GG14763@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/3/2019 10:16 AM, SZEDER Gábor wrote:
> On Fri, May 03, 2019 at 08:47:25AM -0400, Derrick Stolee wrote:
>> It would be much simpler to restrict the model. Your idea of changing
>> the file name is the inspiration here.
>>
>> * The "commit-graph" file is the base commit graph. It is always
>>   closed under reachability (if a commit exists in this file, then
>>   its parents are also in this file). We will also consider this to
>>   be "commit-graph-0".
>>
>> * A commit-graph-<N> exists, then we check for the existence of
>>   commit-graph-<N+1>. This file can contain commits whose parents
>>   are in any smaller file.
>>
>> I think this resolves the issue of back-compat without updating
>> the file format:
>>
>> 1. Old clients will never look at commit-graph-N, so they will
>>    never complain about an "incomplete" file.
>>
>> 2. If we always open a read handle as we move up the list, then
>>    a "merge and collapse" write to commit-graph-N will not
>>    interrupt an existing process reading that file.
> 
> What if a process reading the commit-graph files runs short on file
> descriptors and has to close some of them, while a second process is
> merging commit-graph files?

We will want to keep the number small so we never recycle the file
handles. Instead, we will keep them open for the entire process.

The strategies for creating these graphs should include a "merge"
strategy that keeps the number of commit-graph files very small
(fewer than 5 should be sufficient).
 
>> I'll start hacking on this model.
> 
> Have fun! :)
> 
> 
> Semi-related, but I'm curious:  what are your plans for 'struct
> commit's 'graph_pos' field, and how will it work with multiple
> commit-graph files?

Since we have a predefined "sequence" of graphs, the graph_pos
will be the position in the "meta-order" given by concatenating
the commit lists from each commit-graph. We then navigate to a commit
in O(num graphs) instead of O(1).

In the commit-graph format, we will use this "meta-order" number
to refer to parent positions.

> In particular: currently we use this 'graph_pos' field as an index
> into the Commit Data chunk to find the metadata associated with a
> given commit object.  But we could add any commit-specific metadata in
> a new chunk, being an array ordered by commit OID, and then use
> 'graph_pos' as an index into this chunk as well.  I find this quite
> convenient.  However, with mulitple commit-graph files there will be
> multiple arrays...

Yes, this will continue to be useful*. To find the position inside
a specific commit-graph-N file, take the graph_pos and subtract the
number of commits in the "lower" commit-graph files.

* For example, this meta-data information is necessary for the Bloom
filter data [1].

Thanks,
-Stolee

[1] https://public-inbox.org/git/61559c5b-546e-d61b-d2e1-68de692f5972@gmail.com/
