Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9F67C433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 20:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A94DA6145A
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 20:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbhD3UwX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 16:52:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235970AbhD3UwS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 16:52:18 -0400
Received: from mail-oi1-x22d.google.com (mail-oi1-x22d.google.com [IPv6:2607:f8b0:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17F32C06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 13:51:30 -0700 (PDT)
Received: by mail-oi1-x22d.google.com with SMTP id t24so13871368oic.10
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 13:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5QD42YqawuOdwgGKXGTu8vrfUyERwYBuArBdxArtTeQ=;
        b=HsjIRYLJTkk7BZuOS3faIToWNJGW+QNTsfW6V/lD3iga6MGfKRQ0mojmLh25AXw3aB
         UrozKb8vlsF9ux6pIc94JbUk1lbk6VhzaYO7fTQiiXucUUsnvb5EU1fxgPvdfyahvonM
         +81m6iNuPR+5tjOG5i+YdVexFKvK8T3IViW9IgQ0Fj4fm02/4CArI8DSQSr3ro3R4bsy
         5iFYDTbPOocX/7d70niT5GU7Vj1q5K/TX5YbpR4ZY/oX8E0GiDx2Zjp7/tMsEaXQO9vB
         n5FzOHeYhDjLAShgHFV5PplhBMzLJkO1EqDmFaVoysjqA1BMDsneBLKpZ8fM75fvx/Rh
         6y0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5QD42YqawuOdwgGKXGTu8vrfUyERwYBuArBdxArtTeQ=;
        b=IDO9mFf7E0iFA+HDzF2r15adiNs7MqZtDwLmnA2Et6lk+Y/rh7lyO/KOxSvDIQ6vVz
         rnUt1WZ90Feyn6aGWuXWm/QUGwJiW1XsW01SSlv6sMSTft3d/Jj3vezOJsNOjfvxTFaU
         wlNkKYhp65L0svtixFFtnwfRnlSL9Mi/psdK6H2sBEBlNI506uD8Yutp15SJSrqTsNW3
         q26aw1wdotIwpsDZt9sDZF5nxxAL4b7tEs32ts3y8s48pXH3IU6OY5KZIRWWrNYa4PrW
         Pdupfz16nXVchsrxubZmoqVZ5Xcw1AOa6tEmEqNx+yipRuEs1Uay1uicA2Me83ds6qpc
         uHkg==
X-Gm-Message-State: AOAM533D9M3hAJShGCuHJu9iPxCEfu78H37E2ZNGntSq0XLQsNBSiTO2
        GX6ZNKM+yPm16DLBRykivmFg9ADPdTGwL1Nr7PqVhzachBxxfw==
X-Google-Smtp-Source: ABdhPJyQNg2QKuKkuJ6wE2FsPGSno8ohwQlPfoOzgqMhhriWgP0DmPWLfHj5kNNVN9pHwIr00JudJ9cMuIzAmWGGFIU=
X-Received: by 2002:a54:4498:: with SMTP id v24mr5469760oiv.31.1619815889444;
 Fri, 30 Apr 2021 13:51:29 -0700 (PDT)
MIME-Version: 1.0
References: <CY4P132MB00885C970ACF5A277F06E40385419@CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM>
 <xmqqfszac25x.fsf@gitster.g> <CY4P132MB00885F00AAA46BCFAC76881B855F9@CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM>
 <xmqq5z04fwoz.fsf@gitster.g> <CY4P132MB00883DC8ABC72790A15C9630855E9@CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM>
In-Reply-To: <CY4P132MB00883DC8ABC72790A15C9630855E9@CY4P132MB0088.NAMP132.PROD.OUTLOOK.COM>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 30 Apr 2021 13:51:18 -0700
Message-ID: <CABPp-BHYTBq=ExL=wx5oPH+DmWpSxsTqMbiOHgMM8uF1czs49g@mail.gmail.com>
Subject: Re: bug:git-check-ignore exit status is wrong for negative patterns
 when -v option used
To:     Jeremy Faith <jeremy.faith@jci.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 30, 2021 at 2:57 AM Jeremy Faith <jeremy.faith@jci.com> wrote:
>
> On 30 April 2021 01:22 Junio C Hamano <gitster@pobox.com> wrote:
>
> >Jeremy Faith <jeremy.faith@jci.com> writes:
> >
> >> man git-check-ignore states:-
> >> EXIT STATUS
> >> -----------
> >> 0::
> >>        One or more of the provided paths is ignored.
> >> 1::
> >>        None of the provided paths are ignored.
> >> 128::
> >>        A fatal error was encountered.
> >>
> >> So my change matches what the manual states.
>
> >That is part of what I meant by "understandable, given the history".
>
> >The above description is _wrong_ ever since it was introduced, along
> >with check-ignore, at 368aa529 (add git-check-ignore sub-command,
> >2013-01-06).  It should have said "has/have entry that affects it in
> >the gitignore/exclude files" instead of "is/are ignored".  After
> >all, that is what the tool was written to do, i.e. to help debugging
> >the gitignore/exclude files.
> >
> >    git-check-ignore(1)
> >    ===================
> >
> >    NAME
> >    ----
> >    git-check-ignore - Debug gitignore / exclude files
> >
> >Having said all that.
> >
> >It is a misunderstanding that check-ignore is a tool to learn if a
> >path is or is not ignored, but the misunderstanding is so widespread.
> >
> >I wonder if we can repurpose the command to "match" the
> >misunderstanding, without hurting existing users, by
> >
> > (1) updating the one-liner description of the command in the
> >     documentation;
>
> > (2) keep the EXIT STATUS section as-is; and
> >
> > (3) adjust the code to exit with status that reflects if there was
> >     at least one path that was ignored (not "that had an entry in
> >     the gitignore/exclude files that affected its fate").
>
> If I understand correctly:-
>   (2) requires no change
>   (3) I believe my one line change does this
>
> Which just leaves (1) where current line is
>    git-check-ignore - Debug gitignore / exclude files
> I think with the exit status operating as documented this description still
> works i.e. check-ignore can be used to test if the .gitignore/exclude files
> are working as desired.
>
> The longer Description is:
>   DESCRIPTION
>        For each pathname given via the command-line or from a file via
>        --stdin, check whether the file is excluded by .gitignore (or other
>        input files to the exclude mechanism) and output the path if it is
>        excluded.
> Which matches the exit status meaning as is.
>
> >That certainly is a backward compatible change, but I suspect that
> >we may be able to sell it as a bugfix, taking advantage of the
> >documentation bug you quoted above.  Of course, people do not read
> >documentation, so scripts that used to use the command in the way it
> >was intended to be used (as opposed to "the way it was documented")
> >will still get broken with such a change, though.
>
> I'm not sure how the old exit status could be used in a useful way but you are
> correct there is a chance that some existing scripts depend on it.
>
> I was originally confused by the exit status when using git versions 1.8.3.1
> and 2.25.1. With these versions check-ignore returned 0 when a matching
> pattern was found, it did not matter if it was a positive or negative pattern.
> This did not match the exit status documented in the man page so I thought my
> .gitignore patterns were not working when they were.
> Perhaps I should stop reading man pages...
>
> I then tried the same patterns on an up to date version of git built from a
> a git clone and found that without -v it returned the exit status as the man
> page states but with -v the older exit status was given.
> The commit that changed the exit status was 7ec8125 from 2020-02-18, first
> release that included this commit was 2.26.
>
> So in 2.26 the exit status without -v was changed, maybe accidentally, in a
> way that made it match the man page. But this commit broke scripts(that
> do not use -v) that depend on exit status. My change extends the breakage to
> scripts that do use -v. On the other hand scripts written that expect the
> exit status to match the man page will be fixed!
>
> I'm not sure what the best course of action is but at least with my change
> the exit status matches the man page(even with -v).

I'm inclined to agree with Jeremy here.  Commit  7ec8125fba96
(check-ignore: fix documentation and implementation to match,
2020-02-18) demonstrated pretty clearly that check-ignore was just
flat-out broken since the beginning in regards to negated patterns, in
multiple ways: wrong exit status, documentation that was
self-contradictory, and non-matching documentation and implementation.
Among other things, that commit from last year fixed the exit status
without -v.  Unfortunately, when I (or the users I was interacting
with) use -v, I ignore the exit status and am just looking for the
output.  So I missed the exit status inconsistency for -v when I
created that commit and only fixed the exit status without -v.
