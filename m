Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE9DC433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 02:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47AB722D01
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 02:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726660AbhAGCLq (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 21:11:46 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:61552 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726086AbhAGCLp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 21:11:45 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B8638117990;
        Wed,  6 Jan 2021 21:11:03 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=uEdF9lCyqmsBgv84CLV1TpzGce8=; b=Wi8E8N
        5wY9A5HCRHg3rTyBGcFyDHSIJjcKpv7B3vSqZPK2pi/TaSy3rpTwzfxWyb4IuPGK
        c4n7JAVyQcCxY60lZqAejUQ+JZhHcNd3gicMYLR+o23vbXWWoyG0VU5r3O3eOrFA
        KSkKapNqenZ+JizQaTmbvIKeNrsACM69E5pRc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Uc3A/ZA8VcJE6heaCJDHv+q78vOo5kyi
        jsrmz95ys5bC+vIGmmVsc+H6iMWZeZWLiEhuNMmjXXlk1vHScMo+YzfG636yKjnd
        5Fr9L7fuhGO+Yu+shJjUF1vGtW/ywPfJdFlmIRog5zQ8c8H4zGdvw1tuGWM1sCLW
        jCFUh3qiTYM=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id B03DE11798F;
        Wed,  6 Jan 2021 21:11:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 056F411798C;
        Wed,  6 Jan 2021 21:11:00 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, newren@gmail.com,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH v2 6/9] index-format: update preamble to cached tree
 extension
References: <pull.829.git.1609356413.gitgitgadget@gmail.com>
        <pull.829.v2.git.1609729758.gitgitgadget@gmail.com>
        <75b51483d3c7088d0cfae36544966672374c50f9.1609729758.git.gitgitgadget@gmail.com>
Date:   Wed, 06 Jan 2021 18:10:59 -0800
In-Reply-To: <75b51483d3c7088d0cfae36544966672374c50f9.1609729758.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Mon, 04 Jan 2021
        03:09:15 +0000")
Message-ID: <xmqqble1o5sc.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 967DB958-508D-11EB-863D-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Subject: Re: [PATCH v2 6/9] index-format: update preamble to cached tree extension

By the way, the name of the extension is "cache tree".

	git grep -i 'cached[- ]tree' ':!po/'
        
reveals there are a handful of mistakes already present but their
number is dwarfed when we check:

	git grep -i 'cache tree' ':!po/'

> I had difficulty in my efforts to learn about the cached tree extension
> based on the documentation and code because I had an incorrect
> assumption about how it behaved. This might be due to some ambiguity in
> the documentation, so this change modifies the beginning of the cached
> tree format by expanding the description of the feature.
>
> My hope is that this documentation clarifies a few things:
>
> 1. There is an in-memory recursive tree structure that is constructed
>    from the extension data. This structure has a few differences, such
>    as where the name is stored.
>
> 2. What does it mean for an entry to be invalid?
>
> 3. When exactly are "new" trees created?

Thanks.  Describing them is a worthy goal.

> +  Since the index does not record entries for directories, the cache
> +  entries cannot describe tree objects that already exist in the object
> +  database for regions of the index that are unchanged from an existing
> +  commit. The cached tree extension stores a recursive tree structure that
> +  describes the trees that already exist and completely match sections of
> +  the cache entries. This speeds up tree object generation from the index
> +  for a new commit by only computing the trees that are "new" to that
> +  commit.

The original motivation was the above one.  A cache of tree objects
that correspond to unmodified part of the directory structure helps
writing out a new tree out of modified index.

We later found out that we rather often compare the index against
the tree of HEAD (think: "git status"), and diff-lib.c::diff_cache()
does take advantage of the fact that an entire directory can be
skipped if the tree object taken from the HEAD side exactly matches
the tree recorded for the subdirectory in the cache tree extension.

> +  The recursive tree structure uses nodes that store a number of cache
> +  entries, a list of subnodes, and an object ID (OID). The OID references
> +  the exising tree for that node, if it is known to exist. The subnodes
> +  correspond to subdirectories that themselves have cached tree nodes. The
> +  number of cache entries corresponds to the number of cache entries in
> +  the index that describe paths within that tree's directory.

OK.

> +  Note that the path for a given tree is part of the parent node in-memory

Sorry, I am not sure if I follow.  The top-level in-core cache_tree
object records the number of entries, tree object name for the
entire tree (if valid), and cache_tree_sub structures, one for each
subdirectory.  Each of the cache_tree_sub structure describes the
"child" directory, including the path to it.

> +  but is part of the child in the file format. The root tree has an empty
> +  string for its name and its name does not exist in-memory.

It's more like we could have consistently used cache_tree_sub
instances to represent each and every level (i.e. I consider that
cache_tree_sub is what represents a directory, with cache_tree being
a record of just one aspect of it) including the root of the
hierarchy, but because there wasn't much point in giving a name to
the root level, I cheated and avoided wasting a cache_tree_sub for
it.  So from that point of view, the path belongs to the node in
each level in both in-core and on-disk representations.

> +  When a path is updated in index, Git invalidates all nodes of the
> +  recurisive cached tree corresponding to the parent directories of that
> +  path. We store these tree nodes as being "invalid" by using "-1" as the
> +  number of cache entries.

Correct.

> +  To create trees corresponding to the current
> +  index, Git only walks the invalid tree nodes and uses the cached OIDs
> +  for the valid trees to construct new trees.

I wonder if the above is sufficiently clear, or "Git only has to
walk the spans of index entries that corresponds to the invalid
trees, while reusing the ..." is too long and detailed.

> +  In this way, Git only
> +  constructs trees on the order of the number of changed paths (and their
> +  depth in the working directory). This comes at a cost of tracking the
> +  full directory structure in the cached tree extension, but this is
> +  generally smaller than the full cache entry list in the index.
>  
>    The signature for this extension is { 'T', 'R', 'E', 'E' }.

Looks good.  Thanks for working on this.
