Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7F0D621847
	for <e@80x24.org>; Wed,  2 May 2018 15:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751585AbeEBPxf (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 May 2018 11:53:35 -0400
Received: from mail-ua0-f177.google.com ([209.85.217.177]:38069 "EHLO
        mail-ua0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750954AbeEBPxe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 May 2018 11:53:34 -0400
Received: by mail-ua0-f177.google.com with SMTP id y8so9792344ual.5
        for <git@vger.kernel.org>; Wed, 02 May 2018 08:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=j9EF3GK176ZrGH4ut0u+178k4fblz19DtXKoE4GkffE=;
        b=hREyvuuHJcs67kMKFWX4+lFXsEhaQz9SMbFcuAOE3T/z31ChzSacIWywQGVRB+rLwK
         sBg7xhVorUgZJP3PrTRozEoK8S4s3YEy9jepKgYCrtUww71FUx0DWFyb0IO0wUW6tC9m
         j3THHvY9P4rdQ85ctlSQbjdadVCv3MbRzR0Ee5+4gp7g04pm8NQdngqiYdwCc7s47Boy
         3Y1C+u0aiTla84JCe3ROFq9mEL9pl8so3KwOrGYA4M7MK5sJsfAZwlwUx6bcKcQ23mBL
         7NaLmTPhyV9UrJjxRSvvkpZ26/TRoIaX9vGjBnP774YsJKRWyUuGnNcoZNtyDgLBulXF
         /gUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=j9EF3GK176ZrGH4ut0u+178k4fblz19DtXKoE4GkffE=;
        b=s51si6pKXulAObLYrc6OOkiJUswNSiUEd6kORcgeoS009fUHxtUq+rzbyq9djqlB6O
         RfA5xTwws1QxIjwyaG+OaY0ViWDP7uyBRQOjjmIUKaEUH5m3jLJK0Tc3OymbrvOLixZr
         bd5qhzIey7YpYPq2uofZbqwipmOE9FliBysPZLSwNuzt0j4nRb0C+zGAaKwnXIyIzCz+
         imbv7hCloWEM3JatXLc6ulc0nBjqdwBAJlfA3vCqAGXFue/l5PAszL0o/ATAXluQs+LU
         HrooiYHtA2RQPfbig4xs8l+sp7ans6UEYv0dJpTM6cUZoyXkwnC9N7iQAt6ex14Mr9yK
         9z+w==
X-Gm-Message-State: ALQs6tC2JJ14HQCY0WAWRcseePRU9XzKjvcVbHoMKBVZKa4DCL4btnc8
        DyCfJW0Esqz7VYwuGep+YEzm7mGR/YVGP2ti3lE=
X-Google-Smtp-Source: AB8JxZqrbR3sjwSD2hL6F5ToNA6U1sg1jVxh0zSjnNPHXImbSOEfCfV2nrBSRYlbEEZn0qnqCWHHLxdP7F971COhGXs=
X-Received: by 10.176.9.92 with SMTP id c28mr18779067uah.50.1525276413322;
 Wed, 02 May 2018 08:53:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180426092524.25264-1-sxlijin@gmail.com> <20180418030655.19378-1-sxlijin@gmail.com>
 <20180426092524.25264-2-sxlijin@gmail.com> <xmqq36zawqr3.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqq36zawqr3.fsf@gitster-ct.c.googlers.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Wed, 02 May 2018 15:52:56 +0000
Message-ID: <CAJZjrdVXKx9em=soHSm0P3BCRffyrc23tqNJuFNuT6EG5hivow@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] commit: fix --short and --porcelain options
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 1, 2018 at 10:50 PM Junio C Hamano <gitster@pobox.com> wrote:

> Samuel Lijin <sxlijin@gmail.com> writes:

> > Mark the commitable flag in the wt_status object in the call to
> > `wt_status_collect()`, instead of in `wt_longstatus_print_updated()`,
> > and simplify the logic in the latter function to take advantage of the
> > logic shifted to the former. This means that callers do not need to use
> > `wt_longstatus_print_updated()` to collect the `commitable` flag;
> > calling `wt_status_collect()` is sufficient.
> >
> > As a result, invoking `git commit` with `--short` or `--porcelain`
> > (which imply `--dry-run`, but previously returned an inconsistent error
> > code inconsistent with dry run behavior) correctly returns status code
> > zero when there is something to commit. This fixes two bugs documented
> > in the test suite.


> Hmm, I couldn't quite get what the above two paragraphs were trying
> to say, but I think I figured out by looking at wt_status.c before
> applying this patch, so let me see if I correctly understand what
> this patch is about by thinking a bit aloud.

> There are only two assignments to s->commitable in wt-status.c; one
> happens in wt_longstatus_print_updated(), when the function notices
> there is even one record to be shown (i.e. there is an "updated"
> path) and the other in show_merge_in_progress() which is called by
> wt_longstatus_prpint_state().  The latter codepath happens when we
> are in a merge and there is no remaining conflicted paths (the code
> allows the contents to be committed to be identical to HEAD).  Both
> are called from wt_longstatus_print(), which in turn is called by
> wt_status_print().

> The implication of the above observation is that we do not set
> commitable bit (by the way, shouldn't we spell it with two 'T's?)

Yep, MW confirms: https://www.merriam-webster.com/dictionary/commitable

I didn't think to check how common "commitable" is in the codebase, but it
doesn't seem to be too many, looking at the output of `git grep
commitable`, so I'll add that to the patch series when I reroll.

> if we are not doing the long format status.  The title hints at it
> but "fix" is too vague.  It would be easier to understand if it
> began like this (i.e. state problem clearly first, before outlining
> the solution):

>          [PATCH 1/2] commit: fix exit status under --short/--porcelain
options

>          In wt-status.c, s->commitable bit is set only in the
>          codepaths reachable from wt_status_print() when output
>          format is STATUS_FORMAT_LONG as a side effect of printing
>          bits of status.  Consequently, when running with --short and
>          --porcelain options, the bit is not set to reflect if there
>          is anything to be committed, and "git commit --short" or
>          "--porcelain" (both of which imply "--dry-run") failed to
>          signal if there is anything to commit with its exit status.

>          Instead, update s->commitable bit in wt_status_collect(),
>          regardless of the output format. ...

> Is that what is going on here?  Yours made it sound as if moving the
> code to _collect() was done for the sake of moving code around and
> simplifying the logic, and bugfix fell out of the move merely as a
> side effect, which probably was the source of my confusion.

Yep, that's right. I wasn't sure if the imperative tone was required for
the whole commit or just the description, hence the awkward structure. (I
also wasn't sure how strict the 70 char limit on the description was.)

> > +static void wt_status_mark_commitable(struct wt_status *s) {
> > +     int i;
> > +
> > +     for (i = 0; i < s->change.nr; i++) {
> > +             struct wt_status_change_data *d =
(s->change.items[i]).util;
> > +
> > +             if (d->index_status && d->index_status !=
DIFF_STATUS_UNMERGED) {
> > +                     s->commitable = 1;
> > +                     return;
> > +             }
> > +     }
> > +}

> I am not sure if this is sufficient.  From a cursory look of the
> existing code (and vague recollection in my ageing brain ;-), I
> think we say it is committable if

>   (1) when not merging, there is something to show in the "to be
>       committed" section (i.e. there must be something changed since
>       HEAD in the index).

>   (2) when merging, no conflicting paths remain (i.e. change.nr being
>       zero is fine).

> So it is unclear to me how you are dealing with (2) under "--short"
> option, which does not call show_merge_in_progress() to catch that
> case.

And the answer there is that I'm not :) I had hoped that there was a test
to catch mistakes like this but evidently not. Thanks for pointing that
out, I'll add a test to catch that.

I'm also realizing that I didn't const-ify wt_longstatus_print() in the
next patch, which is another reason I didn't catch this.

This seems a bit trickier to handle. What do you think of this approach:
(1) move wt_status_state into wt_status and (2) move the call to
wt_status_get_state from wt_longstatus_print/wt_porcelain_v2_print_tracking
to wt_status_collect?

(I kind of also want to suggest enum-ifying some of wt_status_state, but
that feels beyond the scope of this and also prone to other pitfalls.)
