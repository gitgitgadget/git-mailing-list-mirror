Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 342B01F403
	for <e@80x24.org>; Mon, 18 Jun 2018 19:32:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936773AbeFRTci (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Jun 2018 15:32:38 -0400
Received: from mail-yw0-f194.google.com ([209.85.161.194]:39361 "EHLO
        mail-yw0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S936020AbeFRTcf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Jun 2018 15:32:35 -0400
Received: by mail-yw0-f194.google.com with SMTP id 81-v6so6049722ywb.6
        for <git@vger.kernel.org>; Mon, 18 Jun 2018 12:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gghpe0FJE9v9RuOBBFTMX4SSdhG5PaAe3410kaEMd+c=;
        b=TtvB+GRYL1ktCLhGJbgy2EML1kV1ImMLtLIQhslx6WLQ28VU3oXT9QtEw8cC9ivT2y
         jMvd6uyNOgi+l/cEm+TcNkA1v6nHglTwLiQC6CkDp6lOBs+Fpiu8pX80KrzAIPPSr6WK
         sfqXYzBYnvJ50l8BjiAzYIpXjAfuX0KFr3DH1L9bxuFPjD7MTg5fFlNPposTGwJrqnlo
         JHm1zgSA6BOuxTFCOgr0Npgz55moHxn/mwT6pd7Xmi0IhZbX78lfMjgrqz2rJ8iY+oo8
         GykjCiwOBdmLqUA7RfGZGsAsa4HB41kpLwQJNDOtQ2DmriJibLZyFUIfmomaHKQ49Edq
         faLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gghpe0FJE9v9RuOBBFTMX4SSdhG5PaAe3410kaEMd+c=;
        b=ZTJ1Io3go8M6TozUbH65ROpiTpTdgOlGbyWDjsRVruWpzXCLGTX5v8GKy807gbxff3
         qWqQWXqp3US6sDYectNNkq6ctAWZtCO5tBBYHs5sC/KaOVunrO+sokwjYexAzuGAZme0
         Pl6s+38LuATA0Gv6wmzjL/ag+IwOrs2BJ24ErS3YhtBPU4jqlvsIk45x0ABFmEOv4Kkc
         6hn+5nufZbAS+XsKuWPcQexMC/1kYmjRJ3UhsA8eI+CcU8Pl6e4uFMU/UrhQDOItF9kR
         2KKGb9eIKzx+zitXMRbjJLDOXT9Jx80ZQZtd9C8aXg+afElna28LkRmBcKV0e4EVZ1Ro
         XG8w==
X-Gm-Message-State: APt69E0jKPbmQ1stu508nwyYJaODK/Zsd24xCGEp3iFgx08LkdXcth+G
        ajcUbFCveJV2jb1nyEsgL6Yt+9O4eO8NjHg403wr/A==
X-Google-Smtp-Source: ADUXVKJDmzXyoOhsZoGYa8JMQzpEM85MeHO489Wffe1Ubuu6PXFRvSV3yCcjP25dJLaXduRmIRl/nD4FlmTxAiDdrOs=
X-Received: by 2002:a0d:d304:: with SMTP id v4-v6mr6684284ywd.500.1529350354376;
 Mon, 18 Jun 2018 12:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1528233146.git.jonathantanmy@google.com>
 <cover.1528234587.git.jonathantanmy@google.com> <2bc7df55a6451afbd35638b31a1551c648129b22.1528234587.git.jonathantanmy@google.com>
 <CAGZ79kbVsV390C0p3dAs3Ddp=K7mLnzfBhFC2jS4oon3Uy_nvw@mail.gmail.com> <CAGf8dgLXi95ZUin+EWQ5Q9MfNT5Qxs82=F5w_ohDw9-cK7OfFg@mail.gmail.com>
In-Reply-To: <CAGf8dgLXi95ZUin+EWQ5Q9MfNT5Qxs82=F5w_ohDw9-cK7OfFg@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 18 Jun 2018 12:32:23 -0700
Message-ID: <CAGZ79kZ0Y6Xu=2ikuejfEAvrsKc7uzyFdhErUO9hydv3aQuBjw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] t5702: test fetch with multiple refspecs at a time
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git <git@vger.kernel.org>, Brandon Williams <bmwill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 18, 2018 at 12:15 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>
> On Mon, Jun 18, 2018 at 11:30 AM, Stefan Beller <sbeller@google.com> wrote:
> >> +test_expect_success 'fetch supports various ways of have lines' '
> >> +       rm -rf server client trace &&
> >
> > Can we move these deletions to test_when_finished of the previous(?) test
> > as well as have them here in a test_when_finished line?
>
> I think that deleting them when necessary makes it more explicit, and
> this also supports tests where a repository is set up and then used
> over multiple tests (e.g. having separate "setup X" and "use X"
> tests).

and it is necessary at the end of each test, so that we minimize
the dependencies between tests. In an ideal world you could run
any one test in the file alone and would still pass. :)

>
> > This test is precise and easy to understand; the patch is
> > Reviewed-by: Stefan Beller <sbeller@google.com>
> > (considering the test_when_finished comment as
> > an optional nit)
>
> Thanks. Do you have any comments about the performance issue that
> Brandon brought up?

Is that https://public-inbox.org/git/20180605212829.GG158365@google.com/ ?
(otherwise I'd be missing the performance issue)

For now I'd filter out tags only if a specific tag is requested
(i.e. the user given refspec contains "refs/tags/" -> no tag following)
and then later I'd try out a date(?) based capability that asks for
new tags only.

Note that you can create old tags by backdating them, so we'd have
to ask the server for any update in its reflog for refs/tags...
