Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 83D7A211B3
	for <e@80x24.org>; Mon,  3 Dec 2018 13:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725924AbeLCN3G (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Dec 2018 08:29:06 -0500
Received: from mail-pl1-f196.google.com ([209.85.214.196]:35633 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725897AbeLCN3F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Dec 2018 08:29:05 -0500
Received: by mail-pl1-f196.google.com with SMTP id p8so6496778plo.2
        for <git@vger.kernel.org>; Mon, 03 Dec 2018 05:28:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tZllS+lwM3EPwdGZnqGS0+ewFodkC7VCZ15bas86qMY=;
        b=o/a9Pyw7TJt7Bk7bJwtooJqtBj/pjXQG5TaF1MzY25MIrfllO5Fdipmk7aUnPrFSIl
         Bj/Cnz8UYPu6bGgDSMrANQJplcCjiQxjZAGEA7OHufFKgDpuH/NlBEVDFtYQX7qDSjy7
         /ajDT0a5IkzmWgfk5JoXN2ythrdYu3+ncV8S1vEtgO0l3HrirxxKNC0hNIXRpBLiIPCq
         XJNhgX4f/idNt2mh5DaCmIEjWjRaHZWiI8D7btzLKRCeKyXkzc8rjo+1W6TKrcU/Xx3b
         mvW9fORVR3bHaf3s3l1N0u/Izf/LYMiLYeJgUNuxH3lUgWTaK5HUivhbEFRz27zG9+zc
         OBHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tZllS+lwM3EPwdGZnqGS0+ewFodkC7VCZ15bas86qMY=;
        b=gfGKPIEOLTkEaUMfJIZzrrduQrdoM4HvNYRcrsVk1xf11FHSNiR8ovaI0kqlwd4HbC
         dfadP8MX4UlKm81jP7xiJUICGaVbPdk3KLXha8cTKyQjNOIDK0+hiI8xuuSqPZbmTpnE
         g2eCoZGttGbNLm5eFVCGdZA7UHZxIVQHleqZFw7vldG/vEyBAWC41suSoAc6b+k6tNdC
         MGSnMrrZ7XZxF0G/KJvwqdDEVuWKnJaoorvOxwDN81atmLuyBRu9V9Y98Dte2GngdEkW
         5cFKxlfirwkO6hX6gZOctoBorn2exzPU/I2uMQbHZFydhVV59z3stHpp4fX5k2yJsnhw
         Ldlg==
X-Gm-Message-State: AA+aEWbDfoo8ttGeqUcbk3l++SjemYMVah986iwwToH8KYNWDdKiPd8T
        VljTDLrecB19n/pZgt3MyB2gzALrcPzzSE92JAY=
X-Google-Smtp-Source: AFSGD/WzWbklLRjhatkX+1JkJjivXZhe1EVxBWR8GVEC4ia6w2bP8lLY360LCc82jpazw+ScgXNv51512am/YeH/UY0=
X-Received: by 2002:a17:902:8c98:: with SMTP id t24mr15932835plo.130.1543843684071;
 Mon, 03 Dec 2018 05:28:04 -0800 (PST)
MIME-Version: 1.0
References: <xmqqk1l32jo2.fsf@gitster-ct.c.googlers.com> <20181128201852.9782-3-avarab@gmail.com>
 <nycvar.QRO.7.76.6.1811291103190.41@tvgsbejvaqbjf.bet> <8736rkyy4h.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.1811291307070.41@tvgsbejvaqbjf.bet> <871s74yms3.fsf@evledraar.gmail.com>
 <nycvar.QRO.7.76.6.1811291641090.41@tvgsbejvaqbjf.bet> <87tvjzyiph.fsf@evledraar.gmail.com>
 <xmqq7egvmh54.fsf@gitster-ct.c.googlers.com> <xmqqwoovkx5s.fsf_-_@gitster-ct.c.googlers.com>
 <CAPig+cS4peHDOz0cK7RJEHb6ch0+czvau_aGTD1j6xM23G0-pQ@mail.gmail.com>
In-Reply-To: <CAPig+cS4peHDOz0cK7RJEHb6ch0+czvau_aGTD1j6xM23G0-pQ@mail.gmail.com>
From:   =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>
Date:   Mon, 3 Dec 2018 14:27:49 +0100
Message-ID: <CAN0heSrfH39-37KDU3XDhxiYs1_3eUMdjbdAm37cPAmnOYUZMA@mail.gmail.com>
Subject: Re: [PATCH] format-patch: do not let its diff-options affect
 --range-diff (was Re: [PATCH 2/2] format-patch: allow for independent diff &
 range-diff options)
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, 30 Nov 2018 at 10:32, Eric Sunshine <sunshine@sunshineco.com> wrote=
:
>
> On Thu, Nov 29, 2018 at 11:27 PM Junio C Hamano <gitster@pobox.com> wrote=
:
> > Junio C Hamano <gitster@pobox.com> writes:
> > So how about doing this on top of 'master' instead?  As this leaks
> > *no* information wrt how range-diff machinery should behave from the
> > format-patch side by not passing any diffopt, as long as the new
> > code I added to show_range_diff() comes up with a reasonable default
> > diffopts (for which I really would appreciate extra sets of eyes to
> > make sure), this change by definition cannot be wrong (famous last
> > words).

> Another benefit of calling show_range_diff() directly is that when
> "git format-patch --stdout --range-diff=3D..." is sent to the terminal,
> the range-diff gets colored output for free. I'm pleased to see that
> that still works after this change.

(If the patch below makes any sense to you and you know more about this
diff/color thing, the fourth bullet in the log message below might
interest you.)

> > diff --git a/range-diff.h b/range-diff.h
> > @@ -5,6 +5,11 @@
> > +/*
> > + * Compare series of commmits in RANGE1 and RANGE2, and emit to the
> > + * standard output.  NULL can be passed to DIFFOPT to use the built-in
> > + * default.
> > + */
>
> It is more correct to say that the range-diff is emitted to
> diffopt->file (which may be stdout).

This seems to be an important remark. There's a pretty bad regression
here since when `diffopt` is NULL, we've lost our original, intended
`diffopt->file` and the range-diff ends up on stdout.

Here's my whitespace-damaged WIP. I would be able to pick this up again
in about 6h, but anyone is more than welcome to pick this up and run
with it in the meantime.

This is not a corner of the code that I'm particularly familiar with...

-->8--
Subject: [PATCH] range-diff: always pass at least minimal diff options
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Commit d8981c3f88 ("format-patch: do not let its diff-options affect
--range-diff", 2018-11-30) taught `show_range_diff()` to accept a
NULL-pointer as an indication that it should use its own "reasonable
default". That fixed a regression from a5170794 ("Merge branch
'ab/range-diff-no-patch'", 2018-11-18), but unfortunately it introduced
a regression of its own.

In particular, it means we forget the `file` member of the diff options,
so rather than placing a range-diff in the cover-letter, we write it to
stdout. In order to fix this, rewrite the two callers adjusted by
d8981c3f88 to create a "dummy" set of diff options where they only fill
in which file to use.

A couple of remarks about this commit:

  * No tests. The change in builtin/log.c has been tested manually, the
    one in log-tree.c not at all, other than by running existing tests.

  * I have not convinced myself 100% that there aren't other things that
    are just as important as `file` to pass down.

  * `show_range_diff()` can still take NULL, although that is now dead
    code. If something like this here commit is deemed the proper fix
    for this, that code path could also go, either as part of this
    commit, or separately, once we've cut 2.20.

  * The range-diff is written colored regardless of destination, i.e.,
    when written to a file, it contains garbage.

Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
---
 builtin/log.c | 12 +++++++++++-
 log-tree.c    | 12 +++++++++++-
 2 files changed, 22 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 5ac18e2848..0609e41ae5 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1094,9 +1094,19 @@ static void make_cover_letter(struct rev_info
*rev, int use_stdout,
     }

     if (rev->rdiff1) {
+        /**
+         * (At least for now) we only want to pass down
+         * the file handle where we want the range-diff
+         * to appear. Avoid any other diff options until
+         * we know how we want to handle them.
+         */
+        struct diff_options opts;
+        diff_setup(&opts);
+        opts.file =3D rev->diffopt.file;
+        diff_setup_done(&opts);
         fprintf_ln(rev->diffopt.file, "%s", rev->rdiff_title);
         show_range_diff(rev->rdiff1, rev->rdiff2,
-                rev->creation_factor, 1, NULL);
+                rev->creation_factor, 1, &opts);
     }
 }

diff --git a/log-tree.c b/log-tree.c
index b243779a0b..bc355a4e91 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -755,14 +755,24 @@ void show_log(struct rev_info *opt)

     if (cmit_fmt_is_mail(ctx.fmt) && opt->rdiff1) {
         struct diff_queue_struct dq;
+        struct diff_options opts;

         memcpy(&dq, &diff_queued_diff, sizeof(diff_queued_diff));
         DIFF_QUEUE_CLEAR(&diff_queued_diff);

         next_commentary_block(opt, NULL);
         fprintf_ln(opt->diffopt.file, "%s", opt->rdiff_title);
+        /**
+         * (At least for now) we only want to pass down
+         * the file handle where we want the range-diff
+         * to appear. Avoid any other diff options until
+         * we know how we want to handle them.
+        */
+        diff_setup(&opts);
+        opts.file =3D opt->diffopt.file;
+        diff_setup_done(&opts);
         show_range_diff(opt->rdiff1, opt->rdiff2,
-                opt->creation_factor, 1, NULL);
+                opt->creation_factor, 1, &opts);

         memcpy(&diff_queued_diff, &dq, sizeof(diff_queued_diff));
     }
--=20
2.20.0.rc2
