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
	by dcvr.yhbt.net (Postfix) with ESMTP id 6C9E91F97E
	for <e@80x24.org>; Wed, 10 Oct 2018 21:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725879AbeJKFU4 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 01:20:56 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:35796 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbeJKFU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 01:20:56 -0400
Received: by mail-ed1-f65.google.com with SMTP id y19-v6so6368435edd.2
        for <git@vger.kernel.org>; Wed, 10 Oct 2018 14:56:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=A3nc0NwKBr3kTQfvdd1lygCgKQik0XuNCd13/sn1Ejc=;
        b=pARAxW0nhasqbmRYkRA5tmp2E8ZQTFAG2kDsrbT36Ep+vcJ9XOypvK/QK9DkN+lkIb
         6Ia7YF3FqgHL298ZltZKHdr8jsBO41hH8r565Oxbim+4xo+5cOZw8sIJ13juxa1mUpWG
         /qQGURm6lyY3iaVe74/eRBh/kU6q784Ic2FsODdvjxBu76Ehz5u7+F/YuI5TbWDTSwlc
         pMelCjaI8t6Pcv7eLFKB/sm7ugsJbMna7nQkZysszf9d6jEUkVpK8XB0M15x4H2ha8Ew
         3UadWE+yo2k/c6/I8y029naQEb7qTWUYSEQ+BnvwlyuwzDu3vMccGJpQbCqAFTyCKfL9
         FAnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=A3nc0NwKBr3kTQfvdd1lygCgKQik0XuNCd13/sn1Ejc=;
        b=MEvlwMicmeYD4rzFen8E2nvOgkswV/tIVm5s/79p2wx3UcRIagGRP8j5yNZFPm92el
         c8pT39XClFXX0iO7bu/SlVz2b+veRZ82qKEM6HR1BrH/z1Zp4d3ZbC+YjjSaMLlMPAHQ
         p74SkcVBWi9aYHljhqHz1NCXsHRvtH1qpA6tT0c9en8dpL9+C+OZXsWQW0gAUuSmPDOn
         XkJKInbiCPMiRxF3W/2Nb7xYUlpLNCCWH79Kzjjbjm6W2ZkxQfUtC4s2hMM6zU3hOb8n
         ljmIIdf/ZYS5jkzQvvbkTu0jA4T248Ey7OHBRvOvddsIUqxUdC0yPt2mBdXWZmeNikS2
         nlbg==
X-Gm-Message-State: ABuFfognFkVk6b5KwBZ/d2w00IYzXnZ7rbLG0iaCDkFJr2Z/SS7S8MIx
        2Uyb+itCqY6nPRFK3wgGKbWUOi2gHck=
X-Google-Smtp-Source: ACcGV63MPue6XA4OZc2fZmqz0CqYH4iPmcu7Y9vEmQ0DJari/auVi8ZZ/M9AgxG/tU9XZ/XkLUVbWg==
X-Received: by 2002:a17:906:5387:: with SMTP id g7-v6mr34937077ejo.174.1539208607438;
        Wed, 10 Oct 2018 14:56:47 -0700 (PDT)
Received: from evledraar (g74155.upc-g.chello.nl. [80.57.74.155])
        by smtp.gmail.com with ESMTPSA id w56-v6sm8654516edd.78.2018.10.10.14.56.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 10 Oct 2018 14:56:46 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH v3 1/2] commit-graph write: add progress output
References: <CACsJy8A5tFxAaD-OqNNvMmX+KnbmW=O7JCCBbY-5dZa8Ta7QYg@mail.gmail.com> <20180917153336.2280-2-avarab@gmail.com> <20181010203738.GE23446@szeder.dev>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <20181010203738.GE23446@szeder.dev>
Date:   Wed, 10 Oct 2018 23:56:45 +0200
Message-ID: <87pnwhea8y.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Oct 10 2018, SZEDER Gábor wrote:

> On Mon, Sep 17, 2018 at 03:33:35PM +0000, Ævar Arnfjörð Bjarmason wrote:
>>     $ git -c gc.writeCommitGraph=true gc
>>     [...]
>>     Annotating commits in commit graph: 1565573, done.
>>     Computing commit graph generation numbers: 100% (782484/782484), done.
>
> While poking around 'commit-graph.c' in my Bloom filter experiment, I
> saw similar numbers like above, and was confused by the much higher
> than expected number of annotated commits.  It's about twice as much
> as the number of commits in the repository, or the number shown on the
> very next line.
>
>> diff --git a/commit-graph.c b/commit-graph.c
>> index 8a1bec7b8a..2c5d996194 100644
>> --- a/commit-graph.c
>> +++ b/commit-graph.c
>> -static void close_reachable(struct packed_oid_list *oids)
>> +static void close_reachable(struct packed_oid_list *oids, int report_progress)
>>  {
>>  	int i;
>>  	struct commit *commit;
>> +	struct progress *progress = NULL;
>> +	int j = 0;
>>
>> +	if (report_progress)
>> +		progress = start_delayed_progress(
>> +			_("Annotating commits in commit graph"), 0);
>>  	for (i = 0; i < oids->nr; i++) {
>> +		display_progress(progress, ++j);
>>  		commit = lookup_commit(the_repository, &oids->list[i]);
>>  		if (commit)
>>  			commit->object.flags |= UNINTERESTING;
>> @@ -604,6 +616,7 @@ static void close_reachable(struct packed_oid_list *oids)
>>  	 * closure.
>>  	 */
>>  	for (i = 0; i < oids->nr; i++) {
>> +		display_progress(progress, ++j);
>>  		commit = lookup_commit(the_repository, &oids->list[i]);
>>
>>  		if (commit && !parse_commit(commit))
>> @@ -611,19 +624,28 @@ static void close_reachable(struct packed_oid_list *oids)
>>  	}
>
> The above loops have already counted all the commits, and, more
> importantly, did all the hard work that takes time and makes the
> progress indicator useful.
>
>>  	for (i = 0; i < oids->nr; i++) {
>> +		display_progress(progress, ++j);

[...]

> This display_progress() call, however, doesn't seem to be necessary.
> First, it counts all commits for a second time, resulting in the ~2x
> difference compared to the actual number of commits, and then causing
> my confusion.  Second, all what this loop is doing is setting a flag
> in commits that were already looked up and parsed in the above loops.
> IOW this loop is very fast, and the progress indicator jumps from
> ~780k right to 1.5M, even on my tiny laptop, so it doesn't need a
> progress indicator at all.

You're right, I tried this patch on top:

    diff --git a/commit-graph.c b/commit-graph.c
    index a686758603..cccd83de72 100644
    --- a/commit-graph.c
    +++ b/commit-graph.c
    @@ -655,12 +655,16 @@ static void close_reachable(struct packed_oid_list *oids, int report_progress)
     		if (commit)
     			commit->object.flags |= UNINTERESTING;
     	}
    +	stop_progress(&progress); j = 0;

     	/*
     	 * As this loop runs, oids->nr may grow, but not more
     	 * than the number of missing commits in the reachable
     	 * closure.
     	 */
    +	if (report_progress)
    +		progress = start_delayed_progress(
    +			_("Annotating commits in commit graph 2"), 0);
     	for (i = 0; i < oids->nr; i++) {
     		display_progress(progress, ++j);
     		commit = lookup_commit(the_repository, &oids->list[i]);
    @@ -668,7 +672,11 @@ static void close_reachable(struct packed_oid_list *oids, int report_progress)
     		if (commit && !parse_commit(commit))
     			add_missing_parents(oids, commit);
     	}
    +	stop_progress(&progress); j = 0;

    +	if (report_progress)
    +		progress = start_delayed_progress(
    +			_("Annotating commits in commit graph 3"), 0);
     	for (i = 0; i < oids->nr; i++) {
     		display_progress(progress, ++j);
     		commit = lookup_commit(the_repository, &oids->list[i]);

And on a large repo with around 3 million commits the 3rd progress bar
doesn't kick in.

But if I apply this on top:

    diff --git a/progress.c b/progress.c
    index 5a99c9fbf0..89cc705bf7 100644
    --- a/progress.c
    +++ b/progress.c
    @@ -58,8 +58,8 @@ static void set_progress_signal(void)
     	sa.sa_flags = SA_RESTART;
     	sigaction(SIGALRM, &sa, NULL);

    -	v.it_interval.tv_sec = 1;
    -	v.it_interval.tv_usec = 0;
    +	v.it_interval.tv_sec = 0;
    +	v.it_interval.tv_usec = 250000;
     	v.it_value = v.it_interval;
     	setitimer(ITIMER_REAL, &v, NULL);
     }

I.e. start the timer after 1/4 of a second instead of 1 second, I get
that progress bar.

So I'm inclined to keep it. It just needs to be 4x the size before it's
noticeably hanging for 1 second.

That repo isn't all that big compared to what we've heard about out
there, and inner loops like this have a tendency to accumulate some more
code over time without a re-visit of why we weren't monitoring progress
there.

But maybe we can fix the message. We say "Annotating commits in commit
grap", not "Counting" or whatever. I was trying to find something that
didn't imply that we were doing this once. One can annotate a thing more
than once, but maybe ther's a better way to explain this...

We had some more accurate progress reporting in close_reachable(),
discussed in
https://public-inbox.org/git/87efe5qqks.fsf@evledraar.gmail.com/ I still
think the *main* use-case for these things is to just report that we're
not hanging, so maybe the proper solution is to pick up Duy's patch to
display a spinner insted of a numeric progress.

>>  		commit = lookup_commit(the_repository, &oids->list[i]);
>>
>>  		if (commit)
>>  			commit->object.flags &= ~UNINTERESTING;
>>  	}
>> +	stop_progress(&progress);
>>  }
