Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B87C43334
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 15:01:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229521AbiGJPBS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 11:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGJPBR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 11:01:17 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AB5DE98
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 08:01:15 -0700 (PDT)
Received: from host-78-147-178-211.as13285.net ([78.147.178.211] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oAYQq-0003Nq-F5;
        Sun, 10 Jul 2022 16:01:13 +0100
Message-ID: <d70a4505-60ef-82c4-5497-499ac788782a@iee.email>
Date:   Sun, 10 Jul 2022 16:01:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v3 1/6] Documentation/technical: describe bitmap lookup
 table extension
Content-Language: en-GB
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
Cc:     Git <git@vger.kernel.org>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
References: <ac52cfea-edb0-b68b-36e2-ab45d2959727@iee.email>
 <20220709075310.83848-1-chakrabortyabhradeep79@gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <20220709075310.83848-1-chakrabortyabhradeep79@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/07/2022 08:53, Abhradeep Chakraborty wrote:
> Hello Philip,
>
> Philip Oakley <philipoakley@iee.email> wrote:
>
>> Not sure if this is new in this extension, but should there be a link or
>> two to the basics of XOR compression and some of the bitmap look up
>> techniques?
>>
>> It's not always obvious if these techniques are 'heuristic' and only
>> have partial commit data, or they have all the commits listed, Nor
>> how/why they work. My point is more about giving new readers a hand-up
>> in their understanding, rather than simple implementation details for
>> those who already know what is going on. For example, are there any
>> external articles that you found helpful in getting started that could
>> be referenced somewhere in the docs?
> As this series is only about adding a lookup-table extension (and not
> about bitmap itself), I am not sure whether it's good to include those
> things in this series. 

Thanks for the clarification. I must have slight misread some of the
discussions and falsely thought it was the XOR compression (which is a
technique I wasn't really aware of), that was being provided by the
extension - Where would it be best for me to look up the background to
your "extension" project?


> But I agree with your point that it should be
> able build a logical understanding among the new readers.

*nod*
>
> There are some external articles[1] which talk about bitmap internals.
> But I think it would be better if we can make a new doc file (may be
> `Documentation/technical/reachability-bitmaps.txt` or similar) rather
> than putting those details in the `bitmap-format.txt` 

Thanks for the two links. In general I agree about the format document.

> (As the name 
> suggests, this file should only contain format details of bitmaps).
> That file would provide the answers of "Why bitmaps", "how they are
> stored",  "How they are fetched", "how they work with pack-objects,
> git-fetch, midx etc.", "Detailed explanation of each bitmap extension"
> , and lastly "what are the future works" (if any).

One thing I've realised on reflection is that I'm unclear how the
'reachability bitmaps' and the 'commit-graph file' techniques relate to
each other (and to the ODB DAG), and what features they pick out within
their heuristic, explained at just enough level to allow folks to
appreciate what the options that select them will do for their use case.

>
> What do you think?

I'd be happy to collate contributions, suggestions and thoughts.

Trying to create these good introductory descriptions can be really
difficult, as you can only step into the same river once (the 'reading
for the first time problem' of not being able to un-hear the
explanations of others when reading a 2nd draft...)
>
>> Separately I'm preparing a short series on adding 'reachability bitmap'
>> and 'commit graph' (among other stuff) to the glossary as part of giving
>> folks [0] stepping stones to cross the chasm of understanding
> Great!
>
> Thanks :)
>
> [1] https://github.blog/2015-09-22-counting-objects/, https://github.blog/2021-04-29-scaling-monorepo-maintenance/
Thank you.
