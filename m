Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 018121F454
	for <e@80x24.org>; Tue, 16 Oct 2018 17:43:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbeJQBek (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 21:34:40 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:38803 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727097AbeJQBej (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 21:34:39 -0400
Received: by mail-pl1-f193.google.com with SMTP id q19-v6so8283919pll.5
        for <git@vger.kernel.org>; Tue, 16 Oct 2018 10:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=UjsWqUMM6kCHWs3wopO6l0xpxMnDEd+qKUe6Q3gJqgs=;
        b=rzzUSNnC+P1IWbIZtEw+oP13+DGIQBAC2H9UVkzQ5yUHncAqbrVH2wWQ2JEoWciMMD
         ygl+seb680H4USy/CaJi702kaJYYrMmgg2Ra/3x+9xgQ3tMzbSA1FIcp7sKDOlA7kCVK
         2mN9mkCGzhv38W8W8x2+3xo/aBcTA/a/Cy4nC+5QzrrcA6MMQFQHAvaLNlVkBEbxB7Cq
         l1FHsYX2LK/3MeH9PrbtfvHpbeFKJriVfqmFZgTkmZCQIRxYga0qN9qLK8f4NV7MLAMW
         mMdreR0jSC5Bqfjs+UGA2YOJd6IwTxvZf1z+cVbMjTRDmZisLzZJ6euRkblZnk6oRS+D
         gBxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=UjsWqUMM6kCHWs3wopO6l0xpxMnDEd+qKUe6Q3gJqgs=;
        b=CpErmNozBCgG6QjlPpovWOnZUuliglLXeXACLccdP8g5d3LEPhEWcBMTXIJpvwLnoc
         j9WOQfjlnxXmz1d3/evJah+4b5q6DNYqNAtfOLMAugpKCs72bJ+/EYV2IqlNxVEQRxPv
         suaqEbb1I40lV+OgHQeBNcrGk1oRcyetFATgMR0UTareCS5gMkxc6K2i2CO8t2h8sb7T
         TMg56f1aZEcbBGRB44ZW2qEkawBxfyRQRM9t/Q1gqY4MrUdgRX+mLEUCnEXIySC30NU4
         lNSSRXcHjOtA0PohiBcA95Ow32c+GDvXbVpjLPgj25rtbMDIBuSw7+GvZIqurxjE0YEu
         AUMQ==
X-Gm-Message-State: ABuFfojnaMxZtXDSi3nnNz0Z0klyuGyM52LePjJChpvzrWv3CY2HvKY5
        w0d2R9p/TZAn1PMX4BZnz70=
X-Google-Smtp-Source: ACcGV62PsDxXvlyrZJd9MbJWeGr5dc8DGhnysnMHWmeC26FkgGSHnSsz/wrmrhQ70r//x0Wu9iXvyA==
X-Received: by 2002:a17:902:740a:: with SMTP id g10-v6mr22036563pll.198.1539711787602;
        Tue, 16 Oct 2018 10:43:07 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:913:3fb0:1473:cdbf:42])
        by smtp.gmail.com with ESMTPSA id k24-v6sm18760389pfi.11.2018.10.16.10.43.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 16 Oct 2018 10:43:06 -0700 (PDT)
Date:   Tue, 16 Oct 2018 10:43:04 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Duy Nguyen <pclouds@gmail.com>, Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Subject: Re: [PATCH v4 9/9] Documentation/config: add
 odb.<name>.promisorRemote
Message-ID: <20181016174304.GA221682@aiede.svl.corp.google.com>
References: <20180802061505.2983-1-chriscool@tuxfamily.org>
 <20180802061505.2983-10-chriscool@tuxfamily.org>
 <CAGZ79kYPik87zvLUPPKFzcATFUdBFcXrAkTYxpxvAQy6w1CcUw@mail.gmail.com>
 <CAP8UFD1ia1xWk9pjfTUQ3zD7=dP=8UjKzf=G0ptsz=qRH8_X+Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP8UFD1ia1xWk9pjfTUQ3zD7=dP=8UjKzf=G0ptsz=qRH8_X+Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Christian,

On Tue, Sep 25, 2018, Christian Couder wrote:

> In the cover letter there is a "Discussion" section which is about
> this, but I agree that it might not be very clear.
>
> The main issue that this patch series tries to solve is that
> extensions.partialclone config option limits the partial clone and
> promisor features to only one remote. One related issue is that it
> also prevents to have other kind of promisor/partial clone/odb
> remotes. By other kind I mean remotes that would not necessarily be
> git repos, but that could store objects (that's where ODB, for Object
> DataBase, comes from) and could provide those objects to Git through a
> helper (or driver) script or program.

Thanks for this explanation.  I took the opportunity to learn more
while you were in the bay area for the google summer of code mentor
summit and learned a little more, which was very helpful to me.

The broader picture is that this is meant to make Git natively handle
large blobs in a nicer way.  The design in this series has a few
components:

 1. Teaching partial clone to attempt to fetch missing objects from
    multiple remotes instead of only one.  This is useful because you
    can have a server that is nearby and cheaper to serve from (some
    kind of local cache server) that you make requests to first before
    falling back to the canonical source of objects.

 2. Simplifying the protocol for fetching missing objects so that it
    can be satisfied by a lighter weight object storage system than
    a full Git server.  The ODB helpers introduced in this series are
    meant to speak such a simpler protocol since they are only used
    for one-off requests of a collection of missing objects instead of
    needing to understand refs, Git's negotiation, etc.

 3. (possibly, though not in this series) Making the criteria for what
    objects can be missing more aggressive, so that I can "git add"
    a large file and work with it using Git without even having a
    second copy of that object in my local object store.

For (2), I would like to see us improve the remote helper
infrastructure instead of introducing a new ODB helper.  Remote
helpers are already permitted to fetch some objects without listing
refs --- perhaps we will want to

 i. split listing refs to a separate capability, so that a remote
    helper can advertise that it doesn't support that.  (Alternatively
    the remote could advertise that it has no refs.)

 ii. Use the "long-running process" mechanism to improve how Git
     communicates with a remote helper.

For (1), things get more tricky.  In an object store from a partial
clone today, we relax the ordinary "closure under reachability"
invariant but in a minor way.  We'll need to work out how this works
with multiple promisor remotes.

The idea today is that there are two kinds of packs: promisor packs
(from the promisor remote) and non-promisor packs.  Promisor packs are
allowed to have reachability edges (for example a tree->blob edge)
that point to a missing object, since the promisor remote has promised
that we will be able to access that object on demand.  Non-promisor
packs are also allowed to have reachability edges that point to a
missing object, as long as there is a reachability edge from an object
in a promisor pack to the same object (because of the same promise).
See "Handling Missing Objects" in Documentation/technical/partial-clone.txt
for more details.

To prevent older versions of Git from being confused by partial clone
repositories, they use the repositoryFormatVersion mechanism:

	[core]
		repositoryFormatVersion = 1
	[extensions]
		partialClone = ...

If we change the invariant, we will need to use a new extensions.* key
to ensure that versions of Git that are not aware of the new invariant
do not operate on the repository.

A promisor pack is indicated by there being a .promisor file next to
the usual .pack file.  Currently the .promisor file is empty.  The
previous idea was that once we want more metadata (e.g. for the sake of
multiple promisor remotes), we could write it in that file.  For
example, remotes could be associated to a <promisor-id> and the
.promisor file could indicate which <promisor-id> has promised to serve
requests for objects reachable from objects in this pack.

That will complicate the object access code as well, since currently
we only find who has promised an object during "git fsck" and similar
operations.  During everyday access we do not care which promisor
pack caused the object to be promised, since there is only one promisor
remote to fetch from anyway.

So much for the current setup.  For (1), I believe you are proposing to
still have only one effective <promisor-id>, so it doesn't necessarily
require modifying the extensions.* configuration.  Instead, the idea is
that when trying to access an object, we would follow one of a list of
steps:

 1. First, check the local object store. If it's there, we're done.
 2. Second, try alternates --- maybe the object is in one of those!
 3. Now, try promisor remotes, one at a time, in user-configured order.

In other words, I think that for (1) all we would need is a new
configuration

	[object]
		missingObjectRemote = local-cache-remote
		missingObjectRemote = origin

The semantics would be that when trying to access a promised object,
we attempt to fetch from these remotes one at a time, in the order
specified.  We could require that the remote named in
extensions.partialClone be one of the listed remotes, without having
to care where it shows up in the list.

That way, we get the benefit (1) without having to change the
semantics of extensions.partialClone and without having to care about
the order of sections in the config.  What do you think?

Thanks,
Jonathan
