Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3483FC433EF
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 23:07:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbhK2XKm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:10:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237303AbhK2XKI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:10:08 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C5BC0698C4
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 11:44:12 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id gu12so15628010qvb.6
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 11:44:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=BdGkBRaAl/RzFoS4Yp8ZQWvFhZk4AORD6/9f3T/OCm4=;
        b=jyRqFpMLsIITQF6ZntLPvTIvvO0bv//2jLMWVIkIcQdnKFjXfC5vcnkXPZeedbgu/+
         uuJl2N8a4m4iXoh+XtqrFDHDCi7THdsaL5ff7arsL59TtRc/2d4iIcKxdsOwCwrAxPrp
         OYid0PQJSLum02i+ywsGlUBL9suH9hYHw/PPrybLCcJ2VczzjGMD8hXlKwFn7r5PIAay
         ngu8CSX64lYLjYKjoll02WYCHl7DJlcBRHj3aECewxWVqKHrJdT7cGD8hjeUHE3BDb6f
         hsVOHH+xK2qJo+qVkbr03JbYhns4i16Gos2FU2QCmkrJzwklBFiFEGTio6AwB5p5gm2h
         pZHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=BdGkBRaAl/RzFoS4Yp8ZQWvFhZk4AORD6/9f3T/OCm4=;
        b=nlSySZhMlajpvollLsxN646/NJGAbiCj85mRFYl4/BYJEriM42AcYb0YX5z01DJtCN
         /8pMKd4UUI7odZmVBhzxjVCAvGUAC6flFkJpnkQTqxwj4vY84oszQk0L75e4JwKBZmWU
         mSpVcqcI5Dyh1RbXh79h24tYFVgzJXzNO0T+ZuWboGuPR/ucW5ar4W6HxLiMbgc80r3z
         FWvfoRu/cwPqdry7zbmDAMNILMBMGmK/249li0YIUuS0iwV2OslaYjmrsHE8LBIvzd0K
         cCAEiZbqEgvbIaYYM9sRDoHKcVBv5oS+mEtQc50SetmcX1G/VcgE8rUxgtroU07s8Edt
         rvhw==
X-Gm-Message-State: AOAM533yO07YJhm+rEJGNDbjwFIpMyVbMWXAjKaJP0Ej23DXGn3sB/t7
        2NduFX23aWFC+p8nSrfT5j+7
X-Google-Smtp-Source: ABdhPJxrp8CvVN8JbsnHfFQ+TwZ7BUOCIq6CMZwsH9cPkzz3+QaiwvdcfjMIR3zgcjLgm7nFtRo08w==
X-Received: by 2002:a05:6214:2584:: with SMTP id fq4mr44900056qvb.53.1638215052140;
        Mon, 29 Nov 2021 11:44:12 -0800 (PST)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id d17sm9152609qtx.96.2021.11.29.11.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Nov 2021 11:44:11 -0800 (PST)
Message-ID: <9c5b7067-b0e3-0153-5cd3-042bae92f91e@github.com>
Date:   Mon, 29 Nov 2021 14:44:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH v6 0/8] Sparse Index: integrate with reset
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>
References: <pull.1048.v5.git.1635345563.gitgitgadget@gmail.com>
 <pull.1048.v6.git.1638201164.gitgitgadget@gmail.com>
 <CABPp-BG0iDHf268UAnRyA=0y0T69YTc+bLMdxCmSbrL8s=9ziA@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CABPp-BG0iDHf268UAnRyA=0y0T69YTc+bLMdxCmSbrL8s=9ziA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
> Hi,
> 
> On Mon, Nov 29, 2021 at 7:52 AM Victoria Dye via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> Changes since V5
>> ================
>>
>>  * Update t1092 test 'reset with wildcard pathspec' with more cases and
>>    better checks
>>  * Add "special case" wildcard pathspec check when determining whether to
>>    expand the index (avoids double-loop over pathspecs & index entries)
> 
> Looks pretty good.  However, I'm worried this special case you added
> at my prodding might be problematic, and that I may have been wrong to
> prod you into it...
> 
>> Thanks! -Victoria
>>
>> Range-diff vs v5:
>>
>>  7:  a9135a5ed64 ! 7:  822d7344587 reset: make --mixed sparse-aware
>>      @@ Commit message
>>
>>           Remove the `ensure_full_index` guard on `read_from_tree` and update `git
>>           reset --mixed` to ensure it can use sparse directory index entries wherever
>>      -    possible. Sparse directory entries are reset use `diff_tree_oid`, which
>>      +    possible. Sparse directory entries are reset using `diff_tree_oid`, which
>>           requires `change` and `add_remove` functions to process the internal
>>           contents of the sparse directory. The `recursive` diff option handles cases
>>           in which `reset --mixed` must diff/merge files that are nested multiple
>>      @@ builtin/reset.c: static void update_index_from_diff(struct diff_queue_struct *q,
>>       +          * (since we can reset whole sparse directories without expanding them).
>>       +          */
>>       +         if (item.nowildcard_len < item.len) {
>>      ++                 /*
>>      ++                  * Special case: if the pattern is a path inside the cone
>>      ++                  * followed by only wildcards, the pattern cannot match
>>      ++                  * partial sparse directories, so we don't expand the index.
>>      ++                  */
>>      ++                 if (path_in_cone_mode_sparse_checkout(item.original, &the_index) &&
>>      ++                     strspn(item.original + item.nowildcard_len, "*") == item.len - item.nowildcard_len)
> 
> I usually expect in an &&-chain to see the cheaper function call first
> (because that ordering often avoids the need to call the second
> function), and I would presume that strspn() would be the cheaper of
> the two.  Did you switch the order because you expect the strspn call
> to nearly always return true, though?
> 

This is a miss on my part, the `strspn()` check is probably less expensive
and should be first.

> Could the strspn() call be replaced by a `item.len ==
> item.nowildcard_len + 1`?  I mean, sure, folks could list multiple
> asterisks in a row in their pathspec, but that seems super unlikely
> and even if it does happen the code will just fall back to the slower
> codepath and still give them the right answer.  And the simpler check
> feels a lot easier to parse for human readers.
> 

Agreed on wanting better readability - if the multiple-wildcard case is
unlikely, the `PATHSPEC_ONESTAR` flag would indicate whether the pathspec
ends in a single wildcard character. If that flag is still too obscure,
though, I can stick with the length comparison.

> But I'm worried there's a deeper issue here:
> 
> 
> Is the wildcard character (or characters) in path treated as a literal
> by path_in_cone_mode_sparse_checkout()?  I think it is...and I'm
> worried that may be incorrect.  For example, if the path is
> 
>    foo/*
> 
> and the user has done a
> 
>   git sparse-checkout set foo/bar/
> 
> Then 'foo/baz/file' is not in the sparse checkout.  However, 'foo/*'
> should match 'foo/baz/file' and yet 'foo/*' when treated as a literal
> path would be considered in the sparse checkout by
> path_in_cone_mode_sparse_checkout.  Does this result in the code
> returning an incorrect answer?  (Or did I misunderstand something so
> far?)
> 

Correct: `path_in_cone_mode_sparse_checkout` interprets the wildcard
literally, and the checks here take that into account. The goal of
`pathspec_needs_expanded_index` is to determine if the pathspec *may* match
only partial contents of a sparse directory (like '*.c', or 'f*le'). For a
`git reset --mixed`, only this scenario requires expansion; if an entire
sparse directory is matched by a pathspec, the entire sparse directory is
reset. 

Using your example, 'foo/*' does match 'foo/baz/file', but it also matches
'foo/' itself; as a result, the `foo/` sparse directory index entry is reset
(rather than some individual files contained within it). The same goes for a
patchspec like 'fo*' ("in-cone" and ending in a wildcard). Conversely, a
pathspec like 'foo/ba*' would _not_ work (it wouldn't match something like
'foo/test-file'), and neither would 'f*o' (it would match all of 'foo', but
would only match files ending in "o" in a directory 'f/').

Hope that helps!

> I'm wondering if I misled you earlier in my musings about whether we
> could avoid the slow codepath for pathspecs with wildcard characters.
> Maybe there's no safe optimization here and wildcard characters should
> always go through the slower codepath.
> 
>>      ++                         continue;
>>      ++
>>       +                 for (pos = 0; pos < active_nr; pos++) {
>>       +                         struct cache_entry *ce = active_cache[pos];
>>       +
>>  8:  f91d1dcf024 = 8:  ddd97fb2837 unpack-trees: improve performance of next_cache_entry
>>
>> --
>> gitgitgadget

