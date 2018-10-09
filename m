Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 447611F97E
	for <e@80x24.org>; Tue,  9 Oct 2018 13:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbeJIVF0 (ORCPT <rfc822;e@80x24.org>);
        Tue, 9 Oct 2018 17:05:26 -0400
Received: from mail-qt1-f182.google.com ([209.85.160.182]:46008 "EHLO
        mail-qt1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbeJIVF0 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Oct 2018 17:05:26 -0400
Received: by mail-qt1-f182.google.com with SMTP id e10-v6so1597667qtq.12
        for <git@vger.kernel.org>; Tue, 09 Oct 2018 06:48:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=0OXHL5YPL7kbskkenl2ravF/wmBXX/N7/1sBh32XN9U=;
        b=kBfoY612eh6nihLgC/EQ9YOemGCjAU95ZBkcaZLElBwm6j4I/jFD5EC32nEPLnpmmn
         ioVnBa8NHkdGdByaD0BTkxnVfgaSwmEInIiaeg5WpluXMD7crwZmOTu/paEM0RScJADX
         swc11VPYA94SOx+2ILVe2YVo38SPKFvFIjsMoNDwG0ZvEMxWJcsV5HeMwfcwRAKVThRk
         K1MIblPO14kqY4NixHNZoIEPyQeF/sqXBY3VM+gG1pKtkEoNoR9sSlWo1t2+hG0Tr+kd
         nltB+lmfULvTLtewMRX66+QIYWD0l0Ds64k6I8MZji3X95jEe0v7tEExmPbmuBVjJux8
         IOLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=0OXHL5YPL7kbskkenl2ravF/wmBXX/N7/1sBh32XN9U=;
        b=eoBy1gi34EFrZ3lp1rGAelFdt3svOS/T6fe5MJEdO7ePm/uy/UDyIuDvtNWnlDw0Yb
         ya8yaAyCsjlTJsrDKFoVUDeykmdu2RFCwVVJOvmGlShJP0A51Cqqr3ius5D7LhMlF8Pa
         ++B3YgpZBKXqvKDgx/It65artds0WWcD66sLtKRBFsAy8yJ8YnijyK2m6paoEyNtTyL8
         X/Wbl5dWhAuyeWyMQkbRyhcmq4+FQtYgq6k041r4DFF9iWyz102SCeQqyOFfJo/yg9tq
         MCvIyx4K5Nkie3HkaOkkGs3hapMQ0m/kAMhfr7QzvWA8WdS8YHLseDj5QcvDYU1HDEvV
         5kiw==
X-Gm-Message-State: ABuFfohm/WEaG7tMMxmigUT2fqg8bVPG8ABRgtpirZioj1WFL7Pzswzr
        JxEcAGOahobtshUnH4H3LGk=
X-Google-Smtp-Source: ACcGV62gP98fdzyfL2C8GlSCn/Pnee9hGOo87hCph2IgpB0+5a7Old1ehcoG8p8UxZLV7guUF0YXnA==
X-Received: by 2002:aed:2601:: with SMTP id z1-v6mr23057607qtc.123.1539092903089;
        Tue, 09 Oct 2018 06:48:23 -0700 (PDT)
Received: from [10.0.1.23] ([98.122.163.216])
        by smtp.gmail.com with ESMTPSA id k71-v6sm11828921qkh.30.2018.10.09.06.48.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Oct 2018 06:48:22 -0700 (PDT)
Subject: Bloom Filters (was Re: We should add a "git gc --auto" after "git
 clone" due to commit graph)
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Duy Nguyen <pclouds@gmail.com>
References: <87o9cbglez.fsf@evledraar.gmail.com>
 <CAGZ79kbYX79Pk=xR3hY6NHaRQd7KMWwvacNVyW8=QpLorzXihQ@mail.gmail.com>
 <87lg7ehnps.fsf@evledraar.gmail.com>
 <20181003185156.GA20709@sigill.intra.peff.net>
 <a300acae-c7f2-eace-5196-381a99d62c13@gmail.com>
 <20181003191805.GB16666@sigill.intra.peff.net>
 <20181008164141.GZ23446@szeder.dev>
 <a66afe22-0523-c785-91e6-bf545683c67d@gmail.com>
 <20181008181015.GA23446@szeder.dev>
 <9ad5f166-f7c5-de79-0f86-f1f952cd33d2@gmail.com>
 <20181009030803.GA6250@sigill.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f877020c-3098-e4c4-ad64-cca57f764b91@gmail.com>
Date:   Tue, 9 Oct 2018 09:48:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20181009030803.GA6250@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(Changing title to reflect the new topic.)

On 10/8/2018 11:08 PM, Jeff King wrote:
> On Mon, Oct 08, 2018 at 02:29:47PM -0400, Derrick Stolee wrote:
>
>> There are two questions that I was hoping to answer by looking at 
>> your code:
>> 1. How do you store your Bloom filter? Is it connected to the commit-graph
>> and split on a commit-by-commit basis (storing "$path" as a key), or is it
>> one huge Bloom filter (storing "$commitid:$path" as key)?
> I guess you've probably thought all of this through for your
> implementation, but let me pontificate.
>
> I'd have done it as one fixed-size filter per commit. Then you should be
> able to hash the path keys once, and apply the result as a bitwise query
> to each individual commit (I'm assuming that it's constant-time to
> access the filter for each, as an index into an mmap'd array, with the
> offset coming from a commit-graph entry we'd be able to look up anyway).

You're right that we want to hash the path a constant number of times. 
Add in that we want to re-use information already serialized when 
updating the file, and we see that having a commit-by-commit Bloom 
filter is a good idea. Using (commit, path) pairs requires lots of 
re-hashing, repeated work when extending the filter, and poor locality 
when evaluating membership of a single key.

The nice thing is that you can generate k 32-bit hash values based on 
two 32-bit hash values that are "independent enough" (see [1]). We used 
Murmur3 with two different seed values to generate hashes a & b, then 
used the arithmetic progression a, a + b, a + 2b, ..., a + (k-1)b as our 
k hash values. These can be computed up front and then dropped into any 
size filter using a simple modulo operation. This allows flexible sizes 
in our filters.

I don't think fixed size filters are a good idea, and instead would opt 
for flex-sized filters with a maximum size. The typical parameters use 7 
hash functions and a filter size of (at least) 10 bits per entry. For 
most commits (say 60-70%), 256 bits (32 bytes) is enough. Using a 
maximum of 512 bytes covers 99% of commits. We will want these bounds to 
be configurable via config. If we had a fixed size, then we either make 
it too small (and don't have sufficient coverage of commits) or too 
large (and waste a lot of space on the commits that change very little).

We can store these flex-sized filters in the commit-graph using two 
columns of data (two new optional chunks):

* Bloom filter data: stores the binary data of each commit's Bloom 
filter, concatenated together in the same order as the commits appear in 
the commit-graph.

* Bloom filter positions: The ith position of this column stores the 
start of the (i+1)th Bloom filter (The 0th filter starts at byte 0). A 
Bloom filter of size 0 is intended to mean "we didn't store this filter 
because it would be too large". We can compute the lengths of the filter 
by inspecting adjacent values.

In order to be flexible, we will want to encode some basic information 
into the Bloom filter data chunk, such as a tuple of (hash version, num 
hash bits, num bits per entry). This allows us to change the parameters 
in config but still be able to read a serialized filter. Here I assume 
that all filters share the same parameters. The "hash version" here is 
different than the_hash_algo, because we don't care about cryptographic 
security, only a uniform distrubution (hence, Murmur3 is a good, fast 
option).

[1] 
https://web.archive.org/web/20090131053735/http://www.eecs.harvard.edu/~kirsch/pubs/bbbf/esa06.pdf

>
> I think it would also be easier to deal with maintenance, since each
> filter is independent (IIRC, you cannot delete from a bloom filter
> without re-adding all of the other keys).
>
> The obvious downside is that it's O(commits) storage instead of O(1).
It would always be O(changes), as the Bloom filter needs to grow in size 
as the number of entries grows.
> Now let me ponder a bit further afield. A bloom filter lets us answer
> the question "did this commit (probably) touch these paths?". But it
> does not let us answer "which paths did this commit touch?".
>
> That second one is less useful than you might think, because we almost
> always care about not just the names of the paths, but their actual
> object ids. Think about a --raw diff, or even traversing for
> reachability (where if we knew the tree-diff cheaply, we could avoid
> asking "have we seen this yet?" on most of the tree entries). The names
> alone can make that a bit faster, but in the worst case you still have
> to walk the whole tree to find their entries.
>
> But there's also a related question: how do we match pathspec patterns?
> For a changed path like "foo/bar/baz", I imagine a bloom filter would
> mark all of "foo", "foo/bar", and "foo/bar/baz". But what about "*.c"? I
> don't think a bloom filter can answer that.

The filter needs to store every path that would be considered "not 
TREESAME". It can't store wildcards, so you would need to evaluate the 
wildcard and test all of those paths individually (not a good idea).

> At least not by itself. If we imagine that the commit-graph also had an
> alphabetized list of every path in every tree, then it's easy: apply the
> glob to that list once to get a set of concrete paths, and then query
> the bloom filters for those. And that list actually isn't too big. The
> complete set of paths in linux.git is only about 300k gzipped (I think
> that's the most relevant measure, since it's an obvious win to avoid
> repeating shared prefixes of long paths).
As you mention below, we would actually want a list of "every path that 
has ever appeared in the repo".
> Imagine we have that list. Is a bloom filter still the best data
> structure for each commit? At the point that we have the complete
> universe of paths, we could give each commit a bitmap of changed paths.
> That lets us ask "did this commit touch these paths" (collect the bits
> from the list of paths, then check for 1's), as well as "what paths did
> we touch" (collect the 1 bits, and then index the path list).  Those
> bitmaps should compress very well via EWAH or similar (most of them
> would be huge stretches of 0's punctuated by short runs of 1's).

I'm not convinced we would frequently have runs of 1's, and the bitmap 
would not compress much better than simply listing the positions. For 
example, a path "foo/bar" that resolves to a tree would only start a run 
if the next changes are the initial section of entries in that tree 
(sorted lexicographically) such as "foo/bar/a, foo/bar/b". If we deepen 
into a tree, then we will break the run of 1's unless we changed every 
path deeper than that tree.

> So that seems promising to me (or at least not an obvious dead-end). I
> do think maintenance gets to be a headache, though. Adding new paths
> potentially means reordering the bitmaps, which means O(commits) work to
> "incrementally" update the structure. (Unless you always add the new
> paths at the end, but then you lose fast lookups in the list; that might
> be an acceptable tradeoff).
>
> And finally, there's one more radical option: could we actually store a
> real per-commit tree-diff cache? I.e., imagine that each commit had the
> equivalent of a --raw diff easily accessible, including object ids. That
> would allow:
>
>    - fast pathspec matches, including globs
>
>    - fast --raw output (and faster -p output, since we can skip the tree
>      entirely)
>
>    - fast reachability traversals (we only need to bother to look at the
>      objects for changed entries)
>
> where "fast" is basically O(size of commit's changes), rather than
> O(size of whole tree). This was one of the big ideas of packv4 that
> never materialized. You can _almost_ do it with packv2, since after all,
> we end up storing many trees as deltas. But those deltas are byte-wise
> so it's hard for a reader to convert them directly into a pure-tree
> diff (they also don't mention the "deleted" data, so it's really only
> half a diff).
>
> So let's imagine we'd store such a cache external to the regular object
> data (i.e., as a commit-graph entry). The "log --raw" diff of linux.git
> has 1.7M entries. The paths should easily compress to a single 32-bit
> integer (e.g., as an index into a big path list). The oids are 20 bytes.
> Add a few bytes for modes. That's about 80MB. Big, but not impossibly
> so. Maybe pushing it for true gigantic repos, though.

Above, I mentioned my gut reaction that storing a "changed path bitmap" 
per commit would not compress well. That puts that implementation very 
close to the one you suggest here (except we also store the OID changes).

I just want to compare your 80MB here to ~4MB it would take to store 
those changed paths in Bloom filters (10 bits per entry -> ~2MB, but 
adding some slop for the commit-by-commit storage).

> Those numbers are ignoring merges, too. The meaning of "did this commit
> touch that path" is a lot trickier for a merge commit, and I think may
> depend on context. I'm not sure how even a bloom filter solution would
> handle that (I was assuming we'd mostly punt and let merges fall back to
> opening up the trees).

My solution here is to always store the list of paths changed against 
the first parent. If we evaluate TREESAME against our first parent while 
computing simplified file history, then we continue along first-parent 
history. It is possible to store filters for every parent, but I don't 
recommend it. The merge commit will typically have many more change 
paths against the second parent, since the second parent is usually 
bringing in a small change done by few to catch up to the work done in 
parallel by many. Those diffs will frequently run over our limit.

> Phew. That was a lot. I don't want to derail any useful work either of
> you is doing. These are just things I've been thinking over (or even in
> some cases experimenting with), and I think it's worth laying all the
> options on the table. I won't be surprised if you'd considered and
> rejected any of these alternate approaches, but I'd be curious to hear
> the counter-arguments. :)

This is a good discussion to have, since the commit-graph feature is 
getting to a stable place. We still have ongoing algorithm work with 
generation numbers, but this Bloom filter discussion (and 
implementation) can happen in parallel.

Thanks,

-Stolee

