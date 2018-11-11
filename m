Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BCF611F87F
	for <e@80x24.org>; Sun, 11 Nov 2018 08:32:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbeKKSUa (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Nov 2018 13:20:30 -0500
Received: from mail-vs1-f66.google.com ([209.85.217.66]:40539 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727334AbeKKSU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Nov 2018 13:20:29 -0500
Received: by mail-vs1-f66.google.com with SMTP id p193so3096824vsd.7
        for <git@vger.kernel.org>; Sun, 11 Nov 2018 00:32:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/JXLJpPes94lREJ99zuVyigIGUbaxeCpTDtboc6b/ug=;
        b=ZWKXPxi+fVxmx2Wuv1uw+sEn7RKMLHFs+odiuEtVLAazlTUmEtdU5k8D/sWIqoVDAO
         4dFrbjQ7sQS6bZq88CqN2GXFIc0Nf+z1wxq9R20yvH7L+Nup+y/UbL/jdWoW1zcYDxmF
         +qlBfglMhfU21nSSUdxSA96Rjtq4599CXhg/PX7u2sCJoMhgvmj6Mt9rScyG58Iy95eF
         EIT1U53XbSxPzBgS1qFBgUV1dzXBgolCxQBIucrDI0eYXQuDmKoY4RY5fOVIYdqajQzn
         4oTjNg4ogED9Vetg800I+QyF1Qn5Fn0ShwfEQpJ89jCbO10QYLUmYVkm7iL6+tIh4u3u
         9f1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/JXLJpPes94lREJ99zuVyigIGUbaxeCpTDtboc6b/ug=;
        b=PHI5MR31t3A0vIrSbmVaaaQKW5cs/ukmK90bp/kMoc3gJxezxZS1NpTrJ8fhH2SYVQ
         i87JygQKbqVaXcyCKAq5k49zW7MwnkPPRSlWXzklY8nycUpMwK0QHRup4+NtHkPhMMz0
         NHPqWGNpWU9H7OeoFAYc1fYunncGlaTv+4LTLeLliwdKIYFK8pmk1K/UvvqGcSAx3ny8
         yLQozNnveY5F7Gad6OGgobuY8KknEjfkfx/i5DpVfCbddzQDcXpLqjVrL2dsO8cLD74t
         x+AzFLZ0oJO1gBEKewL5gVtyyPpjEDZb0TJTb8qKqjfqDHIkz18r/pVaj4unqlpwqm+m
         O1ww==
X-Gm-Message-State: AGRZ1gI7+oG81sUSQ8iLqdu59CYbgOHWtD8aBcxLCTFJAjYsjWUoaOpv
        Gs25G61kRDWqZBvos00O7bYh8+wazSNYlvVM7CM=
X-Google-Smtp-Source: AJdET5dEKLsztE0NFz9T8x8fyrcd/9O7Et0yLEAHI8WY7YwfCfJS41O7T/GDIAtJYd1SUkh1irJ/UP+9KjXU12EfJNA=
X-Received: by 2002:a67:3c5c:: with SMTP id j89mr6457703vsa.117.1541925153372;
 Sun, 11 Nov 2018 00:32:33 -0800 (PST)
MIME-Version: 1.0
References: <CABPp-BEefqYADr8SVvh6uFWkp96PDv7qfKK1c9O1WUnPy3wqrw@mail.gmail.com>
 <20181111062312.16342-1-newren@gmail.com> <20181111062312.16342-10-newren@gmail.com>
 <20181111072007.GI30850@sigill.intra.peff.net>
In-Reply-To: <20181111072007.GI30850@sigill.intra.peff.net>
From:   Elijah Newren <newren@gmail.com>
Date:   Sun, 11 Nov 2018 00:32:22 -0800
Message-ID: <CABPp-BGNt0FcqiT=OqctjOEvY9ewNUJZ-Rs_aVEihjbQt3K8tQ@mail.gmail.com>
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

On Sat, Nov 10, 2018 at 11:20 PM Jeff King <peff@peff.net> wrote:
>
> On Sat, Nov 10, 2018 at 10:23:11PM -0800, Elijah Newren wrote:
>
> > Knowing the original names (hashes) of commits, blobs, and tags can
> > sometimes enable post-filtering that would otherwise be difficult or
> > impossible.  In particular, the desire to rewrite commit messages which
> > refer to other prior commits (on top of whatever other filtering is
> > being done) is very difficult without knowing the original names of each
> > commit.
> >
> > This commit teaches a new --show-original-ids option to fast-export
> > which will make it add a 'originally <hash>' line to blob, commits, and
> > tags.  It also teaches fast-import to parse (and ignore) such lines.
>
> Makes sense as a feature; I think filter-branch can make its mappings
> available, too.
>
> Do we need to worry about compatibility with other fast-import programs?
> I think no, because this is not enabled by default (so if sending the
> extra lines to another importer hurts, the answer is "don't do that").
>
> I have a vague feeling that there might be some way to combine this with
> --export-marks or --no-data, but I can't really think of a way. They
> seem related, but not quite.
>
> > ---
> >  Documentation/git-fast-export.txt |  7 +++++++
> >  builtin/fast-export.c             | 20 +++++++++++++++-----
> >  fast-import.c                     | 17 +++++++++++++++++
> >  t/t9350-fast-export.sh            | 17 +++++++++++++++++
> >  4 files changed, 56 insertions(+), 5 deletions(-)
>
> The fast-import format is documented in Documentation/git-fast-import.txt.
> It might need an update to cover the new format.

We document the format in both fast-import.c and
Documentation/git-fast-import.txt?  Maybe we should delete the long
comments in fast-import.c so this isn't duplicated?

> > --- a/Documentation/git-fast-export.txt
> > +++ b/Documentation/git-fast-export.txt
> > @@ -121,6 +121,13 @@ marks the same across runs.
> >       used by a repository which already contains the necessary
> >       parent commits.
> >
> > +--show-original-ids::
> > +     Add an extra directive to the output for commits and blobs,
> > +     `originally <SHA1SUM>`.  While such directives will likely be
> > +     ignored by importers such as git-fast-import, it may be useful
> > +     for intermediary filters (e.g. for rewriting commit messages
> > +     which refer to older commits, or for stripping blobs by id).
>
> I'm not quite sure how a blob ends up being rewritten by fast-export (I
> get that commits may change due to dropping parents).

It doesn't get rewritten by fast-export; it gets rewritten by other
intermediary filters, e.g. in something like this:

   git fast-export --show-original-ids --all | intermediary_filter |
git fast-import

The intermediary_filter program may want to strip out blobs by id, or
remove filemodify and filedelete directives unless they touch certain
paths, etc.

> The name "originally" doesn't seem great to me. Probably because I would
> continually wonder if it has one "l" or two. ;) Perhaps something like
> "original-oid" might be better. That's well into bikeshed territory,
> though.

I wasn't a huge fan of "originally" either, but I just couldn't come
up with anything else that wasn't really long.  I'd be happy to switch
to original-oid.
