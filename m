Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BCA5C433EF
	for <git@archiver.kernel.org>; Sun, 10 Jul 2022 21:37:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229490AbiGJVhl (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 10 Jul 2022 17:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiGJVhk (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 10 Jul 2022 17:37:40 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184281115F
        for <git@vger.kernel.org>; Sun, 10 Jul 2022 14:37:39 -0700 (PDT)
Received: from host-78-147-178-211.as13285.net ([78.147.178.211] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oAecS-0008yN-Dn;
        Sun, 10 Jul 2022 22:37:36 +0100
Message-ID: <5551bd33-cf95-3201-0a00-23e02ef41de3@iee.email>
Date:   Sun, 10 Jul 2022 22:37:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 2/4] glossary: add commit graph description
Content-Language: en-GB
To:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org
References: <pull.1282.git.1657385781.gitgitgadget@gmail.com>
 <32777cae24de91b0fb873ea04a802630ab85aafe.1657385781.git.gitgitgadget@gmail.com>
 <xmqqedyut22w.fsf@gitster.g>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <xmqqedyut22w.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 09/07/2022 22:20, Junio C Hamano wrote:
> "Philip Oakley via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> +[[def_commit_graph]]commit graph::
>> +	The commit-graph file is a supplemental data structure that
>> +	accelerates commit graph walks. The existing Object Data Base (ODB)
>> +	is the definitive commit graph. The "commit-graph" file is stored
>> +	either in the .git/objects/info directory or in the info directory
>> +	of an alternate object database.
> While it says nothing technically incorrect, I suspect "The existing
> object data base is the definitive commit graph" may invite unneeded
> confusion.

I probably over-shortened the original text I was summarising
(technical/commit-graph.txt intro).
>
> I think you wanted to say that the DAG formed by traversing the
> pointers recorded in the objects is the authoritative source of
> truth and the commit-graph file is merely a precomputed cache
.. of that graph. *nod*
>  and
> can be safely lost, 

I wasn't particularly thinking of that aspect .. Perhaps more that it
accelerates commit graph walks..
> but I am not sure the above description conveys
> that to anybody who does not already know it.
>
>     The commits in the object data base form a directed acyclic
>     graph (DAG) by commits referring to their parent commits.
>     Pieces of information from individual commit objects that are
>     needed to traverse the DAG are pre-computed in the commit-graph
>     file and stored in ...
>
> is my attempt---I am not very happy or proud about it, but it may be
> easier to follow.

I wanted to keepseparate from the graph file definition, the rather
fuzzy relationship between the overall ODB (staging area, and loads of
other stuff), and the way the DAG is generated, which also needs the
selected refs to start the traverse..

In a wider context, it's not clear to me just how the commit graph file
content is chosen relative to the full depth DAG from all local refs.
The reachability bit maps have a similar info gap.

--
Philip

[sorry for erratic responses - currently isolating with covid]

