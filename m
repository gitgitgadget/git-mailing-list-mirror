Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 335A81F461
	for <e@80x24.org>; Tue,  3 Sep 2019 23:36:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfICXgv (ORCPT <rfc822;e@80x24.org>);
        Tue, 3 Sep 2019 19:36:51 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:37593 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727486AbfICXgv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 3 Sep 2019 19:36:51 -0400
Received: by mail-yb1-f196.google.com with SMTP id t5so6622231ybt.4
        for <git@vger.kernel.org>; Tue, 03 Sep 2019 16:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=wU82H3I2nQ4hvb/z9hCgHOYSM6ujl2prGyMAuLSt8VI=;
        b=t00RM5NYdlr96QXD+vUy5sRESuUHTKqhS0vCmeLLPonlumuT+OWGmyyRLpNSKb4yb0
         7qt5Ie06KjRlZDO+cd+qxJgKDP4pbsLl/qr9n1VxOamhElldCoVU/V6nruLwjFV+RjX8
         pv/7O6uWvvlaqtlXwN+QWCxp+sJLar0srAHW08ekwGvARgPy/WTz+VtUZ97HMQYVKhRX
         ZYvKsVNeifibv5JxjHNgGRWoY2CqUWJ/kaxw8Rm6+hUZ7nqGcmxoRYc2KqCB0xM1KN5p
         eusBxquEeUgPbq83pxy1bqwPySi+8/BzmoyJjrkmojl9k6B2lGbF8WiVjfkANVYvutBb
         j2IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=wU82H3I2nQ4hvb/z9hCgHOYSM6ujl2prGyMAuLSt8VI=;
        b=qovxB1FUkh2gcfLQtAMopupz/0e8ypfp+CjXtrNaR29XCuvz1pg/YvX8C4y1q8RqkP
         OGwp3i72ORscVwBSCQhXMjFaVKvPs78Z69zZbtz9BTha5l6y1EPXVCsGU7eyHvjmm6Zd
         /yToMmFepLxEq2P8TFzQezklbD2PTPZdbmhoFHxz/ztafWn5YuC5xL4omiTEzyTLO7uK
         71ODbaTV/hk07U5AUE8XW3nPSQpCGLot03sLT2Hs2gcs0p52UyzpnHHmvmC0crc86S6g
         P9Gp3rLWKwAWBOarm3PPZevXULhEQT4U9jFQAhfattp8xfZnWj9v1Nyrm0Pg336gk1x0
         uQ0A==
X-Gm-Message-State: APjAAAWK4UWwDnOHAnm4QaULAWAZl67/UMvnwGSN8xxCe/XPovGkUA+R
        Y4X1mGNKs3pofpBJyBsAPFU=
X-Google-Smtp-Source: APXvYqxFYtgOOQH1qJFALcM6OEkGmOHWbtlDITnlCOHCwDd8xUeL2COIF5JpVcRRnN6ICfGQ5GXBpg==
X-Received: by 2002:a25:9803:: with SMTP id a3mr26113938ybo.27.1567553809926;
        Tue, 03 Sep 2019 16:36:49 -0700 (PDT)
Received: from [192.168.1.25] ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id l39sm3845748ywh.14.2019.09.03.16.36.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Sep 2019 16:36:49 -0700 (PDT)
Subject: Re: [PATCH 1/1] fetch: add fetch.writeCommitGraph config setting
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com,
        garimasigit@gmail.com, Derrick Stolee <dstolee@microsoft.com>
References: <pull.328.git.gitgitgadget@gmail.com>
 <49f877c85ca2be5bb76d9082ee4aa26e26111a14.1567477320.git.gitgitgadget@gmail.com>
 <xmqqef0xtd3p.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d550ac23-cb65-b547-d9dc-1428ee2e9420@gmail.com>
Date:   Tue, 3 Sep 2019 19:36:48 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:69.0) Gecko/20100101
 Thunderbird/69.0
MIME-Version: 1.0
In-Reply-To: <xmqqef0xtd3p.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/3/2019 3:05 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> diff --git a/builtin/fetch.c b/builtin/fetch.c
>> index 53ce99d2bb..d36a403859 100644
>> --- a/builtin/fetch.c
>> +++ b/builtin/fetch.c
>> @@ -23,6 +23,7 @@
>>  #include "packfile.h"
>>  #include "list-objects-filter-options.h"
>>  #include "commit-reach.h"
>> +#include "commit-graph.h"
>>  
>>  #define FORCED_UPDATES_DELAY_WARNING_IN_MS (10 * 1000)
>>  
>> @@ -1715,6 +1716,20 @@ int cmd_fetch(int argc, const char **argv, const char *prefix)
>>  
>>  	string_list_clear(&list, 0);
>>  
>> +	prepare_repo_settings(the_repository);
>> +	if (the_repository->settings.fetch_write_commit_graph) {
>> +		int commit_graph_flags = COMMIT_GRAPH_SPLIT;
>> +		struct split_commit_graph_opts split_opts;
>> +		memset(&split_opts, 0, sizeof(struct split_commit_graph_opts));
>> +
>> +		if (progress)
>> +			commit_graph_flags |= COMMIT_GRAPH_PROGRESS;
>> +
>> +		write_commit_graph_reachable(get_object_directory(),
>> +					     commit_graph_flags,
>> +					     &split_opts);
>> +	}
> 
> As a low-impact change this is good.  
> 
> For longer term, it feels a bit unfortunate that this is still a
> separate phase of the program, though.  We know what new refs we
> added, we know what new objects we received, and we even scanned
> each and every one of them while running the index-pack step to
> store the .pack and compute the .idx file, i.e. it feels that we
> have most of the information already in-core to extend the commit
> graph for new parts of the history we just received.

You're right that we could isolate the new write to the refs we
just received. We could use the more cumbersome write_commit_graph()
method with a list of commit oids as starting points. I'm happy to
make that change if we see a lot of value there.

However, the current patch also gives us a way to add local refs
to the commit graph and "catch up" to the work the user had done.
With this in mind, I do think the simpler code has another functional
advantage.

Thanks,
-Stolee

