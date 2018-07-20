Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2E9E31F597
	for <e@80x24.org>; Fri, 20 Jul 2018 23:02:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbeGTXwZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 20 Jul 2018 19:52:25 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:44317 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727648AbeGTXwZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Jul 2018 19:52:25 -0400
Received: by mail-ua0-f194.google.com with SMTP id k25-v6so8428424uao.11
        for <git@vger.kernel.org>; Fri, 20 Jul 2018 16:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RzxBRwpUMuEI8PjWWcdfI5GpZolF/CgR7aW7B3yZGOU=;
        b=gVQTPJEP/08FtcbWzEjDnJ3vGH1X+OZ/UR9s/APVBync2SK4CRS/B2mxkfZx6KPKPB
         6rKAPzqBf3Irj4q8Gx30Fvrk8z3nScheVzyuDWLshmXMO5P+TeONuHThWyUw53jlwpVC
         rf0oTASpzr+BhGZymEgmxYC/lrZs7iZYVIxm8Tw/j7uVuvRpahTgVwS2QasU7Pat8ELM
         0TPxcAJEobgzYU2+QPw/pVOyTNPYbpA3plj1Z8N4/h6UwpLwxjPnRxOcij11SV2J3e+a
         BG/Rkfec+TIdW87hM2egq2plw3uE+WEvaG+BzRFP9Qq+pyIltrgZdBST1yZXHQPSKAe5
         NSVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RzxBRwpUMuEI8PjWWcdfI5GpZolF/CgR7aW7B3yZGOU=;
        b=JLsa6nr3EfIYKU4YqL8hBhsCJ/glE/o1/XnLvtK6BJTJo+zohDPMk43IXJ2u24vI4M
         e8veYUWKQP8ZjH4CQINO2EwVDOkjg4WrbuFgqLNHTV2t/jn1QZmd9z0plfeg2b2whr+F
         CNbAlCSp+74zAVjFBdo+y40wEROGnF0r+h1K9+p5V5vwXadLd0Jd8O4KIC3FuLjGs/TQ
         PETl0RpRWzwgDXEJdoQUnGfTfB8dyb9ggUPRniqadV8m6E2tn7WMlnFZDh1adwO++NeR
         aI1g2pt6AQtiH9ocg3BwJPSCM8KbDlKbTj6Um8BcN8PZSIDTYbKLBX15LFOb+ClRYrl2
         Fpzg==
X-Gm-Message-State: AOUpUlFyRjLzGRVteqP3cdVoPrPcGBapvmQm5BO5MLDgeVIvYDlvRKy1
        N0cBLUmMaNC0nc8yidgS7gT+hfn7kddSNcKK6Xw=
X-Google-Smtp-Source: AAOMgpcDhk6cAPbmGO4LzYJUpw/l37Ct94yhq6fGJQMI6rptnmFBADvhwkNcN1Lj+kOPRolmVAkXSrmVAKlF7l/8PGI=
X-Received: by 2002:ab0:4c24:: with SMTP id l36-v6mr2678753uaf.199.1532127721482;
 Fri, 20 Jul 2018 16:02:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab0:21c7:0:0:0:0:0 with HTTP; Fri, 20 Jul 2018 16:02:01
 -0700 (PDT)
In-Reply-To: <xmqqbmb1a7ga.fsf@gitster-ct.c.googlers.com>
References: <5a8d1098-b4c5-64e1-da98-dac13521e7ba@gmail.com>
 <CABPp-BF+Vx8YT2KAJQ+szbkYExv-_o5E-ZkywgvzsHWR0QvVEg@mail.gmail.com>
 <xmqqsh4da9wd.fsf@gitster-ct.c.googlers.com> <CABPp-BE_OHxMqmhJ8BisG6HFpGQjsPJ1AE4G9m5bpJWznkq-1Q@mail.gmail.com>
 <xmqqbmb1a7ga.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 20 Jul 2018 16:02:01 -0700
Message-ID: <CABPp-BGVtP4-_LYh7SjSSoTwcm+ZiKbCRSuK0MCo_wvUWBj3vg@mail.gmail.com>
Subject: Re: [BUG] merge-recursive overly aggressive when skipping updating
 the working tree
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Peart <peartben@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Kevin Willford <kewillf@microsoft.com>,
        Ben Peart <benpeart@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 20, 2018 at 3:05 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Elijah Newren <newren@gmail.com> writes:
>
>> Ah, okay, that's helpful.  So, if there are conflicts, it should be
>> free to clear the skip_worktree flag.  Since merge-recursive calls
>> add_cacheinfo() for all entries it needs to update, which deletes the
>> old cache entry and just makes new ones, we get that for free.
>
> Correct.
>
>> And conversely, if a file-level merge succeeds without conflicts then
>> it clearly doesn't "need to materialize a working tree file", so it
>> should NOT clear the skip_worktree flag for that path.
>
> That is not at all implied by what I wrote, though.
>
> If it can be done without too much effort, then it certainly is
> nicer to keep the sparseness when we do not have to materialize the
> working tree file.  But at least in my mind, if it needs too many
> special cases, hacks, and conditionals, then it is not worth the
> complexity---if it is easier to write a correct code by allowing Git
> to populate working tree files, it is perfectly fine to do so.
>
> In a sense, the sparse checkout "feature" itself is a hack by
> itself, and that is why I think this part should be "best effort" as
> well.

That's good to know, but I don't think we can back out easily:
  - Clearing the skip_worktree bit: no big deal, as you mention above
  - Avoiding working tree updates when merge doesn't change them: very
desirable[1]
  - Doing both: whoops

[1] https://public-inbox.org/git/CA+55aFzLZ3UkG5svqZwSnhNk75=fXJRkvU1m_RHBG54NOoaZPA@mail.gmail.com/


I don't want to regress the bug Linus reported, so to fix Ben's issue,
when we detect that a path's contents/mode won't be modified by the
merge, we can either:
  - Update the working tree file if the original cache entry had the
skip_worktree flag set
  - Mark the new cache entry as skip_worktree if the original cache
entry had the skip_worktree flag set

Both should be about the same amount of work; the first seems weird
and confusing for future readers of the code.  The second makes sense,
but probably should be accompanied with a note in the code about how
there are other codepaths that could consider skip_worktree too.

I'll see if I can put something together, but I have family flying in
tomorrow, and then am out on vacation Mon-Sat next week, so...
