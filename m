Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDA56C433EF
	for <git@archiver.kernel.org>; Wed,  8 Jun 2022 19:46:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbiFHTq6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jun 2022 15:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbiFHTq4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jun 2022 15:46:56 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B8A3BF8B
        for <git@vger.kernel.org>; Wed,  8 Jun 2022 12:46:54 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id v7so17351801ilo.3
        for <git@vger.kernel.org>; Wed, 08 Jun 2022 12:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=SgwD5U6HPKvY4F46TchmNPcR27feaDM87PCAcrw+yq0=;
        b=YuuNpPIAqpWl50lDh3bskZghz6lYTNqlOqoW46UmqyLva/HdSQ4h3Ls3KQ6kbwjTJ5
         jumb1Lmr8sUVL6gBBgiuUkxBJy/+g1gbq6UVfd0zhK2P6wNt1wjyB3ZGwh8IhnVwTzB0
         kGy9ftcgHdDgqxQ+Xow2hIok1349yuKtNSvmGAVKAsz4ODxf2/qw1XqOefsPJ2CSHN85
         Wzzzyqu9ofjE1RNME2FcAWwvTnlvStCMZ0o0E/AwKKwxLQlksPUI4ukp8uFwQWJg3GMe
         E2RA2+ZThx34Ei6uaYhpBYgRPBSN7Bax1tRi5DlsEq55pkto4e0a43UUQkgg+wQ/GXTY
         3VWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=SgwD5U6HPKvY4F46TchmNPcR27feaDM87PCAcrw+yq0=;
        b=APvbxLJWZOcCeoGa+aZJt2bckmqV+upPofLK5ItsGf6VF+x56uXjUuUUa+Y89OBVZS
         Vl7HAvmwmAFFnybKc4XkApdMkw/jb9vNBoXE2PTB2ZYzkJbvmdXEhyq1AAqsrxY4xvWb
         lBNVxSEzlkG4+aMEJhKuny/xD9gWw2FA12EykgFKmkC6YM7r9+7cvon5GYDI5n0Ttv1f
         rkkXYjgFRW25EecZPVWdeSbuX8F75GioGJ8ylPB6+HRPSdh4PKoYsbMLpCCzFOecoLtf
         DtO2Em+GUrHGD4AkhVQJGn5LqfmRAJaLOqaxfwhi5upGY/Gm0TaHQsUe6/DbCYfPDJda
         sG8A==
X-Gm-Message-State: AOAM530kTGKFl+3tDfIGC9ES0HkzHSnIpmyinr+5vjL9NaQIRm5Td36i
        /lw/MR6GJFsVlmBUTCmYBei8
X-Google-Smtp-Source: ABdhPJwpd9Vsoi2SQa+jMYyiavIOiMe8OSIipUcSXEJWvJNAeuizuvZcTHICPd7ehbtQhoAlzIbC/Q==
X-Received: by 2002:a92:ca4b:0:b0:2d3:931c:cc76 with SMTP id q11-20020a92ca4b000000b002d3931ccc76mr21830552ilo.210.1654717613541;
        Wed, 08 Jun 2022 12:46:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:90ef:16b:eb19:f653? ([2600:1700:e72:80a0:90ef:16b:eb19:f653])
        by smtp.gmail.com with ESMTPSA id y5-20020a920905000000b002cf28d7ad23sm2073079ilg.51.2022.06.08.12.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Jun 2022 12:46:53 -0700 (PDT)
Message-ID: <48e722dc-f860-f7a6-36d0-b0106087aef4@github.com>
Date:   Wed, 8 Jun 2022 15:46:50 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/6] docs: document bundle URI standard
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        avarab@gmail.com, dyroneteng@gmail.com, Johannes.Schindelin@gmx.de
References: <pull.1248.git.1654545325.gitgitgadget@gmail.com>
 <e771b2971d092af5ea8a47eb708d03e34b284a0f.1654545325.git.gitgitgadget@gmail.com>
 <xmqqtu8x1fd4.fsf@gitster.g>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqtu8x1fd4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/6/2022 8:33 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> +Cloning with Bundle URIs
>> +------------------------
>> +
>> +The primary need for bundle URIs is to speed up clones. The Git client
>> +will interact with bundle URIs according to the following flow:
>> +
>> +1. The user specifies a bundle URI with the `--bundle-uri` command-line
>> +   option _or_ the client discovers a bundle list advertised by the
>> +   Git server.
>> +
>> +2. If the downloaded data from a bundle URI is a bundle, then the client
>> +   inspects the bundle headers to check that the negative commit OIDs are
> 
> Although "negative" would be understandable to pros, the commits
> required to unbundle a bundle file are officially called
> "prerequisite commits" (cf. "git bundle --help"), so that may be
> easier to understand by ordinary readers.

Ok. I can work to replace this language throughout.
 
>> +   present in the client repository. If some are missing, then the client
>> +   delays unbundling until other bundles have been unbundled, making those
>> +   OIDs present. When all required OIDs are present, the client unbundles
>> +   that data using a refspec. The default refspec is
>> +   `+refs/heads/*:refs/bundles/*`, but this can be configured.
> 
> The refs/bundles/ appear in the document only here, and it is
> unclear why we even want it (I am assuming this is against gc while
> "git clone" is still running) or how we are going to retire it, if
> ever.  If there are multiple bundle files involved in this "git clone",
> to anchor objects that are necessary against "gc", don't we need to use
> refs/bundles/<i>/* or something like that, where <i> is uniquely assigned
> number locally?

The real reason to keep them in refs/bundles/ is because then those
refs can be used in the incremental 'git fetch' after downloading the
bundles (in perpetuity) while not stomping refs/heads or refs/remotes/

>> +3. If the file is instead a bundle list, then the client inspects the
>> +   `bundle.list.mode` to see if the list is of the `all` or `any` form.
> 
> If the downloaded file is not a bundle (e.g. "git bundle list-heads"
> barfs on it) and it is not parseable with our configuration parser,
> do we error out, or do we pretend as if that bundle file or the TOC
> did not exist (if the bundle list with mode=any at the higher level
> has appropriate alternatives)?

I think the best thing to do would be to fail as gracefully as
possible here. In particular: give a warning that the remote did not
give anything helpful, but continue with the normal fetching from the
remote without help from bundles.

>> +   a. If `bundle.list.mode=all`, then the client considers all bundle
>> +      URIs. The list is reduced based on the `bundle.<id>.filter` options
>> +      matching the client repository's partial clone filter.
> 
> OK, this answers my earlier question nicely.  It probably means that
> either the presentation order needs a bit of rethinking, or "we
> group by .filter" needs to be mentioned a lot earlier.

Ok. It may even need to be _implemented_ a lot earlier, looking at my
current outline of future changes.

>> Then, all
>> +      bundle URIs are requested. If the `bundle.<id>.timestamp` heuristic
>> +      is provided, then the bundles are downloaded in reverse-
>> +      chronological order, stopping when a bundle has all required OIDs.
> 
> Stop as soon as just one bundle has all the prerequisite objects, or
> should we keep going until all bundles have their prerequisites
> satisfied?  I presume it is the latter.

True. We keep going until all have their required OIDs. With a .requires
chain of "1 requires 2" and "2 requires 3", it is possible that "1"
has a prerequisite commit that actually exists in "3", but somehow the
bundle "2" can unbundle in the client's repository.

One could argue that the "1" bundle should have a direct .requires
relationship on "3" (in addition to "2"), but for simplicity I think
it is OK to imply "transitive requires".

Using "all" here should make it clearer.

>> +      The bundles can then be unbundled in chronological order. The client
>> +      stores the latest timestamp as a heuristic for avoiding future
>> +      downloads if the bundle list does not advertise newer bundles.
> 
> So we see a list, we start grabbing from new to old.  Newer ones
> that are based on older ones may have dependencies, so we do not
> unbndle until we have all the prerequisites for them.  The bundles
> that satisfy their prerequisites are unbundled---that would give us
> enough objects to play with.  What happens to the refs recorded in
> them, though?

Those refs are translated into refs/bundles/. If multiple bundles
have the same refs/heads/ included, then the newest ones would
overwite those refs in refs/bundles/.

> Is the timestamp per the serving host, or per the CDN host that
> serve us bundle files, or...?  I guess it is premature to discuss it
> here. "git clone" bootstraps from the advertisement made only by a
> single serving host, so the single newest timestamp among the
> bundles used from the bundle list is what we store here.  How that
> timestamp is used is primarily of interest in future fetching, which
> would be discussed later.

The bundle provider is responsible for making the timestamps make
sense as an opaque increasing token.

>> +Fetching with Bundle URIs
>> +-------------------------
>> +
>> +When the client fetches new data, it can decide to fetch from bundle
>> +servers before fetching from the origin remote. This could be done via a
>> +command-line option, but it is more likely useful to use a config value
>> +such as the one specified during the clone.
>> +
>> +The fetch operation follows the same procedure to download bundles from a
>> +bundle list (although we do _not_ want to use parallel downloads here). We
>> +expect that the process will end when all negative commit OIDs in a thin
>> +bundle are already in the object database.
> 
> I do not see why we do not want to use parallel download, though.
> If our last bundle download was last month, and they have two newer
> bundles since then, don't we want to grab both at the same time?
> Wasn't that the point of recording the newest timestamp when "git
> clone" grabbed bundles?

In theory, we have also been fetching from the origin, so we might have
already received all of the objects in that second (or first!) bundle.
By going in reverse-chronological order, we minimize the amount of data
downloaded (assuming that is the most expensive part of the operation).

This is something where we have room to experiment. With Ævar's idea of
downloading only the headers, we could download all headers in parallel
and halt the download for any bundles where we have all of the ref tips.

>> +Error Conditions
>> +----------------
>> +
>> +If the Git client discovers something unexpected while downloading
>> +information according to a bundle URI or the bundle list found at that
>> +location, then Git can ignore that data and continue as if it was not
>> +given a bundle URI. The remote Git server is the ultimate source of truth,
>> +not the bundle URI.
>> +
>> +Here are a few example error conditions:
>> +
>> +* The client fails to connect with a server at the given URI or a connection
>> +  is lost without any chance to recover.
>> +
>> +* The client receives a response other than `200 OK` (such as `404 Not Found`,
>> +  `401 Not Authorized`, or `500 Internal Server Error`). The client should
>> +  use the `credential.helper` to attempt authentication after the first
>> +  `401 Not Authorized` response, but a second such response is a failure.
>> +
>> +* The client receives data that is not parsable as a bundle or table of
>> +  contents.
> 
> Is it an error if bundle.<id>.list and the contents disagree?

I think this can be flexible. It is not difficult to treat the .list
value as advisory, so we can ignore disagreements. If we start making
decisions that hinge on the value of .list, then we can start treating
it as an error.

Or: maybe the .list value is so "advisory" that it is useless, and I
should just drop it from the schema.

> It is fine to call the possibility other than "a bundle file" "table
> of contents", but then let's do so consistently throughout the document.
> When we explain bundle.<id>.list, we should not call the other
> possibility "list" but "table of contents", for example.

Sorry, I had intended to find-and-replace all of these instances, but
missed some that cross line breaks.

>> +* The bundle list describes a directed cycle in the
>> +  `bundle.<id>.requires` links.
>> +
>> +* A bundle includes a filter that does not match expectations.
> 
> Does this refer to a mismatch between the filter recorded in a
> bundle and bundle.<id>.filter entry that described the bundle?

Yes. I can make that more explicit.

>> +* The client cannot unbundle the bundles because the negative commit OIDs
>> +  are not in the object database and there are no more
>> +  `bundle.<id>.requires` links to follow.
> 
> Is a .requires link mandatory?  In a mode=all table of contents, we
> should not have to have .requires at all.  In the above description
> on how bundle files are downloaded and in what order in Clone and
> Fetch operations, I didn't see any mention of .requires at all, but
> I think there should be.  For example, the timestamp heuristics may
> say the bundle A is the latest.  In a mode=any table of contents,
> shouldn't bundles that contain prerequisite commits of the bundle A
> be pointed by A's .requires fields?

It could be considered useful for the .timestamp heuristic, or we
could infer the .requires value as "the next most-recent bundle" in
that heuristic. (So maybe we remove it from the schema.)

With "all" but no heuristic, then we need everything without knowing
where to "start" and trying to minimize downloads.

>> +4. Allow the client to understand the `bundle.list.forFetch` configuration
>> +   and the `bundle.<id>.timestamp` heuristic. When `git clone` discovers a
>> +   bundle URI with `bundle.list.forFetch=true`, it configures the client
>> +   repository to check that bundle URI during later `git fetch <remote>`
>> +   commands.
> 
> So bundle.list.forFetch is, unlike everything else we saw that
> looked like a configuration variable in this document, a
> configuration variable whose value is boolean?
> 
> Ah, no.  You mean the "git clone" sees a bundle URI, grabs it and
> sees a table of contents, and in it, finds "bundle.forFetch" is set
> to true?  Then "git fetch <remote>" is configured to also use bundle
> URI?

Yes. The bundle provider is advertising "I'm working hard to help you
with your 'git fetches' after your initial clone."

> It is unclear to me (with the information given here so far), why we
> want this.  Isn't this something the responder to "git fetch" can
> advertise over the wire?  If we leave a permanent record in the
> resulting repository to do the bundle URI during 'fetch', wouldn't
> it become more cumbersome to cancel (iow "no, you no longer want to
> talk to me with bundle URI feature") from the server side?

I've tried very hard to make the bundle provider as independent from
the origin Git server as possible (including no relationship at all).
Even if the origin Git server knows about a bundle provider at a
given URI, it does not necessarily know if _at this moment_ the
provider is bundling for fetches.

>> +5. Allow clients to discover bundle URIs during `git fetch` and configure
>> +   a bundle URI for later fetches if `bundle.list.forFetch=true`.
>> +
>> +6. Implement the "inspect headers" heuristic to reduce data downloads when
>> +   the `bundle.<id>.timestamp` heuristic is not available.
> 
> Sounds sensible, even though I do not offhand see why the "peek
> header and stop" is any less useful when the timestamp heurisitc is
> available.

Yes, it is still helpful with the heuristic. I can remove that
phrasing. (This functionality is _required_ to help incremental
fetches when a heuristic is not provided.)

>> +A major downside to this mechanism is that the origin server needs to know
>> +_exactly_ what is in those packfiles, and the packfiles need to be available
>> +to the user for some time after the server has responded. This coupling
>> +between the origin and the packfile data is difficult to manage.
> 
> Hmph.  I strongly suspect that there are Googlers on the list who
> have been managing such JGit server installations.  Has this
> "coupling" been difficult to manage for you guys in the real world?
>
>> +Further, this implementation is extremely hard to make work with fetches.
> 
> IOW, they do this only for clones and not fetches?

The last time I spoke with Googlers about this subject, what I heard
from them was "Yes, this is hard to get right for incremental fetches,
but the benefit for clones is big enough that we are happy with just
that." If advancements have come about since then to work with
incremental fetches, then I'd love to hear about it.
 
>> +Related Work: GVFS Cache Servers
>> +--------------------------------
>> ...
>> +During a `git fetch`, a hook requests the prefetch endpoint using the
>> +most-recent timestamp from a previously-downloaded prefetch packfile.
>> +Only the list of packfiles with later timestamps are downloaded.
> 
> That sounds quite straight-forward.  Do you envision that their
> incremental snapshot packfile chains can somehow be shared with the
> bundle URI implementations?  Doesn't it make it more cumbersome that
> this proposal uses the bundles as the encapsulation format, rather
> than packfiles?  As you are sending extra pieces of information on
> top of the payload in the form of table-of-contents already, I
> wonder if bundle.<id>.uri should point at a bare packfile (instead
> of a bundle), while multi-valued bundle.<id>.prerequisite give the
> prerequisite objects?  The machinery that is already generating the
> prefetch packfiles already know which packfile has what
> prerequisites in it, so it rather looks simpler if the solution did
> not involve bundles.

The prefetch packfiles could be replaced with bundle URIs, if desired.

The reason bundles were not needed for the GVFS protocol was that
all other object data not in those prefetch packfiles is downloaded
via direct requests (one object per request or a batch of objects
requested from a list of OIDs) and not from an incremental fetch. The
VFS for Git clients only talk to the origin server for the ref
advertisement and talk to the cache servers for the objects necessary
to satisfy the client's Git command. (Also: the client pushes directly
to the origin server.)

So in this world, the bundle URIs could be used as a replacement for
downloading these prefetch packfiles (bundles with filter=blob:none)
but the bundled refs become useless to the client.

Thanks,
-Stolee
