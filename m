Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1858C00140
	for <git@archiver.kernel.org>; Fri,  5 Aug 2022 16:36:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238518AbiHEQgx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Aug 2022 12:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232185AbiHEQgw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Aug 2022 12:36:52 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45D617AA6
        for <git@vger.kernel.org>; Fri,  5 Aug 2022 09:36:50 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id iw1so3084509plb.6
        for <git@vger.kernel.org>; Fri, 05 Aug 2022 09:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=u6tWR9mCoaRw0f9SlGoDAahKwr5mFV4eT2sf777E9VI=;
        b=LbUgfAi6L5LZdinRJnLSpV8KCXpEI0JEqeoPLaIklcDFyflIncM3V+5r40y5ssF3It
         oenGsKWEj+jFVvlezw4SFjmni/fRvqKMycLcivlKeF/f2b7txKqIhC8qMoQSjVwUCyP/
         YS+9fN7YAg7d/dFjgeDXel5XxTMdzQBAgflnTnQflTBlmPYXH5WbloUo0FYk5dxfyYtf
         W08arkSvActZIaTtgklfj0RD750HyQ8fS/RyUbSkMUdnm2naBBM1+ZAf4Z8QVy97biFS
         TyRgOg2VJuublMk9TbdAU1NdhnKCXPDsXCYCAOr5mAED5RvRWDDhIyPaLsJ6SE466BzV
         tv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=u6tWR9mCoaRw0f9SlGoDAahKwr5mFV4eT2sf777E9VI=;
        b=Rnojst58iTL0vYxpyU9f2NdGdie5FeEBIOE+rWSZFiIvHHOjcWzW/XHmUsHbCBX9VG
         5448H2LXXnO+x44UN6QyMq9FaZhhKQAvsK1G4P7+O6S8KvzwqiH+gJCICm8BqW58f8dA
         xc7fWXIg6ADGEInyYYqUqrO4VU/rrpMiw6nZDWLea31yTkv8JhNYMT1IJoK2q4Zlixza
         R5aLtDDKKKxcEv97q6et+nhgmSG3OgA42aIxC0G9kiM2SH/9OMzuhWh1iTyiLG7srwGb
         iQEuP+FiohsH+5EWukQOC6CLbNyPa6VVjFTY0vDlTpVm21EN+s7nAUDp+xVFz9FpEDsw
         LVjg==
X-Gm-Message-State: ACgBeo0yZoV0iF3jRKrYv2wJohRsMIHayoOqJZ6NZQ4OgrvEXLp8KWgH
        E400CPRAyF/tS6zSOwwOSfhg
X-Google-Smtp-Source: AA6agR6Fo1uYPUMUMDYanEIsiGWYruKf/1Yu5wBk64Tyn97BKqAa882ND8nQwFGWlFMJG1pHRMWaqg==
X-Received: by 2002:a17:902:c943:b0:16f:15a0:d497 with SMTP id i3-20020a170902c94300b0016f15a0d497mr7591381pla.80.1659717410228;
        Fri, 05 Aug 2022 09:36:50 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id t22-20020a17090aba9600b001f5513f6fb9sm3257375pjr.14.2022.08.05.09.36.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 09:36:49 -0700 (PDT)
Message-ID: <3825ef9a-4c71-21ed-6452-bbd322ca839c@github.com>
Date:   Fri, 5 Aug 2022 09:36:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH 4/4] unpack-trees: handle missing sparse directories
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Victoria Dye via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, derrickstolee@github.com,
        shaoxuan.yuan02@gmail.com, newren@gmail.com
References: <pull.1312.git.1659645967.gitgitgadget@gmail.com>
 <016971a67112efe2d15fe7908e86c5d2631f8e66.1659645967.git.gitgitgadget@gmail.com>
 <xmqqa68j1tlr.fsf@gitster.g>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <xmqqa68j1tlr.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano wrote:
> "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Victoria Dye <vdye@github.com>
>>
>> If a sparse directory does not exist in the index, unpack it at the
>> directory level rather than recursing into it an unpacking its contents
>> file-by-file. This helps keep the sparse index as collapsed as possible in
>> cases such as 'git reset --hard' restoring a sparse directory.
> 
> My reading hiccuped at "does not exist in".  After reading the above
> twice, I think the situation is that there is a directory A/B in
> which a file C sits, and A/ is marked as sparse and the paragraph is
> talking about directory A/B.  Because the index has A/ as a tree in
> index, A/B does not exist in the index.
> > When we _somehow_ need to ensure that A/B exists in the index for
> _unknown_ reason, we could flatten the index fully and have A/B/C as
> a blob (without A or A/B in the index proper, even though they may
> appear in cache-tree), but if we stop at removing A and adding A/B
> still as a tree without showing A/B/C in the index, we may gain
> efficiency, under the assumption that we do not have to access A/B/C
> and its siblings.
> 
> Did I read the intention correctly?  I suspect future readers of the
> commit that would result from this patch would also wonder what the
> "somehow" and "unknown" above are.
> 
If I'm reading this correctly, it's not quite what I meant - the situation
this patch addresses is when _nothing_ in the tree rooted at 'A/' (files,
subdirectories) exists in the index, but 'unpack_trees()' is merging tree(s)
where 'A/' *does* exist. I originally wanted to write "If a sparse directory
*is deleted from* the index", but that doesn't cover the case where 'A/'
never existed in the index and we're merging in tree(s) that introduce it.

Maybe it would be clearer to describe it with a different perspective: "If
'unpack_callback()' is merging a new tree into a sparse index, merge the
tree as a sparse directory rather than traversing its contents" or something
like that? I'll try to come up with a better way of explaining this and
update in V2. 

>> A directory is determined to be truly non-existent in the index (rather than
>> the parent of existing index entries), if 1) its path is outside the sparse
>> cone and 2) there are no children of the directory in the index. This check
>> is performed by 'missing_dir_is_sparse()' in 'unpack_single_entry()'. If the
>> directory is a missing sparse dir, 'unpack_single_entry()'  will proceed
>> with unpacking it. This determination is also propagated back up to
>> 'unpack_callback()' via 'is_missing_sparse_dir' to prevent further tree
>> traversal into the unpacked directory.
> 
> Makes sense.
> 
>> diff --git a/unpack-trees.c b/unpack-trees.c
>> index 8a454e03bff..aa62cef20fe 100644
>> --- a/unpack-trees.c
>> +++ b/unpack-trees.c
>> @@ -1069,6 +1069,53 @@ static struct cache_entry *create_ce_entry(const struct traverse_info *info,
>>  	return ce;
>>  }
>>  
>> +/*
>> + * Determine whether the path specified corresponds to a sparse directory
>> + * completely missing from the index. This function is assumed to only be
>> + * called when the named path isn't already in the index.
>> + */
>> +static int missing_dir_is_sparse(const struct traverse_info *info,
>> +				 const struct name_entry *p)
>> +{
>> +	int res, pos;
>> +	struct strbuf dirpath = STRBUF_INIT;
>> +	struct unpack_trees_options *o = info->data;
>> +
>> +	/*
>> +	 * First, check whether the path is in the sparse cone. If it is,
>> +	 * then this directory shouldn't be sparse.
>> +	 */
>> +	strbuf_add(&dirpath, info->traverse_path, info->pathlen);
>> +	strbuf_add(&dirpath, p->path, p->pathlen);
>> +	strbuf_addch(&dirpath, '/');
>> +	if (path_in_cone_mode_sparse_checkout(dirpath.buf, o->src_index)) {
>> +		res = 0;
>> +		goto cleanup;
>> +	}
> 
> OK.
> 
>> +	/*
>> +	 * Given that the directory is not inside the sparse cone, it could be
>> +	 * (partially) expanded in the index. If child entries exist, the path
>> +	 * is not a missing sparse directory.
>> +	 */
>> +	pos = index_name_pos_sparse(o->src_index, dirpath.buf, dirpath.len);
>> +	if (pos >= 0)
>> +		BUG("cache entry '%s%s' shouldn't exist in the index",
>> +		    info->traverse_path, p->path);
> 
> So, we fed 'p' to this function, and we didn't expect it to exist in
> the index if it is outside the sparse cone.
> 

Correct; if an index entry with the name 'p' existed, 'src[0]' would not be
NULL in 'unpack_callback()'/'unpack_single_entry()' and this function
wouldn't have been called.

>> +	pos = -pos - 1;
> 
> This is the location that a cache entry for the dirpath.buf would
> sit in the index if it were a sparse entry.
> 
>> +	if (pos >= o->src_index->cache_nr) {
>> +		res = 1;
>> +		goto cleanup;
>> +	}
>> +	res = strncmp(o->src_index->cache[pos]->name, dirpath.buf, dirpath.len);
> 
> So, we found where dirpath.buf would be inserted.  If we (can) look
> at the cache entry that is currently sitting at that position, and
> find that it is a path inside it, then res becomes zero.  IOW, we
> found that the sparse directory is missing in the index, but there
> is a path that is in the directory recorded in the index.
> 
> The current entry, on the other hand, is outside the dirpath.buf,
> then res becomes non-zero.  We are asked to yield true (i.e.
> nonzero) if and only if the given directory and all paths in that
> directory are missing from the index, so that is what happens here.
> Sounds OK.
> 
> And the "out of bounds" check just means that the entries that sit
> near the end of the index sort strictly before our dirpath.buf, so
> they cannot be inside our directory, which is also the case where we
> are expected to yield "true".
> 
> OK.
> 
>> +
>> +cleanup:
>> +	strbuf_release(&dirpath);
>> +	return res;
>> +}
>> +
>>  /*
>>   * Note that traverse_by_cache_tree() duplicates some logic in this function
>>   * without actually calling it. If you change the logic here you may need to
>> @@ -1078,21 +1125,40 @@ static int unpack_single_entry(int n, unsigned long mask,
>>  			       unsigned long dirmask,
>>  			       struct cache_entry **src,
>>  			       const struct name_entry *names,
>> -			       const struct traverse_info *info)
>> +			       const struct traverse_info *info,
>> +			       int *is_missing_sparse_dir)
>>  {
>>  	int i;
>>  	struct unpack_trees_options *o = info->data;
>>  	unsigned long conflicts = info->df_conflicts | dirmask;
>> +	const struct name_entry *p = names;
>>  
>> -	if (mask == dirmask && !src[0])
>> -		return 0;
>> +	*is_missing_sparse_dir = 0;
>> +	if (mask == dirmask && !src[0]) {
>> +		/*
>> +		 * If the directory is completely missing from the index but
>> +		 * would otherwise be a sparse directory, we should unpack it.
>> +		 * If not, we'll return and continue recursively traversing the
>> +		 * tree.
>> +		 */
>> +		if (!o->src_index->sparse_index)
>> +			return 0;
>> +
>> +		/* Find first entry with a real name (we could use "mask" too) */
>> +		while (!p->mode)
>> +			p++;
>> +
>> +		*is_missing_sparse_dir = missing_dir_is_sparse(info, p);
>> +		if (!*is_missing_sparse_dir)
>> +			return 0;
> 
> Interesting.  Nobody checked if the name in 'p' is a directory up to
> this point, but missing_dir_is_sparse() does not care?  The only
> thing we know is that !src[0], so the name represented by 'p' does
> not exist in the index.  IIRC, the function only checked if p names
> a path inside or outside the sparse cone and if there are or are not
> paths that would be inside the path if p _were_ a directory but I
> didn't read it carefully what it did when the caller fed a path to a
> non-directory to the function.  As long as it will say "no" to such
> a situation, I won't complain, but I have to wonder how the logic
> around here tells apart a case where a sparse directory is
> completely hidden (which missing_dir_is_sparse() gives us) from a
> case where there is absolutely nothing, not a directory and not a
> blob, at the path in the index.  Or perhaps it works correctly
> without having to tell them apart?  I dunno.
> 

I wrote 'missing_dir_is_sparse()' in an attempt keep some complex logic out
of the already-complicated 'unpack_single_entry()', but as part of that it
relies on information already established by its caller.

We know 'p' is a directory because 'missing_dir_is_sparse()' is called
inside a 'mask == dirmask' condition. 'mask' is a representation of which
trees being traversed have an entry with the given name and 'dirmask' is a
representation of which of those entries are directories, so the only way
'mask == dirmask' and 'p' is *not* a directory is if the currently-traversed
entries in all of the trees do not exist. *That* won't happen because
'unpack_callback()' won't be invoked at all by 'traverse_trees()' if 'mask'
is 0.

Given that it requires jumping through multiple function invocations and
callbacks to figure that out, I can add some assertions or 'return 0'
conditions at the beginning of 'missing_dir_is_sparse()' to codify its
assumptions. Even if the assertions are slightly redundant now, they'll make
the code clearer and make the function safer for reuse.

> By the way, there is a comment before the function that reminds us
> that traverse_by_cache_tree() may need a matching change whenever a
> change is made to this function.  Does this require such a matching
> change?

In this case, I *think* a parallel change there is unnecessary.
'traverse_by_cache_tree()' iterates on the contents of the index, so its
equivalent of 'src[0]' always exists when it merges individual entries. And,
to trigger that function, the cache tree needs to identically match the
tree(s) being merged; if a subtree doesn't exist in either the index or any
of the merging trees, there's nothing to merge.

In any case, thanks for the reminder - I didn't notice the comment while
implementing this, so it could have just as easily needed fixing.
