Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 48C211F42D
	for <e@80x24.org>; Tue, 29 May 2018 18:20:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937000AbeE2SUK (ORCPT <rfc822;e@80x24.org>);
        Tue, 29 May 2018 14:20:10 -0400
Received: from mail-yw0-f173.google.com ([209.85.161.173]:38911 "EHLO
        mail-yw0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966037AbeE2STJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 May 2018 14:19:09 -0400
Received: by mail-yw0-f173.google.com with SMTP id y123-v6so5129393ywa.5
        for <git@vger.kernel.org>; Tue, 29 May 2018 11:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NSRQiuP47fODSunI6A3sW/Q+heWOE3u9ajkhhV3qCO4=;
        b=e3LBdU+o0mBDfld4lDS6lNkxcX0GrZEiQ0rCphD5E+jKbNUPNu0qr7eqRJU3Uqbptz
         j11+kckeOPwWEgwSqEwu6Va7lWUUx8gi38uifea7RYVpOHCyG7ZFzurw1eGUcWI75aTP
         mAJdwpDnAyJbbooQIzN1KVQLzewH0KciOzOliqS6M8aHWKsqvDoZKeLRr1PaCglKOFC1
         TY19hgJP6AFvbF+eZpI7C5Ub0ezY6SaOXmhfMUfKD0PMcH6tpZSWnuqjJDW9b7C0ODDX
         k0MKwFDQOYqgVw9Ti4NZ3FAj/YOjcDSS/+XouW+/d3dxgZGngAHCfEfVXsEU6hzOGAQe
         XiXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NSRQiuP47fODSunI6A3sW/Q+heWOE3u9ajkhhV3qCO4=;
        b=fVWuRsPFsacSb4XI6eMtYMOjU37X+p9AvrAhS2DkkRjdaV6Jdrr6ndQcslckQpr1H+
         CPfJ/WGCyAEsN92w1gQRpnm1lsWFwriwxKOycQNi5HS725VBR2IQGcBT0VfJK49fGlEJ
         bwy2xgVfrsNvK/QXvn9AS8IgjvU8Z6wrbSSGJJmkQ2uyvkQl+mfLG17zL63aBqdEaGz0
         AwFTSqq5EmyVnqJYnKuNZQDytbOB4tn50gOlsL+Ck4yxTgdgkhH3yYwDxuaQBSuPJ9P+
         XC2gBE56SKzvh/lH3HDejVJRHb1ZXno8HIPtgTdkG9Zy+qJ5jPgN7pIWPxulLQ7xl+kg
         4cIg==
X-Gm-Message-State: ALKqPweaePGHA0Wmge8wVFb4SXeokcaIY8loYhQa2PQtKOpIQNSZuBbr
        BhDrEwEBzdLQ+uKFMbWQ4HfDayWDpC11/tlEmlDOMA==
X-Google-Smtp-Source: ADUXVKKaLunCMJYIwMKdwgaejESGRnjjWnIoM/cc8UyGHMclwY8MkEPW6jlqIiTZRc+eDJUteJpIa37vb0BxMiZIdvQ=
X-Received: by 2002:a81:9447:: with SMTP id l68-v6mr2917704ywg.345.1527617948544;
 Tue, 29 May 2018 11:19:08 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:e87:0:0:0:0:0 with HTTP; Tue, 29 May 2018 11:19:07 -0700 (PDT)
In-Reply-To: <CABPp-BFQJZHfCJZ1qvhvVcMd-_sOfi0Fkm5PexEwzzN+Zw2akw@mail.gmail.com>
References: <CABPp-BFQJZHfCJZ1qvhvVcMd-_sOfi0Fkm5PexEwzzN+Zw2akw@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Tue, 29 May 2018 11:19:07 -0700
Message-ID: <CAGZ79ka39xbbm_koyFeEizggoDBqKuwgmGwRBZJnBc13aOWZag@mail.gmail.com>
Subject: Re: RFC: Merge-related plans
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 28, 2018 at 1:48 PM, Elijah Newren <newren@gmail.com> wrote:
> Hi everyone,
>
> I have some merge-related plans (and work in progress) that I'd like
> to get some feedback on in order to find what order would be best to
> address things in, if there are special steps I should take while
> approaching some of the bigger items, and even if folks disagree with
> any of the plans.
>
>
> Currently, I would like to:
>
> A) Fix cases where directory rename detection does not work with
>    rebase/am due to how they call merge-recursive.
>
>    Notes: Could just wait for D & E to land before fixing.
>    Alternatively, email RFC to list now explaining issues and how the
>    fix has performance implications; poll for opinions on whether to
>    fix before or after D.
>
> B) Implement a remerge-diff ability (compare a merge commit to what an
>    "automatic merge" would look like)[1].
>
>    Notes: Possibly for cherry-picks and reverts too.  Depends on C &
>    E.
>
> C) Modify/extend how path-based and mode-based conflicts are
>    communicated to the user.
>
>    Notes: Particularly important as a mechanism for handling
>    challenges[2] with implementing the remerge-diff ability.  Need to
>    send RFC to list with ideas to get feedback.
>
> D) Improve merge performance.
>
>    Notes: Includes 4-5 specific optimizations[5], some of which I
>    expect to be somewhat invasive and thus may make more sense to just
>    make part of the new merge strategy implemented in E.  Biggest
>    optimization depends on F.
>
> E) Write a new merge strategy meant to replace merge-recursive.
>
>    Notes: Suggested by Junio[3][4].  Depends on F & G.
>
> F) Make file collision conflict types more consistent.
>
>    Notes: Specifically, make rename/rename(2to1) & rename/add
>    conflicts behave more like add/add[6][7].  Depends on part of G.
>    Would prefer H to be accepted first.
>
> G) Improve merge-related portion of testsuite.
>
>    Notes: Intended to help test new merge strategy with more
>    confidence.  Will include approximately a dozen edge and corner
>    cases where merge-recursive currently falls short.  Started at [8];
>    see also [9].

Most items forward-reference "Depends on (<later letter>) up to here;
(H) seems independent, but might be a good first start.
(G) [8] is queued as origin/en/merge-recursive-tests, or do you mean
to expand (G) into a mini-framework of merge-testing? i.e. run the
mini test framework multiple times, each using a different
merge strategy, similar to submodule tests, e.g. see
t/lib-submodule-update.sh and one of its users, t1013.


> H) Miscellaneous code cleanups irritating me while working on other
>    changes[10].
>
>
> My current plan was to work roughly in reverse, from H to A.  Some questions:
>
>   * Does any of this look objectionable?

Going in order A-H seems slightly out-of-order to me, I'd think (H) and (G)
would go first;

(B) sounds like an independent feature, which could go in parallel?

>   * Should I post RFC questions on A and C earlier?

I would think so, it is easier to give feedback on code, I would think.

>   * Should I split D and G?  (Current plan was to keep D together, but
>     split G into five short slightly inter-dependent topics)

I would have expected to have tests (G) as a companion of (A) or (C)
rather than (D), as performance improvements would keep the test suite
unchanged?

>   * E is kind of big.  Are there any specific things folks would like to see
>     with how that is handled?

How much abstraction can be done ahead of time such that there is an
interface/API where you just plug in a new merge strategy and do not
need to duplicate a lot of code/tests?

Stefan
