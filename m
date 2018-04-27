Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0A7B71F424
	for <e@80x24.org>; Fri, 27 Apr 2018 00:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753646AbeD0ACe (ORCPT <rfc822;e@80x24.org>);
        Thu, 26 Apr 2018 20:02:34 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:43700 "EHLO
        mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752549AbeD0ACd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Apr 2018 20:02:33 -0400
Received: by mail-vk0-f51.google.com with SMTP id v134-v6so65026vkd.10
        for <git@vger.kernel.org>; Thu, 26 Apr 2018 17:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=QGtVSqKxD2oZyBY3B5KTHlkwrVlb4caqJ8GFCp85ta8=;
        b=MOznqW+l3go1TkZn4DIN9rZV7Jy9ZkP+XhaCZ+QpZJyrFHKO1oUNdWvyp+l6uZ12C4
         /VHHQrtgKW9I5yhwgOgCFS04MxmaTWMUyny4K/w2JyZL6u/K9iTW3BarJGh/92jaikRN
         dj4wp9t6ACTzJKDHbsp7d+RtPkxZ7UNaUeONzYBU0e+tpWniGF0etU6bsTYABpx1RF5o
         Uxi8gFfaT1AwP2gqmAxSnxatIekWGIBKWI0RoYuckiDy+d83ZojXIYXduyjokvp4UtCG
         z3wSGD+9v/lPc+DTxf0Dunv7dKYhgQRnRj7Brbc73DtWA6ZIMTc/RUP9TQUakG6DzE4C
         wOEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=QGtVSqKxD2oZyBY3B5KTHlkwrVlb4caqJ8GFCp85ta8=;
        b=PXvvL03tBUlfWeSbZJqO1ZVTzI0G4OXi6h52HJaVq96auZRW5Ym2Agoub9KQdNCaVJ
         JfrvUfTxxqIhZrjuSHIbolLd62Es2SNJqAVPsr188TJo+nGHHxd9h9UBUP1vZpZSSEW7
         vCCxHoIGaBHPmIYJBr+mBmg9oXVkgP8ffPPR9S1q21J1mDhwRoNJ4BjaPwAwOd8vcRNE
         cpt6pKRq71KtVlR3+o4nGoLMz4J5huhJyZGFJLTAQ/u6576s4WbPKKAeSS0YKulxuQUS
         jX+SymUijuiJHs5W86KgYur8mU39QQuep5E6NphpBreMnAJNOn9iAIKwOAXyqNXz88fN
         lSLw==
X-Gm-Message-State: ALQs6tCp1+S6ghOGD49bxbIz1PJ4w3k+swx1tJqOPcai3QPnzrvtz2h6
        xAoBp3XtB5H4OrrNcttwmm0pNeaPOYfRKlBFfvM=
X-Google-Smtp-Source: AB8JxZqBEWen3+3wZg+c2168qzb+fQnB12dS6TDo788tOhcsPXhN+Fzks6t4GkJEZw/WZdy4CRQd1z/bkpxfxu2DMyo=
X-Received: by 2002:a1f:5584:: with SMTP id j126-v6mr76368vkb.184.1524787352875;
 Thu, 26 Apr 2018 17:02:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.176.95.4 with HTTP; Thu, 26 Apr 2018 17:02:31 -0700 (PDT)
In-Reply-To: <CA+P7+xrUwq0G2YySC3SLKqyihhPnFPCiQnQpoVVa89+=W9O9+w@mail.gmail.com>
References: <1524739599.20251.17.camel@klsmartin.com> <CAGZ79kZA_R-5bA6mPdoHkVW-C21pNn_0x6FayhuuXqnOTrmjWw@mail.gmail.com>
 <CA+P7+xrUwq0G2YySC3SLKqyihhPnFPCiQnQpoVVa89+=W9O9+w@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 26 Apr 2018 17:02:31 -0700
Message-ID: <CABPp-BG0zjcCuO1q7ek5LH0oh+nruKhB7etqb9ZhtbjSCqpMVg@mail.gmail.com>
Subject: Re: git merge banch w/ different submodule revision
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     Stefan Beller <sbeller@google.com>,
        "Middelschulte, Leif" <Leif.Middelschulte@klsmartin.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 26, 2018 at 2:46 PM, Jacob Keller <jacob.keller@gmail.com> wrote:
> On Thu, Apr 26, 2018 at 10:56 AM, Stefan Beller <sbeller@google.com> wrote:
>> We often treating a submodule as a file from the superproject, but not always.
>> And in case of a merge, git seems to be a bit smarter than treating it
>> as a textfile
>> with two different lines.
>
> Sure, but a submodule is checked out "at a commit", so if two branches
> of history are merged, and they conflict over which place the
> submodule is at.... shouldn't that produce a conflict??

By "which place a submodule is at", do you mean the commit it points
to, or the path at which the submodule is found within the parent
repository?  Continuing on it sounds like you meant the former, but I
was unsure if you were asking mutliple different questions here.

> I mean, how is the merge algorithm supposed to know which is right?
> The patch you linked appears to be able to resolve it to the one which
> contains both commits.. but that may not actually be true since you
> can rewind submodules since they're *pointers* to commits, not commits
> themselves.

Only if both commits also contain the base; see lines 328 to 332 of
that patch.  So, if the submodules are rewound, that algorithm would
leave them as conflicted.
