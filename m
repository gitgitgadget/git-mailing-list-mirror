Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-12.0 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E01761F453
	for <e@80x24.org>; Fri, 15 Feb 2019 22:19:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728593AbfBOWTD (ORCPT <rfc822;e@80x24.org>);
        Fri, 15 Feb 2019 17:19:03 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:43370 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726000AbfBOWTD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Feb 2019 17:19:03 -0500
Received: by mail-lf1-f67.google.com with SMTP id j1so8302498lfb.10
        for <git@vger.kernel.org>; Fri, 15 Feb 2019 14:19:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RXvwoO8M2y9+plodqP5D3yEQpDADc/nn7iKOmiBZvkk=;
        b=XNa5W7M9CheEMxeENQuxxISeLewfqqbb51teyGnoiU5kzgyE9uJ+NqsIoMTKRE+x2g
         2yuHnpbOGH2/xex6KqeIne/4LG0o903E6WOnpx4nenGjJ2G9YdkD48USd192B8WWhXFs
         uurAlyUBRqVwFcXS5rW9PTTtIY9bQ8apAnVCrn4ZY7j0M4OYvfnjwWkerY8WoMeEgNAW
         YOU1uLkBzJO0eUZ0Cj1GfBQ5e8zxz5QarbblhPdANwmX2BCY3GlhY27OurO5u7WGAKl0
         MAjlWa8b686obwzOIvrREuctDBGbVLbwY8l1uUos8nfDZI0xilDiIH2anGbNE3s00uSG
         iUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RXvwoO8M2y9+plodqP5D3yEQpDADc/nn7iKOmiBZvkk=;
        b=NEl89kzoLp/qu5IFLYBE7osIj4Srwo2aPoU1gMdXi6q1sM7MW/G+SYn35OycTHCXYF
         m6cTh/afvOK1siKdIJMdQ1v3JGwJAixLG1A80udpE6rWXc53K/J1B8u9CxlRhRxlcDuj
         EmgkASSIrMn4b2KvkD4KMvuW73CPWH3lAStltKq7WVetgdhepvgXdKjmnGmAof5AX8fQ
         vR7aU+OjgnDzhM1ym9qNp09H6PuExLxCa2iQzQMHpdLpu4673UWL8b8CbHOZIoYa8ugL
         qHHzgEq88r3NpWszfxb8vk4ZXBZPROdeAbLpxI6AhI+lHRXn3uqNZWRxgPcdDJUPyji8
         wOPA==
X-Gm-Message-State: AHQUAuYuJzR9tOVYbw2OeH1iDly5ueW8fLJ1TmcASxo52CHJZlaZly3r
        aNskGe4q8NGOHBjKhzgbG8Whn0Bao+Nmmvj8DshPmQ==
X-Google-Smtp-Source: AHgI3IbzM01UWyz0bJpk8ODLzyx7Yt8jQshXfauCaSvEYib0uD7sIBWOrkQgppULZlfniQTVgnMvEK1ydKpMG57cX5g=
X-Received: by 2002:a19:a345:: with SMTP id m66mr6940521lfe.84.1550269140928;
 Fri, 15 Feb 2019 14:19:00 -0800 (PST)
MIME-Version: 1.0
References: <20190215043105.163688-1-sxenos@google.com> <xmqqlg2g6hcv.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqlg2g6hcv.fsf@gitster-ct.c.googlers.com>
From:   Stefan Xenos <sxenos@google.com>
Date:   Fri, 15 Feb 2019 14:18:49 -0800
Message-ID: <CAPL8ZiseLQgemzr-U2yFM815Ty+Di_cGznZ_hNAcf3sMy5mXEg@mail.gmail.com>
Subject: Re: [PATCH v5 1/8] technical doc: add a design doc for the evolve command
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> It would really need a summary of what changed

Sure! In this iteration, I made some minor changes to the technical doc:

- Fixed a number of typos and inconsistent language.
- Removed the "replace" subcommand from the "changes" command since
the "update" command is sufficient for this purpose.
- Removed the "--continue" and "--abort" arguments from "evolve" since
I don't need them to address the initial use-cases and jrn@ proposed
some reasonable alternatives that may render them redundant. I'll put
them back in a follow-up in the event that we go this route.
- Added some clarifying text.
- Added a paragraph describing the possibility of cycles between
changes and how the evolve command will treat them.

I also changed the "git change update" subcommand to add output
describing which changes were modified by the operation. I did some
minor refactoring to collect that output.

In general, would you prefer if I keep submitting these as revisions
of the same patch series, or would it be easier if I created new
patches on top of what is currently in "pu"? Sorry, I'm new here and
am unfamiliar with the email workflow -- but I'm happy to accommodate
whatever you prefer.

> saw a few comments that say "needs further work".

Could you clarify where you saw those comments? Were they something I
wrote or did I miss a comment on this mailing list asking me to do
follow-up work that I neglected? To the best of my knowledge, I've
addressed every concern anyone brought up in the list.

> What's the intention?  Unfinished but soliciting further comments and sanity checks to help polishing the finished parts

To the best of my knowledge, the patches in this series are ready for
submission. There is further work needed to implement the "evolve"
command itself (which I haven't started), but that will build on top
of this code. I am not aware of further refinement required for these
patches. In earlier patch series I commented about the desire to make
better use of the memory pool, but I've also included those
refinements in later versions of the patch series. Does that answer
your question?

>  thanks for working on this.

And thank you for taking the time to review it and consider its inclusion!

  - Stefan


On Fri, Feb 15, 2019 at 10:23 AM Junio C Hamano <gitster@pobox.com> wrote:
>
> sxenos@google.com writes:
>
> > From: Stefan Xenos <sxenos@google.com>
> >
> > This document describes what a change graph for
> > git would look like, the behavior of the evolve command,
> > and the changes planned for other commands.
> >
> > Signed-off-by: Stefan Xenos <sxenos@google.com>
> > ---
>
> It would really need a summary of what changed since the earlier
> rounds, if a series this size wants to be re-read by those who
> helped the previous one.
>
> I briefly looked at the patches (and the diff against the previous
> one that has been in 'pu') and saw a few comments that say "needs
> further work".  What's the intention?  Unfinished but soliciting
> further comments and sanity checks to help polishing the finished
> parts (if that is the case that is perfectly fine, but it would help
> those who want to help if you are clear about it)?
>
> I'll read them through laster today or tomorrow with fresh set of
> eyes; thanks for working on this.
>
