Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CF091F404
	for <e@80x24.org>; Fri, 26 Jan 2018 13:06:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751363AbeAZNGa (ORCPT <rfc822;e@80x24.org>);
        Fri, 26 Jan 2018 08:06:30 -0500
Received: from mail-qt0-f193.google.com ([209.85.216.193]:35104 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751174AbeAZNG3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Jan 2018 08:06:29 -0500
Received: by mail-qt0-f193.google.com with SMTP id g14so1070608qti.2
        for <git@vger.kernel.org>; Fri, 26 Jan 2018 05:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding:content-language;
        bh=Qhew2ByvHSbRbHDJPR74Qqs708rYng8xr2xd+MBPpOg=;
        b=jrItAAxa4MARyimdE+hup3qo5B8vR5e4nRX5JzyLGk6z5ARaXceSe+/hoe71JjY9yf
         EKM3IZKOETA/41R8EhJKsZC323WrHzVS1U14K0OevsDxRSQHn3N9gRIZdkXf3oefXsL7
         nDAfJFtpg7PSSgbrrYHFyeqVy1S7ivBlyP13dSrnm4VfK/j08UG9xgAfk7qWlT8NZ5H+
         FOODM+Nb6HCvKJWsSxFYFrtp9b6tnZwKbsYbPvNR4i2mLfkNtPXvmc3KpFrImz83dQ5x
         8j5nePy5SOFqBE/HMdN/HgmGot3c9PjoO8bmhLIdyJz/XQtvecgS1uNJ+cJaGaFOlT+m
         gZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=Qhew2ByvHSbRbHDJPR74Qqs708rYng8xr2xd+MBPpOg=;
        b=Xn52GftDyrUDCePN73LKYzZaOjxXPW0pSvWpNRwfLbuVSyydf9hoNyuro/d7Oi/XXs
         NMEH+cbqEsI4fqSeGG5XxtmCW7tO/4q5m7rRt0TFElgr+u/m0oqNxzdjj3kxm7eksQBg
         5gQKNDkIsjmB1p8zaZ2M76JYIVakpOCNSFVlo+ZyieBzkKVJgsF9m4O5OGnoe1HsDl5n
         3BiGdFxmVi2U8wGdRM7vY8iQ9SZ3PKb0YhUHUQps5OjbXqT7XYe+vwoPOcLuviLrpnZR
         MlDt8/xqOxr06O53Opes9BpjxP/aZxwfrmD7YLjMjCAJpFPPQAdaBSpKBzMCiV+hOuk5
         IE3Q==
X-Gm-Message-State: AKwxyteHkS+s92kbyP/ZnXi48mELF6csxb5tD1hAec7xvn2Mi7p/fbA3
        ZAhFT3++MGN7qoFFQ3MIXzg=
X-Google-Smtp-Source: AH8x225ja2xfPOh32oyW7+LVnJ19vWfBCvkE/jxG+GtW0DliJTT9kSTaBLYJK40m4bZdjDtkhtNmmA==
X-Received: by 10.55.42.143 with SMTP id q15mr20406675qkq.206.1516971988539;
        Fri, 26 Jan 2018 05:06:28 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c4e6:7a22:56f1:df04? ([2001:4898:8010:0:ae1c:7a22:56f1:df04])
        by smtp.gmail.com with ESMTPSA id p8sm3476240qki.61.2018.01.26.05.06.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Jan 2018 05:06:27 -0800 (PST)
Subject: Re: [PATCH 01/14] graph: add packed graph design document
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, peff@peff.net, git@jeffhostetler.com,
        sbeller@google.com, dstolee@microsoft.com
References: <20180125140231.65604-1-dstolee@microsoft.com>
 <20180125140231.65604-2-dstolee@microsoft.com>
 <xmqqzi518wu3.fsf@gitster.mtv.corp.google.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e74758fe-f645-0a75-51fd-2b2e39289ce4@gmail.com>
Date:   Fri, 26 Jan 2018 08:06:27 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <xmqqzi518wu3.fsf@gitster.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/25/2018 4:14 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
>
>> Add Documentation/technical/packed-graph.txt with details of the planned
>> packed graph feature, including future plans.
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>>   Documentation/technical/packed-graph.txt | 185 +++++++++++++++++++++++++++++++
>>   1 file changed, 185 insertions(+)
>>   create mode 100644 Documentation/technical/packed-graph.txt
> I really wanted to like having this patch at the beginning, but
> unfortunatelly I didn't see the actual file format description,
> which was a bit disappointing.  An example of the things that I was
> curious about was how the "integer ID" is used to access into the
> file.  If we could somehow use "integer ID" as an index into an
> array of fixed size elements, it would be ideal to gain "fast
> lookups", but because of the "list of parents" thing, it needs some
> trickery to do so, and that was among the things that I wanted to
> see how much thought went into the design, for example.

There is definitely a chicken-or-the-egg situation here. I'm happy to 
start with the format before the design document.

I can try to expand this "integer ID" concept, but you can see how I use 
it in the following method from patch 11/14:

+int parse_packed_commit(struct commit *item)
+{
+        if (!core_graph)
+                return 0;
+        if (item->object.parsed)
+                return 1;
+
+        prepare_packed_graph();
+        if (packed_graph) {
+                uint32_t pos;
+                int found;
+                if (item->graphId != 0xFFFFFFFF) {
+                        pos = item->graphId;
+                        found = 1;
+                } else {
+                        found = bsearch_graph(packed_graph, 
&(item->object.oid), &pos);
+                }
+
+                if (found)
+                        return fill_packed_commit(item, packed_graph, pos);
+        }
+
+        return 0;
+}

Note that if item->graphId has a "real" value (not 0xFFFFFFFF which in 
hindsight should be a macro) then we navigate directly to that position 
in the graph. Otherwise, we use binary search to query the graph's 
commit list to find the position (if the commit is packed).

>> diff --git a/Documentation/technical/packed-graph.txt b/Documentation/technical/packed-graph.txt
>> new file mode 100644
>> index 0000000000..fcc0c83874
>> --- /dev/null
>> +++ b/Documentation/technical/packed-graph.txt
>> @@ -0,0 +1,185 @@
>> +Git Packed Graph Design Notes
>> +=============================
>> +
>> +Git walks the commit graph for many reasons, including:
>> +
>> +1. Listing and filtering commit history.
>> +2. Computing merge bases.
>> +
>> +These operations can become slow as the commit count grows above 100K.
>> +The merge base calculation shows up in many user-facing commands, such
>> +as 'status' and 'fetch' and can take minutes to compute depending on
>> +data shape. There are two main costs here:
> s/data shape/history shape/ may make it even clearer.
>
>> +1. The commit OID.
>> +2. The list of parents.
>> +3. The commit date.
>> +4. The root tree OID.
>> +5. An integer ID for fast lookups in the graph.
>> +6. The generation number (see definition below).
>> +
>> +Values 1-4 satisfy the requirements of parse_commit_gently().
>> +
>> +By providing an integer ID we can avoid lookups in the graph as we walk
>> +commits. Specifically, we need to provide the integer ID of the parent
>> +commits so we navigate directly to their information on request.
> Commits created after a packed graph file is built may of course not
> appear in a packed graph file, but that is OK because they never need
> to be listed as parents of commits in the file.  So "list of parents"
> can always refer to the parents using the "integer ID for fast lookup".

One thing I need to test locally is what happens with boundary commits 
of a shallow clone. The commit's parents are not in the repo, so they 
will not be in the graph. I think that parse_commit_buffer() drops the 
parents, so the graph will treat them as root commits.

> Makes sense.  Item 2. might want to say "The list of parents, using
> the fast lookup integer ID (see 5.) as reference instead of OID",
> though.

That will be more specific, thanks.

>> +Define the "generation number" of a commit recursively as follows:
>> + * A commit with no parents (a root commit) has generation number 1.
>> + * A commit with at least one parent has generation number 1 more than
>> +   the largest generation number among its parents.
>> +Equivalently, the generation number is one more than the length of a
>> +longest path from the commit to a root commit.
> When a commit A can reach roots X and Y, and Y is further than X,
> the distance between Y and A becomes A's generation number.  "One
> more than the length of the path from the commit to the furthest
> root commit it can reach", in other words.

My "Equivalently,..." sentence is mangled. What I mean is:

     Equivalently, the generation number of A is one more than
     the length of a longest path from A to a root commit.

I intended to make a non-recursive definition, and the "one more than" 
here could easily be conflated with the "one more than" in the recursive 
definition. The reason for "one more than" is that root commits have a 
path of length zero but generation number one.

Reminder to self: use "one" instead of "1" in the recursive definition.

>> +The recursive definition
>> +is easier to use for computation and the following property:
>> +
>> +    If A and B are commits with generation numbers N and M, respectively,
>> +    and N <= M, then A cannot reach B. That is, we know without searching
>> +    that B is not an ancestor of A because it is further from a root commit
>> +    than A.
>> +
>> +    Conversely, when checking if A is an ancestor of B, then we only need
>> +    to walk commits until all commits on the walk boundary have generation
>> +    number at most N. If we walk commits using a priority queue seeded by
>> +    generation numbers, then we always expand the boundary commit with highest
>> +    generation number and can easily detect the stopping condition.
> These are both true.  It would be nice if an optimized walker
> algorithm can also deal with history with recent commits for which
> we do not yet know the generation numbers (i.e. you first traverse
> and assign generation numbers and record in packed graph, then
> history grows but we haven't added the new commits to the packed
> graph yet).

My forward-thinking intention is that we will perform walks using a 
priority queue whose priority first compares generation number (which 
will be 0xFFFFFFFF for commits not in the graph) and then compares by 
commit date on equal generation number. For walks that require 
topological constraints, we cannot stop the walk until all commits in 
the queue have a "real" generation number. This will allow our 
algorithms to work with a mix of packed commits and unpacked commits.

>
>> +- A graph file is stored in a file named 'graph-<oid>.graph' in the pack
>> +  directory. This could be stored in an alternate.
> Is that <oid> really an object name?  The <hash> that appears in the
> name of a packfile pack-<hash>.pack is *not* an <oid>, and I somehow
> suspect that you are doing a similar "use hash of (some) contents to
> make it uniquely identify the content", not "information about a
> single object that is identified by the <oid>".

This is definitely a mistake on my part and I'll switch this to use 
<hash> in the documents. I do use 'struct object_id' in the code for 
this value. Is that OK?

>
>> +- The graph file is only a supplemental structure. If a user downgrades
>> +  or disables the 'core.graph' config setting, then the existing ODB is
>> +  sufficient.
> OK, that is exactly what I meant to say in a few paragraphs above
> that I wanted to see.

I'll move this to the top!

>
>> +Current Limitations
>> +-------------------
>> +
>> +- Only one graph file is used at one time. This allows the integer ID to
>> +  seek into the single graph file. It is possible to extend the model
>> +  for multiple graph files, but that is currently not part of the design.
>> +
>> +- .graph files are managed only by the 'graph' builtin. These are not
>> +  updated automatically during clone or fetch.
> In addition to "clone or fetch", I presume operations that locally
> create commits do not automatically create them, right?

No. Writing a graph file is too expensive for one commit operation. 
Perhaps some threshold of new commits could trigger the graph calculation.

>
>> +- After computing and storing generation numbers, we must make graph
>> +  walks aware of generation numbers to gain performance benefits. This
>> +  will mostly be accomplished by swapping a commit-date-ordered priority
>> +  queue with one ordered by generation number. The following operations
>> +  are important candidates:
>> +
>> +    - paint_down_to_common()
>> +    - 'log --topo-order'
> Do you mean that this round only writes "graph" without any actualy
> consumers?  It is somewhat hard to assess the value of what is
> stored in the new file without the consumers.
>
> Anyway, thanks for starting this.  Let's read on.
>

See Patch 11/14 for consumption by EVERY commit-graph walk. This patch 
includes significant performance improvements for every walk by avoiding 
parsing, but to get the benefit of generation numbers we will need to 
change the algorithms that operate on the commit graph.

While that integration with algorithms may seem daunting, the good news 
is that we can make iterative changes to improve each algorithm one-by-one.

Thanks,
-Stolee

