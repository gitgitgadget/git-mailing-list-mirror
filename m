Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059FEC433F5
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 14:35:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D76826113E
	for <git@archiver.kernel.org>; Thu,  7 Oct 2021 14:35:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242071AbhJGOgz (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Oct 2021 10:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbhJGOgy (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Oct 2021 10:36:54 -0400
Received: from mail-qt1-x832.google.com (mail-qt1-x832.google.com [IPv6:2607:f8b0:4864:20::832])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128B6C061570
        for <git@vger.kernel.org>; Thu,  7 Oct 2021 07:35:01 -0700 (PDT)
Received: by mail-qt1-x832.google.com with SMTP id r16so6280437qtw.11
        for <git@vger.kernel.org>; Thu, 07 Oct 2021 07:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=5RunbBfUtg1slw3BDeeA6WQ/KLMTajB7Oh9tC6waYa8=;
        b=Nm832OaSS/AWYVvaw0vEwdrkPpvHNRZNN0XHSJbfiuTJWKUqjGi7q0WLdBfLytjMvj
         IAfX5WAueE4hrRTRtrFvpQui+qWMkEjJC+uRTCkOmctDQGXgwS9CxhKJ35z9b/WsmdU/
         R0UqaJjAWG+8OjG72CZWDJzbzR0urdqKz9lQUsBico+Kay0GF0OIWpel0ckcmD+MfXp4
         5KAgYx6o/YOvxZ4iKxJJmvp+pB8b55PJ3kllQXnOZN6y9w4nLfD3YUHQuFfAXBur8WR9
         /beJj7v0qLSI3zZia3Fp9oH1PmK/P1tYBPKwKY1+uJxZBgGRekPasl7dun9s95Z/zVQL
         //DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=5RunbBfUtg1slw3BDeeA6WQ/KLMTajB7Oh9tC6waYa8=;
        b=Lcfn6Y7/GIYGdum1EMZxtJJ4p/1VCWQ0ANVHrayj/8ASiBUXfUaIBb0pNuc8+ifYyK
         WwJxdPWxiBVXneImNp9xXCoFUu1wSnXIL0n/Ft5pVqtiTLKHoC/S/PkbF6J9JOnEKk8M
         QOJ2cRo2J1/Pi4xCuJCYDXfL2sXJrUaJl+l9yfDdBFnIrpkQF66V9Oew9S7J8r3PypM2
         6AAB1WkFuEkGCDeL9qIV9jqcqIXC+n88nv9kHmy6nayN+n60f1ietd3AVaPNeT2p6QWq
         WF2TgqYxJzeFQUb9jZYnW7ubkOKhyRjVhsph9XmAUrqvSCDJrqD2mqQozBchLIzldazn
         7Pyw==
X-Gm-Message-State: AOAM531X1v376QEoWZiuL7IUzrHmoQxKUIHU/VMstWD/LOY2xFJFYqE6
        uHpsIJkX/nk6sqn0/8kkZOBT
X-Google-Smtp-Source: ABdhPJz2P09E3f1chgz9fkfs7enScCqqu8DtYgK0/5eWRN8yDlQpgqr2WHvL+qUGVHkOzulCD+yFLw==
X-Received: by 2002:ac8:7763:: with SMTP id h3mr3487744qtu.159.1633617300245;
        Thu, 07 Oct 2021 07:35:00 -0700 (PDT)
Received: from [192.168.0.105] (70.15.20.152.res-cmts.sm.ptd.net. [70.15.20.152])
        by smtp.gmail.com with ESMTPSA id m15sm1083751qka.95.2021.10.07.07.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Oct 2021 07:34:59 -0700 (PDT)
Message-ID: <8cc2ad6b-393c-9961-b911-be042bd2fb68@github.com>
Date:   Thu, 7 Oct 2021 10:34:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.1.2
Subject: Re: [PATCH v2 6/7] reset: make --mixed sparse-aware
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
References: <pull.1048.git.1633013461.gitgitgadget@gmail.com>
 <pull.1048.v2.git.1633440057.gitgitgadget@gmail.com>
 <5eaae0825af4cee84040b784c32190bb1de2f919.1633440057.git.gitgitgadget@gmail.com>
 <CABPp-BHDog6U1bFKurNq+sKbNPOnmqbhB8W2wg0UeF=jb+ZScw@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CABPp-BHDog6U1bFKurNq+sKbNPOnmqbhB8W2wg0UeF=jb+ZScw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren wrote:
>> +       /*
>> +        * When pathspec is given for resetting a cone-mode sparse checkout, it may
>> +        * identify entries that are nested in sparse directories, in which case the
>> +        * index should be expanded. For the sake of efficiency, this check is
>> +        * overly-cautious: anything with a wildcard or a magic prefix requires
>> +        * expansion, as well as literal paths that aren't in the sparse checkout
>> +        * definition AND don't match any directory in the index.
> 
> s/efficiency/efficiency of checking/ ?  Being overly-cautious suggests
> you'll expand to a full index more than is needed, and full indexes
> are more expensive.  But perhaps the checking would be expensive too
> so you have a tradeoff?
> 
> Or maybe s/efficiency/simplicity/?
> 

"Simplicity" is probably more appropriate, although the original intent was
"efficiency of checking". I wanted to avoid repeated iteration over the
index (for example, matching the `no_wildcard_len` of each wildcard pathspec
item against each sparse directory in the index). However, to your point,
expanding the index is a more expensive operation anyway, so it's probably
worth the more involved checks.

>> +        */
>> +       if (pathspec->nr && the_index.sparse_index) {
>> +               if (pathspec->magic || pathspec->has_wildcard) {
>> +                       ensure_full_index(&the_index);
> 
> dir.c has the notion of matching the characters preceding the wildcard
> characters; look for "no_wildcard_len".  If the pathspec doesn't match
> a path up to no_wildcard_len, then the wildcard character(s) later in
> the pathspec can't make the pathspec match that path.
> 
> It might at least be worth mentioning this as a possible future optimization.
> 

I'll incorporate a something like this into the next version.

>> +               } else {
>> +                       for (i = 0; i < pathspec->nr; i++) {
>> +                               if (!path_in_cone_mode_sparse_checkout(pathspec->items[i].original, &the_index) &&
>> +                                   !matches_skip_worktree(pathspec, i, &skip_worktree_seen)) {
> 
> What if the pathspec corresponds to a sparse-directory in the index,
> but possibly without the trailing '/' character?  e.g.:
> 
>    git reset HEAD~1 -- sparse-directory
> 
> One should be able to reset that directory without recursing into
> it...does this code handle that?  Does it handle it if we add the
> trailing slash on the path for the reset command line?
> 

It handles both cases (with and without trailing slash), the former due to
`!matches_skip_worktree(...)` and the latter due to
`!path_in_cone_mode_sparse_checkout(...)`.

>> +                                       ensure_full_index(&the_index);
>> +                                       break;
>> +                               }
>> +                       }
>> +               }
>> +       }
>> +
>> +       free(skip_worktree_seen);
>>
>> -       ensure_full_index(&the_index);
>>         if (do_diff_cache(tree_oid, &opt))
>>                 return 1;
>>         diffcore_std(&opt);
>> diff --git a/t/t1092-sparse-checkout-compatibility.sh b/t/t1092-sparse-checkout-compatibility.sh
>> index e301ef5633a..4afcbc2d673 100755
>> --- a/t/t1092-sparse-checkout-compatibility.sh
>> +++ b/t/t1092-sparse-checkout-compatibility.sh
>> @@ -804,11 +804,22 @@ test_expect_success 'sparse-index is not expanded' '
>>                 ensure_not_expanded reset --hard $ref || return 1
>>         done &&
>>
>> +       ensure_not_expanded reset --mixed base &&
>>         ensure_not_expanded reset --hard update-deep &&
>>         ensure_not_expanded reset --keep base &&
>>         ensure_not_expanded reset --merge update-deep &&
>> -       ensure_not_expanded reset --hard &&
> 
> This commit was only touching the --mixed case; why is it removing one
> of the tests for --hard?
> 

[...]

>> +       ensure_not_expanded reset --hard update-folder1 &&
> 
> Wait...is update-folder1 a branch or a path?  And if this commit is
> about --mixed, why are --hard testcases being added?
> 
>> +       ensure_not_expanded reset base -- folder1 &&
>> +
>> +       ensure_not_expanded reset --hard update-deep &&
> 
> another --hard testcase...was this an accidental squash by chance?
> 

I included `git reset --hard` between the "actual" test cases so that the
`git reset --mixed` tests would start in a "clean" state (clear out any
modified files), but it's unnecessary in most cases so I'll remove them in
V3. To answer your other question, `update-folder1` is a branch.
