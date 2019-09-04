Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 037F41F461
	for <e@80x24.org>; Wed,  4 Sep 2019 20:29:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfIDU3B (ORCPT <rfc822;e@80x24.org>);
        Wed, 4 Sep 2019 16:29:01 -0400
Received: from mail-vs1-f67.google.com ([209.85.217.67]:46211 "EHLO
        mail-vs1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726495AbfIDU3B (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 4 Sep 2019 16:29:01 -0400
Received: by mail-vs1-f67.google.com with SMTP id z14so9114819vsz.13
        for <git@vger.kernel.org>; Wed, 04 Sep 2019 13:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=khyTAbGKAhPN+nfn7KMQ3mNTr31KEngURTCx9WZiCrg=;
        b=N+vEkTZgC6ZEg2K2vnC1FN+riDBIhX9VCQJXs6FB0UfZuEr/JJr8MYhpkDbD/U0pcS
         T4qMJHIqfpaauzj3MNLPhuhDWabu2xJZQryVbl7qlEkfnFAZn9USUwi+muieni+FkCC2
         R6CxN/JYPfgLIbJ1zgXQknYo5r8HopnXIxLQusTzz1l33STNH3VNoEvHaFc6La5TYMS2
         6NQ+Hy4hBkLEfGirRw14khn8UbYRxBNroeL0QDVwm3emO9SF8sVwrWBjJUWgVnHJr4tl
         NY+R4SJRuklcU/LxK8fRqoNOmdzww/8RbBEzT8A+/ADBD/Ssp8CZvH/uutgrplNWb9Wl
         JkEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=khyTAbGKAhPN+nfn7KMQ3mNTr31KEngURTCx9WZiCrg=;
        b=WcpGIVe+FLr4r7lBt2hSZv4933/J+B0XvCIf/ZTJ4/jdguq5/ml5MAOMLwZkHPqvXM
         0JQ+h3shxSmwh30WKNCrwS4lqbW/5I3EdAfUT9A8SU22PFFFsDk4sq6yRs6NUvgIw5JK
         D7zH5LFpMrxmO6f6EcRwKqK4UoIExYTG7dam0m/zcsUtylpcApLkeADxydeu/x4T7Cwp
         DK3mEWmZLiqKc2V9ZxPy1R6J5TkCuoM8r8klTk8MST1UpDk8IenydVY6Nex7F6AwmzK2
         V+SaNRWJ4HTgSZcRkFBJ5tIlEnpqaGEnEl0Zla4x+dezgwvghXLFGUdnNCFlOnQ+uAs5
         TuOA==
X-Gm-Message-State: APjAAAWaI99w0KsHq/5oHZ7egaqq7zXBzBjVLnUi9K5fYpueOLNOcw/j
        06rrRExhFzWkPVAB7lFSLPnzDKaST/C+hfMi7uw=
X-Google-Smtp-Source: APXvYqw8KdW20IGp4sBpfe5TRPKOhNo9l3V/aQtRNcOOxcb8UxxMz+A1GqbO1PgF+aXjwXss/q/e/A18ws3ueKbCDYY=
X-Received: by 2002:a67:e886:: with SMTP id x6mr14355422vsn.117.1567628939947;
 Wed, 04 Sep 2019 13:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <pull.329.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.329.git.gitgitgadget@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Wed, 4 Sep 2019 13:28:48 -0700
Message-ID: <CABPp-BH2LoP=f0ZD1uegP3-CKTgZ9MExamyYQw8YLkdmtTVpkg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Refactor excludes library
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 3, 2019 at 11:04 AM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> The exclude library defined in dir.h was originally written for the
> .gitignore feature, but has since been used for .gitattributes and
> sparse-checkout. In the later applications, these patterns are used for
> inclusion rather than exclusion, so the name is confusing. This gets
> particularly bad when looking at how the sparse-checkout feature uses
> is_excluded_from_list() to really mean "should be included in the working
> directory".
>
> This series performs several renames of structs and methods to generalize
> the exclude library to be a "pattern matching" library. Instead of a list of
> excludes, we have a list of path patterns. It is up to the consumer to
> decide what to do with a match. The .gitignore logic will still treat the
> patterns as a list of exclusions, the sparse-checkout logic treats the
> patterns as a list of inclusions.

Wahoo!  Thanks for going through and cleaning these up.  The
possibility of negated patterns (or negated logic or both) on top of
using "exclude" when "include" was _sometimes_ meant was just too much
for me to keep track of.  This series will make it much easier.

> For this reason, some methods and structs in dir.h retain "exclude" in their
> name. These are limited to things consumed only by the .gitignore feature
> (as far as I can tell).
>
> Most of these changes are mechanical find-and-replaces, with the exception
> of some variable names and the last patch.

I looked through the first four patches with --color-words=. to spot
check them; as you say, looks like straightforward mechanical changes.

I did notice that the first two paragraphs were shared between the
commit messages; it does make sense to help provide the context, but
it seemed a little duplicative.  I'm not sure what to suggest; it may
be fine as it is.  Just thought I'd flag it.

> The last patch, "unpack-trees: rename 'is_excluded_from_list()'", performs a
> more meaningful refactor. The method is_excluded_from_list() was only used
> by sparse-checkout (inside the clear_ce_flags() methods) to see if a path
> should be included in the working directory. The return value of "1 for
> excluded" was confusing. Instead, use a new enum value. This required
> changing several method prototypes inside unpack-trees.c.
>
> This refactor was inspired by Elijah Newren's feedback [1] on my
> sparse-checkout builtin RFC. I am working on a few other orthogonal changes
> to make to the existing sparse-checkout behavior before I resubmit that RFC.
>
> I had started working on v2.23.0, but found adjacent-diff conflicts with
> md/list-objects-filter-combo [2] and js/partial-clone-sparse-blob [3]. Those
> branches are independent, but the conflicts with
> md/list-objects-filter-combo were more severe (and that branch seems closer
> to merging) so this is based on md/list-object-filter-combo. Hopefully the
> conflicts with js/partial-clone-sparse-blob are clear enough to resolve
> easily.

I posted some comments on patch 5; otherwise, the series looks good to me.
