Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32354C433F5
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 19:47:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E13E61A56
	for <git@archiver.kernel.org>; Thu, 18 Nov 2021 19:47:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbhKRTuN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Nov 2021 14:50:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233541AbhKRTuM (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Nov 2021 14:50:12 -0500
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0568DC061574
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 11:47:12 -0800 (PST)
Received: by mail-lf1-x130.google.com with SMTP id z34so31589705lfu.8
        for <git@vger.kernel.org>; Thu, 18 Nov 2021 11:47:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=e8jlqRwc5CNmGHOr4T+QbLctrJCFO5lhMhvVDyZ8Qmk=;
        b=QLlgHWkLVfmtRPxV02QUaVMRmKS+39ZN4N1o6tXPquV4cPminyr33t31rurd6mQlww
         +2RWZ8YX7XSaBFL70/7Ua8hDGjQntB2PkWWMwGDpif0j3aIdVe7/jmtAUp0ZWuQLYgXh
         VTgsWCrokzsVonNn/cw2IT4XII5LDFk8JUqJHd+IikhTX+X1g3A7cAa/lNwJFQv6ASZX
         KC0n1Dho77s5A+Qdi23vTJ727NthvNfCBQUMCyN6Nr+ql5g/m+viXxjUShRCQkEqKe7w
         X0WCaolvfPZ4Ba5HlypDyQKvOXtEw7bQx16sl6ztsBL+rhngmBpmEoqwi0CrSibe8pIb
         MTmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=e8jlqRwc5CNmGHOr4T+QbLctrJCFO5lhMhvVDyZ8Qmk=;
        b=WR6JciR+nEB/HyRkbxOFfX2VmjZj5vrEOc1/F9jSAIJbBFS1xpHXygzQTnDjNYWt/C
         zULpNc7W+HNE4IhmxvhvLqqQAb19eeCdXhXQfPquwS+6EB+y92zdBxlc/n8REMqEDyb0
         jIhI7SNvVQ32K9y7MdyOmxZPD5qqnbZyA0PyLbv7wMpSfCdRdIZWkGmYR8km5C/w2HOy
         3gNhTGrsTT0oWE9ArJ1xAP/ZHn2wy/vVz9Qcn3Igco01SDCLTJ8+l94DkVsCQSIyMS3Q
         lfTYCqrKOj2mjZ/h8gIHdFo9IgvVv6UdsxVimgVOOooOnohhW/8LJN44ySZqnupoo5ua
         wdyg==
X-Gm-Message-State: AOAM531QNWEHbZ2sM2VFiJD/klX0Kxz8LeLVlKRhzuTo5+xq/Vtytu4f
        Z40ysN/WBqQSdOAJlaSVngnRDrpN0WCHI5NVdeQ=
X-Google-Smtp-Source: ABdhPJy0bWCfR7WMnJhtdqwIzHulRzs0qjKTl2UGp8bo5SdWtHRkCy2M2weg8ONnS15jkcNMfoic1qS7csuxn5zhbu0=
X-Received: by 2002:a05:651c:2119:: with SMTP id a25mr19302173ljq.131.1637264830278;
 Thu, 18 Nov 2021 11:47:10 -0800 (PST)
MIME-Version: 1.0
References: <211110.86r1bogg27.gmgdl@evledraar.gmail.com> <20211111004724.GA839@neerajsi-x1.localdomain>
 <211111.86pmr7pk9o.gmgdl@evledraar.gmail.com> <CANQDOdcdhfGtPg0PxpXQA5gQ4x9VknKDKCCi4HEB0Z1xgnjKzg@mail.gmail.com>
 <xmqq35ntxp9y.fsf@gitster.g>
In-Reply-To: <xmqq35ntxp9y.fsf@gitster.g>
From:   Neeraj Singh <nksingh85@gmail.com>
Date:   Thu, 18 Nov 2021 11:46:59 -0800
Message-ID: <CANQDOdc+j0PgRJw0bzTLoAnSq=taabXSE4r9jrYczNaBHX9XuQ@mail.gmail.com>
Subject: Re: RFC: A configuration design for future-proofing fsync() configuration
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Wong <e@80x24.org>, Christoph Hellwig <hch@lst.de>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 18, 2021 at 11:00 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Neeraj Singh <nksingh85@gmail.com> writes:
>
> > After sleeping on it for a while, I'm willing to consolidate the
> > configuration along the lines that you've specified, but I'd like to
> > reduce the number of degrees of freedom.
> >
> > My proposal in Documentation form:
> >
> > core.fsync::
> > A comma-separated list of parts of the repository which should be hardened by
> > calling fsync when created or modified. When an aggregate option is
> > specified, a subcomponent can be overriden by prefixing it with a '-'. For
> > example, `core.fsync=all,-index` means "fsync everything except the index".
> > Items which are not fsync'ed may be lost in the even of an unclean system
> > shutdown. This setting defaults to `objects,-loose-objects`
> > +
> > * `loose-objects` hardens objects added to the repo in loose-object form.
> > * `packs` hardens objects added to the repo in packfile form and the related
> >   bitmap and index files.
> > * `commit-graph` hardens the commit graph file.
> > * `refs` (future) hardens references when they are modified.
> > * `index` (future) hardens the index when it is modified.
> > * `objects` is an aggregate option that includes `loose-objects`, `packs`, and
> >   `commit-graph`.
> > * `all` is an aggregate option that syncs all individual components above.
> > * `none` is an aggregate option that disables fsync completely.
>
> I wasn't closely following the discussion at all, but the above
> simplification may still even be too fine-grained?  For example,
> what does it mean to care less about the robustness of loose objects
> than packs or ref updates?  How does an existing fine-grained
> classification interact with new classes of filesystem entity we
> will introduce under .git in the future?  Imagine that we didn't
> have .midx and multi-pack bitmap yet; since 'loose-objects',
> 'packs', and 'commit-graph' are the only three groups we can choose
> to place any "objects and reachability" related data in, we need to
> pick one, and choosing 'packs' class may be the choice of least
> resistance, the default kitchen-sync category for anything related
> to "object".  Or just like 'commit-graph' has its own category,
> would we invent a new class and call it 'multi-pack'?
>
> I cannot shake the feeling that these are making everything
> unnecessarily complex and adding more things that we need to explain
> to the end-user---and the worst part is I doubt it would help the
> end-users very much tot understand what gets explained.
 I agree with you that this is fairly complex. I did two things to
come up with this specific list:
1) Looked at what we're fsyncing today (most of these items are being
synced through the CSUM_FSYNC flag).  Some of these things should
perhaps not be fsynced if they are derived metadata that can be
reconstructed easily.  For instance, can the commit-graph file be
recomputed easily enough from the ODB and the refs? How hard is it to
reconstruct the pack-indexes? Maybe they should get their own item.
2) Thought about what's necessary to be able to retrieve data out of
git after a series of commands followed by a system crash.  If I fetch
a repo, modify some worktree files, add the modifications, and then
commit them, what does Git need to persist to not lose unique work?
We need to sync the packfiles since they form the base of the commit
graph and trees and it may be difficult to construct a sane repo if we
have objects without their dependencies. We obviously need to sync the
new objects the user is adding. We need to sync the index after 'add'
in case we crash between 'add' and 'commit', so the user can find
their new objects.  Lastly we need to sync the refs after a commit so
that the user can find the added objects after switching branches.

I also wanted to make sure we could express the current state of
fsyncing so that users could go back to that if the cost of syncing
some particular thing is too high in their workload.

I expect that people should really specify `objects` to sync all of
the things that comprise the object store and leave it to us to decide
which subcomponents are considered derived metadata.

>
> > core.fsyncMethod::
> > A value indicating the strategy Git will use to harden repository data using
> > fsync and related primitives.
> > +
> > * 'default' uses the fsync(2) system call or platform equivalents.
> > * 'batch' uses APIs such as sync_file_range or equivalent to reduce the number
> >   of hardware FLUSH CACHE requests sent to the storage hardware.
> > * 'writeout-only' (future) issues requests to send the writes to the storage
> > * hardware, but does not send any FLUSH CACHE request.
> > * 'syncfs' (future) uses the syncfs API, where available, to sync all of the
> >   files on the same filesystem as the Git repo.
>
> How would an end-user choose among these?  If they assume that the
> version of Git they use is bug-free, is there a reason why they
> should ever pick 'default' over 'batch', for example?  Shouldn't we
> be the one to choose the best approach on the underlying filesystem
> for the users, instead of forcing them to choose?
>
> As implementors, these choices may be of interest and give you a
> handy way to compare different design, but I am not sure if we want
> to give anything more complex than a binary choice, "default" and
> "eatmydata".

Maybe `default` should be renamed `fsync` to indicate the specific
action to be performed and no value can be "let git decide".  I think
the "eatmydata" option would be core.fsync=none and core.fsyncMethod
would then be ignored.  One reason to have this option would be to
allow distributors and organizations to choose a good config based on
the actual filesystem them deploy on.  On Windows, it would be clear
that we should use 'batch' because we're committed to making sure that
setting is actually safe on our filesystems (we'll fix bugs in the FS
if we find out that people are reporting corrupt repos).  Given that
the Linux and POSIX durability situation is really murky, it's hard to
see how Git can give any useful guarantee on those platforms.

>
> > core.fsyncObjectFiles::
> > If `true`, this legacy setting is equivalent to `core.fsync=objects`. If
> > `core.fsync` is explicitly specified, then this setting is ignored.
>
> I think deprecating this very-specific knob is a good idea,
> regardless of how complex we'd want to make the alternative.
>

Glad you agree.  I hope we see others weigh in on the tradeoff between
complexity and control.

Thanks,
Neeraj
