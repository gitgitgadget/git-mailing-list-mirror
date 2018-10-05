Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22A121F453
	for <e@80x24.org>; Fri,  5 Oct 2018 13:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728538AbeJEUEj (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Oct 2018 16:04:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:35334 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728494AbeJEUEi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Oct 2018 16:04:38 -0400
Received: by mail-wr1-f65.google.com with SMTP id w5-v6so13501881wrt.2
        for <git@vger.kernel.org>; Fri, 05 Oct 2018 06:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=ZWYoETbS9tIRQ1thur/G96J6eQm34M0xI/Iz1RhbRoo=;
        b=XYd0HgWS5faSpczQsbd/gPb4JRYYcHESMfNdSYBMO59UijvHEey8xyqZ54J13LmJ8D
         1wljkZ3A5Ts1GrWKdU2bD3urthtEoy0bWSf1eKUYPD3kvApI9H4jd9NmXTkKF1NDleIq
         ZXOhWnpHTMQN30dj7ZPwHIp3GuzfMet59g83VHyDOk/7HQC1vCJRXic0TDXuGSkmqr46
         N5EOv7dtIbdoiT9GVeyXGfPL1xPjJYxNos7wpEjpn1+IOWJMog2wb4Vw1z5fEgci77i/
         SHSpgRQKut+0zHIpNHmiygHDqagmN9etV+981hl9TsijlICYn3q3GRa7SyQeTeC34Kw5
         JUtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=ZWYoETbS9tIRQ1thur/G96J6eQm34M0xI/Iz1RhbRoo=;
        b=FMHzTI2W081RmhKOTAJbLVkRN4LpgSiV1FnkLavTah0XEgaIg1Ut1nzdyKqfsVh8tE
         fS6IHWOIr60MIQSYLiGT4o1G+GdguAMuPdsYW35IEeul0riqf37opDf3P6kzqigtp1OD
         xnezr+bYDVTMp0x6rA0kEJl5tKznTpaUJp4E+6EfsUCeifaAfY5NrmRPcaYesEOnEAx8
         T0lyRIlKzr8BcTvPkYboDqjh/HK+Ht0o+PO4Tv0kBmP4Qa5o6KNia/l+i57c6/zpbEe7
         eW34GA23EoVW5qmrHR1JZYgc+5nWqnsG6cZY2+NXm9p80Nzigb3xrGo8fdi9hBDSW2hZ
         r+TA==
X-Gm-Message-State: ABuFfojp2IuHEUgxAOnFjaShSyIrpm7y27mcmpK+eaB7p/tL2d8WeQah
        3SrFlvJtV34EEZ8TL5JUUXHWEZ1y
X-Google-Smtp-Source: ACcGV61XkpdCHaNarA91XhWcgAvZuRdwkjYIK99JklMN3cil1ZhbSxkDKr87Yzq4QD17aG+xk55scQ==
X-Received: by 2002:adf:e387:: with SMTP id e7-v6mr8363989wrm.94.1538744758163;
        Fri, 05 Oct 2018 06:05:58 -0700 (PDT)
Received: from evledraar (proxy-gw-a.booking.com. [5.57.21.8])
        by smtp.gmail.com with ESMTPSA id j46-v6sm11805406wre.91.2018.10.05.06.05.57
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 05 Oct 2018 06:05:57 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>
Subject: Re: [RFC PATCH] We should add a "git gc --auto" after "git clone" due to commit graph
References: <87tvm3go42.fsf@evledraar.gmail.com>
        <87in2hgzin.fsf@evledraar.gmail.com>
        <dcb8f115-ce3c-64fa-50cc-dd03569c0164@gmail.com>
User-agent: Debian GNU/Linux testing (buster); Emacs 25.2.2; mu4e 1.1.0
In-reply-to: <dcb8f115-ce3c-64fa-50cc-dd03569c0164@gmail.com>
Date:   Fri, 05 Oct 2018 15:05:56 +0200
Message-ID: <87ftxkh7bf.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Oct 05 2018, Derrick Stolee wrote:

> On 10/4/2018 5:42 PM, Ævar Arnfjörð Bjarmason wrote:
>> I don't have time to polish this up for submission now, but here's a WIP
>> patch that implements this, highlights:
>>
>>   * There's a gc.clone.autoDetach=false default setting which overrides
>>     gc.autoDetach if 'git gc --auto' is run via git-clone (we just pass a
>>     --cloning option to indicate this).
>
> I'll repeat that it could make sense to do the same thing on clone
> _and_ fetch. Perhaps a "--post-fetch" flag would be good here to
> communicate that we just downloaded a pack from a remote.

I don't think that makes sense, but let's talk about why, because maybe
I've missed something, you're certainly more familiar with the
commit-graph than I am.

The reason to do it on clone as a special-case or when the file is
missing, is because we know the file is desired (via the GC config), and
presumably is expected to help performance, and we have 0% of it. So by
going from 0% to 100% on clone we'll get fast --contains and other
goodies the graph helps with.

But when we're doing a fetch, or really anything else that runs "git gc
--auto" we can safely assume that we have a recent enough graph, because
it will have been run whenever auto-gc kicked in.

I.e.:

    # Slow, if we assume background forked commit-graph generation
    # (which I'm avoiding)
    git clone x && cd x && git tag --contains
    # Fast enough, since we have an existing commit-graph
    cd x && git fetch && git tag --contains

I *do* think it might make sense to in general split off parts of "gc
--auto" that we'd like to be more aggressive about, simply because the
ratio of how long it takes to do, and how much it helps with performance
makes more sense than a full repack, which is what the current heuristic
is based on.

And maybe when we run in that mode we should run in the foreground, but
I don't see why git-fetch should be a special case there, and in this
regard, the gc.clone.autoDetach=false setting I've made doesn't make
much sence. I.e. maybe we should also skip forking to the background in
such a mode when we trigger such a "mini gc" via git-commit or whatever.

>>   * A clone of say git.git with gc.writeCommitGraph=true looks like:
>>
>>     [...]
>>     Receiving objects: 100% (255262/255262), 100.49 MiB | 17.78 MiB/s, done.
>>     Resolving deltas: 100% (188947/188947), done.
>>     Computing commit graph generation numbers: 100% (55210/55210), done.
>
> This looks like good UX. Thanks for the progress here!
>
>>   * The 'git gc --auto' command also knows to (only) run the commit-graph
>>     (and space is left for future optimization steps) if general GC isn't
>>     needed, but we need "optimization":
>>
>>     $ rm .git/objects/info/commit-graph; ~/g/git/git --exec-path=$PWD -c gc.writeCommitGraph=true -c gc.autoDetach=false gc --auto;
>>     Annotating commits in commit graph: 341229, done.
>>     Computing commit graph generation numbers: 100% (165969/165969), done.
>>     $
>
> Will this also trigger a full commit-graph rewrite on every 'git
> commit' command?

Nope, because "git commit" can safely be assumed to have some
commit-graph anyway, and I'm just special casing the case where it
doesn't exist.

But if it doesn't exist and you do a "git commit" then "gc --auto" will
be run, and we'll fork to the background and generate it...

>  Or is there some way we can compute the staleness of
> the commit-graph in order to only update if we get too far ahead?
> Previously, this was solved by relying on the auto-GC threshold.

So re the "I don't think that makes sense..." at the start of my E-Mail,
isn't it fine to rely on the default thresholds here, or should we be
more aggressive?

>>   * The patch to gc.c looks less scary with -w, most of it is indenting
>>     the existing pack-refs etc. with a "!auto_gc || should_gc" condition.
>>
>>   * I added a commit_graph_exists() exists function and only care if I
>>     get ENOENT for the purposes of this gc mode. This would need to be
>>     tweaked for the incremental mode Derrick talks about, but if we just
>>     set "should_optimize" that'll also work as far as gc --auto is
>>     concerned (e.g. on fetch, am etc.)
>
> The incremental mode would operate the same as split-index, which
> means we will still look for .git/objects/info/commit-graph. That file
> may point us to more files.

Ah!

>> +int commit_graph_exists(const char *graph_file)
>> +{
>> +	struct stat st;
>> +	if (stat(graph_file, &st)) {
>> +		if (errno == ENOENT)
>> +			return 0;
>> +		else
>> +			return -1;
>> +	}
>> +	return 1;
>> +}
>> +
>
> This method serves a very similar purpose to
> generation_numbers_enabled(), except your method only cares about the
> file existing. It ignores information like `core.commitGraph`, which
> should keep us from doing anything with the commit-graph file if
> false.
>
> Nothing about your method is specific to the commit-graph file, since
> you provide a filename as a parameter. It could easily be "int
> file_exists(const char *filename)".

I was being paranoid about not doing this if it didn't exist but it was
something else than ENOENT (e.g. permission error?), but in retrospect
that's silly. I'll drop this helper and just use file_exists().
