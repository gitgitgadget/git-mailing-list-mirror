Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07C9B1F404
	for <e@80x24.org>; Fri,  7 Sep 2018 15:23:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728516AbeIGUE6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Sep 2018 16:04:58 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:36722 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbeIGUE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Sep 2018 16:04:58 -0400
Received: by mail-wr1-f68.google.com with SMTP id e1-v6so6304087wrt.3
        for <git@vger.kernel.org>; Fri, 07 Sep 2018 08:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=OSb5B7lLuUCxKNjoJJO1L7BoYDAtcW/L4Mf2jKbn7j8=;
        b=QdpD6YyJDGRn0U7bqnmbVGQCpk/MTSD601n2YKI8IVPTjOLLMBldMSs80atxaWpFvh
         2zHX07vaVb5/HZbexF7QDp7qQl1Khy2cIws5BrlfR44/lDdRatXGWfCIG9ssTnDa3t3d
         B1pRxpu1iFTAR+MnGNFhzp/eMsSYWnicbsc9v3F97TzjM+1pBXKOBgzWOQztbrW0zIeJ
         kKZYd9/8EIMcmwJsAzwqku8y8TY1r1jR8K2/0HxHOjLDrAfaRbptlGelW+fNIBDgO5t2
         J9UG63g5mKn/azfo+SAWHFcK+MwJ/4jru3t4JGT4AWNJCxk47ddiM+LCIord7I7AC98b
         Nl6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=OSb5B7lLuUCxKNjoJJO1L7BoYDAtcW/L4Mf2jKbn7j8=;
        b=skT1HJud6mhlHUQTp27CUNLgmPBLMwG9+n/jfe4nsANGLQYqxAbLqzrkkfUDKwfcE1
         9NDAbH+You5Ha8H2c7kWkZ9gnCTOHvYlqZI0WEAOCWKQsvXIOaFiiwvOVxyFsTuZRfQ4
         XTURwOKbmVdF5cU1Nzg1R/XQXDoDNde1RJdYCuymh2QDxRNCu9SihlqoAN2r1kqoq77P
         FLKl+XK3AsdSudDUQwrgG+r4PJfplrLCXxPRDtAKAAt/n27kG4Y6hD0bp5hwFx2vGzVk
         UYApKf6ctNBCk8hdYD42/K2WsFxxuGyyyn8zwOTvaGM8Xs+agCwohKBL67cEWMbb8U+z
         YKmQ==
X-Gm-Message-State: APzg51DL3IkLpvMdPwgLtaWOOKxGJaesFFlx0f9DIBzl4cYrCJh6sCV1
        HhHsNvGP9O6VgYwjVznbbkI=
X-Google-Smtp-Source: ANB0VdaOT3+SoaqmLB6+967rJ6NxMXfZsajU/1l10IPx628d9DFG+Wzi6VfMSdHjqTywNBSyLze0ww==
X-Received: by 2002:adf:97d3:: with SMTP id t19-v6mr6320936wrb.283.1536333812948;
        Fri, 07 Sep 2018 08:23:32 -0700 (PDT)
Received: from evledraar ([5.57.21.50])
        by smtp.gmail.com with ESMTPSA id 200-v6sm13503628wmv.6.2018.09.07.08.23.32
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Sep 2018 08:23:32 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] commit-graph write: add progress output
References: <20180904202729.13900-1-avarab@gmail.com> <20180904202729.13900-2-avarab@gmail.com> <xmqqin3k7w8b.fsf@gitster-ct.c.googlers.com> <c6960252-c095-fb2b-e0bc-b1e6bb261614@gmail.com> <87ftylqr4z.fsf@evledraar.gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <87ftylqr4z.fsf@evledraar.gmail.com>
Date:   Fri, 07 Sep 2018 17:23:31 +0200
Message-ID: <87efe5qqks.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Sep 07 2018, Ævar Arnfjörð Bjarmason wrote:

> On Wed, Sep 05 2018, Derrick Stolee wrote:
>
>> On 9/4/2018 6:07 PM, Junio C Hamano wrote:
>>> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>>>
>>>> With --stdin-packs we don't show any estimation of how much is left to
>>>> do. This is because we might be processing more than one pack. We
>>>> could be less lazy here and show progress, either detect by detecting
>>>> that we're only processing one pack, or by first looping over the
>>>> packs to discover how many commits they have. I don't see the point in
>>> I do not know if there is no point, but if we were to do it, I think
>>> slurping the list of packs and computing the number of objects is
>>> not all that bad.
>>
>> If you want to do that, I have nothing against it. However, I don't
>> expect users to use that option directly. That option is used by VFS
>> for Git to compute the commit-graph in the background after receiving
>> a pack of commits and trees, but not by 'git gc' which I expect is how
>> most users will compute commit-graphs.
>>
>>>>   static void compute_generation_numbers(struct packed_commit_list* commits)
>>>>   {
>>>>   	int i;
>>>>   	struct commit_list *list = NULL;
>>>> +	struct progress *progress = NULL;
>>>>   +	progress = start_progress(
>>>> +		_("Computing commit graph generation numbers"), commits->nr);
>>>>   	for (i = 0; i < commits->nr; i++) {
>>>> +		display_progress(progress, i);
>>>>   		if (commits->list[i]->generation != GENERATION_NUMBER_INFINITY &&
>>>>   		    commits->list[i]->generation != GENERATION_NUMBER_ZERO)
>>>>   			continue;
>>> I am wondering if the progress call should be moved after this
>>> conditional continue; would we want to count the entry whose
>>> generation is already known here?  Of course, as we give commits->nr
>>> as the 100% ceiling, we cannot avoid doing so, but it somehow smells
>>> wrong.
>>
>> If we wanted to be completely right, we would count the commits in the
>> list that do not have a generation number and report that as the 100%
>> ceiling.
>>
>> Something like the diff below would work. I tested it in Linux by
>> first deleting my commit-graph and running the following:
>>
>> stolee@stolee-linux:~/linux$ rm .git/objects/info/commit-graph
>> stolee@stolee-linux:~/linux$ git rev-parse v4.6 | ~/git/git
>> commit-graph write --stdin-commits
>> Annotating commits in commit graph: 1180333, done.
>> Computing commit graph generation numbers: 100% (590166/590166), done.
>> stolee@stolee-linux:~/linux$ ~/git/git commit-graph write --reachable
>> Annotating commits in commit graph: 1564087, done.
>> Computing commit graph generation numbers: 100% (191590/191590), done.
>>
>> -->8--
>>
>> From: Derrick Stolee <dstolee@microsoft.com>
>> Date: Wed, 5 Sep 2018 11:55:42 +0000
>> Subject: [PATCH] fixup! commit-graph write: add progress output
>>
>> Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
>> ---
>> commit-graph.c | 15 +++++++++++----
>> 1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/commit-graph.c b/commit-graph.c
>> index 1a02fe019a..b933bc9f00 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> @@ -634,14 +634,20 @@ static void close_reachable(struct
>> packed_oid_list *oids)
>>
>> static void compute_generation_numbers(struct packed_commit_list* commits)
>> {
>> - int i;
>> + int i, count_uncomputed = 0;
>>  struct commit_list *list = NULL;
>>  struct progress *progress = NULL;
>>
>> + for (i = 0; i < commits->nr; i++)
>> + if (commits->list[i]->generation ==
>> GENERATION_NUMBER_INFINITY ||
>> + commits->list[i]->generation == GENERATION_NUMBER_ZERO)
>> + count_uncomputed++;
>> +
>>  progress = start_progress(
>> - _("Computing commit graph generation numbers"),
>> commits->nr);
>> + _("Computing commit graph generation numbers"),
>> count_uncomputed);
>> + count_uncomputed = 0;
>> +
>>  for (i = 0; i < commits->nr; i++) {
>> - display_progress(progress, i);
>>  if (commits->list[i]->generation !=
>> GENERATION_NUMBER_INFINITY &&
>>  commits->list[i]->generation != GENERATION_NUMBER_ZERO)
>>  continue;
>> @@ -670,10 +676,11 @@ static void compute_generation_numbers(struct
>> packed_commit_list* commits)
>>
>>  if (current->generation >
>> GENERATION_NUMBER_MAX)
>>  current->generation =
>> GENERATION_NUMBER_MAX;
>> +
>> + display_progress(progress,
>> ++count_uncomputed);
>>  }
>>  }
>>  }
>> - display_progress(progress, i);
>>  stop_progress(&progress);
>> }
>
> One of the things I was trying to do with this series was to make sure
> that whenever we run "git gc" there's always some indication that if you
> set gc.writeCommitGraph=true that it's actualy doing work.
>
> This modifies that, which I think is actually fine, just something I
> wanted to note. I.e. if you run "git commit-graph write" twice in a row,
> the second time will have no output.
>
> Unless that is, your repo is big enough that some of the delayed timers
> kick in. So e.g. on git.git we get no output the second time around, but
> do get output the first time around, and on linux.git we always get
> output.
>
> But in the common case people aren't running this in a loop, and it's
> useful to see how many new things are being added to the graph, so I
> think this is better. Just wanted to note the behavior difference (and
> will change the commit message).

Hrm, no. I spoke too soon because I was conflating "commit-graph write"
v.s. "gc". For "gc" we're now with this change just e.g. spending 6
seconds on 2015-04-03-1M-git displaying nothing, because we're looping
through the commits and finding that we have no new work.

So I'm on the fence about this, but leaning towards just taking my
initial approch. I.e. it sucks if you're e.g. testing different "git gc"
options that we're churning in the background doing nothing, just
because we're trying to report how many *new* things we added to the
graph.

After all, the main point IMNSHO is not to show some diagnostic output
of exactly how much work we're doing, that I have 200 new commits with
generation numbers or whatever is just useless trivia, but rather to not
leave the user thinking the command is hanging.

So I think I'll just do what I was doing to begin with and change the
message to "Refreshing commit graph generation numbers" or something to
indicate that it's a find/verify/compute operation, not just a compute
operation.
