Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7EEC433F5
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 02:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231675AbiCCCUX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 21:20:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231643AbiCCCUV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 21:20:21 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F22C5240BA
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 18:19:35 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id hw13so7581227ejc.9
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 18:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4zNo7tGCl6kCsvydQ09EEH2ZLAY86rnxqAwyBQplju4=;
        b=mq5SDtYSOBkpHnT3RUWaZplBilQo7wFkUgs1kwDeTfWsOK2pSb+WovXo2GVE6cHtzQ
         lVTa6eJ2Pm2AQT/LRZjoPouydaDJ9dkP4B9aFWLLXbdevnhw3t+kDaI2onvsBzwjgb74
         tFOXoNRavOPaYFLJe8skFK6ASTBGiRlbbXJMAL6vOREqurW/nwW4Uq0mzIGzdTGHTaq2
         nZrstXbbYADDeFWmgsoYNpV7gSwAIxbBC1l3/7s4jVZ0WROCOjNsiIHsJYdXByVHt9Ey
         Wb2QQp7+tnkANj88BXAyL0k8v0Hp7qaqHEIM0I1VQjRBDKIc7HZxHLYkoT8i/uOgKsEK
         jWeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4zNo7tGCl6kCsvydQ09EEH2ZLAY86rnxqAwyBQplju4=;
        b=uDvVYXPt6rTv7QUxqjCNUlpazIn0JhQZUXJkxtejpXYVW1YPuf9A+6xgUfkvLP25g4
         EWpyHUVjaVM+nCC16NzBX4mtZt96s1xYLowtu+IC5IzzVF2kLyFOPdt7eGWGaLVSfO4s
         sRh+H61UEwmASsfGZpPxdXJ7rv9SRoTJzYnEQJVzddhinxIkWMOBKfvb7kFMelw7GV+q
         5ZSJ2N/M+8rrM3X1Vt/2c9R+8vwnfnVbRnFW9KHbMaXSh661Y3cDEsy+g1y0eiNaf1Lm
         AD7OZCl/iisXMBJ3Wm6UT8bwpcmt+1MW6xOmq8lfvu4+uw69zzBSIVQn2iPfP5XS0KG5
         dIKQ==
X-Gm-Message-State: AOAM532WFvA6G+sf8jqzyHIg9FsbWLQ5tSyhLDgePbOvthLhGcZ7nbFv
        P76pQkp++zYnO4+N/advQhoGE3aTuSTMZFzI0Dg=
X-Google-Smtp-Source: ABdhPJxkdgXCcGP5y24aYsA2jFxsHGtZGuLT5EnIhr+7MmQzT0NGXyWPVQiNtm+UMIwfaCb+JjzK6zhC0HmhY/y6z7M=
X-Received: by 2002:a17:906:3a18:b0:6cd:ba45:995f with SMTP id
 z24-20020a1709063a1800b006cdba45995fmr26031987eje.328.1646273974237; Wed, 02
 Mar 2022 18:19:34 -0800 (PST)
MIME-Version: 1.0
References: <pull.1160.git.1645641063.gitgitgadget@gmail.com>
 <0abec796b0089b84d23cb52bb127788fdd04961c.1645641063.git.gitgitgadget@gmail.com>
 <CABPp-BEXgmGW=Lk5-JE6bc1F8RbGidDVjALAZraeZ-2_u476gg@mail.gmail.com> <4f5f4751-c047-b9de-28a7-6ee3c31826f0@github.com>
In-Reply-To: <4f5f4751-c047-b9de-28a7-6ee3c31826f0@github.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 2 Mar 2022 18:19:22 -0800
Message-ID: <CABPp-BFA4fPhrOpfC8ROQAqzofn+7LTiYXmz+AqOFEx5H_sYGA@mail.gmail.com>
Subject: Re: [PATCH 01/25] docs: document bundle URI standard
To:     Derrick Stolee <derrickstolee@github.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 2, 2022 at 6:06 AM Derrick Stolee <derrickstolee@github.com> wrote:
>
[...]
> >> +bundle.<id>.timestamp::
> >> +       (Optional) This value is the number of seconds since Unix epoch
> >> +       (UTC) that this bundle was created. This is used as an approximation
> >> +       of a point in time that the bundle matches the data available at
> >> +       the origin server.
> >
> > As an approximation, is there a risk of drift where the user has
> > timetamp A which is very close to B and makes decisions based upon it
> > which results in their not getting dependent objects they need?  Or is
> > it just an optimization for them to only download certain bundles and
> > look at them, and then they'll iteratively go back and download more
> > (as per the 'requires' field below) if they don't have enough objects
> > to unbundle what they previously downloaded?
>
> The user doesn't ever generate the timestamp. It saves the timestamp
> from the most-recent bundle it downloaded. The only risk of timestamp
> drift is if the server has multiple machines generating different sets
> of bundles, and places those machines behind a load balancer.
>
> This is something the server can control, likely by having one job
> generate the bundle set and then distributing them to various storage
> locations.

My first thought here was "can, or must?"...and if it's not "must",
are there ramifications we have to consider in the design of how the
Git client behaves?  However, reading through the rest of the document
and your response, I don't think there is no problem here because
below you mention that when fetching, the client can grab the latest
bundle, and if it lacks some of the necessary pre-requisite objects,
it can just iteratively download previous bundles until they have
enough.

Also, the main thing that prompted my question was my wondering about
how to get pre-existing clones to start taking advantage of bundle
URIs for future fetches, and this timestamp approximation seemed
problematic.  But in addition to iteratively grabbing more bundles,
you also suggested that such users would just be forced to reclone,
which would also avoid timestamp approximation issues.

And, just now, I noticed the little "Optional" you put in the
description that I somehow missed previously.  I just can't read.
Anyway, it sounds like the timestamp isn't used for correctness for
the client to know what to grab, it's more just an aid for grabbing a
useful initial set.

> >> +Cloning with Bundle URIs
> >> +------------------------
> >> +
> >> +The primary need for bundle URIs is to speed up clones. The Git client
> >> +will interact with bundle URIs according to the following flow:
> >> +
> >> +1. The user specifies a bundle URI with the `--bundle-uri` command-line
> >> +   option _or_ the client discovers a bundle URI that was advertised by
> >> +   the remote server.
> >> +
> >> +2. The client downloads the file at the bundle URI. If it is a bundle, then
> >> +   it is unbundled with the refs being stored in `refs/bundle/*`.
> >> +
> >> +3. If the file is instead a table of contents, then the bundles with
> >> +   matching `filter` settings are sorted by `timestamp` (if present),
> >> +   and the most-recent bundle is downloaded.
> >> +
> >> +4. If the current bundle header mentions negative commid OIDs that are not
> >> +   in the object database, then download the `requires` bundle and try
> >> +   again.
> >> +
> >> +5. After inspecting a bundle with no negative commit OIDs (or all OIDs are
> >> +   already in the object database somehow), then unbundle all of the
> >> +   bundles in reverse order, placing references within `refs/bundle/*`.
> >> +
> >> +6. The client performs a fetch negotiation with the origin server, using
> >> +   the `refs/bundle/*` references as `have`s and the server's ref
> >> +   advertisement as `want`s. This results in a pack-file containing the
> >> +   remaining objects requested by the clone but not in the bundles.
> >
> > Does step 6 potentially involve a new, second connection to the origin
> > server?  I'm wondering about timeouts closing the original connection
> > while the client is downloading the bundle uris.  Will the client
> > handle that automatically, or will they potentially be forced to
> > re-issue the clone/fetch command?  I'm also wondering if we want to be
> > "nice" and pre-emptively close the original connection to the server
> > while we fetch the bundles -- for example, some servers have a
> > threadpool for processing fetch/clone requests and will only serve a
> > limited number; IIRC Gerrit operates this way.  I have no idea if
> > that's a good idea or a horrible one.  If a second connection is tried
> > automatically, will the user potentially be forced to re-enter
> > connection credentials again?  And is there a risk that after the
> > second connection, there are new bundle uris for the client to go
> > fetch (and/or a removal of the original ones, e.g. replacing the old
> > "daily" bundle with a new one)?  Does this possibly cause us some
> > timestamp confusion as I noted earlier?
>
> If the user is cloning over HTTPS, then the connections are stateless
> and this is not any different than how it works today.
>
> When using SSH, we will probably want to close the SSH connection on
> the client and then reopen it to avoid keeping that connection open
> during the download. The implementation in this RFC does _not_ do this,
> but I think it would be valuable to do.

Right, I was thinking of ssh.

> >> +Note that during a clone we expect that all bundles will be required. The
> >> +client could be extended to download all bundles in parallel, though they
> >> +need to be unbundled in the correct order.
> >
> > What does required mean?  That the origin server can refuse to service
> > requests if the client does not have commits found in said bundles?
> > That new enough Git clients are expected to download all the bundles
> > (and no config option will be provided to users to just do traditional
> > negotation without first downloading them)?  Something else?
>
> The assumption I'm making here is that all but on bundle in the table
> of contents contains a thin pack, depending on an "earlier" bundle.
> The client would be unsuccessful unbundling any single bundle except
> the earliest one first.
>
> The benefit of this assumption is that we could also implement parallel
> downloads of all bundles in the future.
>
> This assumes that there is no way to organize the bundles to communicate
> that a user might want only the objects reachable from the default branch,
> but also some users want every reachable object. Such an organization
> would require extra information to describe two "parallel" lists of
> bundles that could be selected for each of those categories. If such an
> organization is valuable, then the table of contents can be extended with
> information to communicate such an organization. The downside is that
> clients with this "v1" version would download extra data based on this
> assumption.

That makes sense, and seems to suggest, as you clarify below, that no
bundles are required.  However, that makes your earlier sentence "Note
that during a clone we expect that all bundles will be required" a bit
jarring and perhaps in need of rewording to clarify the intent (e.g.
"Note that during a clone we expect that clients will download and use
all bundles, not just a subset of them.").

> > If users are doing a single-branch clone or a shallow clone, will the
> > requirements still hold?  (I'm not a fan of shallow clones, but they
> > are sadly used in a number of places and I'm curious how the features
> > interact or conflict.)
>
> The current specification does not focus on shallow clones. The TOC
> could be extended to say "this bundle is for a shallow clone of
> commit <X>" if that was valuable.

I guess it could, though I suspect the easier answer is that clients
ignore the bundle URIs for shallow clones, because doing otherwise is
just a nightmare for managing bundles with various depths.  (As a side
note, is the likely result of this series that shallow clones become
the bad citizens that put the heaviest load on the origin server?)

> For single-branch clones, my expectation is that the bundles will
> give the user more information than they need for that clone. The
> negotiation will find out what they need from that branch that was
> not in the bundles, but the bundles will also contain a lot of
> objects that are not reachable from that ref. (This is also up to
> the discretion of the bundle server operator, since they could
> focus on only objects reachable from a subset of refs, minimizing
> the bundle data while increasing the potential size of that
> follow-up fetch.)

Makes sense to me.

[...]
> I expect that users who already cloned will never configure their
> repositories to include a bundle server.
>
> That said, if you run 'git bundle fetch <uri>' in an existing
> repository, then it will fetch only the newest bundle and see if you
> already have all of its negative refs. If so, then it stops and that
> is the only bundle that is downloaded. Its timestamp is stored for
> the next 'git bundle fetch'.
>
> In the case where the server starts advertising a bundle URI, a
> 'git fetch' will not start using that URI. That check only happens
> during 'git clone' (as currently designed).

So people have to reclone to take advantage of this performance improvement?

It probably doesn't matter to me; our repository sizes are such that I
suspect we may only use this feature for clones anyway.  I'm just
curious.

[...]
> >> +Here are a few example error conditions:
> >> +
> >> +* The client fails to connect with a server at the given URI or a connection
> >> +  is lost without any chance to recover.
> >> +
> >> +* The client receives a response other than `200 OK` (such as `404 Not Found`,
> >> +  `401 Not Authorized`, or `500 Internal Server Error`).
[...]
> >
> > Should these result in warnings so that folks can diagnose slower
> > connections, or should they be squelched?  (I'm thinking particularly
> > of the `401 Not Authorized` case in combination with users never
> > having had to use a credential helper before.)
>
> There is a lot of work to be done around polishing the user ergonomics
> here, and that is an interesting thing to consider for a second round
> after the basic standard is established. I appreciate that you are
> already thinking about the user experience in these corner cases.

Thanks, but I think this particular situation (using ssh for clone and
possibly not having credential helpers setup before) isn't so much of
a corner case:
  * Setting up cloning via ssh is easy (on Linux and maybe Mac),
whereas https involves more hoops.  So, at my previous employer,
cloning was only available via ssh.  (No idea if they've since changed
or adopted a Git repository manager of some sort.)
  * At current employer, ssh is default, and has at various times been
the _only_ option:
    * Back when we used gitolite, gitolite was intrinsically tied to
ssh (probably still is, right?)
    * For years during part of the time we used Gerrit, https cloning
was disabled.  This was probably a configuration oversight at first,
but I inherited the system and didn't notice this for years, likely
because of having migrated from gitolite.  I think I enabled it, and
possibly disabled it again because Gerrit liked to default to https
for download links if it was a possibility.  Or maybe I disabled it
again due to the authentication issues that also affected GHE
(mentioned below).
    * For a few years during the early usage of GHE, https cloning was
disabled.  This was not an oversight, but an unfortunate fallout of
some kind of issues in our then-authentication scheme (salesforce,
duo, who knows what else).  Something in that stack didn't work
together in a way that somehow only adversely affected cloning (at
least to my knowledge), but since everyone was used to cloning solely
via ssh anyway, the folks running GHE simply disabled cloning via
https.  We've since changed authentication schemes, and it appears
https was re-enabled somewhere along the way (I just tried to verify).

So, I expect many users here have never cloned any of our internal
repositories with https, and thus likely have not set up a credential
helper.  And my previous employer would have been in the same boat and
it would not surprise me if they still are.  Combine the above with
the following:
  * The Infosec team here will not allow unauthenticated source code
access; so the bundle access would have to be authenticated here.
  * I'm pretty certain my former employer would have felt the same.

So, to me at least, this particular case (using ssh for clone and
possibly not having credential helpers setup) feels pretty common.
Not that you're doing anything wrong for this case, just noting that
we need to make sure such folks are aware of the authentication
considerations.
