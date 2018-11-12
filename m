Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1888C1F87F
	for <e@80x24.org>; Mon, 12 Nov 2018 15:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729962AbeKMBkP (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Nov 2018 20:40:15 -0500
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46184 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbeKMBkO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Nov 2018 20:40:14 -0500
Received: by mail-vs1-f65.google.com with SMTP id r14so5338757vsc.13
        for <git@vger.kernel.org>; Mon, 12 Nov 2018 07:46:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G0FH8MHxAhwWQQ3S2WIGMmVGpTpYne629GeSr1Q1mfo=;
        b=svrMY8Pryc6ESTeY1T47IYHxu8gXWnoWwzvKgVcV9ruoDjTdls+xCEYuM3SX9D8daK
         IVQDXgc7+hnTHHAdv8CU5BUDjJszl+0xUU4mkHip06o6BrnposFmsFyEjp7Yv0N6UN+3
         Z+baDZeJYaAozrAIjPEEDE4soyVrVZXbpopgQwvi3dgiZ8WoVosHoZ2y/dkEaGJkoRFB
         L8EW85wQCLrdhvCWSJCoq0wzqgdQO3tJ2Qf7dnVJCwuDqskN3Fyee5m7dNhjDWrlXO7s
         8OPHN8i4iwsl7xRE3aYALpvQbggUbAMOzcZbtdQ8JOxxN/QI2cUbgugzQLMVYQeWdH1w
         abQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G0FH8MHxAhwWQQ3S2WIGMmVGpTpYne629GeSr1Q1mfo=;
        b=gJCm3azb5aZRtklh/mscgwFq0TqXHrh5tgKTKZJPyDlk1SQZtI9USunSphIDEDPzKp
         kUHjvA75444nsnSg23j9CUKd4y03wG5qgY+xwcozxARS6gnJzX1QMGNP3vh7RVaBtd8Q
         2iWOFSLIWAfKLP1P51l9A69LoKomPT9DI+WcPelLCGkWzy1nP6fZ7fpfpP76SbBiz7LU
         6BMa0NBY9pSYM9yMOS9yzGInc4XbUhYRhhlYdiG88tDmUupwaFca626k8cPJj2TsJdA8
         1VvudSBiDT0N/qrX4udBgIRtSU8ON91d1KgM/p4AMOUjthOerdJdAVv/3m31dBM/zb+l
         fZRw==
X-Gm-Message-State: AGRZ1gKV6TyCwEKWq761D+WixbkcXyclpkpp00x9plvKLeM0Gmled/VU
        ipgqsK/0FHAjDdAMc4gMeVG8rebXD6/bRn0Hie5Of6OB
X-Google-Smtp-Source: AJdET5e1bhH9b7cihahHwNDxvsVy1L4QE9BYp68jYp9FiC++0G6rtHEvsjqowkyhOjYYxmM1NtdF3/P0sR17xTCqnso=
X-Received: by 2002:a67:f696:: with SMTP id n22mr635867vso.175.1542037585988;
 Mon, 12 Nov 2018 07:46:25 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com> <20181111062312.16342-10-newren@gmail.com>
 <20181111072007.GI30850@sigill.intra.peff.net> <CABPp-BGNt0FcqiT=OqctjOEvY9ewNUJZ-Rs_aVEihjbQt3K8tQ@mail.gmail.com>
 <20181112125341.GH3956@sigill.intra.peff.net>
In-Reply-To: <20181112125341.GH3956@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 12 Nov 2018 07:46:14 -0800
Message-ID: <CABPp-BG6FJjFm7ZFWpe--n3-vXzAcrQYWXmx4M4hA_kkSPJhkQ@mail.gmail.com>
Subject: Re: [PATCH 09/10] fast-export: add a --show-original-ids option to
 show original names
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Lars Schneider <larsxschneider@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 12, 2018 at 4:53 AM Jeff King <peff@peff.net> wrote:
> On Sun, Nov 11, 2018 at 12:32:22AM -0800, Elijah Newren wrote:
>
> > > >  Documentation/git-fast-export.txt |  7 +++++++
> > > >  builtin/fast-export.c             | 20 +++++++++++++++-----
> > > >  fast-import.c                     | 17 +++++++++++++++++
> > > >  t/t9350-fast-export.sh            | 17 +++++++++++++++++
> > > >  4 files changed, 56 insertions(+), 5 deletions(-)
> > >
> > > The fast-import format is documented in Documentation/git-fast-import.txt.
> > > It might need an update to cover the new format.
> >
> > We document the format in both fast-import.c and
> > Documentation/git-fast-import.txt?  Maybe we should delete the long
> > comments in fast-import.c so this isn't duplicated?
>
> Yes, that is probably worth doing (see the comment at the top of
> fast-import.c). Some information might need to be migrated.
>
> If we're going to have just one spot, I think it needs to be the
> user-facing documentation. This is a public interface that other people
> are building compatible implementations for (including your new tool).

Okay, I'll work on that.

> OK, that matches my understanding. So why does fast-export need to print
> the blob ids? If the intermediary is rewriting blobs, it can then
> produce the "originally" line itself, can't it?
>
> The more interesting case I guess is your "strip out blobs by id"
> example. There the intermediary _could_ do so itself, but it would
> require recomputing the object id of each blob.
>
> If you use "--no-data", then this just works (we specify tree entries by
> object id, rather than by mark). But I can see how it would be useful to
> have the information even without "--no-data" (i.e., if you are doing
> multiple kinds of rewrites on a single stream).
>
> I think the thing that confused me is that this "originally" is doing
> two things:
>
>   - mentioning blob ids as an optimization / convenience for the reader
>
>   - mentioning rewritten commit (and presumably tag?) ids that were
>     rewritten as part of a partial history export. I suppose even trees
>     could be rewritten that way, too, but fast-import doesn't generally
>     consider trees to be a first-class item.
>
> So I'm OK with it, but I wonder if there is an easier way to explain it.

Yeah, I started out just needing to add the original oids for commits.
Once I added them there, I wondered whether someone would need them
for tags and blobs too (not trees since fast-import doesn't work with
those).  For blobs, it made sense as a small performance optimization
(when running without --no-data), as you pointed out.  I can't think
of a use for them in tags, but once I've included them in blobs and
commits it felt like I might as well include them there for
completeness.  So maybe my commit message should have been something
more like:

"""
Knowing the original names (hashes) of commits can sometimes enable
post-filtering that would otherwise be difficult or impossible.  In
particular, the desire to rewrite commit messages which refer to other
prior commits (on top of whatever other filtering is being done) is
very difficult without knowing the original names of each commit.

In addition, knowing the original names (hashes) of blobs can allow
filtering by blob-id without requiring re-hashing the content of the
blob, and is thus useful as a small optimization.

Once we add original ids for both commits and blobs, we may as well
add them for tags too for completeness.  Perhaps someone will have a
use for them.

This commit teaches a new --show-original-ids option to fast-export
which will make it add a 'original-oid <hash>' line to blob, commits,
and tags.  It also teaches fast-import to parse (and ignore) such
lines.
"""

?
