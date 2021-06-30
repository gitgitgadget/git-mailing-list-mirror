Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23D41C11F65
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 16:33:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04AFB61436
	for <git@archiver.kernel.org>; Wed, 30 Jun 2021 16:33:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231536AbhF3Qfz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Jun 2021 12:35:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbhF3Qfy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Jun 2021 12:35:54 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6FDAC061756
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 09:33:24 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id u11so3740998oiv.1
        for <git@vger.kernel.org>; Wed, 30 Jun 2021 09:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=meJI6uWw7mZwi8+tMEOBhG3e5wfVjCvkcACFDDfIToo=;
        b=fAuiBIQysnK9kHucyTFiprahpSIKmcPJCI597M1zn4toHvaH4742IzY8DfqGYiSPxG
         w1rHnXjy9ns2xR0lJzUkpmuEF201JZO3u0+mO3yIzRjBI7wOuKn2YJ4VVYq5SucqkEwv
         iqI4+FsDkMTvx/FcU7KQQtmQ2ldw72uCWk8bOW8W2k6Nh232EDs7lvoMLjVZSljejZhP
         dOMrfbsLLRG3DptorgPzJyVLyct88E0Zrkd92EhsXDlyz86JcWBUVW6iRl0ehHZxsdyb
         Vr1YRr8CYMJZM68ggxMLLxFQ2m7WUnLuss6DxIUt+mTz3oPc7snR8CYjri1Ed/+VlMPb
         MRBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=meJI6uWw7mZwi8+tMEOBhG3e5wfVjCvkcACFDDfIToo=;
        b=VnsuYDSeJLaLVCSqqh6wEY+9QrbMl+V/Nlnj/aehwnqBMX/7tznlYi2BXRpnVHt0zp
         +HncUcjmOJ3VL7Fs1fFG2UgGDEM/AS3HqpkVFq5iWThnhLkyi+sA6WKqS/0GbP46+wDN
         l8sYvQTig3sKOTYfTGoTruXjqVOGWrFcoLhtPAy8UqRDuQDTUl6JcG2CR1Uz992uviqG
         LmgtdSh708rxJH39OSq/1JLMwBacyqULmlligR4/puj/KlfcQ16tA4mlYrVtsBEpVaau
         cmq7qt97HPDjHQk7ep4zzYsZXmhJbaPXOCGQoaVya+tINmqmOwA9cUbGrDOUmGy2AY6W
         gLIg==
X-Gm-Message-State: AOAM533+HnLCzZjKgZfwt7uRQ/6Ol+PcpmMMvyv0G9JpmDIqvHkC3NVQ
        1sZRcWe/3zMDnqeaxgcFr4CcLHh3ajeuLy+e6g0=
X-Google-Smtp-Source: ABdhPJx5g8lnZlu/7UjhNNZGa3rPCavbc/4SRZrHsWVKdXiNw8QtBOQ/X2rEAMefc/opX3HkKX/oKkq78P+HpbRzf+0=
X-Received: by 2002:a05:6808:10c4:: with SMTP id s4mr3665371ois.39.1625070804142;
 Wed, 30 Jun 2021 09:33:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1039.git.git.1624727121.gitgitgadget@gmail.com>
 <d3572e8bc85e4c7a33094f5da71957c2e59fd7f4.1624727121.git.gitgitgadget@gmail.com>
 <c088028d-3045-70ce-19e9-f3ffc9c57c98@gmail.com>
In-Reply-To: <c088028d-3045-70ce-19e9-f3ffc9c57c98@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 30 Jun 2021 09:33:13 -0700
Message-ID: <CABPp-BFsXWNzS-6JSM7rYN0LLtTmT3UsgG7aTUmpSq6K2jHyFg@mail.gmail.com>
Subject: Re: [PATCH 1/3] t6423: test directory renames causing rename-to-self
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 29, 2021 at 5:50 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/26/2021 1:05 PM, Elijah Newren via GitGitGadget wrote:
> > From: Elijah Newren <newren@gmail.com>
> >
> > Directory rename detection can cause transitive renames, e.g. if the two
> > different sides of history each do one half of:
> >     A/file -> B/file
> >     B/     -> C/
> > then directory rename detection transitively renames to give us C/file.
> > Since the default for merge.directoryRenames is conflict, this results
> > in an error message saying it is unclear whether the file should be
> > placed at B/file or C/file.
> >
> > What if C/ is A/, though?
>
> This case seems interesting, but somehow missing from the test cases
> below. Each of those cases include renaming up or down the directory
> hierarchy instead of doing a sideways rename.
>
> > +# Testcase 12i, Directory rename causes rename-to-self
> > +#   Commit O: source/{subdir/foo, bar, baz_1}
> > +#   Commit A: source/{foo, bar, baz_1}
> > +#   Commit B: source/{subdir/{foo, bar}, baz_2}
> > +#   Expected: source/{foo, bar, baz_2}, with conflicts on
> > +#                source/bar vs. source/subdir/bar
>
> This test goes deeper.
>
> > +# Testcase 12j, Directory rename to root causes rename-to-self
> > +#   Commit O: {subdir/foo, bar, baz_1}
> > +#   Commit A: {foo, bar, baz_1}
> > +#   Commit B: {subdir/{foo, bar}, baz_2}
> > +#   Expected: {foo, bar, baz_2}, with conflicts on bar vs. subdir/bar
>
> This test goes higher.
>
> Does the problematic case not hit when going out to the side, such
> as "with conflicts on subdir/bar vs otherdir/bar"?
>
> If so, then _maybe_ the commit message could indicate this is an
> omission on purpose. If not, then maybe a third test should be
> added?

The only special case in the code is renaming to the root directory,
so I didn't think of extending beyond two cases.  However, while
adding more testcases doesn't exercise the current incarnation of the
code further, it's pretty easy to add another and it certainly doesn't
hurt.  I'll resubmit with a third testcase.
