Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 190921F597
	for <e@80x24.org>; Mon, 23 Jul 2018 20:51:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388236AbeGWVyi (ORCPT <rfc822;e@80x24.org>);
        Mon, 23 Jul 2018 17:54:38 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35639 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388178AbeGWVyi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jul 2018 17:54:38 -0400
Received: by mail-qt0-f194.google.com with SMTP id a5-v6so2070144qtp.2
        for <git@vger.kernel.org>; Mon, 23 Jul 2018 13:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OLVNSobveONpr0ltnQZicJas3Kdw+slZghlJPyj8In4=;
        b=c4y58RrLo87gCF65LJkwHWIPknkGkgfP/8Nu7WF6N7buTwiJiXhm/unWkFgi028Sqn
         nJLSufrtQGo3v2o3PY5xIQUNdUmMjzkL24YfGoJssmV+EovzVhDQRucR1Iki4b6++qu6
         ZgALKEMniR9LUAWB9A5KeNqFmsVjew291WyS2wXDcclCr/h5a7NuDpZilbVmBBCkcso0
         MCku7ds3LbCVOpr8OcmZaTpYu639ya89qVI7bd+wWIDMd1YLkrDhaekDYFUVhU8L+CZx
         gkDM8SpEN64uO9lu43xlSP6OCm0ZeoZGruF79gYDq9PRYgBnnBkTZNZh1Gy3oqdNeOds
         nwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OLVNSobveONpr0ltnQZicJas3Kdw+slZghlJPyj8In4=;
        b=obxsQdhx4jriIObQ/VvIANBM4dY7TBC/wGL8andcuMoXp27I5PETVnt3TBwhRq7E47
         5tlmmb9ABpMQT5NbZgIrTiqomNLzUtMHQF57aZSVWc9skCH+ZSHLtQ0xt9MW7wZ6jaZ7
         ik+7W5lr2o9ZIqSf6WWGmW5pvsip34k+NFoOmBEHi0SCmw9EGecTBA87IAS/AC6YO5VG
         7MaM2d9NvXkwnoDIrrMkSNeDryKZWZ/z6N2xadGTaa0aHJ4EaLY/hJy9wrqrQBapekwU
         UfL3BuSERTCaqaMSOvJk5Ch32Rt5Bo4xlnBiGEFzIG4zmV9JW08zYGsmjo8SuxrzJd/b
         LDbw==
X-Gm-Message-State: AOUpUlHp1hm70gPtU6k74rJh1KfLGUyOXvyKDwpuy0k+hVJsP+fCe7lp
        zX2vz74ELLk85uEKgmF7GSgI9BvU
X-Google-Smtp-Source: AAOMgpc8DdDtKlPpC4QL9SBd+MGQf06Kuh16XYHKg9LgLarDzTLr8VuIN/VzsrW8RlXEr6Qc5QDGww==
X-Received: by 2002:a0c:d4a9:: with SMTP id u38-v6mr12499555qvh.112.1532379099524;
        Mon, 23 Jul 2018 13:51:39 -0700 (PDT)
Received: from [192.168.1.97] (70-33-148-227.unassigned.ntelos.net. [70.33.148.227])
        by smtp.gmail.com with ESMTPSA id j5-v6sm4799327qtb.34.2018.07.23.13.51.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Jul 2018 13:51:38 -0700 (PDT)
Subject: Re: [PATCH v1 0/3] [RFC] Speeding up checkout (and merge, rebase,
 etc)
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20180718204458.20936-1-benpeart@microsoft.com>
 <20180718213420.GA17291@sigill.intra.peff.net>
 <a2ad0044-f317-69f7-f2bb-488111c626fb@gmail.com>
 <CACsJy8D-3sSnoyQZKxeLK-2RmpJSGkziAp5Gf4QpUnxwnhchSQ@mail.gmail.com>
From:   Ben Peart <peartben@gmail.com>
Message-ID: <6ff6fbdc-d9cf-019f-317c-7fdba31105c6@gmail.com>
Date:   Mon, 23 Jul 2018 16:51:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CACsJy8D-3sSnoyQZKxeLK-2RmpJSGkziAp5Gf4QpUnxwnhchSQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/23/2018 1:03 PM, Duy Nguyen wrote:
> On Mon, Jul 23, 2018 at 5:50 PM Ben Peart <peartben@gmail.com> wrote:
>>> Anyway, on to the actual discussion:
>>>
>>>> Here is a checkout command with tracing turned on to demonstrate where the
>>>> time is spent.  Note, this is somewhat of a �best case� as I�m simply
>>>> checking out the current commit:
>>>>
>>>> benpeart@gvfs-perf MINGW64 /f/os/src (official/rs_es_debug_dev)
>>>> $ /usr/src/git/git.exe checkout
>>>> 12:31:50.419016 read-cache.c:2006       performance: 1.180966800 s: read cache .git/index
>>>> 12:31:51.184636 name-hash.c:605         performance: 0.664575200 s: initialize name hash
>>>> 12:31:51.200280 preload-index.c:111     performance: 0.019811600 s: preload index
>>>> 12:31:51.294012 read-cache.c:1543       performance: 0.094515600 s: refresh index
>>>> 12:32:29.731344 unpack-trees.c:1358     performance: 33.889840200 s: traverse_trees
>>>> 12:32:37.512555 read-cache.c:2541       performance: 1.564438300 s: write index, changed mask = 28
>>>> 12:32:44.918730 unpack-trees.c:1358     performance: 7.243155600 s: traverse_trees
>>>> 12:32:44.965611 diff-lib.c:527          performance: 7.374729200 s: diff-index
>>>> Waiting for GVFS to parse index and update placeholder files...Succeeded
>>>> 12:32:46.824986 trace.c:420             performance: 57.715656000 s: git command: 'C:\git-sdk-64\usr\src\git\git.exe' checkout
>>>
>>> What's the current state of the index before this checkout?
>>
>> This was after running "git checkout" multiple times so there was really
>> nothing for git to do.
> 
> Hmm.. this means cache-tree is fully valid, unless you have changes in
> index. We're quite aggressive in repairing cache-tree since aecf567cbf
> (cache-tree: create/update cache-tree on checkout - 2014-07-05). If we
> have very good cache-tree records and still spend 33s on
> traverse_trees, maybe there's something else.
> 

I'm not at all familiar with the cache-tree and couldn't find any 
documentation on it other than index-format.txt which says "it helps 
speed up tree object generation for a new commit."  In this particular 
case, no new commit is being created so I don't know that the cache-tree 
would help.

After a quick look at the code, the only place I can find that tries to 
use cache_tree_matches_traversal() is in unpack_callback() and that only 
happens if n == 1 and in the "git checkout" case, n == 2. Am I missing 
something?
