Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D549C1F454
	for <e@80x24.org>; Wed, 31 Oct 2018 06:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728795AbeJaPZH (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Oct 2018 11:25:07 -0400
Received: from mail-it1-f196.google.com ([209.85.166.196]:32820 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727231AbeJaPZH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Oct 2018 11:25:07 -0400
Received: by mail-it1-f196.google.com with SMTP id p11-v6so608778itf.0
        for <git@vger.kernel.org>; Tue, 30 Oct 2018 23:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eFoI2eEGfEjEagoYGUhiw/CFngQwBaNhG3nKXvjsmLg=;
        b=cdtRFVVGGjrc7QvXMTzBwTKUFg2FM4RlWUqBnTb4i+idRFbgjNMuatMBQCvkdrnDx0
         dqs3ePz6Iwawr4BiMlEqbOsm1VoVUaWmKwkYmutv2vbk0U1KpI0BRIqVXSQkFBsL96h0
         3STsYDCmCGo9AN86WhHEtTKA9smKxaRwTCA29z331bVP+ZU4UiRNofxlx+AmH0vKxJMh
         iS0R08s4gJ7yYtn448lgkJtfDjgwWD5m1ItqLsqqo5Vk3eq6w18OAjz9Q0z5rfZ7mZ2O
         gJXmAGQTgyqqkX3tTBCKwYKkwP1Sq1VcIfgwhGrUPD1jc6duO9HGWtFagkCiDccUl38r
         g2jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eFoI2eEGfEjEagoYGUhiw/CFngQwBaNhG3nKXvjsmLg=;
        b=EGUTcnC+lljw1/Km4465rr/idAHDu480VX/xz03swp1MmQJEBc7N8nzg6l2+NUEFjT
         H8AI6qIS0HfNxHY131ygXqY9rbkl5Fipln63fE3VnKCxDHCYsih29RFD5Anu/1OO5AdF
         KV2R1HngF3K8YumeqPdkoyS43bk339RbTunP3+iNIwwXXLkWPS1JBZWyqM+7rc3lq8h5
         atvjS1gb//AaWctKVQ/1AVFR320OhsWmcF3AY3h3wms5ovyi2tk7A/bKj2fQOy7Bbrpe
         2BODqkzU5IQTuCFiZ1WkjQTrBdt36G00U94opFqc4ETFu3em4EKMAxZIIJfFhKfGYENB
         8ALQ==
X-Gm-Message-State: AGRZ1gLSD9BokF6eg24h5zi2lzwCF/4qBrotd7IvLbYQRtuTIRWGi8aq
        do0wM7u6U0xCdpEu4AZwWNvp4Byg99InxMzmGFY=
X-Google-Smtp-Source: AJdET5dfjDKW4f8Y9CJtzSp+n9G1JVsYyZjtliaoG8K2NJsVS0XQLvoweAVQ8eRUAKnDEFs/w4NtB038/hjf8XnKxME=
X-Received: by 2002:a02:2708:: with SMTP id g8-v6mr1249298jaa.93.1540967301832;
 Tue, 30 Oct 2018 23:28:21 -0700 (PDT)
MIME-Version: 1.0
References: <20180802061505.2983-1-chriscool@tuxfamily.org>
 <20180802061505.2983-10-chriscool@tuxfamily.org> <CAGZ79kYPik87zvLUPPKFzcATFUdBFcXrAkTYxpxvAQy6w1CcUw@mail.gmail.com>
 <CAP8UFD1ia1xWk9pjfTUQ3zD7=dP=8UjKzf=G0ptsz=qRH8_X+Q@mail.gmail.com> <20181016174304.GA221682@aiede.svl.corp.google.com>
In-Reply-To: <20181016174304.GA221682@aiede.svl.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 31 Oct 2018 07:28:09 +0100
Message-ID: <CAP8UFD3nrhjANwNDqTwx5ZtnZNcnbAFqUN=u=LrvzuH4+3wQQA@mail.gmail.com>
Subject: Re: [PATCH v4 9/9] Documentation/config: add odb.<name>.promisorRemote
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>, git <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Ben Peart <Ben.Peart@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        Eric Wong <e@80x24.org>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Beat Bolli <dev+git@drbeat.li>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

On Tue, Oct 16, 2018 at 7:43 PM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> Hi Christian,
>
> On Tue, Sep 25, 2018, Christian Couder wrote:
>
> > In the cover letter there is a "Discussion" section which is about
> > this, but I agree that it might not be very clear.
> >
> > The main issue that this patch series tries to solve is that
> > extensions.partialclone config option limits the partial clone and
> > promisor features to only one remote. One related issue is that it
> > also prevents to have other kind of promisor/partial clone/odb
> > remotes. By other kind I mean remotes that would not necessarily be
> > git repos, but that could store objects (that's where ODB, for Object
> > DataBase, comes from) and could provide those objects to Git through a
> > helper (or driver) script or program.
>
> Thanks for this explanation.  I took the opportunity to learn more
> while you were in the bay area for the google summer of code mentor
> summit and learned a little more, which was very helpful to me.

Thanks for inviting me at the Google offices in Sunnyvale and San
Francisco to discuss about this and other issues.

> The broader picture is that this is meant to make Git natively handle
> large blobs in a nicer way.  The design in this series has a few
> components:
>
>  1. Teaching partial clone to attempt to fetch missing objects from
>     multiple remotes instead of only one.  This is useful because you
>     can have a server that is nearby and cheaper to serve from (some
>     kind of local cache server) that you make requests to first before
>     falling back to the canonical source of objects.
>
>  2. Simplifying the protocol for fetching missing objects so that it
>     can be satisfied by a lighter weight object storage system than
>     a full Git server.  The ODB helpers introduced in this series are
>     meant to speak such a simpler protocol since they are only used
>     for one-off requests of a collection of missing objects instead of
>     needing to understand refs, Git's negotiation, etc.
>
>  3. (possibly, though not in this series) Making the criteria for what
>     objects can be missing more aggressive, so that I can "git add"
>     a large file and work with it using Git without even having a
>     second copy of that object in my local object store.

Yeah, I think this is a good summary of the issues I have been trying
to address.

> For (2), I would like to see us improve the remote helper
> infrastructure instead of introducing a new ODB helper.  Remote
> helpers are already permitted to fetch some objects without listing
> refs --- perhaps we will want to
>
>  i. split listing refs to a separate capability, so that a remote
>     helper can advertise that it doesn't support that.  (Alternatively
>     the remote could advertise that it has no refs.)
>
>  ii. Use the "long-running process" mechanism to improve how Git
>      communicates with a remote helper.

Yeah, I agree that improving the remote helper infrastructure is
probably better than what I have been trying to add. And I agree with
the above 2 steps you propose.

> For (1), things get more tricky.  In an object store from a partial
> clone today, we relax the ordinary "closure under reachability"
> invariant but in a minor way.  We'll need to work out how this works
> with multiple promisor remotes.
>
> The idea today is that there are two kinds of packs: promisor packs
> (from the promisor remote) and non-promisor packs.  Promisor packs are
> allowed to have reachability edges (for example a tree->blob edge)
> that point to a missing object, since the promisor remote has promised
> that we will be able to access that object on demand.  Non-promisor
> packs are also allowed to have reachability edges that point to a
> missing object, as long as there is a reachability edge from an object
> in a promisor pack to the same object (because of the same promise).
> See "Handling Missing Objects" in Documentation/technical/partial-clone.txt
> for more details.
>
> To prevent older versions of Git from being confused by partial clone
> repositories, they use the repositoryFormatVersion mechanism:
>
>         [core]
>                 repositoryFormatVersion = 1
>         [extensions]
>                 partialClone = ...
>
> If we change the invariant, we will need to use a new extensions.* key
> to ensure that versions of Git that are not aware of the new invariant
> do not operate on the repository.

Maybe the versions of Git that are not aware of the new invariant
could still work using only the specified remote while the new
versions would know that they can use other remotes by looking at
other config variables.

> A promisor pack is indicated by there being a .promisor file next to
> the usual .pack file.  Currently the .promisor file is empty.  The
> previous idea was that once we want more metadata (e.g. for the sake of
> multiple promisor remotes), we could write it in that file.  For
> example, remotes could be associated to a <promisor-id> and the
> .promisor file could indicate which <promisor-id> has promised to serve
> requests for objects reachable from objects in this pack.

I think it would be nicer if we could avoid any modification of the
file format. Also I don't think it is important for the user to be
able to blame any specific remote for not being able to serve a given
object, because sometimes it could be better for a remote that would
be too slow to provide a large blob to just reject any request for
this blob and to instead expect users to get it from another faster
remote.

I think that when Git cannot get a promised object it should just tell
that it could not get it from the configured promisor remotes and list
the promisor remotes (along maybe with the associated URLs).

> That will complicate the object access code as well, since currently
> we only find who has promised an object during "git fsck" and similar
> operations.  During everyday access we do not care which promisor
> pack caused the object to be promised, since there is only one promisor
> remote to fetch from anyway.

I agree.

> So much for the current setup.  For (1), I believe you are proposing to
> still have only one effective <promisor-id>, so it doesn't necessarily
> require modifying the extensions.* configuration.

Yes, it would be better if we don't need to modify the "extensions.*"
configuration. So the remote given by the "extensions.partialClone"
config option would only be a remote that can provide all the objects
to previous versions of Git (those that don't work with more than one
promisor remote).

> Instead, the idea is
> that when trying to access an object, we would follow one of a list of
> steps:
>
>  1. First, check the local object store. If it's there, we're done.
>  2. Second, try alternates --- maybe the object is in one of those!
>  3. Now, try promisor remotes, one at a time, in user-configured order.

Yeah, 1. and 2. are already working, so we just need to implement 3..

> In other words, I think that for (1) all we would need is a new
> configuration
>
>         [object]
>                 missingObjectRemote = local-cache-remote
>                 missingObjectRemote = origin

Yeah, we could add some configuration to define an order. I don't
think it's really important though to be able to configure an order
right now. I think it's more important to first just have a mechanism
to iterate over the promisor remotes. By default if no order is
configured, the order we use to iterate can be the order of the
promisor remotes in the config file(s).

> The semantics would be that when trying to access a promised object,
> we attempt to fetch from these remotes one at a time, in the order
> specified.  We could require that the remote named in
> extensions.partialClone be one of the listed remotes, without having
> to care where it shows up in the list.

Yeah, when we implement this in the config, it would make sense to
have such kind of semantics. If some promisor remotes are not
configured in the order, we could also decide that these remotes
should be tried after those that are configured, or maybe we should
decide that they should not be tried except if the remote is specified
by "extensions.partialClone".

> That way, we get the benefit (1) without having to change the
> semantics of extensions.partialClone and without having to care about
> the order of sections in the config.  What do you think?

I mostly agree with you, though I would like to work on things in the
following order:

  1) Teaching partial clone to attempt to fetch missing objects from
multiple remotes instead of only one using the order in the config.

  2) Simplifying the protocol for fetching missing objects so that it
can be satisfied by a lighter weight object storage system than a full
Git server.

  3) Making it possible to explicitly define an order in which the
remotes are accessed.

  4) Making the criteria for what objects can be missing more
aggressive, so that I can "git add" a large file and work with it
using Git without even having a second copy of that object in my local
object store.

Or maybe even switching the above 3) and 4).

I think we should also decide how we specify different parameters for
each promisor remote. There is already "core.partialclonefilter", but
if we have more than one promisor remote, we might want to have
different partial clone filters for different remotes.

I am ok with using the "remote.<remote name>.*" namespace, for example
"remote.<remote name>.partialclonefilter". "core.partialclonefilter"
would then be the default partial clone filter for the remote
specified by "extensions.partialClone".

After saying all the above though, I still wonder if keeping
"extensions.partialClone" and "core.partialclonefilter" is not already
a burden that will make us implement unnecessarily complex semantics
and will become even more a burden over time.

For example what if we later want to say something like:

"When fetching from this remote, I want to use these promisor remotes
in this order, though, when pushing to that (maybe different) remote,
I want to
use those (maybe a bit different) promisor remotes in that order."

which I think should become quite reasonable to ask for.

So I think it might be interesting to look at how we would ideally
want to specify such kind of configuration, as it might lead us to
follow a different, though perhaps saner over time, direction.

Thanks,
Christian.
