Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 22E841F597
	for <e@80x24.org>; Thu, 19 Jul 2018 09:32:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727501AbeGSKOh (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 06:14:37 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:51038 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726640AbeGSKOh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 06:14:37 -0400
Received: by mail-it0-f66.google.com with SMTP id w16-v6so8255070ita.0
        for <git@vger.kernel.org>; Thu, 19 Jul 2018 02:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oeIRRiMJ5XKMUA/yUeMwJeQz/0T+Cn7C5a32CZmnufk=;
        b=BHhxjUJe5WuR72xiuHaClYlYjPAt3Dd95s6MzBzXoWz2vRdRFiGRk735usVHpKu6+W
         Z+VH3v6v+DZFIlMjuGxUPSCx4+zFJBPfNoQ5ph0FbBb9SwK755cYLRe7ksIJrNaaFd2G
         EMyon8x3b9jhvdG+L2V5Snkk9qX/jdeh8cZWtQ4JeysJDYt+im4TQbDVf0VG1b/QFYpa
         XpTmgTq3xGm2MW8KjWMVXEHPki1QJb0YUuCtM0xBEtPMvNuTkclpDMs59IMEG0AZRBxQ
         5XKakex9DKA9Ld7gcczvMcyXlmN/eAF8QFq+owDQ3T5/Hzh/Tlmy+wGcZg72myntqr3D
         /EHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oeIRRiMJ5XKMUA/yUeMwJeQz/0T+Cn7C5a32CZmnufk=;
        b=q8KKkxjCSg1zHSc4QWCZB20qeNZ7V/1mVDYusyDFntI3TE/l80pX+1ksxQqsRQW09f
         n0Lm0M2PsjhQF7h42ClP9biIAlDrH5rH9O5dadI4SyCnrnQkUnxa3z+ZeZMKCk7rQcX+
         TfzHwgqJw1YAM7CZ8uZMEqJ8i12ec92tib9XMZcrDkmJrbw2C4aos9Sulkg7dM/M72fO
         qkwwfKUZTkOG7yuH64eQleXClGrmzDz7ccyVBEMz1CZm6rFlIsUAG/SJ0KJaHbhUdlEy
         rPS9n00S9YrS5TX2TUyq4Mula9ke9CemCnx94IkQ/6F9CIisWT0LWg2BFnyX9RLYa/8W
         1DRA==
X-Gm-Message-State: AOUpUlFZFPVVXF8YmvJAPfFNKgS7UEBV7mc9fl5YAuupm5xPmAjholdG
        NTs8vYHZsRLEkFVFNX0mMHfFYUiHutKW/cgMqaE=
X-Google-Smtp-Source: AAOMgpeK53/7yHDYi7CafZTCKDuHFA0wE2qgz/hiBWD6wgzqLr13/dWiAW4q9OH9xJUWHTC4dMkY6r504Er0Tox7j9Y=
X-Received: by 2002:a24:2f0e:: with SMTP id j14-v6mr4841512itj.120.1531992739258;
 Thu, 19 Jul 2018 02:32:19 -0700 (PDT)
MIME-Version: 1.0
References: <20180426092524.25264-1-sxlijin@gmail.com> <20180715110807.25544-4-sxlijin@gmail.com>
 <xmqqh8kxpy21.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh8kxpy21.fsf@gitster-ct.c.googlers.com>
From:   Samuel Lijin <sxlijin@gmail.com>
Date:   Thu, 19 Jul 2018 02:31:33 -0700
Message-ID: <CAJZjrdVj55W39fxK2ebYTgwO-N-ez=WcEvyepK4wqddiiQct3A@mail.gmail.com>
Subject: Re: [PATCH v3 3/3] commit: fix exit code for --short/--porcelain
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks for the review.

On Tue, Jul 17, 2018 at 10:33 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Samuel Lijin <sxlijin@gmail.com> writes:
>
> > diff --git a/wt-status.c b/wt-status.c
> > index 75d389944..4ba657978 100644
> > --- a/wt-status.c
> > +++ b/wt-status.c
> > @@ -718,6 +718,39 @@ static void wt_status_collect_untracked(struct wt_=
status *s)
> >               s->untracked_in_ms =3D (getnanotime() - t_begin) / 100000=
0;
> >  }
> >
> > +static int has_unmerged(const struct wt_status *s)
> > +{
> > +     int i;
> > +
> > +     for (i =3D 0; i < s->change.nr; i++) {
> > +             struct wt_status_change_data *d;
> > +             d =3D s->change.items[i].util;
> > +             if (d->stagemask)
> > +                     return 1;
> > +     }
> > +     return 0;
> > +}
> > +
> > +static void wt_status_mark_committable(
> > +             struct wt_status *s, const struct wt_status_state *state)
> > +{
> > +     int i;
> > +
> > +     if (state->merge_in_progress && !has_unmerged(s)) {
> > +             s->committable =3D 1;
> > +             return;
> > +     }
>
> Is this trying to say:
>
>         During/after a merge, if there is no higher stage entry in
>         the index, we can commit.
>
> I am wondering if we also should say:
>
>         During/after a merge, if there is any unresolved conflict in
>         the index, we cannot commit.
>
> in which case the above becomes more like this:
>
>         if (state->merge_in_progress) {
>                 s->committable =3D !has_unmerged(s);
>                 return;
>         }
>
> But with your patch, with no remaining conflict in the index during
> a merge, the control comes here and goes into the next loop.
>
> > +     for (i =3D 0; i < s->change.nr; i++) {
> > +             struct wt_status_change_data *d =3D (s->change.items[i]).=
util;
> > +
> > +             if (d->index_status && d->index_status !=3D DIFF_STATUS_U=
NMERGED) {
> > +                     s->committable =3D 1;
> > +                     return;
> > +             }
> > +     }
>
> The loop seems to say "As long as there is one entry in the index
> that is not in conflict and is different from the HEAD, then we can
> commit".  Is that correct?
>
> Imagine there are two paths A and B in the branches involved in a
> merge, and A cleanly resolves (say, we take their version because
> our history did not touch it since we diverged) while B has
> conflict.  We'll come to this loop (because we are in a merge but
> have some unmerged paths) and we find that A is different from HEAD,
> happily set committable bit and return.

I'll be honest: when I wrote this, I didn't think too much about what
the code was actually doing, semantically speaking: I was assuming
that the behavior that set the commitable bit in the call tree of
wt_longstatus_print() was correct, and that it was just a matter of
mechanically copying that logic over to the --short/--porcelain call
paths.

Looking into this more deeply, I think you're right, but more
problematically, this is technically a bug with the current Git code
that seems to be cancelled out by another bug: wt_status_state
apparently does not correctly reflect the state of the index when it
reaches wt_longstatus_print_updated(). Working from master
(f55ff46c9), I modified the last test in t7501 to look like this:

=E2=86=92.echo "Initial contents, unimportant" | tee test-file1 test-file2 =
&&
=E2=86=92.git add test-file1 test-file2 &&
=E2=86=92.git commit -m "Initial commit" &&
=E2=86=92.echo "commit-1-state" | tee test-file1 test-file2 &&
=E2=86=92.git commit -m "commit 1" -i test-file1 test-file2 &&
=E2=86=92.git tag commit-1 &&
=E2=86=92.git checkout -b branch-2 HEAD^1 &&
=E2=86=92.echo "commit-2-state" | tee test-file1 test-file2 &&
=E2=86=92.git commit -m "commit 2" -i test-file1 test-file2 &&
=E2=86=92.! $(git merge --no-commit commit-1) &&
=E2=86=92.echo "commit-2-state" | tee test-file1 &&
=E2=86=92.git add test-file1 &&
=E2=86=92.git commit --dry-run &&
=E2=86=92.git commit -m "conflicts fixed from merge."

And once inside gdb did this:

(gdb) b wt-status.c:766
Breakpoint 1 at 0x205d73: file wt-status.c, line 766.
(gdb) r
Starting program: /home/pockets/git/git commit --dry-run
[Thread debugging using libthread_db enabled]
Using host libthread_db library "/usr/lib/libthread_db.so.1".
On branch branch-2
You have unmerged paths.
  (fix conflicts and run "git commit")
  (use "git merge --abort" to abort the merge)


Breakpoint 1, wt_longstatus_print_updated (s=3D0x555555a29960 <s>) at
wt-status.c:766
warning: Source file is more recent than executable.
760             for (i =3D 0; i < s->change.nr; i++) {
(gdb) print s->change.nr
$1 =3D 1

Can you confirm I'm not crazy, and am analyzing this correctly?

> I _think_ with the change to "what happens during merge" above that
> I suggested, this loop automatically becomes correct, but I didn't
> think it through.  If there are ways other than .merge_in_progress
> that place conflicted entries in the index, then this loop is still
> incorrect and would want to be more like:
>
>         for (i =3D 0; i < s->change.nr; i++) {
>                 struct wt_status_change_data *d =3D (s->change.items[i]).=
util;
>
>                 if (d->index_status =3D=3D DIFF_STATUS_UNMERGED) {
>                         s->committable =3D 0;
>                         return;
>                 }
>                 if (d->index_status)
>                         s->committable =3D 1;
>         }
>
> i.e. we declare "not ready to commit" if there is *any* conflicted
> entry, but otherwise set committable to 1 if we see any entry that
> is different from HEAD (to declare succcess once we successfully
> loop through to the last entry without seeing any conflict).
>
> >  void wt_status_collect(struct wt_status *s, const struct wt_status_sta=
te *state)
> >  {
> >       wt_status_collect_changes_worktree(s);
> > @@ -728,6 +761,8 @@ void wt_status_collect(struct wt_status *s, const s=
truct wt_status_state *state)
> >               wt_status_collect_changes_index(s);
> >
> >       wt_status_collect_untracked(s);
> > +
> > +     wt_status_mark_committable(s, state);
> >  }
> >
> >  static void wt_longstatus_print_unmerged(const struct wt_status *s)
> > @@ -753,28 +788,28 @@ static void wt_longstatus_print_unmerged(const st=
ruct wt_status *s)
> >
> >  }
> >
> > -static void wt_longstatus_print_updated(struct wt_status *s)
> > +static void wt_longstatus_print_updated(const struct wt_status *s)
> >  {
> > -     int shown_header =3D 0;
> >       int i;
> >
> > +     if (!s->committable) {
> > +             return;
> > +     }
>
> No need to have {} around a single statement.  Especially when you
> know you won't be touching the line (e.g. to later add more
> statements in the block) in this last patch in a series.
>
> > +     wt_longstatus_print_cached_header(s);
> > +
