Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 145981F403
	for <e@80x24.org>; Fri,  8 Jun 2018 15:58:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751524AbeFHP6a (ORCPT <rfc822;e@80x24.org>);
        Fri, 8 Jun 2018 11:58:30 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:41908 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751224AbeFHP63 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jun 2018 11:58:29 -0400
Received: by mail-ot0-f195.google.com with SMTP id d19-v6so10693138oti.8
        for <git@vger.kernel.org>; Fri, 08 Jun 2018 08:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ppEuYabWuO3aX5lIlm4x2SDxB9eHIM6cEulzQ8BCFcQ=;
        b=i3+LMT32WJ4q09LDMd0dRAxgqGsuzs5W19vruSTM1V8DPRTOZpUyOdsy5WFek30R49
         RNI8S6Ikwu5b7PzAzksxT+C+BmUuY0Yg489V0D5T0mJz9tXVysV4UcgNmr2E8ksABu9f
         tBg/BgvRfiuLLaVNsKa9RBRzW7IwCyMUVN6fe/rT/EB1CbIcM2lVpt9IvjZKsUG1bWnl
         78xSmqd5vSkt5W29fRwq2Ke6kt+rVwhIfa0Yb+qxt16DIQMPcgZmTIX7CD5ld6xqDtLj
         XsBiF0iSXEKRucdiOXnvHHv1ggOLNd2Fk9dqenH887wx3kTcMeRuIDnKcAlbMoEobCEI
         VH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ppEuYabWuO3aX5lIlm4x2SDxB9eHIM6cEulzQ8BCFcQ=;
        b=TUzo+A+lm6Nxog85pde+P4l79rhOTV2k3u05+sP6CjBF6JRDDdU/IOuj7PTAKnNZqz
         qYmBEHnNLpQavtpzSgyvva+DBcgDoo/7JH0znfAi5Y9lRe8e9NgZymBrOfX3tIfLviZh
         XJ0rASV5n1G/zNLtcRLyo4T/qQSzLU8ydkZV82AUK0BcrXLoGFBGaYUUIHA399GV+xMN
         9xyabXpcXWbDrr4j6Yg8Rho2L1I9FiokUxnMKcdf+ojHGL9udYLlCZC9+kGxGLvrrrdo
         N+SgDVve5mBfkyUM3rIZ9CCCpF/7bQW18L0CnN4yEYjU3dF0yZawIjAKphDqX0b7Lrxa
         0+OQ==
X-Gm-Message-State: APt69E2IFcylxD2xwfAXUWZmsaOesp7XkbWOCt9ul6HJwifa2/+v0PYS
        bxD2qJFGr9xgeyOVcuyNglZ0O6S1A/tIhQpz5tU=
X-Google-Smtp-Source: ADUXVKJ1q+nVG7VzRbbiFj72sWOxdFos+6VQshklZqZBdw55PnizBm8kmJ3ySJIEpHyzayl7o2O8s0eV5kfkJamwAIA=
X-Received: by 2002:a9d:124:: with SMTP id 33-v6mr4223691otu.65.1528473508510;
 Fri, 08 Jun 2018 08:58:28 -0700 (PDT)
MIME-Version: 1.0
References: <20180606073933.14755-1-pclouds@gmail.com> <20180606165016.3285-1-pclouds@gmail.com>
 <20180606165016.3285-5-pclouds@gmail.com> <CABPp-BFzOkX_uSyiVH-S8mqxeOin0xcYR-EzXUtvcdN7dGhidQ@mail.gmail.com>
 <CACsJy8AwjMsCR=gbT1ZLbEwve7hzuPBF7tT7m+P1DJ4rRx_jrw@mail.gmail.com>
In-Reply-To: <CACsJy8AwjMsCR=gbT1ZLbEwve7hzuPBF7tT7m+P1DJ4rRx_jrw@mail.gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Fri, 8 Jun 2018 17:58:01 +0200
Message-ID: <CACsJy8Dk8jS-m9vPdHY3r8iGV0DA7v_V8uOFn7+7WqTev-ajdg@mail.gmail.com>
Subject: Re: [PATCH v4 04/23] unpack-tress: convert clear_ce_flags* to avoid the_index
To:     Elijah Newren <newren@gmail.com>
Cc:     Brandon Williams <bmwill@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 7, 2018 at 5:11 PM Duy Nguyen <pclouds@gmail.com> wrote:
>
> On Thu, Jun 7, 2018 at 9:41 AM, Elijah Newren <newren@gmail.com> wrote:
> > Subject line: unpack-trees rather than unpack-tress.
> >
> >
> >
> > On Wed, Jun 6, 2018 at 9:49 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc D=
uy <pclouds@gmail.com> wrote:
> >> Prior to fba92be8f7, this code implicitly (and incorrectly) assumes
> >> the_index when running the exclude machinery. fba92be8f7 helps show
> >> this problem clearer because unpack-trees operation is supposed to
> >> work on whatever index the caller specifies... not specifically
> >> the_index.
> >>
> >> Update the code to use "istate" argument that's originally from
> >> mark_new_skip_worktree(). From the call sites, both in unpack_trees(),
> >> you can see that this function works on two separate indexes:
> >> o->src_index and o->result. The second mark_new_skip_worktree() so far
> >> has incorecctly applied exclude rules on o->src_index instead of
> >> o->result. It's unclear what is the consequences of this, but it's
> >> definitely wrong.
> >>
> >> [1] fba92be8f7 (dir: convert is_excluded_from_list to take an index -
> >>     2017-05-05)
> >>
> >> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmai=
l.com>
> >
> > A somewhat curious finding: when I was rebuilding and re-testing all
> > 23 patches, I got a failure on this patch in test 31 of
> > t7063-status-untracked-cache.sh. I did not get any test failures with
> > any of the other patches.  However, after re-running that test or the
> > whole suite half a dozen times with just up to this patch applied, I
> > was not able to trigger the failure again.  Is there a rare race in
> > that testcase?
>
> Untracked cache tests are very time-sensitive. I'll try to run and
> re-run them a couple times to understand more. Thanks for pointing it
> out.

after hours of running tests, either with full 23 patches or just the
first 4, and failing to catch the failure, i declare (or more like,
pray) that you ran into a crack of time that led to a race. I'll take
no action on this, but I'll remember this and watch out for untracked
cache related mails for some time.
--=20
Duy
