Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 709EB1F453
	for <e@80x24.org>; Fri, 25 Jan 2019 20:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfAYUE1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Jan 2019 15:04:27 -0500
Received: from mail-vs1-f50.google.com ([209.85.217.50]:44928 "EHLO
        mail-vs1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725778AbfAYUE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jan 2019 15:04:27 -0500
Received: by mail-vs1-f50.google.com with SMTP id u11so6380381vsp.11
        for <git@vger.kernel.org>; Fri, 25 Jan 2019 12:04:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yNlYERb346X4RKzBpFfckU4IS6KjF1h3AdKXPFZMTX0=;
        b=achfPgUxfZjV7HLWkYNDqHyBlbNbpa77MvOiZtNd+r0aDYwNuQphiPN7qdyaqQI53u
         rq2DaCm4xVpRqLRdULpF026l7MK/+WWU2oRznqvK8LBf9LhuQM8YJl55FtYNp6TAsxCk
         ylC7Ilth3PJ7D+nSmMYfBa1ScJ7uWPjb7iY10SKr7Ayfo8mdWUgD86JBBdUxek6RC2kq
         1JljMPcmRQp26V8lwexOY0oIW1HgufoTYq5XmfcuoedpGdmXWPCn8dGz6aE7Axqmbphc
         rzLyQTNZF09t53csmVM9vaPIqKue9SOgmPFg3S+rUCcQrZPM2lcTy+c3ubhd+Y+Sdl6q
         xtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yNlYERb346X4RKzBpFfckU4IS6KjF1h3AdKXPFZMTX0=;
        b=BAIJKrBHrjJxqz68QLV3gJlGZST6Iarodr0v7+IRBCFNb5trdRb1ESS1DXIQNwiu5o
         ky+4Z2CQ/V2MKurEUlaTpbyLvlHmmQl2ZKRahdzATFvfi5LJv1/p357jYnFZC2uzrP1I
         7VeKk4Q2f7r1EWmtHjG7vTB8mRw1refzv7C4u+6UR3Qbazqnp6QPt/U1gcOdr9X5qib/
         mzX1INQZ4bEeuHqS0+yovn47i5lWgf1TTUlrn+alYaNB8/PSJ473wNOQkW41VvmlmN5Y
         TZ2RyfkdIv8cMb8LU+ldjCZ4gzfbPOSvLXdhGQEIR6opT3QRAB1Pkp9ybI8Zy/NiN/3a
         hhYA==
X-Gm-Message-State: AJcUukeLaay+9Dy99IEuWx5HoU1tSV5RQ4b8A6gB/lLx+P+V/AkATt7y
        eyKaP1x5NpWDgs7QehYSBbSc7i35BVHUTQ2K0xU=
X-Google-Smtp-Source: ALg8bN5TsRAdDt0g6OZFi/Zpgu4Pg7GFp1J2jF3R2+YZRL34oIw2+xCf+T1c6wj5te4KyRLn7Z8JeD+tYr2e17e2qKE=
X-Received: by 2002:a67:7657:: with SMTP id r84mr5127164vsc.117.1548446665633;
 Fri, 25 Jan 2019 12:04:25 -0800 (PST)
MIME-Version: 1.0
References: <20190124164654.1923-1-newren@gmail.com> <xmqqmunofsdv.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqmunofsdv.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 25 Jan 2019 12:04:13 -0800
Message-ID: <CABPp-BFjUgY5htSbPpnamPDRM3bCLNsQv-K35uXoRzaT2f85tA@mail.gmail.com>
Subject: Re: [PATCH] log,diff-tree: add --combined-with-paths options for
 merges with renames
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 25, 2019 at 11:29 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > The raw diff format for merges with -c or --cc will only list one
> > filename, even if rename detection is active and a rename was detected
> > for the given path.  Examples:
> >
> >   ::100644 100644 100644 fabadb8 cc95eb0 4866510 MM   describe.c
> >   ::100755 100755 100755 52b7a2d 6d1ac04 d2ac7d7 RM   bar.sh
> >   ::100644 100644 100644 e07d6c5 9042e82 ee91881 RR   phooey.c
> >
> > This doesn't let us know what the original name of bar.sh was in the
> > first parent, and doesn't let us know what either of the original
> > names of phooey.c were in either of the parents.  In contrast, for
> > non-merge commits, raw format does provide original filenames (and a
> > rename score to boot).  In order to also provide original filenames
> > for merge commits, add a --combined-with-paths option (which is only
> > useful in conjunction with -c, --raw, and -M and thus implies all
> > those options) so that we can print tab-separated filenames when
> > renames are involved.  This transforms the above output to:
> >
> >   ::100644 100644 100644 fabadb8 cc95eb0 4866510 MM   describe.c
> >   ::100755 100755 100755 52b7a2d 6d1ac04 d2ac7d7 RM   foo.sh  bar.sh
> >   ::100644 100644 100644 e07d6c5 9042e82 ee91881 RR   fooey.c fuey.c  phooey.c
>
> I admit that I designed the original without too much thought.
> Perhaps we should have avoided discarding info, but it is way too
> late to fix with a default behaviour change.
>
> I am not sure if it is easy for consumers to guess which name on the
> output line corresponds to which input tree from the status letter,
> though.  Would it make it easier for consumers if this showed names
> in all input trees if any of them is different from the name in the
> resulting tree, I wonder?  Even in that case, the consumer must know
> some rule like "if R or C appears in the status column, then we have
> N preimage names plus the name in the result for N-way merge", so it
> may not be too bad to force them to know "for each of R or C in the
> status column, the name in the preimage tree is emitted, and the
> last name is the name in the result".  I dunno.

I wasn't able to guess the other fields in the raw format ("which of
the three blob shas is the final one and which ones were for parents")
without going and reading the diff-format.txt documentation.  Unless
we always list all names on all lines (even e.g. for 'MM' changes
which will list the same filename three times), we have a more
complicated case where people will have to refer to that
documentation.  I hope the extra paragraphs and examples I added there
are sufficient to spell it out.

Also, my first version of the patch actually showed all names, on all
lines, but I found the heavy repetition really annoying, and not in
keeping with how non-merge commits are handled (where original
filenames are only shown when they differ).  Granted, my change isn't
the only one.  We could just have all names shown if they are not all
identical, as you suggest and I also considered, but I liked this way
slightly better.  If others feel strongly, I can change it, that was
just my gut feel and preference.

> > +For `-c` and `--cc`, only the destination or final path is shown even
> > +if the file was renamed on any side of history.  With
> > +`--combined-with-paths`, the number of paths printed will be one more
> > +than the number of 'R' characters in the concatenated status.  For
> > +each 'R' in the concatenated status characters, the original pathname
> > +on that side of history will be shown, and the final path shown on the
> > +line will be the path used in the merge.
>
> Is it safe for readers to pay attention to only 'R'?  Will it stay
> forever that way?  My immediate worry is 'C', but there might be
> other cases that original and result have different names.

Oops, yeah, it should also handle 'C' and be worded so that if any
future change type comes along involving different names then it'd be
included.

> > +--combined-with-paths::
> > +     This flag is similar to -c, but modifies the raw output format for
> > +     merges to also show the original paths when renames are found.
> > +     Implies -c, -M, and --raw.
>
> So, --cc -p is not allowed to use this?  I was wondering if we want
> to have a separate "even though traditionally we did not show
> preimage names in combined output, this option tells Git to do so,
> regardless of output format used, as long as 'combine-diff' is in
> effect".

You could kind of ask the same question of -c -p, actually.  I looked
into that, but I was only interested in raw format output and --cc is
only about coalescing uninteresting hunks in patches.  Whenever git
shows a combined diff in patch format, it always lists two files in
the header, e.g.:
  a/foo.c
  b/foo.c
perhaps because people have a built-in expectation that a diff has to
involve exactly two files.  I wasn't sure how hard-baked in that
assumption is, but as I was only interested in raw format I didn't
mess with it.  We'd have to switch to showing three or more if we want
this to be relevant to such a mode.  Would that make sense for users
to show in a patch?  I guess the "combined" patch is already kind of
special, so it could make sense, but it kind of feels like a follow-on
feature for someone else to implement...unless leaving it out now
somehow boxes us in.
