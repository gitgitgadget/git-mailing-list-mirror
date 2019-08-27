Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3542F1F4B7
	for <e@80x24.org>; Tue, 27 Aug 2019 06:18:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbfH0GSI (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Aug 2019 02:18:08 -0400
Received: from mail-vs1-f65.google.com ([209.85.217.65]:46313 "EHLO
        mail-vs1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbfH0GSI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Aug 2019 02:18:08 -0400
Received: by mail-vs1-f65.google.com with SMTP id x20so12446035vsx.13
        for <git@vger.kernel.org>; Mon, 26 Aug 2019 23:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qehwcoznhK8qEYlvob+XTcntEQCNSIGXTofjtGGmMNg=;
        b=IN52MKHF8UITIMrA4R/Ofybu54oGVfRff9C24u4uNTzqV13aO8sJErJb29kKc+Ixmn
         uAX+XYWnKqFdac3W+Gr50CPVllzI4ZZBr8KT0lb9cpwngX4lhFHOysh5e3u79Vx4Wc3t
         BUDRjhzUdFHNX0s5I3dYvQQCjghzFlzGFXxtuSEdYVNkGtmg6UNhTXpzp14bemE8NXCv
         Bwb7lRFq+ptUPJJhPLxjG6MF3y8b6Us9KWmIt9iEtgKG64F5/efVM57b+eqRetxuUhBl
         D1jZariu0cyJ7ec62A0ghs+0ljnwQyzMfD0L7ROKSrFs18xZbNc3CfyYg/gA1fTNz1Is
         h48w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qehwcoznhK8qEYlvob+XTcntEQCNSIGXTofjtGGmMNg=;
        b=J4AVqxJGo9Be4IpFLK66WeVIxDnVVatVvVsQ3fD1yBbLK8TqD2CQ0VMSBkA33PDBEm
         5POsq0AG49HG7PKVBaOtlP5tlgIvHXspPhinzlNBrriNl23VEfNN5FFZZDOgEUfpkjAS
         cVVSGuQoG+An13KiBk1cRBM8kNYP8SpaLSbT/kseoVaWfCaWoGovII5U/XSyhoMku3sJ
         4SiAMgRTnPk07RiKTY9VpkAk5rNfpiV28/GtSC6ogAd4+EW+mTtxukNZ6X1LSw1RkYg1
         iG3Jrvim5BXAhBLyOhDhtXk3RfJlh3pI/bmc7wdC/UMXsMgFBlMd8H2ZwbV+k+HxO5DQ
         egUw==
X-Gm-Message-State: APjAAAXvWmztgQPcyxnsPt8IPvX1j1san74ihuN9VNxI5zodl6l3q7+D
        uzSIhKhhUH6IrUOEs4BQP01h8rISJ/IjVoWUqrw=
X-Google-Smtp-Source: APXvYqy1l/+Xt5Qa7WeV7pDBadIJzxHadbHwKS4T3OPhGbsK0ndA+QJocz/epfUufYoKJ4U5Xp6psEPrJA3TSgAxYTs=
X-Received: by 2002:a67:d099:: with SMTP id s25mr10959631vsi.175.1566886686423;
 Mon, 26 Aug 2019 23:18:06 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqd0gwopej.fsf@gitster-ct.c.googlers.com> <20190826235226.15386-1-newren@gmail.com>
 <922dbed9-3670-16b4-807c-ce68430ee591@gmail.com>
In-Reply-To: <922dbed9-3670-16b4-807c-ce68430ee591@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 26 Aug 2019 23:17:55 -0700
Message-ID: <CABPp-BERNsoxdexwX1USuH4rcNVz6MOeao9mrLOrJbV8Azs9-w@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] Remove git-filter-branch from git.git; host it elsewhere
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 26, 2019 at 6:39 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 8/26/2019 7:52 PM, Elijah Newren wrote:
> > Following up on the suggestion to make git.git smaller and shed non-core
> > tools, here's an RFC series to do so with git-filter-branch.  This
> > series first removes dependencies on git-filter-branch (of which there
> > were very few), and then deletes git-filter-branch itself in the final
> > commit.
> >
> > I'm more than happy to consider alternate places for the filter-branch
> > history (I had considered just merging it in with git-filter-repo), but
> > for now I just made it available here:
> >         https://github.com/newren/git-filter-branch
> >
> > The rewrite above contains the history of the files deleted in Patch 5,
> > plus a one-time copy of relevant build files (Makefiles, test-lib.sh,
> > etc. -- I didn't want the whole history of these), and then touchups to
> > streamline the build files and make them all work in this standalone
> > repo.
> >
> >
> > Some highlevel notes on the patches:
> >
> >   * Patches 1&2: are good cleanups & performance wins regardless of
> >     whether the rest of the series is taken
>
> I agree! These are great. I just had a nit about extracting a helper
> instead of copy-pasting the same three lines in multiple tests.
>
> >   * Patch 3: an attempt to improve i18n situation for external scripts,
> >     but discovered to not be necessary/useful for git-filter-branch
> >     specifically
>
> I'm not sure this is super-important now, but could be saved for a
> later date, when it is important.
>
> >   * Patch 4:
> >     * If we are good with deleting git-filter-branch now and just noting
> >       it in the release notes, then patch 4 could be simplified; there's
> >       no need to update git-filter-branch.txt in that case.
> >     * If, however, we want to do some external messaging for an
> >       additional release cycle or two before moving git-filter-branch
> >       out of git.git, this patch will help us until then to at least
> >       avoid recommending a tool which will likely mangle user's data in
> >       unexpected ways.  But it'd be really helpful if folks could review
> >       and opine on the BFG stuff if so.
>
> I think this is a good step, and should be taken even if we never
> plan to take Patch 5.
>
> >   * Patch 5: actually deletes git-filter-branch, its tests, and
> >     documentation.
>
> This is the one where others need to chime in with opinions. I
> think this one can only be taken if we have a concrete plan about
> how to support the tool _somehow_, even if it is "go download the
> script from this place; it may have broken since we last tested it."
>
> Yes, we want to strongly recommend that people use newer, better
> tools. That's not always something users can accept. Having the
> tool live somewhere that is accessible can appease some users for
> a while, and it can decay and die a slow death there.

Perhaps I should add some more words about the separate repo I
created; even though it wasn't one of the five patches in this series
it actually represented the lionshare of the work before I submitted
this.  Anyway, it has a Makefile which supports the normal 'test',
'doc', 'clean', 'install' (and variants), and 'dist' (and variants).
The 'test' target will run all the filter-branch tests taken from the
git.git testsuite (i.e. t7003 and t7009) without requiring a version
of git built inside that separate repo, 'doc' will build both html and
manpages, etc.  It doesn't look at any config.mak* files and has
stripped out lots of stuff from the main repo, but it's relatively
minimal and self-contained beyond an assumption that a normal copy of
git has been installed somehow already.  Given how infrequently
filter-branch has needed fixes in the past, and the fact that it is
pretty good about relying on plumbing rather than porcelain, I suspect
it might actually be a pretty light maintenance load to keep it
running for a good long time.
