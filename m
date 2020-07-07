Return-Path: <SRS0=WOg5=AS=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A06C433E0
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 15:12:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44DFC2065D
	for <git@archiver.kernel.org>; Tue,  7 Jul 2020 15:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="bpRqVuHJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgGGPMV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Jul 2020 11:12:21 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:65188 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726911AbgGGPMV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Jul 2020 11:12:21 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 50262773FE;
        Tue,  7 Jul 2020 11:12:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=PofD4EIh8pclGtuHQFeYBXZT8zI=; b=bpRqVu
        HJl7+UWrydMs0RwTM0yjnwWUU89bWPnO8oYsxMBEunQmPXOlLn7D99Dd3s9/l6To
        4R6Gw8skaC7brwWeVnZy0U0f6eLqGP2dhpRl4bxsCmJ5ptAT8JgxWlSh+MTz3fRd
        hY6e314wZ/NGRr46TlCFTvLgnhoxjhbs3WoFc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=lGK+6s9eUkV+mfWmLiaouGH3ByQRjBZ9
        sHSKV/LPd7snd4sgeNISbdy1O2igc1eOI68dTebCkOflwVtN+zuGH8q0Xr5ZyHsV
        8ohm+qohBOX4Ue8bjv9uRnDA0jZULG0wHvgcgEQwG7ZV8bYM6xBzvKLm1dgCr5+l
        3v5nlfwuN8E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E23F773FD;
        Tue,  7 Jul 2020 11:12:17 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B15FA773FC;
        Tue,  7 Jul 2020 11:12:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: sg/commit-graph-cleanups (was Re: What's cooking in git.git (Jul 2020, #01; Mon, 6))
References: <xmqqh7uj7tqn.fsf@gitster.c.googlers.com>
        <90cf9ac2-1ab0-1c9b-706b-6c5176ab47dd@gmail.com>
Date:   Tue, 07 Jul 2020 08:12:16 -0700
In-Reply-To: <90cf9ac2-1ab0-1c9b-706b-6c5176ab47dd@gmail.com> (Derrick
        Stolee's message of "Tue, 7 Jul 2020 09:29:29 -0400")
Message-ID: <xmqqzh8b5pgv.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3E9533C4-C064-11EA-BAE9-D1361DBA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <stolee@gmail.com> writes:

> On 7/7/2020 1:57 AM, Junio C Hamano wrote:
>> * ds/commit-graph-bloom-updates (2020-07-01) 10 commits
>>   (merged to 'next' on 2020-07-06 at 177e6b362e)
>>  + commit-graph: check all leading directories in changed path Bloom filters
>>  + revision: empty pathspecs should not use Bloom filters
>>  + revision.c: fix whitespace
>>  + commit-graph: check chunk sizes after writing
>>  + commit-graph: simplify chunk writes into loop
>>  + commit-graph: unify the signatures of all write_graph_chunk_*() functions
>>  + commit-graph: persist existence of changed-paths
>>  + bloom: fix logic in get_bloom_filter()
>>  + commit-graph: change test to die on parse, not load
>>  + commit-graph: place bloom_settings in context
>>  (this branch uses sg/commit-graph-cleanups.)
>> 
>>  Updates to the changed-paths bloom filter.
>> 
>>  Will merge to 'master'.
>> 
>> * sg/commit-graph-cleanups (2020-06-08) 10 commits
>>  + commit-graph: simplify write_commit_graph_file() #2
>>  + commit-graph: simplify write_commit_graph_file() #1
>>  + commit-graph: simplify parse_commit_graph() #2
>>  + commit-graph: simplify parse_commit_graph() #1
>>  + commit-graph: clean up #includes
>>  + diff.h: drop diff_tree_oid() & friends' return value
>>  + commit-slab: add a function to deep free entries on the slab
>>  + commit-graph-format.txt: all multi-byte numbers are in network byte order
>>  + commit-graph: fix parsing the Chunk Lookup table
>>  + tree-walk.c: don't match submodule entries for 'submod/anything'
>>  (this branch is used by ds/commit-graph-bloom-updates.)
>> 
>>  The changed-path Bloom filter is improved using ideas from an
>>  independent implementation.
>> 
>>  Under review.
>>  cf. <20200627155610.GN2898@szeder.dev>
>>  cf. <20200627163335.GO2898@szeder.dev>
>>  cf. <20200627155348.GM2898@szeder.dev>
>
> I see these are both in 'next' (thanks!).
>
> Perhaps the "Under review" status for sg/commit-graph-cleanups
> should be modified to match ds/commit-graph-bloom-updates?

Oops, I am not sure what happened here.  There I thought were issues
pointed out at least on the latter series but was I hallucinating?

For now, as -rc0 is so close, I'm tempted to mark both of them to be
cooked in 'next' during the rc period.

Thanks.
