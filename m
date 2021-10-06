Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61D66C433FE
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 14:03:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3AE5F6105A
	for <git@archiver.kernel.org>; Wed,  6 Oct 2021 14:03:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238801AbhJFOFL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Oct 2021 10:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238586AbhJFOFK (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Oct 2021 10:05:10 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8519FC061753
        for <git@vger.kernel.org>; Wed,  6 Oct 2021 07:03:18 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id r18so9215860wrg.6
        for <git@vger.kernel.org>; Wed, 06 Oct 2021 07:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3OWfWzfeUZnb+vR4X6FSK73O7mZz3RvlAiSFXkM4WjM=;
        b=Nl45bp8mYw52WAeeZaPCB/xh00hZNb/J44oo4aJAf8szE9ln1XwG9QnC5WAu8UuM95
         fm7PH/AHQUqEnmPnTrk6q5vBbXPVvcpJc7J4Nvhb2OvEOCA6fqo2TrTUGOgQM0ZipxrR
         yC9IVmtt2VQH5JsiaHexsIszZK1zzOD18PyYEjCFrC96KuBcbq5hDo0TNge4RX03xnMV
         gJvrRROxzZTrjDaL39NKtW2Bh8WPEQvT/d4KrV2Yw7JPQuXqmeNroscpqHWMy5pFCkHz
         yrLoK91ENApQE+gANjufc3B1lSxkz9NEioU7vbPJXofK1aOksjA0c5KUHzMhwGSO9k5g
         kggg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3OWfWzfeUZnb+vR4X6FSK73O7mZz3RvlAiSFXkM4WjM=;
        b=O9jRAtzwWPBYQfVxdEIjSDN6CMa9xB8KIEDa+9DoPMoZU1LbNl5atnIJqHl4d1gQU9
         hfW95Ye+9PY+YYmOMcViSchpEj4NV5ilVcgc++t/NirH4deZuxgMuoUK9TmDhmM5HyBL
         iP+H4X01KJ3I9zUvX3pXm+50bEHLXp116ziGm7mmwDsR6pjy8pjGJlwpw9e9+60jDTHF
         6GztLGpT6vIfHR/pBRKi9DqHNSDZd/Qlwrm3GDVjaCha8dkAd21B607YhZfUgLsr6QwU
         lpc+Pgzek58A2hEPzq1xji0Kyzu7bK2F6G3ELFzilHbHGtuYoeXPiZD0UQ2ZzEg4RpvM
         2YGQ==
X-Gm-Message-State: AOAM533RWxZw6wQu6UtS8L9BwxAzaUMc9ga4w1lcguz/eLiu9Ozejgjn
        LKIkk8nuBzQOwcuhD/YZaEE=
X-Google-Smtp-Source: ABdhPJyk8NyzLL1toxdDcF7DQgRvpDaZ7Zl0b8tTNE8IqcRQVsHlBC82uTtuSM4trGzg1daXM4AzTQ==
X-Received: by 2002:a5d:6dce:: with SMTP id d14mr29881601wrz.363.1633528997096;
        Wed, 06 Oct 2021 07:03:17 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id k9sm20733172wrz.22.2021.10.06.07.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Oct 2021 07:03:16 -0700 (PDT)
Message-ID: <04cdeb7c-4469-7036-40f4-87543e729026@gmail.com>
Date:   Wed, 6 Oct 2021 15:03:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 00/11] rebase: reset_head() related fixes and improvements
Content-Language: en-GB-large
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        phillip.wood@dunelm.org.uk, Junio C Hamano <gitster@pobox.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
 <xmqqbl482rby.fsf@gitster.g> <xmqq4ka02fc4.fsf@gitster.g>
 <ddf5e9c2-3211-cec2-cd18-2a083e279ccb@gmail.com>
 <5af2ddb1-0330-a987-9887-14331f6ea006@web.de>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <5af2ddb1-0330-a987-9887-14331f6ea006@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi René

On 02/10/2021 14:38, René Scharfe wrote:
>[..]
>> ==74345==ERROR: AddressSanitizer: heap-use-after-free on address 0x606000001b20 at pc 0x557cbe82d3a2 bp 0x7ffdfee08090 sp 0x7ffdfee08080
>> READ of size 4 at 0x606000001b20 thread T0
>>      #0 0x557cbe82d3a1 in verify_one /home/phil/src/git/cache-tree.c:863
>>      #1 0x557cbe82ca9d in verify_one /home/phil/src/git/cache-tree.c:840
>>      #2 0x557cbe82ca9d in verify_one /home/phil/src/git/cache-tree.c:840
>>      #3 0x557cbe82ca9d in verify_one /home/phil/src/git/cache-tree.c:840
>>      #4 0x557cbe830a2b in cache_tree_verify /home/phil/src/git/cache-tree.c:910
>>      #5 0x557cbea53741 in write_locked_index /home/phil/src/git/read-cache.c:3250
>>      #6 0x557cbeab7fdd in reset_head /home/phil/src/git/reset.c:87
>>      #7 0x557cbe72147f in cmd_rebase builtin/rebase.c:2074
>>      #8 0x557cbe5bd151 in run_builtin /home/phil/src/git/git.c:461
>>      #9 0x557cbe5bd151 in handle_builtin /home/phil/src/git/git.c:714
>>      #10 0x557cbe5c0503 in run_argv /home/phil/src/git/git.c:781
>>      #11 0x557cbe5c0503 in cmd_main /home/phil/src/git/git.c:912
>>      #12 0x557cbe5bad28 in main /home/phil/src/git/common-main.c:52
>>      #13 0x7fdd4b82eb24 in __libc_start_main (/usr/lib/libc.so.6+0x27b24)
>>      #14 0x557cbe5bcb8d in _start (/home/phil/src/git/git+0x1b9b8d)
>>
>> 0x606000001b20 is located 0 bytes inside of 56-byte region [0x606000001b20,0x606000001b58)
>> freed by thread T0 here:
>>      #0 0x7fdd4bacff19 in __interceptor_free /build/gcc/src/gcc/libsanitizer/asan/asan_malloc_linux.cpp:127
>>      #1 0x557cbe82af60 in cache_tree_free /home/phil/src/git/cache-tree.c:35
>>      #2 0x557cbe82aee5 in cache_tree_free /home/phil/src/git/cache-tree.c:31
>>      #3 0x557cbe82aee5 in cache_tree_free /home/phil/src/git/cache-tree.c:31
>>      #4 0x557cbe82aee5 in cache_tree_free /home/phil/src/git/cache-tree.c:31
>>      #5 0x557cbeb2557a in ensure_full_index /home/phil/src/git/sparse-index.c:310
>>      #6 0x557cbea45c4a in index_name_stage_pos /home/phil/src/git/read-cache.c:588
>>      #7 0x557cbe82ce37 in verify_one /home/phil/src/git/cache-tree.c:850
>>      #8 0x557cbe82ca9d in verify_one /home/phil/src/git/cache-tree.c:840
>>      #9 0x557cbe82ca9d in verify_one /home/phil/src/git/cache-tree.c:840
>>      #10 0x557cbe82ca9d in verify_one /home/phil/src/git/cache-tree.c:840
>>      #11 0x557cbe830a2b in cache_tree_verify /home/phil/src/git/cache-tree.c:910
> 
> Looks like cache_tree_verify() indirectly triggered ensure_full_index(),
> which throws the cache_tree away, then kept going using stale pointers.
> It should instead stop and start over in such a case, no?

Thanks for that, I found it really helpful

Best Wishes

Phillip

>>      #12 0x557cbea53741 in write_locked_index /home/phil/src/git/read-cache.c:3250
>>      #13 0x557cbeab7fdd in reset_head /home/phil/src/git/reset.c:87
>>      #14 0x557cbe72147f in cmd_rebase builtin/rebase.c:2074
>>      #15 0x557cbe5bd151 in run_builtin /home/phil/src/git/git.c:461
>>      #16 0x557cbe5bd151 in handle_builtin /home/phil/src/git/git.c:714
>>      #17 0x557cbe5c0503 in run_argv /home/phil/src/git/git.c:781
>>      #18 0x557cbe5c0503 in cmd_main /home/phil/src/git/git.c:912
>>      #19 0x557cbe5bad28 in main /home/phil/src/git/common-main.c:52
>>      #20 0x7fdd4b82eb24 in __libc_start_main (/usr/lib/libc.so.6+0x27b24)
>>
>> previously allocated by thread T0 here:
>>      #0 0x7fdd4bad0459 in __interceptor_calloc /build/gcc/src/gcc/libsanitizer/asan/asan_malloc_linux.cpp:154
>>      #1 0x557cbebc1807 in xcalloc /home/phil/src/git/wrapper.c:140
>>      #2 0x557cbe82b7d8 in cache_tree /home/phil/src/git/cache-tree.c:17
>>      #3 0x557cbe82b7d8 in prime_cache_tree_rec /home/phil/src/git/cache-tree.c:763
>>      #4 0x557cbe82b837 in prime_cache_tree_rec /home/phil/src/git/cache-tree.c:764
>>      #5 0x557cbe82b837 in prime_cache_tree_rec /home/phil/src/git/cache-tree.c:764
>>      #6 0x557cbe8304e1 in prime_cache_tree /home/phil/src/git/cache-tree.c:779
>>      #7 0x557cbeab7fa7 in reset_head /home/phil/src/git/reset.c:85
>>      #8 0x557cbe72147f in cmd_rebase builtin/rebase.c:2074
>>      #9 0x557cbe5bd151 in run_builtin /home/phil/src/git/git.c:461
>>      #10 0x557cbe5bd151 in handle_builtin /home/phil/src/git/git.c:714
>>      #11 0x557cbe5c0503 in run_argv /home/phil/src/git/git.c:781
>>      #12 0x557cbe5c0503 in cmd_main /home/phil/src/git/git.c:912
>>      #13 0x557cbe5bad28 in main /home/phil/src/git/common-main.c:52
>>      #14 0x7fdd4b82eb24 in __libc_start_main (/usr/lib/libc.so.6+0x27b24)
>>
>> SUMMARY: AddressSanitizer: heap-use-after-free /home/phil/src/git/cache-tree.c:863 in verify_one
>> Shadow bytes around the buggy address:
>>    0x0c0c7fff8310: fd fd fd fd fd fd fd fa fa fa fa fa fd fd fd fd
>>    0x0c0c7fff8320: fd fd fd fa fa fa fa fa fd fd fd fd fd fd fd fa
>>    0x0c0c7fff8330: fa fa fa fa 00 00 00 00 00 00 00 02 fa fa fa fa
>>    0x0c0c7fff8340: fd fd fd fd fd fd fd fa fa fa fa fa 00 00 00 00
>>    0x0c0c7fff8350: 00 00 00 02 fa fa fa fa fd fd fd fd fd fd fd fa
>> =>0x0c0c7fff8360: fa fa fa fa[fd]fd fd fd fd fd fd fa fa fa fa fa
>>    0x0c0c7fff8370: 00 00 00 00 00 00 00 02 fa fa fa fa fd fd fd fd
>>    0x0c0c7fff8380: fd fd fd fa fa fa fa fa 00 00 00 00 00 00 00 02
>>    0x0c0c7fff8390: fa fa fa fa fd fd fd fd fd fd fd fa fa fa fa fa
>>    0x0c0c7fff83a0: fd fd fd fd fd fd fd fa fa fa fa fa fd fd fd fd
>>    0x0c0c7fff83b0: fd fd fd fa fa fa fa fa 00 00 00 00 00 00 00 fa
>> Shadow byte legend (one shadow byte represents 8 application bytes):
>>    Addressable:           00
>>    Partially addressable: 01 02 03 04 05 06 07
>>    Heap left redzone:       fa
>>    Freed heap region:       fd
>>    Stack left redzone:      f1
>>    Stack mid redzone:       f2
>>    Stack right redzone:     f3
>>    Stack after return:      f5
>>    Stack use after scope:   f8
>>    Global redzone:          f9
>>    Global init order:       f6
>>    Poisoned by user:        f7
>>    Container overflow:      fc
>>    Array cookie:            ac
>>    Intra object redzone:    bb
>>    ASan internal:           fe
>>    Left alloca redzone:     ca
>>    Right alloca redzone:    cb
>>    Shadow gap:              cc
>> ==74345==ABORTING
>>
>>
>>> e575f29006 (i.e. without the reftable topic) fails t1092.  If you
>>> revert e575f29006^2 (i.e. the "do not fork 'git checkout'") from
>>> that merge, all tests pass including t1092.
>>>
>>> The reftable topic is queued near the tip of 'seen' not necessarily
>>> because it _breaks_ CI (I do not think it does), but it needed a
>>> handful of fixup commits on top.  The topic needs rerolling with the
>>> fixes squashed in.
>>>
>>> Thanks.
>>>
>>
> 
