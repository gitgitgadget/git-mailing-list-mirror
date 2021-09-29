Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D32C8C433F5
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 06:42:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2CC4613CD
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 06:42:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244441AbhI2Goj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Sep 2021 02:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244423AbhI2Goi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Sep 2021 02:44:38 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2EEDC06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 23:42:57 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 5-20020a9d0685000000b0054706d7b8e5so1648652otx.3
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 23:42:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=WS3utOd0hprluVj8zi2arz7cyeu92pmU06O0zsC5LTQ=;
        b=lcSmgdhIS1Rb1J3ObY022EY/Muqzza5KmI6PIW+Baw81b/dBa8QJbyx8hG0kxI0Y11
         FES3yp/onN6IShG2JN8CZY3pEPO9HB7Pxh6lgyIU6kObrIWPa/DOWA5nkDTzEQHywoLA
         L6QUet6tu2ow9htpTz2cMO8OKIqqCa/UecFsZMWGwYrFlgxi5tgUryhJC3ZjP3Bxroua
         3zgJYz8PorhWQrbW+b0haRR/e9YGa4xWOitFpmfxsmKMocegZY4KUmHGr6g733CxQ1Q3
         GaTdzGcIHt0i7LmhFU7LCV1fdKUggl1MGY7B0PdlMj0oXMZsj0h2Ym57dPPfw+6lhgpa
         xhzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=WS3utOd0hprluVj8zi2arz7cyeu92pmU06O0zsC5LTQ=;
        b=E9D22rGr7Y0FimDCAuiZ2EyKdPkg0UDMKGoMf5b9luo/f1W0q4KAbC/hWrLIQMe0tz
         aG9zE2aPfOSCAgMWP/oSFWt3Xxb8AWTqGzD36WD0QkGuegvz1xm2RF/hETDAU5yEt5ia
         0vHrRwd4VDXvG5vTFfxTUj8YX7n3wA0mgdvUEfz9AARgeUKevlDlmu1NHDByD658tNrk
         GKg0uZryQivIXFudYowYoY/CCT1DKw6lY6FsSmoHu5feEayR+64b7aKwfLOj8/TUSZ9C
         cKLy3k5zszdtA+0hhcnWZyOL/lQ2AMN564r/djAhSxQKPoVG/655lYwvjtX1IwybqjGH
         wEAg==
X-Gm-Message-State: AOAM533xCzKZ7l9SCPSjhwrZjsQVl+9U8mBpHkMFO+uFEJ9QPHTFc07d
        jmZAfJNniLX/DkCrWov2ZIzAPdQD9eJEZJOYRiA=
X-Google-Smtp-Source: ABdhPJygAtvM791ENXWCFyteaMazceCKAB28EwRmLuJwA+k1mrugpM4+7sHGZrlTqB+fYa9XUIH8jQhi484BUyrv5FA=
X-Received: by 2002:a9d:7f17:: with SMTP id j23mr5463081otq.25.1632897777286;
 Tue, 28 Sep 2021 23:42:57 -0700 (PDT)
MIME-Version: 1.0
References: <xmqq8rzhmsi7.fsf@gitster.g> <CABPp-BGuzd_TH57-1RvwJQD5r3S3ZkJcuiPnU8aWee8pgzUBEw@mail.gmail.com>
 <xmqqo88clixa.fsf@gitster.g>
In-Reply-To: <xmqqo88clixa.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 28 Sep 2021 23:42:45 -0700
Message-ID: <CABPp-BF-tEk-ef3tVD_27a2UbcrRsZw8y+49+v0H5E39UPgPrg@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2021, #08; Mon, 27)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 28, 2021 at 10:16 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> >> * js/scalar (2021-09-14) 15 commits
> > ...
> > However, since Johannes has been away for a couple weeks, maybe give
> > him a chance to return and respond to myself and others (and perhaps
> > push any updates that occurred to him while on vacation) before
> > merging down?
>
> Fair enough.
>
> >> * en/remerge-diff (2021-08-31) 7 commits
> >>  - doc/diff-options: explain the new --remerge-diff option
> >>  - show, log: provide a --remerge-diff capability
> >>  - tmp-objdir: new API for creating and removing primary object dirs
> >>  - merge-ort: capture and print ll-merge warnings in our preferred fas=
hion
> >>  - ll-merge: add API for capturing warnings in a strbuf instead of std=
err
> >>  - merge-ort: add ability to record conflict messages in a file
> >>  - merge-ort: mark a few more conflict messages as omittable
> >>
> >>  A new presentation for two-parent merge "--remerge-diff" can be
> >>  used to show the difference between mechanical (and possibly
> >>  conflicted) merge results and the recorded resolution.
> >>
> >>  Will merge to 'next'?
> >
> > It has been a month that it's been cooking with no issues brought up,
> > and it's been in production for nearly a year...
>
> Please do not read that much for being in "seen".  Until a topic
> hits 'next', where some orgs package and ship to their internal
> audience, I am not sure if it can be called "cooking".

As a heads up, I found this topic in an email titled "What's
Cooking...", and in particular it was listed in a section of that
email that was titled "[Cooking]".  ;-)

Sorry, I couldn't resist.

But yeah, I know "seen" doesn't mean much.  My comment was reflecting
that while leaving a topic in seen for a while sometimes results in
more information coming forth to inform the decision about whether to
merge the series to next, or drop it, or ask the submitter for
changes, there comes a point where further waiting is unlikely to
provide any additional information that would help inform that
decision.  I was starting to wonder whether we'd get any (more)
feedback.  But I'm glad we waited a little longer.  :-)

> But your using it on your folks in the production (how big is your
> audience, I don't know) does count ;-)

~100 opt-in users (apparently shot up in the past few months; used to
be ~50).  I have a hard time gauging how heavily this particular
feature was/is used by them, however:

  * The feature was explicitly announced, but I did it because I
thought it was cool and a nice demonstration of merge-ort features,
not because there were explicit requests for it
  * I did make "-p" imply "--remerge-diff" for git-log in our internal
opt-in distribution, so that should increase usage significantly.
  * A bug in an internal tool for a while was accidentally running
`git log -p --name-status $COMMIT --not
--remotes=3DACCIDENTALLY_INVALID_REMOTE_NAME` for a while, including in
big repos; in combination with previous point, this increased usage
and scope of remerge-diff usage a fair amount as that command would
run on all commits in history.
  * Most merges here are done by either GitHub (Enterprise) or Gerrit,
both of which require the user to rebase and re-push if there are any
conflicts.  This makes remerge-diff boring for most merges.  There are
some notable exceptions where merges are done differently, they're
just much less common.  (--remerge-diff-only for cherry-picks and
reverts is a bit more interesting, but that's not part of this
series...and I also haven't gotten much feedback on it.)
  * I have only received feedback from two users about the
remerge-diff feature, one only indirectly, and both reports actually
ended up being about underlying bugs in early versions of merge-ort[+]

[+] The bugs were (1) my QSORT in write_tree() was not originally
using tree_entry_order() and thus was writing trees with the wrong
ordering of elements; this was a bug that was fixed before
write_tree() was ever submitted upstream, and (2) and the bug fixed by
72b3091040f8 (merge-ort: use STABLE_QSORT instead of QSORT where
required, 2021-03-20)

> > But just this morning I pinged peff and jrnieder if they might have
> > time to respectively look at the tmp-objdir stuff (patch 5, plus its
> > integration into log-tree.c in patch 7) and the ll-merge.[ch] changes
> > (patch 3).  I don't know if either will have time to do it, but
> > perhaps wait half a week or so to see if they'll mention they have
> > time?
>
> Sure.

Apparently that was a good idea; Peff and =C3=86var have both chimed in
with feedback.  :-)
