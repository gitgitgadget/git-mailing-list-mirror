Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6CC70202DD
	for <e@80x24.org>; Wed, 25 Oct 2017 18:10:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932197AbdJYSKz (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Oct 2017 14:10:55 -0400
Received: from mail-it0-f46.google.com ([209.85.214.46]:43765 "EHLO
        mail-it0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932124AbdJYSKy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Oct 2017 14:10:54 -0400
Received: by mail-it0-f46.google.com with SMTP id k70so11636413itk.0
        for <git@vger.kernel.org>; Wed, 25 Oct 2017 11:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=Dd9TYARbrSNjqD7gxxaTa6vdC2atFsARbkhiW/dt/UY=;
        b=GYgTNisrxOM5uLDtMrz7LVGCKknb+fL6fhjhdy6uQpiPK4l3xyAnaRt207Ibfpmlhk
         gHD+eH2p7WguGhP95/gwx+4KruPuwqwEmM3tDbrD4tFycY2mmqjKr9xqFcejANIqv4y8
         8a3v1UdpRbML455vqtKb4yrMulo/Yon7ZN074oLECJp0uouypH5sP3vyV5yjdhVpqjq7
         SprxWqnoyzWUagAxosBA/e59mZCZuPKgi6pw0S5oowU1DZ+ifTDZku+aB4x6YxOD1nS4
         hbv68Gf3u+jSKNFX8ynJPQ2XFxYG9KQR67VvpxcKIX6AcsnF9xpXbHwjK8BSIoN1hlP7
         IRzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Dd9TYARbrSNjqD7gxxaTa6vdC2atFsARbkhiW/dt/UY=;
        b=jJ+tb1Jk6DPCsQDRHmyzMKyNqq/HbwKqIyKHIctbpf8k0YAc8s7YUghd9u1YXoCT6H
         qROghD2lROTprvtXJHcHXZW1bVEX86IZAHFepmJkR4kZQt/h1keK1Kjj5XqhtYuquDMp
         B1sXvElfNwA9WpyHksCzCWOhJHTrY5DdVZa8Fz6Xa62l+OmfoppStl5BezN3zyr2GEfu
         qni7+dxHKkL3bZidoa1sUKG8jbDw8Tb5e8KdpIq6Qhgqmhv0/rk2NwHW6MsgUMdSKZZh
         hOUt4KbSzq5awrZuNIC5Zxaf/r6rPue+5M03n6Yy4C2C17crwjLIoHojvLFu6pAlwgdA
         Kqnw==
X-Gm-Message-State: AMCzsaXK6NMv6QCS68ZalOSLVy4rf7a05aTvsjvJ7bpJGmyf/BrEisOX
        SL1yxr1fz+pbE5vFk9rjDBD6fQ==
X-Google-Smtp-Source: ABhQp+QVu5fu/gJTapifvdPcARD/p0JPK6LT2E2KE1Cen8zztizcMPjwPFLs69NHZNo8Phi0q6XOIw==
X-Received: by 10.36.204.70 with SMTP id x67mr3017059itf.133.1508955053755;
        Wed, 25 Oct 2017 11:10:53 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:c01f:5e59:5832:ba3a])
        by smtp.gmail.com with ESMTPSA id s16sm1604752itb.15.2017.10.25.11.10.51
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 25 Oct 2017 11:10:52 -0700 (PDT)
Date:   Wed, 25 Oct 2017 11:10:50 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     git@vger.kernel.org, spearce@spearce.org, git@jeffhostetler.com,
        gitster@pobox.com, jonathantanmy@google.com, jrnieder@gmail.com,
        peff@peff.net, sbeller@google.com
Subject: Re: [RFC] protocol version 2
Message-ID: <20171025181050.GA18778@google.com>
References: <20171020171839.4188-1-bmwill@google.com>
 <0ba57a04-9321-e765-ed19-3d0e68e1edc0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ba57a04-9321-e765-ed19-3d0e68e1edc0@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/25, Derrick Stolee wrote:
> On 10/20/2017 1:18 PM, Brandon Williams wrote:
> >  Overview
> >==========
> >
> >This document presents a specification for a version 2 of Git's wire
> >protocol.  Protocol v2 will improve upon v1 in the following ways:
> >
> >   * Instead of multiple service names, multiple commands will be
> >     supported by a single service
> >   * Easily extendable as capabilities are moved into their own section
> >     of the protocol, no longer being hidden behind a NUL byte and
> >     limited by the size of a pkt-line (as there will be a single
> >     capability per pkt-line).
> >   * Separate out other information hidden behind NUL bytes (e.g. agent
> >     string as a capability and symrefs can be requested using 'ls-ref')
> >   * Ref advertisement will be omitted unless explicitly requested
> >   * ls-ref command to explicitly request some refs
> 
> Hi Brandon,
> 
> I'm very interested in your protocol as a former server-side dev for
> the VSTS Git server, and understand some of these headaches. We

Always happy to hear that someone is excited about the area I'm working
on :)

> built limited refs specifically to target the problem you are
> solving with ls-ref, but it requires knowledge about the
> authenticated user in order to work. I believe your suggestion is a
> better solution for the Git protocol.

Yes one of the big issues we've run into is the ref advertisement, 1
because it makes it difficult to add any additional features to the
protocol and 2 because it doesn't scale well because all refs are
blasted at the client (unless you use a separate system like you
implemented to reduce that number).  So I'm hoping we can solve (1) by
doing some sort of capability advertisement instead of a ref
advertisement upfront and (2) by allowing clients to express a way of
limiting the ref advertisement server side.

> 
> The "easily extendable" part has specifically caught my interest, as
> we (Microsoft) would like to move most of the GVFS protocol into
> core Git, and this is a great way to do it. Even if not all features
> are accepted by upstream, we could use our GVFS-specific fork of Git
> to communicate to our servers without breaking normal users'
> interactions.

This is one thing I'm excited about too and hope there's enough desire
for such a capability to extend the protocol.  I first was interested in
building such a system when i looked at some of the previous work done
by stephan trying to introduce a protocol v2
(https://public-inbox.org/git/1429658342-5295-1-git-send-email-sbeller@google.com/)
and this idea was further reinforced when I sat down and talked with
some mercurial developers about their protocol and what they did to
migrate to a v2.  I also discovered that their v2 protocol is
service/command oriented and it makes it very simple and easy for
extensions to be added server and client side which allow for additional
commands to be executed during a server/client exchange without breaking
the normal fetch/push interaction.

So I'm hoping that what we decided on for v2 will enable exactly what
you want.  It may even allow for doing things like server side log and
grep when a client has a partial clone or a repo which is so big it
would be difficult to do some of those operations locally.  Of course
you identified some of the issues which such operations below :)

> 
> Please CC me in future versions of this proposal. Let me know if you
> want to chat directly about the "TODO" items below.

Of course, I'll make sure to keep you updated.

> 
> Speaking of TODOs, how much of this concept do you have working in a
> prototype? Do you have code that performs this version 2 handshake
> and communicates the ls-refs result?

Most of the TODOs are areas where more thought and design needs to
happen.  My main goal with this RFC is to see if a modular design like
this would have support from the community and if so, to nail down the
design of the exchanges outside of individual commands since that
infrastructure would be harder to change after the fact.

As for the commands themselves, since this design is meant to be module
we could implement them separately or one at a time (though a base set
of commands would need to be implemented and designed before v2 could
roll out).  That being said I've begun working up a rough prototype of
the basic initial capability/command exchange and the ls-refs command.
Since its pretty rough and not integrated into the actual transport code
yet its no where near ready to be sent out though I wouldn't mind
pushing the WIP code out so people can see/play with what's there.

And if you have any comments or suggestions about any parts of the
design or the TODOs I would love to chat about it :)

> 
> >  Ls-refs
> >---------
> >
> >Ls-refs can be looked at as the equivalent of the current ls-remote as
> >it is a way to query a remote for the references that it has.  Unlike
> >the current ls-remote, the filtering of the output is done on the server
> >side by passing a number of parameters to the server-side command
> >instead of the filtering occurring on the client.
> >
> >Ls-ref takes in the following parameters:
> >

For context most of these options i pulled from the existing ls-remote
command and was assuming the existing behavior of the ref advertisement,
so some of these options may definitely need to be tweaked in addition
to what the default would be (without any options).

> >   --head, --tags: Limit to only refs/heads or refs/tags
> 
> Nit: It would be better to use "--heads" to match refs/heads and
> your use of "--tags" for refs/tags.

Thanks for catching this :)

> 
> >   --refs: Do not show peeled tags or pseudorefs like HEAD
> 
> Assuming we are in the case where the server has a HEAD ref, why
> would that ever be advertised? Also, does this imply that without
> the --refs option we would peel annotated tags until we find non-tag
> OIDs? Neither of these functions seem useful as default behavior.

Currently both are true of the existing ref advertisement, all tags are
peeled and HEAD is advertised.  Maybe we don't need this to be the
default though IIRC upon a clone the advertised HEAD is what is checked
out by default once the clone completes.

> 
> >   --symref: In addition to the object pointed by it, show the underlying
> >             ref pointed by it when showing a symbolic ref
> >   <refspec>: When specified, only references matching the given patterns
> >              are displayed.
> 
> Can you be specific about the patterns? For instance, it is not a
> good idea to allow the client to submit a regex for the server to
> compute. Instead, can we limit this pattern-matching to a
> prefix-set, such as the following list of prefixes:
> 
>     refs/heads/master
>     refs/releases/*
>     refs/heads/user/me/*

You're right we may need to think carefully about what kind of limiting
we allow to prevent malicious clients.

> >  Fetch
> >-------
> >
> >Fetch will need to be a modified version of the v1 fetch protocol.  Some
> >potential areas for improvement are: Ref-in-want, CDN offloading,
> >Fetch-options.
> >
> >Since we'll have an 'ls-ref' service we can eliminate the need of fetch
> >to perform a ref-advertisement, instead a client can run the 'ls-refs'
> >service first, in order to find out what refs the server has, and then
> >request those refs directly using the fetch service.
> >
> >//TODO Flush out the design
> >
> >  Fetch-object
> >--------------
> >
> >This service could be used by partial clones in order to request missing
> >objects.
> >
> >//TODO Flush out the design
> 
> As you flesh our these "fetch" and "fetch-object" commands, keep in
> mind that partial clones could mean any of the following:
> 
>  * fetch all reachable objects except for blobs.
> 
>  * fetch all reachable objects except for blobs above a
>    certain size.
> 
>  * fetch all commits, trees, (and blobs?) within a certain
>    "cone" of the file system.
> 
> >  Push
> >------
> >
> >Push will need to be a modified version of the v1 push protocol.  Some
> >potential areas for improvement are: Fix push-options, Negotiation for
> >force push.
> 
> Negotiation is something to keep in mind for all pushes, especially
> in an ecosystem full of fork-based workflows. If you are working
> across forks and someone else syncs data between your remotes, you
> may re-push a large chunk of objects that are already present in a
> fork. Adding an ls-refs step before push would be a step in the
> right direction.
> >  Other Considerations
> >======================
> >
> >   * Move away from pkt-line framing?
> >   * Have responses structured in well known formats (e.g. JSON)
> >   * Eliminate initial round-trip using 'GIT_PROTOCOL' side-channel
> >   * Additional commands in a partial clone world (e.g. log, grep)
> 
> [Tangent]
> 
> I too have thought about making calls like "log" and "blame"
> available for calling remotes. One reason GVFS sends a "prefetch
> pack" of _all_ commits and trees is because one "git log --
> path/to/file" command would start downloading thousands of objects
> one at a time as the walk moves through the history. If the remote
> can compute the commands that require historical data, then our
> partial clones can be more "pure" (i.e. only contain objects
> required for the user's changes).
> 
> One major caveat: if someone runs "log" from HEAD, then they may be
> working over data that is not on the remote, which means they would
> need to start the history walk until reaching commits that are known
> to be on the remote. If there are merges in the local history, then
> this could include multiple independent commits.

These are some of the same points that some of my fellow coworkers have
also pointed out and definitely needs to be kept in mind if we ever
implement such a command.

> 
> Further complicating this area, the server may not want to allow
> certain types of commands (i.e. regexes, expensive history options
> like "--simplify-merges").
> 
> In conclusion, I think it is a great idea to have the protocol allow
> these extensions, especially in a way that is easy to extend without
> breaking client/server compat scenarios (after both have v2
> enabled).
> 
> [End Tangent]
> 
> Thanks,
> -Stolee
> 

Thanks for taking a look and giving your feedback!

-- 
Brandon Williams
