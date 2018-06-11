Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 757DC1F517
	for <e@80x24.org>; Mon, 11 Jun 2018 21:46:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753645AbeFKVqM (ORCPT <rfc822;e@80x24.org>);
        Mon, 11 Jun 2018 17:46:12 -0400
Received: from mail-yw0-f174.google.com ([209.85.161.174]:39552 "EHLO
        mail-yw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752830AbeFKVqL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Jun 2018 17:46:11 -0400
Received: by mail-yw0-f174.google.com with SMTP id 81-v6so6830166ywb.6
        for <git@vger.kernel.org>; Mon, 11 Jun 2018 14:46:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LYYBcYpb7Tlsb3f3NNpN8PcV13tUTYQX0gLGzgTg5gg=;
        b=bFPEnbx1nw70DEoualvgaJ34ivJFWw6J1+U38fPW0PCawxIvj4BuitQ1xbNOvd8tBC
         SmOLfKMVvYJQmACTxMbdl6twiNzz8mCe+FuJGltAL+6l7zmvbW2IVEyS6bPLbULWO4Oc
         WCrYVZb0uPGmXxGKE7TP5IhxtoqVRDN9OF5dF2HwuW3pkyuysRcwvle9EHXQLAqbym3D
         X2nWobf+ycD1dkqsbZKGoV3JSRlYLbed2ZzAL/kiBpZoDPrMUVui/uPZ2Hk0t0RNnfSI
         GVcxyIL6xhzDhRdf2HF2mBZE7Ez8VOneFsc9FIXFVmOXqVC85l2ub/K3epONBQrp6C3i
         Mqhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LYYBcYpb7Tlsb3f3NNpN8PcV13tUTYQX0gLGzgTg5gg=;
        b=Jd0HUx+sme+enyIDzIpN1ktTW7vUczyWabHk9rwEsfx/TGGUHGyQbvvAU+rDn3IHz9
         rAnv1qsLXG2X2QRfW0Z9s2x0jX5yBEwyB6eyJHDEjy83WjMr9QlsPKDi4tv+feF6qh+K
         Txx2MkO3boNBldUlpIxJ+MsdA5DYkiQAfXffx67XhzB/8AaC1KnFEv6hj1LmtCEEq4/F
         i8MtBPHTjhOrPFeiBSmmT2IWBdO3Th97j/pyc6R1KwFD+4136KN9t54N0oS7dkiRtw7u
         bHd/7wqASqsEArvxQKpQ3bHInAYhQep/j0jN205KUSB2/rtnVdKCW6KU7M/zoIkTVUPe
         v//A==
X-Gm-Message-State: APt69E3+y2gSemCEKRItXwIl19oDkciGtj78ZxS5UWrIQjrZ/8+HRq5O
        EIz4nyw9lkzeNcbJ0OVf4LnLTxtorD0eEWFLyV0vyurFmSE=
X-Google-Smtp-Source: ADUXVKJd5cgoOKkwTYlvQvwGHs2t01tn/BdgUuUZUNYj42n+CHNgozqn+Ga308YcNlzYMn7WnWhWyRuMA8Jhge8a9rg=
X-Received: by 2002:a81:8801:: with SMTP id y1-v6mr447953ywf.238.1528753570516;
 Mon, 11 Jun 2018 14:46:10 -0700 (PDT)
MIME-Version: 1.0
References: <alpine.LFD.2.21.1806080914520.20892@localhost.localdomain> <b8801d73-71c4-15c8-4b29-8e4edb3faec9@gmail.com>
In-Reply-To: <b8801d73-71c4-15c8-4b29-8e4edb3faec9@gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 11 Jun 2018 14:45:59 -0700
Message-ID: <CAGZ79kazegY-udjKfbkfw=ox82cfxhO5E3AEjLKkSt3LMY-DFw@mail.gmail.com>
Subject: Re: is there a canonical doc about how to deal with whitespace issues?
To:     Derrick Stolee <stolee@gmail.com>
Cc:     "Robert P. J. Day" <rpjday@crashcourse.ca>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 8, 2018 at 10:15 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/8/2018 9:18 AM, Robert P. J. Day wrote:
> >    for one of my courses, i wanted to write a section about the various
> > techniques for dealing with whitespace issues in git, so i started

What do you mean by white space issues?
That in itself is a complex topic:
* There are 3 different modes to ignore white space changes:
  - trailing whitespaces,
  - conversion of tab to space and back
    These two are caught by the default in 'git diff --check'
  - any white space change
    This is interesting to ignore in git-blame[1], but sometimes
    it is actually interesting.

[1] See also
https://commondatastorage.googleapis.com/chrome-infra-docs/flat/depot_tools/docs/html/git-hyper-blame.html



> > making a list, things like:
> >
> >    - running "git diff --check"
> >    - "git commit --cleanup=" possibilities
> >    - config options like core.{eol,safecrlf,autocrlf}

This sounds more like line ending or cross platform issues
than whitespaces (except .eol)

> >    - i'm sure there are client-side hooks that can be mentioned

Personally I use the defaults when contributing to git.git
and have an editor setting that removes trailing white spaces.

That has served me well so far; the only time I was bitten by
white spaces is when sending patches using an email client
other than git-send-email as the white spaces might get mangled
there.

Is sending patches by email part of your course?
