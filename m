Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31B8120248
	for <e@80x24.org>; Sat,  9 Mar 2019 18:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726402AbfCIS1S (ORCPT <rfc822;e@80x24.org>);
        Sat, 9 Mar 2019 13:27:18 -0500
Received: from mail-vk1-f193.google.com ([209.85.221.193]:43830 "EHLO
        mail-vk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726381AbfCIS1R (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 9 Mar 2019 13:27:17 -0500
Received: by mail-vk1-f193.google.com with SMTP id e131so170433vkf.10
        for <git@vger.kernel.org>; Sat, 09 Mar 2019 10:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Mkwp3uIzWTKOZHzPR9Ys7ogQk355FLZHpYVZkQmj/UI=;
        b=l7ttnTgdqTWo/ZaUBzBpU8B4OxPgzJvDGB8crtOJ68r2zbIAU72tmjb2EWLYVDInpW
         CmYsf7yk/84Elvz3+Hdpz6+LIcDZtAiRT7aDVlq85utJWNUIa/QKmYmeh8P4lzsB8SRe
         eDYbLFerpDgfAJoGMFhUkb89lcylBbrJw/REIsitB9QDCrXtCN+MW4pqrttkMYMj/cIn
         K1HL9Ye6alKwmkA0iug12vdrhqL0sKQykpQQAsz6CKOzEVku5Alvsf2jvBDe6mPJbYMF
         TM+rjeq4I7KlPaAE1Es9CzuhgnSV3nl/7KO0m+Kpkl9qx39ojLKQFuRfsi9ivc55Dxwh
         0x2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Mkwp3uIzWTKOZHzPR9Ys7ogQk355FLZHpYVZkQmj/UI=;
        b=S+3uOcnC+tRSZwYpUufATzoNN2OlgXItKJBpwMPk4GYcZmQNZ4SXYiACSKyHzSpfdn
         eQgWlqlBfZh23vTH/Lq4daSGAntMUUqPmUeUy3WcYr2nFmiqtlm6p5ltO8yrvLfR4b56
         1p2VFEYJY4spuZ1kenA+h/8/8/DZo7elNXTXVhgc8h4tj+7BrTR+fj0e8CMuTGdlt/T5
         pkLNTHiCNAJ9jZMBrEtvM9rJO2oK+cwm+KM2YUnWPZW4rdsdAFVPiDz1OqxvYTxmrRqx
         5K5fdAVTQs5n9zPEJlYO3CD52H8853VLAOCxkjfiINLa6QJ7LW0wcc+vcz8L1CfGMyAQ
         xKMw==
X-Gm-Message-State: APjAAAVVEwlfGpvUX0J+zqI5ADOInfrqe80c4AEEYHIX3XRwHBfl1XA9
        3LTfTRE+r5cTWN8bA3AnJDsXwAg6ks+TMbi/9Hc=
X-Google-Smtp-Source: APXvYqx59p0NuZpXLH/xnk1sb/CZd0kKQB2go1C2AxSnO16pTe7gvtvudAWN3FIGWibkasZbXw2qP+4+Kxct7LlMVsQ=
X-Received: by 2002:a1f:ab03:: with SMTP id u3mr12158717vke.1.1552156036296;
 Sat, 09 Mar 2019 10:27:16 -0800 (PST)
MIME-Version: 1.0
References: <20190308101655.9767-1-pclouds@gmail.com> <20190308101655.9767-2-pclouds@gmail.com>
 <CABPp-BFXZMorrHph3hGFnqfceHs68byWNgffNKGp1ov6X5-o5A@mail.gmail.com> <CACsJy8D4tvm_zLo0DcnjmcBeKDRDR+HGAxd1PsUMSBcgR59DPg@mail.gmail.com>
In-Reply-To: <CACsJy8D4tvm_zLo0DcnjmcBeKDRDR+HGAxd1PsUMSBcgR59DPg@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Sat, 9 Mar 2019 10:27:05 -0800
Message-ID: <CABPp-BENtDUOpKYHZu=4rKFrQMaCE=fEtAWRqHvePjZYm1jTtg@mail.gmail.com>
Subject: Re: [PATCH v1 01/11] checkout: split part of it to new command 'restore'
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 9, 2019 at 4:16 AM Duy Nguyen <pclouds@gmail.com> wrote:
> On Sat, Mar 9, 2019 at 1:01 AM Elijah Newren <newren@gmail.com> wrote:

> > > +-q::
> > > +--quiet::
> > > +       Quiet, suppress feedback messages.
> > > +
> > > +--progress::
> > > +--no-progress::
> > > +       Progress status is reported on the standard error stream
> > > +       by default when it is attached to a terminal, unless `--quiet`
> > > +       is specified. This flag enables progress reporting even if not
> > > +       attached to a terminal, regardless of `--quiet`.
> >
> > I'm assuming this means there are feedback messages other than
> > progress feedback?
>
> There could be. This is carried over from git-checkout. I suspect this
> is about warnings that we print from time to time.

Why would --quiet squelch warnings?  I figured it'd only squelch
feedback, informational, or progress messages.

I understand you just carried it over from git-checkout, but as worded
it makes me wonder if checkout has suboptimal behavior or perhaps just
a suboptimal explanation of its flags ... and if it does, we probably
don't want to carry that over.

> > > +-f::
> > > +--force::
> > > +       If `--source` is not specified, unmerged entries are left alone
> > > +       and will not fail the operation. Unmerged entries are always
> > > +       replaced if `--source` is specified, regardless of `--force`.
> >
> > This may be slightly confusing, in particular it suggests that --index
> > (or --worktree and --index) are the default.  Is --force only useful
> > when --index is specified?  If it has utility with --worktree only,
> > what does it do?
>
> Well, this is 'git checkout -f' behavior which only concerns the
> index. So yeah it only matters with --index.

Okay, good to know that this only matters with --index. However, new
problem: This makes the explanation feel contradictory, though,
because elsewhere you stated that --source=HEAD is implied when
--index is given without a source.  So, the combination of this
description and that fact suggests that -f is either useless (--index
is not specified) or ignored (because --source will either default to
HEAD or be specified by the user).  Maybe that's true and -f should be
removed from this new document.  If it has actual utility in some
cases, then this description needs to be reworked to explain what
those circiumstances are somehow.

> > Also, what happens when there are unmerged entries
> > in the index and someone tries to restore just working tree files --
> > are the ones corresponding to unmerged entries skipped (if so,
> > silently or with warnings printed for the user?), or does something
> > else happen?
>
> If -m is also specified, then we recreate the conflict. The from code,
> if an unmerged path is skipped, there will be warnings.

Not sure I understand.  Are you saying that if -m is not specified and
nor is --source or --index, that we print a warning for each unmerged
entry specified by the pathspecs?

> > > +
> > > +-m::
> > > +--merge::
> > > +       Recreate the conflicted merge in the specified paths.
> > > +
> > > +--conflict=<style>::
> > > +       The same as `--merge` option above, but changes the way the
> > > +       conflicting hunks are presented, overriding the merge.conflictStyle
> > > +       configuration variable.  Possible values are "merge" (default)
> > > +       and "diff3" (in addition to what is shown by "merge" style,
> > > +       shows the original contents).
> >
> > Should you mention that these are incompatible with --source and
> > --index?  And perhaps also make sure the code aborts if either of
> > these options are combined with either of those?
>
> I will make sure that the code aborts. Not so sure about mentioning
> every incompatible combination though. Will it be too much? I think we
> catch and report plenty invalid combinations but I don't think we have
> mentioned them all (or maybe we have, I didn't check the document
> again)

Making sure the code aborts is probably good enough.


Elijah
