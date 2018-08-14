Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AD9531F404
	for <e@80x24.org>; Tue, 14 Aug 2018 23:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbeHOCTv (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 Aug 2018 22:19:51 -0400
Received: from mail-yw1-f66.google.com ([209.85.161.66]:43618 "EHLO
        mail-yw1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729286AbeHOCTv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Aug 2018 22:19:51 -0400
Received: by mail-yw1-f66.google.com with SMTP id l189-v6so17547916ywb.10
        for <git@vger.kernel.org>; Tue, 14 Aug 2018 16:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DtysyyS1OaT1/oHk3RCWw09ynqRBZ65WTN0CkoWRR3w=;
        b=CM5MCY3xBZ+D8xbfUJoUl07ZC8z3+FNVAXz/fLwFM1CL1sPA/Ix2y062pno2RY5lkT
         EWZN7p9zogAMODmvvl8W4FAf3icWsqjqDMhkL5CIp7uE/rKCBHmYdGIaoxyfhVxJtrgt
         xWb3+WXZkpn9Q54zADyAtUMjevIML5KJRw+SgHdXSpraVJByPH/fM83zmB5F+q5GDGYi
         fIaBHr0lXkdmhS0t7ro4E6KG+LI8mE99gP0kioGA9s4uWwtsxp1j9v12swuA9vPL3sQp
         J5Vzd6pKmF47kRLuFP5P1sv4nP3oJdQ5LhCZV12ZziyfTYb1t46b4uATfVuRRv+9O/Ra
         ZB3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DtysyyS1OaT1/oHk3RCWw09ynqRBZ65WTN0CkoWRR3w=;
        b=Vjhoe3uBSlcHjvP86LZa7RVB4gApo5XzMaP4diGtJGRgFe5gXqQTBeaZsOsyxzy+jW
         09bHqe8PELOQqS+Up42ThuqGJBbBV14p2XyIqg7K3hqvZkvGurlDKB9SKlCpPsAWzxKW
         V49CSh5EldEOzwsm3qtBWGtxHK0uDbI1oGJhEh6DixNdbddMMy53D6HWaM2dMrg5oXEg
         NkrTikOXObQzR65dQWF22/djVfNl/1QJTj/JLTfYOmq8EVl1/Yys5004WKthqrwO4SW0
         dyNcfQckuBcU3aM05qFaKpbCUSLdr4jUeGNrC8aRcDnfJQNqzKUHvkDeC0ONdvEFNlfG
         SD2Q==
X-Gm-Message-State: AOUpUlGJ5mY4qToGO/mlzSP8OE7YWeWNuD/NtnQsKnEWyJL7ejUCZj9z
        yRA3aLs3L6IEHNlP2AqhJNVpa3R8IXuV/Jhii6lMxA==
X-Google-Smtp-Source: AA+uWPxmyQETopfO09g59fWUCtz9x5aQUN5pZlZGiZGvnN5tkbisAkXA0IBnaBYN/oB0Rgpw1+EO4F7EHVPyEHTyPy0=
X-Received: by 2002:a25:3c45:: with SMTP id j66-v6mr2202317yba.247.1534289420526;
 Tue, 14 Aug 2018 16:30:20 -0700 (PDT)
MIME-Version: 1.0
References: <95e4f9df528a40bf3f3e648318904500343abf9a.camel@infinera.com>
 <20180814223820.123723-1-sbeller@google.com> <xmqqo9e4y2gr.fsf@gitster-ct.c.googlers.com>
 <xmqqk1osy1qo.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqk1osy1qo.fsf@gitster-ct.c.googlers.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 14 Aug 2018 16:30:09 -0700
Message-ID: <CAGZ79kZtWkbSoMEva5Wv0H1Q23JJ6S3d36LY66+yH2Ot8kADEA@mail.gmail.com>
Subject: Re: [PATCH 1/2] store submodule in common dir
To:     Junio C Hamano <gitster@pobox.com>
Cc:     joakim.tjernlund@infinera.com, git <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Duy Nguyen <pclouds@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 14, 2018 at 4:20 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > My understanding of what Joakim wants to do is to have a top-level
> > project that has three subdirectories, e.g. kernel/v2.2, kernel/v2.4
> > and kernel/v2.6, each of which is a submodule that houses these
> > versions of Linux kernel source, but only clone Linus's repository
> > (as the up-to-late tree has all the necessary history to check out
> > these past development tracks).  And that should be doable with
> > just the main checkout, without any additional worktree (it's just
> > the matter of having .git/modules/kernel%2fv2.6/ directory pointed
> > by two symlinks from .git/modules/kernel%2fv2.[24], or something
> > like that).
>
> Actually I take the last part of that back.  When thought naively
> about, it may appear that it should be doable, but because each of
> the modules/* directory in the top-level project has to serve as the
> $GIT_DIR for each submodule checkout, and the desire is to have
> these three directories to have checkout of three different
> branches, a single directory under modules/. that is shared among
> three submodules would *not* work---they must have separate index,
> HEAD, etc.
>
> Theoretically we should be able to make modules/kernel%2fv2.[24]
> additional "worktree"s of modules/kernel%2fv2.6, but given that
> these are all "bare" repositories without an attached working tree,
> I am not sure how that would supposed to work.  Thinking about
> having multiple worktrees on a single bare repository makes me head
> spin and ache X-<;-)

Well the worktree feature would do all this in a safe manner, but the existing
feature of just cloning the submodules with a reference pointer to another
repository at least dedupes some of the object store, although warnings
need to be read carefully.

Regarding the worktree, I would think we'd want to have

  git worktree --recurse-submodules [list, add, etc]

that would do a sensible thing for each action on the worktrees,
but you seem to propose to have one of the three submodules
the main worktree and the other two would be just worktrees of
the first.

  I guess you could just

* init/update one of the submodules
* add their worktrees manually pointed to where
  the 2nd and 3rd submodule would go.
* make a symbolic link from
  ln -s .git/modules/<1st>/worktrees/<2nd> .git/modules/<2nd>
  ln -s .git/modules/<1st>/worktrees/<3rd> .git/modules/<3rd>

as then submodule operations should "just work" and by having the
worktrees in-place where the submodules are, we'd also have
all the protection against overzealous garbage collection, too.

Stefan
