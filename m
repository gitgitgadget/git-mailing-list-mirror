Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B39631F453
	for <e@80x24.org>; Sun, 27 Jan 2019 18:40:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726888AbfA0Skg (ORCPT <rfc822;e@80x24.org>);
        Sun, 27 Jan 2019 13:40:36 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:35877 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726630AbfA0Skg (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Jan 2019 13:40:36 -0500
Received: by mail-qk1-f195.google.com with SMTP id o125so8248868qkf.3
        for <git@vger.kernel.org>; Sun, 27 Jan 2019 10:40:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=w1GBDEiL0KMSw/WrvWvj3F+q8oDqAT0WqnoL5grXXvE=;
        b=jgLbg1qQXdEhM1lFjhqNMIBpj95af8dcngQSfh1Kt97pCXPeJKvG9R+pq0dbTiZfUg
         CFzmsoeYLwBFRhHLr1ghWXInyHWzOA6y/MYC20ZcfPcuwPOxdl+lTyOejvfCvYvcq8w9
         2DAiCc8Ncda3bEycSpk63CsW7XkA4SFe87+CygAYhLYxBD19tjU/baB/zu/jM1vNImvQ
         B4pZMw5XHsPECfzmxEOcKBsWa7k7M0/pVEyolXGA9gnkjZc2JirEB7nUGhpMjBe20rP4
         g96Uinmt0j4xWlAXQNBkRXG4oVfUQ0hhBEe01CopoMC5ADnZ+aB178wwO99p+KLEdCw+
         L92Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=w1GBDEiL0KMSw/WrvWvj3F+q8oDqAT0WqnoL5grXXvE=;
        b=CWlq8KzT6oo8L1CgIdMxqlni8dj9J+CgiSqgd646vJEn6ERXazpuudIekVwirVSe0l
         3XxEWyqEI7xahbQaxd83gwtWv8m6uIKqsF36+Rh1MiUtw6jP9egG0BvdylStuSnEzRam
         /22j9UaHRM9/lMZq2C3j0FauACpN/ICbP30cJ7EmUr10hw5R6oltP92ion7M60TWZ5TV
         nupeHKBHnRHdhHeB/uSTBZmTZxRdIE4CCVCT4L3UQy5hqpV7JR1mTR4kmF63Jl/IsJUu
         u28vMCUhzWYDQT7yBBhaIfTogyPLVd90IAdodmaeIJvvJMpJlfSiHMFQGhjHlKXZb2wE
         R2Nw==
X-Gm-Message-State: AJcUukcOPA1r4Rq/iJOHQZggGPybwyw52Y/aRH9D5dApF9HQUQhdCq4O
        1R0V8BaiEHCIQBeji6lIP+A=
X-Google-Smtp-Source: ALg8bN6CI6vz27qdrHdMjtDyDXGjblTmMg3fecCVsn0wIGNp7BBmBVmGE5ICOaY3loJdAROoVt7iQg==
X-Received: by 2002:a37:4042:: with SMTP id n63mr16560205qka.153.1548614434868;
        Sun, 27 Jan 2019 10:40:34 -0800 (PST)
Received: from [10.0.1.23] ([98.122.160.2])
        by smtp.gmail.com with ESMTPSA id v2sm59916599qte.75.2019.01.27.10.40.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Jan 2019 10:40:34 -0800 (PST)
Subject: Re: [PATCH] object_as_type: initialize commit-graph-related fields of
 'struct commit'
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
References: <20190125222126.GH6702@szeder.dev>
 <20190127130832.23652-1-szeder.dev@gmail.com>
 <20190127132854.GI6702@szeder.dev>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <ae9229c7-926c-fb55-4d1d-658c8b6acfc4@gmail.com>
Date:   Sun, 27 Jan 2019 13:40:33 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:65.0) Gecko/20100101
 Thunderbird/65.0
MIME-Version: 1.0
In-Reply-To: <20190127132854.GI6702@szeder.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/27/2019 8:28 AM, SZEDER Gábor wrote:
> On Sun, Jan 27, 2019 at 02:08:32PM +0100, SZEDER Gábor wrote:
>> When the commit graph and generation numbers were introduced in
>> commits 177722b344 (commit: integrate commit graph with commit
>> parsing, 2018-04-10) and 83073cc994 (commit: add generation number to
>> struct commit, 2018-04-25), they tried to make sure that the
>> corresponding 'graph_pos' and 'generation' fields of 'struct commit'
>> are initialized conservatively, as if the commit were not included in
>> the commit-graph file.
>>
>> Alas, initializing those fields only in alloc_commit_node() missed the
>> case when an object that happens to be a commit is first looked up via
>> lookup_unknown_object(), and is then later converted to a 'struct
>> commit' via the object_as_type() helper function (either calling it
>> directly, or as part of a subsequent lookup_commit() call).
>> Consequently, both of those fields incorrectly remain set to zero,
>> which means e.g. that the commit is present in and is the first entry
>> of the commit-graph file.  This will result in wrong timestamp, parent
>> and root tree hashes, if such a 'struct commit' instance is later
>> filled from the commit-graph.
>>
>> Extract the initialization of 'struct commit's fields from
>> alloc_commit_node() into a helper function, and call it from
>> object_as_type() as well, to make sure that it properly initializes
>> the two commit-graph-related fields, too.  With this helper function
>> it is hopefully less likely that any new fields added to 'struct
>> commit' in the future would remain uninitialized.
>>
>> With this change alloc_commit_index() won't have any remaining callers
>> outside of 'alloc.c', so mark it as static.
>>
>> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
>> ---
>>
>> So, it turns out that ec0c5798ee (revision: use commit graph in
>> get_reference(), 2018-12-04) is not the culprit after all, it merely
>> highlighted a bug that is as old as the commit-graph feature itself.
>> This patch fixes this and all other related issues I reported
>> upthread.
> 
> And how/why does this affect 'git describe --dirty'?
> 
>   - 'git describe' first iterates over all refs, and somewhere deep
>     inside for_each_ref() each commit (well, object) a ref points to
>     is looked up via lookup_unknown_object().  This leaves all fields
>     of the created object zero initialized.
> 
>   - Then it dereferences HEAD for '--dirty' and ec0c5798ee's changes
>     to get_reference() kick in: lookup_commit() doesn't instantiate a
>     brand new and freshly initialized 'struct commit', but returns the
>     object created in the previous step converted into 'struct
>     commit'.  This conversion doesn't set the commit-graph fields in
>     'struct commit', but leaves both as zero.  get_reference() then
>     tries to load HEAD's commit information from the commit-graph,
>     find_commit_in_graph() sees the the still zero 'graph_pos' field
>     and doesn't perform a search through the commit-graph file, and
>     the subsequent fill_commit_in_graph() reads the commit info from
>     the first entry.
> 
>     In case of the failing test I posted earlier, where only the first
>     commit is in the commit-graph but HEAD isn't, this means that the
>     HEAD's 'struct commit' is filled with the info of HEAD^.
> 
>   - Ultimately, the diff machinery then doesn't compare the worktree
>     to HEAD's tree, but to HEAD^'s, finds that they differ, hence the
>     incorrect '-dirty' flag in the output.
> 
> Before ec0c5798ee get_reference() simply called parse_object(), which
> ignored the commit-graph, so the issue could remain hidden.

Thanks for digging in, Szeder. This is a very subtle interaction, and
I'm glad you caught the issue. There are likely other ways this could
become problematic, including hitting BUG() statements regarding
generation numbers.

I recommend this be merged to 'maint' if possible.

Thanks,
-Stolee

