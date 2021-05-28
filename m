Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60D9AC2B9F7
	for <git@archiver.kernel.org>; Fri, 28 May 2021 18:09:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 446566124B
	for <git@archiver.kernel.org>; Fri, 28 May 2021 18:09:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbhE1SLN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 14:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbhE1SLN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 14:11:13 -0400
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com [IPv6:2607:f8b0:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10AACC061574
        for <git@vger.kernel.org>; Fri, 28 May 2021 11:09:37 -0700 (PDT)
Received: by mail-ot1-x32f.google.com with SMTP id t10-20020a05683022eab0290304ed8bc759so4267079otc.12
        for <git@vger.kernel.org>; Fri, 28 May 2021 11:09:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=FK9fkPHXsx9TK8HsEqKaVVcwXVuO6pgciDBWlL3zbqs=;
        b=VzQcK7WZ5IyV/+HyLyjLxYBpnQd3Jn177i8JHFZAI0y7MjtlX9UGKLw2lJD1Gq4ZqO
         iLmDHnFIiUcuNoE+9xST5u/RQyVjdz6t/0I7xM6LPbpMR2OjONJSzuc2oqk2t9vyTcxt
         +ldYFb51YgKouBMPacTdTP2mzqeVFYvwQxVjBD1vN2AAZI9OtT3xMPrrNrU3L+sSnQoJ
         BkuKi1TMef8Jej9zdcdpBqOWRYB3fu2MzSZJCgy73SjE1yr0FjWAps5fyfbsveAkybsK
         2AcWb+ZZKH4y2t9e8XnqvgZDoJ7PkFSKeD5gtI4lil0FbrYYwabGUDJKCxECbYGV9L0Q
         C7Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=FK9fkPHXsx9TK8HsEqKaVVcwXVuO6pgciDBWlL3zbqs=;
        b=rJplOXm4gY93N81sDCu0+2C6jrYqY0JPXH0zlhhR3n7q3QtneUdD/nOf9w61yMfXsl
         WbOnqBxwDIJr8tI5shwISPKQAoZQl4MHp+4DYONSIQMBMDhcNFZ0F6oNgG/TJq0Qypf9
         GqYblD8fqvf6MBSYGn522x5HB7V+0/6opih7DJNZjYtaOIQEEatNcy2Xf5jvlL/WCciq
         szIco+WRJju7dFjaIwbwRIqeNSRVKzQytfScXw1wnyBWoTbgiJ7hcRADJddDH2f8u1xI
         X4n0b80nDGtuEnxL3prkOeG7fWupmtjkjFpBw4QjfqMP6FiJEu0MledGBZUNfT4gSFAN
         VdiQ==
X-Gm-Message-State: AOAM531+VbpSVnTs2xlQ0XxUmlbhft2jKWZ0Ba6VzfsKM7olrPcPE/35
        hlR6KdAYofmCbjFxD2QDWxSX6Sq/I+IQMKTNLMg=
X-Google-Smtp-Source: ABdhPJzktPdzbMVXcqSQCXJWxll8FS22Z9NmLEgnHkRKIPTUVM+SuF8JPiuQPciEYpX3M9sYjIU0AJ4yrc6FxD84FOE=
X-Received: by 2002:a9d:67c5:: with SMTP id c5mr7824163otn.162.1622225376412;
 Fri, 28 May 2021 11:09:36 -0700 (PDT)
MIME-Version: 1.0
References: <pull.962.git.1622104642.gitgitgadget@gmail.com>
 <5055dfce32815c8c8ec250457df389d4cd02ee12.1622104642.git.gitgitgadget@gmail.com>
 <e0842d32-a11c-91d8-3660-cffdb5639193@web.de> <CABPp-BH_nFJ2N6Jf64jZPNKdbwm2Yt=zo6pw-9s6S+fzo7a=pg@mail.gmail.com>
 <106a5592-4e5e-cf06-16e4-100ca3c3fb5f@web.de>
In-Reply-To: <106a5592-4e5e-cf06-16e4-100ca3c3fb5f@web.de>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 28 May 2021 11:09:25 -0700
Message-ID: <CABPp-BHoZTFwcqZvLLdPR0deuBRjzeY9DgPVkCu4GYkt9=gc-Q@mail.gmail.com>
Subject: Re: [PATCH 1/5] merge-ort: replace string_list_df_name_compare with
 faster alternative
To:     =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Taylor Blau <me@ttaylorr.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 28, 2021 at 9:12 AM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
>
> Am 28.05.21 um 00:47 schrieb Elijah Newren:
> > On Thu, May 27, 2021 at 2:00 PM Ren=C3=A9 Scharfe <l.s.r@web.de> wrote:
> >>
> >> Am 27.05.21 um 10:37 schrieb Elijah Newren via GitGitGadget:
...
> >>>  /*** Function Grouping: functions related to process_entries() ***/
> >>>
> >>> -static int string_list_df_name_compare(const char *one, const char *=
two)
> >>> +static int sort_dirs_next_to_their_children(const void *a, const voi=
d *b)
> >>>  {
> >>> -     int onelen =3D strlen(one);
> >>> -     int twolen =3D strlen(two);
> >>
> >> The old code scans both strings fully, while the new one stops when it
> >> reaches a difference and doesn't look at any further characters.  How
> >> much does that contribute to the speedup?  (I suspect a lot.)
> >
> > Oh, indeed, good catch.  It appears to be responsible for essentially a=
ll of it.
>
> Then you can keep the original function signature (as well as the use of
> string_list_sort) and avoid explicit casts.

Fair enough; though I'll probably still apply the function rename,
even if I keep the old signature.  The function has a completely
different purpose in merge-ort.c than it does in merge-recursive.c.

> The same function exists in merge-recursive.c, by the way.  I suspect we
> could avoid sorting entirely there by taking advantage of the index
> order and a mechanism like the one in the second half of
> fsck.c::verify_ordered().  That's a bit tricky, though (for me anyway).
>
> All tests still pass when I replace string_list_df_name_compare() with
> strcmp() in merge-recursive.c, so the first thing needed would be tests
> that highlight the difference between those comparison functions,
> however.  Not sure if it's worth it -- merge-recursive is on its way
> out, right?

Interesting idea (and interesting that the function might not matter
anymore in merge-recursive.c and might be replaceable by strcmp), but
yeah merge-recursive.c is on its way out.  In fact, there are two
other reasons to also not modify merge-recursive.c along these lines:
(1) We want to keep merge-recursive stable right now as we push people
to try out merge-ort, so that we have a good comparison point if they
run into problems; if we modify merge-recursive, especially in tricky
ways, then our comparison point might get invalidated.  (2) This
codepath is relatively hot in merge-ort.c because it has optimized all
the other stuff, so saving approximately half a second is significant.
In merge-recursive.c, saving half a second is a small blip in the
overall timing that would be lost in the run-to-run variability.
(Saving 0.7s off of 10.127 s =C2=B1  0.073 s is huge; but removing that
much time from 5964.031 s =C2=B1 10.459 is wasted effort.)

> Not sure if d/f conflicts could also be detected in merge-ort.c without
> sorting -- the original order is lost when the paths are thrown into
> a strmap.

While string_list_df_name_compare() in merge-recursive.c is used for
the purpose of detecting D/F conflicts, this function in merge-ort.c
had nothing to do with detecting D/F conflicts.  In fact, D/F
conflicts were already detected in collect_merge_info_callback() on
this line:

    unsigned df_conflict =3D (filemask !=3D 0) && (dirmask !=3D 0);

and recorded in setup_path_info(), which was done long before it got
to this point in the code.  The point of this sorting in merge-ort.c
is just to put paths in an order that allows us to write out trees as
we process them and record the resulting hash for the next directory
up the chain as we go.
