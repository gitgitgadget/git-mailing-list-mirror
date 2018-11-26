Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 953C51F97E
	for <e@80x24.org>; Mon, 26 Nov 2018 23:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbeK0KF6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Nov 2018 05:05:58 -0500
Received: from mail-ed1-f52.google.com ([209.85.208.52]:43658 "EHLO
        mail-ed1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726516AbeK0KF6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Nov 2018 05:05:58 -0500
Received: by mail-ed1-f52.google.com with SMTP id f4so17352980edq.10
        for <git@vger.kernel.org>; Mon, 26 Nov 2018 15:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=F88hGppLrSxmJHlerISCd+C8E7470jkSpjI6tyw2/rQ=;
        b=MuDBH+rtcLa/ubniLRtm3NDZ3yG5g+ExjSAquAnYhYwBeYS6QRpIDDqQKC59BQ+RZO
         bfnf7FVv/gQWMj03bMNuWWyzH6qu9a/tAxAOYmDon7S2xX4ZZoTxPBjwRnIKYSi75wuq
         ABA8QszZlF8UvqhpqdYZEmMSRcviJBdSJGH8aPAbz5aQByB35mG4UXFod3srBFiClXxp
         +n4zGkvQYEM7wiegRv5WjDEBiwmkDtQkVkxw3FSjaHNcAhq/sbhKO2Im75crE1qAPHM/
         whyhMEmla68wUjWmFl+36zqbwoJzTtf9UJd1HFpdZokZchWnKoTJ1ySizD10Ix8IWM0X
         YryA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=F88hGppLrSxmJHlerISCd+C8E7470jkSpjI6tyw2/rQ=;
        b=sB3cwKPkxomuPVSm2Ey9Cv7VcOGyejXpSXOLpz7gq+27p5CFPX9be2EUIHKe5Cmboz
         Ue367iIajKFaSukX4Z2ck9oMR6lrmZycbGOpZ0RS+40DBRvNkQWCvhFaWBAmhCvEjHca
         8T17S3Pe2zoNThRZPwxZqB+GD70/L5uC/Xxr0YCkV4FI1AmfSv/rhs297CGQtfyZSr+Y
         wSO/C5ozoXHcH+WE+kv4eyp8U4jeOwq8iKaupHoGaj/tjxiSIbzUgCbMYA60pcLcbVOE
         Zywb7GCCl6mGKabTomH+vaDflxTnG5KXRuN/e8AZjgl6Lhs2zrJwtnHqA0kVZNhBI6TS
         83Pw==
X-Gm-Message-State: AGRZ1gIP5WSDXwAx/IeHkhZO+VJKmhvdU/JdbqP5eDU8m/kLyn2B3Y9e
        3wbKkulW7nGHsRRsk1zHjrZWoQBw+R0OUXh5aUI3CA==
X-Google-Smtp-Source: AJdET5dfXPsMfVQrv8oigMzbCjM3UF20KShVDXpamFVUYWUJIB7oYqwnREfKRxoyv++LDFNhVjD48UkGXLYFYSLMYig=
X-Received: by 2002:a17:906:f04:: with SMTP id z4-v6mr22069727eji.106.1543273812341;
 Mon, 26 Nov 2018 15:10:12 -0800 (PST)
MIME-Version: 1.0
References: <20181110133525.17538-1-pclouds@gmail.com> <xmqq8t1y3jex.fsf@gitster-ct.c.googlers.com>
 <CACsJy8BGgf0J=iKNc3qmz_rTMNdaPmR_1v+9i3nhGKcuOH4AFA@mail.gmail.com>
 <8736rx1ah9.fsf@evledraar.gmail.com> <CACsJy8B6wKGg2Jsopct-0dYNhKJGf9RdnrnTqBOt4kxy6LzxMw@mail.gmail.com>
 <20181120174554.GA29910@duynguyen.home> <87o9abzv46.fsf@evledraar.gmail.com>
In-Reply-To: <87o9abzv46.fsf@evledraar.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 26 Nov 2018 15:10:00 -0800
Message-ID: <CAGZ79kaCidJ1s2vXaQX9b_o7Tk4O+WTdmBSM3RBKX3bCBMSFKA@mail.gmail.com>
Subject: Re: [RFC] Introduce two new commands, switch-branch and restore-paths
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 26, 2018 at 8:01 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
>
> On Tue, Nov 20 2018, Duy Nguyen wrote:
>
> > On Mon, Nov 19, 2018 at 04:19:53PM +0100, Duy Nguyen wrote:
> >> I promise to come back with something better (at least it still
> >> sounds better in my mind). If that idea does not work out, we can
> >> come back and see if we can improve this.
> >
> > So this is it. The patch isn't pretty, mostly as a proof of
> > concept. Just look at the three functions at the bottom of checkout.c,
> > which is the main thing.
> >
> > This patch tries to split "git checkout" command in two new ones:
> >
> > - git switch-branch is all about switching branches
>
> Isn't this going to also take the other ref arguments 'git checkout'
> takes now? I.e. tags, detached HEADs etc? I'm reminded of the discussion
> about what "range-diff" should be called :)

Heh, good call. :-)
Note that the color of a bikeshed has fewer functional implications
than coming up with proper names in your API exposed to millions
of users, as cognitive associations playing mind tricks, can have a
huge impact on their productivity. ;-)

In a neighboring thread there is discussion of the concept of a
'change' (and evolving the change locally), which is yet another
thing in the refs-space.

'switch-branch' sounds like a good name for a beginner who is just
getting started, but as soon as they discover that there is more than
branches (detached HEAD via commits, tags,
remote tracking "branches"), this name may be confusing.
So it would not be a good choice for the intermediate Git user.
The old time power user would not care as they have 'checkout'
in their muscle memory, aliased to 'co', but maybe they'd find
it nice for explaining to new users.

So I'd be thrilled to find a name that serves users on all levels.

Maybe we need to step back and consider what the command does.
And from that I would name it "rewire-HEAD-and-update-index&worktree"
and then simplify from there. For the beginner user, the concept of
HEAD might be overwhelming, such that we don't want to have that
in there.

So I'd be tempted to suggest to call it "switch-to-ref", but that would
be wrong in the corner case as well: When using that with a remote
tracking branch, you don't "switch to it" by putting it into your HEAD,
but you merely checkout the commit that it's pointing at.



>
> > - git restore-paths (maybe restore-file is better) for checking out
> >   paths

"content-to-path", maybe(?) as it moves the content (as given by commit
or implicitly assuming the index when omitted) into that path(, again).
(I am not enthused about this, as you can similarly argue for
content-to-paths, content-to-worktree, which then could split up into
"index-to-worktree [pathspec]" as well as "tree-to-worktree <commit>".
also the notion of X-to-Y seems a novel concept in our naming, so maybe
verb-noun is better, hence restore-path or "fix-paths" may be better)

> > Later on, we could start to add a bit more stuff in, e.g. some form of
> > disambiguation is no longer needed when running as switch-branch, or
> > restore-paths.
> >
> > So, what do you think?

The patch looks interestingly small :-)

> That "git checkout" does too many things is something that keeps coming
> up in online discussions about Git's UI. Two things:
>
> a) It would really help to have some comparison of cases where these
>    split commands are much clearer or less ambiguous than
>    git-checkout. I can think of some (e.g. branch with the same name as
>    a file) but having some overall picture of what the new UI looks like
>    with solved / not solved cases would be nice. Also a comparison with
>    other SCMs people find less confusing (svn, hg, bzr, ...)

How do other SCMs solve this issue? (What is their design space?
How many commands do they have for what git-checkout does
all-in-one?)

> b) I think we really need to have some end-game where we'd actually
>    switch away from "checkout" (which we could still auto-route to new
>    commands in perpetuity, but print a warning or error). Otherwise
>    we'll just end up with https://xkcd.com/927/ and more UI confusion
>    for all.

Heh, that situation is only avoided when the new command has clear
advantages over the old, and ISTM that we can only compete on
UX and better defaults, so maybe I'd push for making it more logical,
maybe so:

  git tree-to-worktree # git checkout <commit> -- <path>
  git index-to-worktree # git checkout -- <path>
  git rev-to-ref # git checkout <commit>

Just food for thought, specifically the last one would be
hilarious if we'd end up with it.

Stefan
