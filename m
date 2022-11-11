Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87F4C4332F
	for <git@archiver.kernel.org>; Fri, 11 Nov 2022 23:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234318AbiKKX2h (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Nov 2022 18:28:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233752AbiKKX2f (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Nov 2022 18:28:35 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EF0DDF7E
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 15:28:33 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id b3so10428648lfv.2
        for <git@vger.kernel.org>; Fri, 11 Nov 2022 15:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GfopasnvjCbwVCy0y9WCxFA0hG/Awj2UVVfO/JYNBqo=;
        b=NL4yHBez44acB+kbXhb/iDNcnJohhfoQt3jH2po2brKzYrJiPBLvwpMQRwKi/2AYWe
         M4Ekkfw4DJPCAku7F0pb8nl/0JwMfdvRgmYF+hPiSuqXhRZt4zFGSPLB1bR4wtQSnK3L
         qn/qxrioCoqWDgnkz1QEgWaX8xU6dR2yJsCXfy6U60YYAfkjpEI9eYyYuLH7pBvhKW5c
         jZCnM6RD9m4Y56sgs77e0GzqfIkBtnaJRY5AlKyKHui/8j50aazHOb+88O3eaAAqb7Wp
         +Lf/DiOWUM+Iw0If/zvSAI8D5e6h34MgjBucloe9qHEzQ961PxQYS0uM/NX+sMyLyk4K
         e2EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GfopasnvjCbwVCy0y9WCxFA0hG/Awj2UVVfO/JYNBqo=;
        b=vxJvVmRVWL7YUJUEOYcsx6p/61rZQpPm3JBkPlsGj25J05E1hlvTq/KY3s+L2CgSrP
         fci9Spt1OOcGqwJHeZiqbSlFUDBsYb4mTNbC9WV+vzG2DMf+2OdFTLbW90QJYmel64ol
         bahAxpJbkDMti2pAfiGVTBvRFvhnVXiPG4r8oThKrcRM7bhCP/SBgV02ppXzJ1KZMc3U
         PtDDyEZKxUdNMhqvpHlhl+kYLiqZIIzcSR5vnVcoVn8/begP8SZ49q36JtgO9TD8BPpg
         olz8PRBizjQzaKfLnC7nbhKljTzaXaGnfCB4WLr2d6WLFLhKlrG6QtyMVhv3o6igCTO0
         vdlQ==
X-Gm-Message-State: ANoB5pn6S/khmYuGJ389+L4PpuBIy9GMNxvwDM6TjiBTb6RMqnBgAKI3
        4XzhIDnzmfj9mKIT0sqOXsEWk6DiDg5fa7KAayg=
X-Google-Smtp-Source: AA0mqf4qftP0MgN0h2q2OqidkR85ZEVnVjhTd0NsgKcP+6grc+MctE3ipufQgU0rH5bWG9d74sfFB2RFljYyvFZzOZo=
X-Received: by 2002:ac2:5d69:0:b0:4b4:1036:bbb with SMTP id
 h9-20020ac25d69000000b004b410360bbbmr1341046lft.65.1668209310791; Fri, 11 Nov
 2022 15:28:30 -0800 (PST)
MIME-Version: 1.0
References: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
In-Reply-To: <pull.1408.git.1667846164.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 11 Nov 2022 15:28:18 -0800
Message-ID: <CABPp-BEZK2KJHY+=Ta3VUzNjJKY=evPiAtp5UQFTVLMD0qreVQ@mail.gmail.com>
Subject: Re: [PATCH 00/30] [RFC] extensions.refFormat and packed-refs v2 file format
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, jrnieder@gmail.com,
        Derrick Stolee <derrickstolee@github.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 7, 2022 at 11:01 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Introduction
> ============
>
> I became interested in our packed-ref format based on the asymmetry between
> ref updates and ref deletions: if we delete a packed ref, then the
> packed-refs file needs to be rewritten. Compared to writing a loose ref,
> this is an O(N) cost instead of O(1).
>
> In this way, I set out with some goals:
>
>  * (Primary) Make packed ref deletions be nearly as fast as loose ref
>    updates.

Performance is always nice.  :-)

>  * (Secondary) Allow using a packed ref format for all refs, dropping loose
>    refs and creating a clear way to snapshot all refs at a given point in
>    time.

Is this secondary goal the actual goal you have, or just the
implementation by which you get the real underlying goal?

To me, it appears that such a capability would solve both (a) D/F
conflict problems (i.e. the ability to simultaneously have a
refs/heads/feature and refs/heads/feature/shiny ref), and (b) case
sensitivity issues in refnames (i.e. inability of some users to work
with both a refs/heads/feature and a refs/heads/FeAtUrE, due to
constraints of their filesystem and the loose storage mechanism).  Are
either of those the goal you are trying to achieve (I think both would
be really nice, more so than the performance goal you have), or is
there another?

> I also had one major non-goal to keep things focused:
>
>  * (Non-goal) Update the reflog format.
>
> After carefully considering several options, it seemed that there are two
> solutions that can solve this effectively:
>
>  1. Wait for reftable to be integrated into Git.
>  2. Update the packed-refs backend to have a stacked version.
>
> The reftable work seems currently dormant. The format is pretty complicated
> and I have a difficult time seeing a way forward for it to be fully
> integrated into Git. Personally, I'd prefer a more incremental approach with
> formats that are built for a basic filesystem. During the process, we can
> create APIs within Git that can benefit other file formats within Git.
>
> Further, there is a simpler model that satisfies my primary goal without the
> complication required for the secondary goal. Suppose we create a stacked
> packed-refs file but only have two layers: the first (base) layer is created
> when git pack-refs collapses the full stack and adds the loose ref updates
> to the packed-refs file; the second (top) layer contains only ref deletions
> (allowing null OIDs to indicate a deleted ref). Then, ref deletions would
> only need to rewrite that top layer, making ref deletions take O(deletions)
> time instead of O(all refs) time. With a reasonable schedule to squash the
> packed-refs stack, this would be a dramatic improvement. (A prototype
> implementation showed that updating a layer of 1,000 deletions takes only
> twice the time as writing a single loose ref.)

Makes sense.  If a ref is re-introduced after deletion, then do you
remove it from the deletion layer and then write the single loose ref?

> If we want to satisfy the secondary goal of passing all ref updates through
> the packed storage, then more complicated layering would be necessary. The
> point of bringing this up is that we have incremental goals along the way to
> that final state that give us good stopping points to test the benefits of
> each step.

I like the incremental plan.  Your primary goal perhaps benefits
hosting providers the most, while the second appears to me to be an
interesting usability improvement (some of my users might argue it's
even a bugfix) that would affect users with far fewer refs as well.
So, lots of benefits and we get some along the way to the final plan.

> Stacking the packed-refs format introduces several interesting strategy
> points that are complicated to resolve. Before we can do that, we first need
> to establish a way to modify the ref format of a Git repository. Hence, we
> need a new extension for the ref formats.
>
> To simplify the first update to the ref formats, it seemed better to add a
> new file format version to the existing packed-refs file format. This format
> has the exact lock/write/rename mechanics of the current packed-refs format,
> but uses a file format that structures the information in a more compact
> way. It uses the chunk-format API, with some tweaks. This format update is
> useful to the final goal of a stacked packed-refs API, since each layer will
> have faster reads and writes. The main reason to do this first is that it is
> much simpler to understand the value-add (smaller files means faster
> performance).
>
>
> RFC Organization
> ================
>
> This RFC is quite long, but the length seemed necessary to actually provide
> and end-to-end implementation that demonstrates the packed-refs v2 format
> along with test coverage (via the new GIT_TEST_PACKED_REFS_VERSION
> variable).
>
> For convenience, I've broken each section of the full RFC into parts, which
> resembles how I intend to submit the pieces for full review. These parts are
> available as pull requests in my fork, but here is a breakdown:


> Part I: Optionally hash the index
> =================================
>
> [1] https://github.com/derrickstolee/git/pull/23 Packed-refs v2 Part I:
> Optionally hash the index (Patches 1-2)
>
> The chunk-format API uses the hashfile API as a buffered write, but also all
> existing formats that use the chunk-format API also have a trailing hash as
> part of the format. Since the packed-refs file has a critical path involving
> its write speed (deleting a packed ref), it seemed important to allow
> apples-to-apples comparison between the v1 and v2 format by skipping the
> hashing. This is later toggled by a config option.
>
> In this part, the focus is on allowing the hashfile API to ignore updating
> the hash during the buffered writes. We've been using this in microsoft/git
> to optionally speed up index writes, which patch 2 introduces here. The file
> format instead writes a null OID which would look like a corrupt file to an
> older 'git fsck'. Before submitting a full version, I would update 'git
> fsck' to ignore a null OID in all of our file formats that include a
> trailing hash. Since the index is more short-lived than other formats (such
> as pack-files) this trailing hash is less useful. The write time is also
> critical as the performance tests demonstrate.

This feels like a diversion from your goals.  Should it really be up-front?

Reading through the patches, the first patch does appear to be
necessary but isn't well motivated from the cover letter.  The second
patch seems orthogonal to your series, though it is really nice to see
index writes dropping almost to half the time.

> Part II: Create extensions.refFormat
> ====================================
>
> [2] https://github.com/derrickstolee/git/pull/24 Packed-refs v2 Part II:
> create extensions.refFormat (Patches 3-7)
>
> This part is a critical concept that has yet to be defined in the Git
> codebase. We have no way to incrementally modify the ref format. Since refs
> are so critical, we cannot add an optionally-understood layer on top (like
> we did with the multi-pack-index and commit-graph files). The reftable draft
> [6] proposes the same extension name (extensions.refFormat) but focuses
> instead on only a single value. This means that the reftable must be defined
> at git init or git clone time and cannot be upgraded from the files backend.
>
> In this RFC, I propose a different model that allows for more customization
> and incremental updates. The extensions.refFormat config key is multi-valued
> and defaults to the list of files and packed.

This last sentence doesn't parse that well for me.  Perhaps "...and
defaults to a combination of 'files' and 'packed', meaning supporting
both loose refs and packed refs "?

> In the context of this RFC,
> the intention is to be able to add packed-v2 so the list of all three values
> would allow Git to write and read either file format version (v1 or v2). In
> the larger scheme, the extension could allow restricting to only loose refs
> (just files) or only packed-refs (just packed) or even later when reftable
> is complete, files and reftable could mean that loose refs are the primary
> ref storage, but the reftable format serves as a drop-in replacement for the
> packed-refs file. Not all combinations need to be understood by Git, but
> having them available as an option could be useful for flexibility,
> especially when trying to upgrade existing repositories to new formats.
>
> In the future, beyond the scope of this RFC, it would be good to add a
> stacked value that allows a stack of files in packed-refs format (whose
> version is specified by the packed or packed-v2 values) so we can further
> speed up writes to the packed layer. Depending on how well that works, we
> could focus on speeding up ref deletions or sending all ref writes straight
> to the packed-refs layer. With the option to keep the loose refs storage, we
> have flexibility to explore that space incrementally when we have time to
> get to it.
>
>
> Part III: Allow a trailing table-of-contents in the chunk-format API
> ====================================================================
>
> [3] https://github.com/derrickstolee/git/pull/25 Packed-refs v2 Part III:
> trailing table of contents in chunk-format (Patches 8-17)
>
> In order to optimize the write speed of the packed-refs v2 file format, we
> want to write immediately to the file as we stream existing refs from the
> current refs. The current chunk-format API requires computing the chunk
> lengths in advance, which can slow down the write and take more memory than
> necessary. Using a trailing table of contents solves this problem, and was
> recommended earlier [7]. We just didn't have enough evidence to justify the
> work to update the existing chunk formats. Here, we update the API in
> advance of using in the packed-refs v2 format.
>
> We could consider updating the commit-graph and multi-pack-index formats to
> use trailing table of contents, but it requires a version bump. That might
> be worth it in the case of the commit-graph where computing the size of the
> changed-path Bloom filters chunk requires a lot of memory at the moment.
> After this chunk-format API update is reviewed and merged, we can pursue
> those directions more closely. We would want to investigate the formats more
> carefully to see if we want to update the chunks themselves as well as some
> header information.

I like how you point out additional benefits the series could provide,
but leave them out.  Perhaps do the same with the optional index
hashing in patch 2?

> Part IV: Abstract some parts of the v1 file format
> ==================================================
>
> [4] https://github.com/derrickstolee/git/pull/26 Packed-refs v2 Part IV:
> abstract some parts of the v1 file format (Patches 18-21)
>
> These patches move the part of the refs/packed-backend.c file that deal with
> the specifics of the packed-refs v1 file format into a new file:
> refs/packed-format-v1.c. This also creates an abstraction layer that will
> allow inserting the v2 format more easily.
>
> One thing that doesn't exist currently is a documentation file describing
> the packed-refs file format. I would add that file in this part before
> submitting it for full review. (I also haven't written the file format doc
> for the packed-refs v2 format, either.)

Sounds like another win-win opportunity to get someone from the
community to contribute.  :-)   ..Or maybe that's not the best
strategy, since recent empirical evidence suggests that trick doesn't
work.  Oh well, it was worth a shot.

> Part V: Implement the v2 file format
> ====================================
>
> [5] https://github.com/derrickstolee/git/pull/27 Packed-refs v2 Part V: the
> v2 file format (Patches 22-35)
>
> This is the real meat of the work. Perhaps there are ways to split it
> further, but for now this is what I have ready. The very last patch does a
> complete performance comparison for a repo with many refs.
>
> The format is not yet documented, but is broken up into these pieces:
>
>  1. The refs data chunk stores the same data as the packed-refs file, but
>     each ref is broken down as follows: the ref name (with trailing zero),
>     the OID for the ref in its raw bytes, and (if necessary) the peeled OID
>     for the ref in its raw bytes. The refs are sorted lexicographically.
>
>  2. The ref offsets chunk is a single column of 64-bit offsets into the refs
>     chunk indicating where each ref starts. The most-significant bit of that
>     value indicates whether or not there is a peeled OID.
>
>  3. The prefix data chunk lists a set of ref prefixes (currently writes only
>     allow depth-2 prefixes, such as refs/heads/ and refs/tags/). When
>     present, these prefixes are written in this chunk and not in the refs
>     data chunk. The prefixes are sorted lexicographically.
>
>  4. The prefix offset chunk has two 32-bit integer columns. The first column
>     stores the offset within the prefix data chunk to the start of the
>     prefix string. The second column points to the row position for the
>     first ref that has name greater than this prefix (the 0th prefix is
>     assumed to start at row 0, so we can interpret the prefix range from
>     row[i-1] and row[i]).
>
> Between using raw OIDs and storing the depth-2 prefixes only once, this
> format compresses the file to ~60% of its v1 size. (The format allows not
> writing the prefix chunks, and the prefix chunks are implemented after the
> basics of the ref chunks are complete.)
>
> The write times are reduced in a similar fraction to the size difference.
> Reads are sped up somewhat, and we have the potential to do a ref count by
> prefix much faster by doing a binary search for the start and end of the
> prefix and then subtracting the row positions instead of scanning the file
> between to count refs.
>
>
> Relationship to Reftable
> ========================
>
> I mentioned earlier that I had considered using reftable as a way to achieve
> the stated goals. With the current state of that work, I'm not confident
> that it is the right approach here.
>
> My main worry is that the reftable is more complicated than we need for a
> typical Git repository that is based on a typical filesystem. This makes
> testing the format very critical, and we seem to not be near reaching that
> approach. The v2 format here is very similar to existing Git file formats
> since it uses the chunk-format API. This means that the amount of code
> custom to just the v2 format is quite small.
>
> As mentioned, the current extension plan [6] only allows reftable or files
> and does not allow for a mix of both. This RFC introduces the possibility
> that both could co-exist. Using that multi-valued approach means that I'm
> able to test the v2 packed-refs file format almost as well as the v1 file
> format within this RFC. (More tests need to be added that are specific to
> this format, but I'm waiting for confirmation that this is an acceptable
> direction.) At the very least, this multi-valued approach could be used as a
> way to allow using the reftable format as a drop-in replacement for the
> packed-refs file, as well as upgrading an existing repo to use reftable.
> That might even help the integration process to allow the reftable format to
> be tested at least by some subset of tests instead of waiting for a full
> test suite update.

Thanks for providing this background; I also like how it potentially
makes it easier to adopt reftable in the future.

> I'm interested to hear from people more involved in the reftable work to see
> the status of that project and how it matches or differs from my
> perspective.

That wouldn't be me, but I appreciate the comparisons to help me
orient where things are.
