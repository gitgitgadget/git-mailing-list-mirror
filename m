Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7AE181CEF
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 13:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719407216; cv=none; b=VOYaCEooyvCiZPUOvikzLMlJxd8EKBnAydzZGx8F93vMIrere6c3b/yI8vuwhlIkY9wuZNji5NHncCX8W9DEO9Y3dPLStVhXHh+gxsCb0lMX+f9zPURRHWll4CDU2AYf/Bf+PgMZ4NR2FFKehfts3bfMg24DoTqAQ0/beVKUG20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719407216; c=relaxed/simple;
	bh=M0WXuYM0n1uok9DkUd+EZ0kvepv1Tv4QmK8LRfhC9ZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MfIyQwcjrQka0bjSWd6t7UXCSMc5r0cSCqvL7qtEPYxpErEKcUMN7SxN7pUXgDDfrBK1VTxzWOGz2jNqJyZuDldtMD/xUb9X09u6qs+l+LIn4raJE9ZQ2deAqYIOx68uIZe0M5Fgt5JBV6GnjNfIm27v5+BLjNS+Zy/jxJvz1rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kIf15+Im; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kIf15+Im"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6f8edde24b3so4057813a34.2
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 06:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719407214; x=1720012014; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J5nXwCZl1sWaRdiomRTHDXaH+ffu1vZcJKqkj5otWwE=;
        b=kIf15+ImtnX0rDCDtBEjr9y70fjnTm+MKjByPhwm5ZaHFhBeA5ZINXP86nc39l876z
         NgS5NRHh5+RuLCt5CKlJbk2LEs5Yu8staxM819NzQD7VP6oKn9I5llSfo5SLGTZU+pfd
         HAv7ZQrt5d0Ok7mityFfMrzO1ZzeoiYPR1r2fSG8+M+tfzP2by3IsxIwnYCg13mjetU6
         uvqGY3KJAewSbw5+pnPKQH9KvzLXtj7/2JP/0YNyKM2N+zYXzXi7C89KsEPNkfFMBwHS
         MWf8PqqMM8ylxpvgp1FW3k31uvmhwbub/gMXNHXzqoGcNi1CZLIkIwbxdUf2P23wz1IA
         UTAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719407214; x=1720012014;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J5nXwCZl1sWaRdiomRTHDXaH+ffu1vZcJKqkj5otWwE=;
        b=LiYEoAvX4Vc9zt88ubMoU7Z7WGadHDjRFkJ9Y/iMPJnvFIRvTHEGt3+laZt3TIoJzu
         LS6Zx7DcJCXFAJm5bKeyF04v59FQhkxmOxupqCEWLB4nFANzEv5XpDSDmgn8wQP41jOc
         b8BtdRORaQkwyD0uavnQCv4vKRksjiLXtZSc9XyEzGgTy1k1neNfF7+FRL2IuoF7B0ti
         PIr758G1avBwfHyc7Rx8xbieWJMCbFIMjQ3Qo2XUnm8nlAXbXW9T41hDVaqfL/9cMwNa
         vuINfetMMrkVOUm2yyUd1fuUgOELlm/jnkFMqY9qCMZd3TRfmWL2k7wK2sVIdEsfPmWa
         V3xQ==
X-Gm-Message-State: AOJu0Yy5an3TG0jrydGd7lWQkdppo+ATWosQN8x/bjDEFXNj8Q5bMbl7
	iJcqspIOpowNFm/YGHzfF88KqKG6reDXQe4WV4lswDxR9QF/AQiH
X-Google-Smtp-Source: AGHT+IH2Cps13ffb9cBLtc2sjefSfnfgbE1vxYR00bp1DAYM4riTcmDb86oHSyqjt3RHnTHM2JOzwA==
X-Received: by 2002:a05:6830:1041:b0:700:9dd6:956 with SMTP id 46e09a7af769-700b11c8e7cmr11058451a34.15.1719407213496;
        Wed, 26 Jun 2024 06:06:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:60ba:9810:5cca:8078:1e70:3d3c? ([2600:1700:60ba:9810:5cca:8078:1e70:3d3c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7009c69641asm1870249a34.80.2024.06.26.06.06.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Jun 2024 06:06:52 -0700 (PDT)
Message-ID: <cfb20e54-eee5-4043-abcb-63c8211635d3@gmail.com>
Date: Wed, 26 Jun 2024 09:06:51 -0400
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] sparse-index: improve lstat caching of sparse paths
To: Elijah Newren <newren@gmail.com>,
 Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, anh@canva.com
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
 <2654fcb7142a606c5684c762ed28bb5e8d9b4712.1718899877.git.gitgitgadget@gmail.com>
 <CABPp-BFgg8DOy-SUUsXLyfsWr0DOUUc1vQKnPpihy-h+NAj_zg@mail.gmail.com>
Content-Language: en-US
From: Derrick Stolee <stolee@gmail.com>
In-Reply-To: <CABPp-BFgg8DOy-SUUsXLyfsWr0DOUUc1vQKnPpihy-h+NAj_zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 6/24/24 6:14 PM, Elijah Newren wrote:
> On Thu, Jun 20, 2024 at 10:11 AM Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>>
>> From: Derrick Stolee <stolee@gmail.com>
>>
>> The clear_skip_worktree_from_present_files() method was first introduced
>> in af6a51875a (repo_read_index: clear SKIP_WORKTREE bit from files
>> present in worktree, 2022-01-14) to allow better interaction with the
>> working directory in the presence of paths outside of the
>> sparse-checkout cone.
> 
> s/cone//
> 
>> The initial implementation would lstat() every
>> single sparse tree to see if it existed, and if one did, then the sparse
>> index would expand and every sparse file would be checked.
> 
> This sounds like the algorithm only lstat()ed the sparse directories,
> which feels misleading.  Perhaps
> 
> The initial implementation would lstat() every SKIP_WORKTREE path to
> see if it existed; if it ran across a sparse directory that existed
> (when a sparse-index was in use), then it would expand the index and
> then check every SKIP_WORKTREE path.
> 
>> Since these lstat() calls were very expensive, this was improved in
>> d79d299352 (Accelerate clear_skip_worktree_from_present_files() by
>> caching, 2022-01-14) by caching directories that do not exist. However,
>> there are some inefficiencies in that caching mechanism.
> 
> Maybe this is obvious, but I thought a few extra words to end the
> second-to-last sentence would be helpful, such as "so it could avoid
> lstat()ing any files under such directories".

Thanks. I will use both of these suggestions verbatim.

>> To set up a scenario that triggers this code in an interesting way, we
>> need a sparse-checkout in cone mode and a sparse index. To trigger the
> 
> I think you state this too strongly.  While trying to duplicate, I
> first went with a cone mode & sparse index at first, but out of
> curiosity tried it without either of these modes set and still saw
> dramatic improvement from your patch.  What is needed is that the
> sparsity is such that entire directories are missing, and not just one
> level above the files of interest.  That is more likely to occur when
> cone mode and perhaps sparse index are in use, but perhaps consider
> changing "we need" to "it is easiest to consider"

Absolutely. This stems from my earlier assumption that the sparse index
was required, but it is not. I have reworded locally.

>> full index expansion and a call to the
>> clear_skip_worktree_from_present_files_full() method, we need one of the
>> sparse trees to actually exist on disk. The performance test script
>> p2000-sparse-operations.sh takes the sample repository and copies its
>> HEAD to several copies nested in directories of the form f<i>/f<j>/f<k>
>> where i, j, and k are numbers from 1 to 4. The sparse-checkout cone is
>> then selected as "f2/f4/". Creating "f1/f1/" will trigger the behavior
>> and also lead to some interesting cases for the caching algorithm since
>> "f1/f1/" exists but "f1/f2/" and "f3/" do not.
> 
> For some reason I had difficulty triggering a case using this guide.
> I might have made an error, but I decided I wanted a deeper directory
> tree to test with anyway.  After some playing around to come up with
> an interesting testcase, I eventually came up with the following steps
> to reproduce in case anyone else wants to try:
> 
>      git clone https://github.com/newren/gvfs-like-git-bomb
>      cd gvfs-like-git-bomb
>      ./runme.sh
>      git sparse-checkout set bomb/b/c            # incidentally cone mode
>      mkdir -p bomb/d/e/f/a/a
>      git ls-files -t | colrm 2 | sort | uniq -c  # optional, but interesting
>      GIT_TRACE2_PERF=$(pwd)/trace git ls-files -t >/dev/null
>      grep lstat_count trace
> 
> Further, you can recompile the git version in use in another window,
> then come back to this one and run 'rm trace' followed by the last two
> commands to retest.
> 
> The commands above create a 'gvfs-like-git-bomb' git directory that
> has 1,000,001 files in HEAD.
> 
> With this test directory, before applying this patch, I see:
>      ..sparse_lstat_count:722011
> After applying this patch I see
>      ..sparse_lstat_count:135
> and with a slight tweak to your patch I see
>      ..sparse_lstat_count:125
> I'll comment on the slight tweak at the end of the patch.

Thanks for these numbers! Are you willing to keep that example repo
on GitHub so I can refer to it in the message?

>> This is difficult to notice when running performance tests using the Git
>> repository (or a blow-up of the Git repository, as in
>> p2000-sparse-operations.sh) because Git has a very shallow directory
>> structure.
>>
>> This change reorganizes the caching algorithm to focus on storing both
>> the deepest _existing_ directory and the next-level non-existing
>> directory.
> 
> This was slightly hard to parse for me, and misled me into thinking
> you were tracking two directories.  Maybe:
> 
> This change reorganizes the caching algorithm to focus on storing the
> highest level leading directory that does not exist (i.e. we are
> restricting to the leading directory whose parent directory does
> exist).

I have reworded in a slightly different way, but with the same meaning
as you provide here.

>> By doing a little extra work on the first sparse file, we can
>> short-circuit all of the sparse files that exist in that non-existing
>> directory.
> 
> Here you use "exist" as "tracked by git" in one case, and "appears in
> the working tree" in another.  That's a problem, because the files in
> question are tracked by git but do not appear in the working tree,
> making it impossible for people to understand unless they guess the
> correct definition for each use.  I think we want "exist" to just mean
> "appears in the working tree" here, so we'd need to s/sparse files
> that exist in/sparse files underneath/ (or something similar) to fix
> this sentence.
> 
> Also, you've used the phrase "sparse file(s)" a number of times in
> this commit message; I think I know what you mean, but it is not
> defined in the vocabulary section of
> Documentation/technical/sparse-checkout.txt.  Together with the above
> problem, it made me question what was meant, re-read all the
> definitions, etc.  Perhaps "sparse file(s)" should be added to that
> vocabulary section, though...especially if we are going to use it and
> since we never fixed "sparse directory" despite mentioning that we
> wanted to?

You're right. My use of "sparse file" or "sparse directory" was intended
to mean "a path from a cache entry with SKIP_WORKTREE that is either a
blob or tree" but that isn't necessary here.

Instead, I'll focus my attention on paths being passed to path_found(),
which removes the context of an index. The danger there is that the
caching assumes that we are moving through the paths in an order such
as in the index, but that's a natural type of ordering for paths.

>>          /*
>> -        * Otherwise, path does not exist so we'll return 0...but we'll first
>> -        * determine some info about its parent directory so we can avoid
>> -        * lstat calls for future cache entries.
>> +        * At this point, we know that 'path' doesn't exist, and we know that
>> +        * the parent directory of 'data->dir' does exist. Let's set 'data->dir'
>> +        * to be the top-most non-existing directory of 'path'. If the first
>> +        * parent of 'path' exists, then we will act ast though 'path'
> 
> s/ast/as/

Oops! Thanks.

>> +               /*
>> +                * Now that we have a slash, let's grow 'data->dir' to include
>> +                * this slash, then test if we should stop.
>> +                */
>> +               strbuf_add(&data->dir, path + data->dir.len,
>> +                          (next_slash - path) - data->dir.len + 1);
> 
> I had to re-read this multiple times and was confused by it.  I
> eventually realized it was simple -- you use "path + data->dir.len"
> 3-4 times in this loop.  Could we reduce the cognitive overhead by
> setting some variable to this value at the beginning within the loop
> and then just use it?  It'd simplify this particular call to
> 
>      strbuf_add(&data->dir, rest, next_slash - rest + 1);
> 
> or substitute any other variable name for "rest" there.  Maybe it
> shouldn't be a big deal, but the rest of the method was complex enough
> that I just blew my local stack space at this point.  I think this
> simple substitution would have made it easier for me.

Excellent. Thanks for recognizing this pattern and recommending a
simplification.

>> +       /*
>> +        * At this point, 'data->dir' is equal to 'path' plus a slash character,
>> +        * and the parent directory of 'path' definitely exists. Let's return
>> +        * the case of whether 'path' exists.
>> +        */
> 
> Can I suggest adding the following to this comment?
>    " path does not exist at this point or we would have already
> returned 1 above when we lstat()ed it before the above loop. "
> 
>> +
>> +       data->lstat_count++;
>> +       return !lstat(path, &st);
> 
> ...and, as long as I didn't missing something with my above comment
> suggestion, these two lines can be replaced by
> 
>      return 0;
> 
> Or did I miss something here?

No, you understood correctly. Thanks for the further simplification and
speed improvement.

> Anyway, despite the many small comments I made, well done!  I think
> the method is not only much more performant, but more readable than my
> original.  With a few small tweaks, it should be good to merge.

Thanks for your detailed review. I'll put these updates into a v2 and
send it later today. I need to retest in my monorepo example and add
your publicly-available example before v2 will be ready.

Thanks,
-Stolee

