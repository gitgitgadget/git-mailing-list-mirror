Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBA9EC433ED
	for <git@archiver.kernel.org>; Mon, 10 May 2021 22:34:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C53B66157F
	for <git@archiver.kernel.org>; Mon, 10 May 2021 22:34:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbhEJWfj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 18:35:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhEJWfh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 18:35:37 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88726C061574
        for <git@vger.kernel.org>; Mon, 10 May 2021 15:34:32 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id w22so3392161oiw.9
        for <git@vger.kernel.org>; Mon, 10 May 2021 15:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VeBcVlXdBRiwaDotxyTpdUip7wypsfV0FMGbB2SjbOM=;
        b=OVUwApODK74e9vywdJvcfEXlBz02l/rJyTSTcnajfADOtQOuAvs/QZv1UoeLVWyuSG
         +n7k2Y8s+9rIlfIomgZ+34P4tG+htiWbgWQP+3Xsx4V2aGuxRc0v0HW/OftCCThi+fI4
         d9UnXLxdfUd6I9sybC8X9nGXQCodGzhutHC0T2YbrgF/uq0afDBKmVtQ4qiBK6xxGZ2F
         nu3vdYHkry7vixh8mkHOVykOByQ/8Y+Vgvr6tfBa9mCvj40izDXzdxZGjJtzcvjfvXRX
         fNu7LMBw63JYTvHOfokfgLl+mbgA53T8IFwIRyklqRLMpEHeQQKXcnfUcMsqnNKMyB9H
         ykaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VeBcVlXdBRiwaDotxyTpdUip7wypsfV0FMGbB2SjbOM=;
        b=sd/nVDAKBE3k6rfdvlhw9QG/t5ojcaWZgxaf/JWwcsWr0EbZJsUqTGhV6nQGrqfjyL
         f26kG6J771Tu9hgHhv5Zaqm4D8oNsy1YRD/4Z9c6l8/iDdWFqb+EY+ejYp8K8uD3ZW2q
         mtbc68faCMTs3eT18ny2muGxo3yuqJNN3MlE0mQOp1TZLRtp+aAgZoSjh95Pk72oa12m
         QSjd6c/rQuVry0ys3RuiCaIwv91I04BjzAXFz1QO0F0doBQVlq35UauxG8dpdAL+7dyz
         n+jt/vdiebxlAh1iYV/5GxjkgPfdDJIEKDZ+5CPxlTBd0H7Po2zgea/6dd0btg0I17PE
         /0lg==
X-Gm-Message-State: AOAM533XH4ofN7jNRYmnluxilHVxS3HdnmV8PjXQ98d1sJk5nXM3mbZY
        zGMgpBaghP0hcqDDtHQ5+xUZc4AcgAmSMs+B8NA=
X-Google-Smtp-Source: ABdhPJzcZ8lzxUxi1EUJ8p0kVP8JngJlzwr+YQbTL25zou1Tap65OQcZQgw76hOXXWIJhS43K3ue/X0s51fex/Rnqxw=
X-Received: by 2002:a05:6808:13d5:: with SMTP id d21mr4232260oiw.31.1620686071999;
 Mon, 10 May 2021 15:34:31 -0700 (PDT)
MIME-Version: 1.0
References: <e4c3d482-03b4-141c-e47b-cb3e175da3ab@iee.email>
 <789bcc9cd074cb94f706b9d432e29b52bf6a33c3.1620134775.git.matheus.bernardino@usp.br>
 <CABPp-BFpeoENLADH-e6dCc0PyEVQyHueY6PV8AZYbD+a3iceXA@mail.gmail.com> <CAHd-oW7veyN+qetv-Mf-qPa+bcah=JCz6mSRAzunVgaFRxdbnA@mail.gmail.com>
In-Reply-To: <CAHd-oW7veyN+qetv-Mf-qPa+bcah=JCz6mSRAzunVgaFRxdbnA@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 10 May 2021 15:34:20 -0700
Message-ID: <CABPp-BHPr0aJZTRsVPK+Ga2oKZJLa75OkcyHLpZH=sD1pfpNZg@mail.gmail.com>
Subject: Re: gitignore + commit with excludes = bug
To:     Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Cc:     Philip Oakley <philipoakley@iee.email>,
        Git Mailing List <git@vger.kernel.org>,
        mailnew4ster@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 10, 2021 at 12:37 PM Matheus Tavares Bernardino
<matheus.bernardino@usp.br> wrote:
>
> On Mon, May 10, 2021 at 4:27 PM Elijah Newren <newren@gmail.com> wrote:
> >
> > Thanks for tracking this down.  Your analysis and patch look correct
> > to me, but perhaps we could simplify the code a bit.  Instead of
> > looping twice, perhaps insert the following code above the if-checks:
> >
> > +               /*
> > +                * We can have a bunch of exclusion rules:
> > +                *    .gitignore
> > +                *    *.log
> > +                *    !settings.log
> > +                * and we're trying to see if the path matches one of these,
> > +                * but note that the last one is a "negated exclusion rule",
> > +                * for the excludes to match this pathspec, it needs to not
> > +                * match the negated exclusion.
> > +                */
> > +               int retval = (item->magic & PATHSPEC_EXCLUDE) ? 0 : 1;
> >
> > and then change all the "return 1" statements to "return retval".
>
> Hmm, but then wouldn't something like `git add ignored :^ignored` also
> trigger the warning, as we see 'ignored' first, and return 1 before
> seeing ':^ignored'?

Oh, right, whoops.  Do you want to add this testcase, and a commit
message for this (and maybe a comment explaining the double loop)?
