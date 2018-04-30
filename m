Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 21A93215F4
	for <e@80x24.org>; Mon, 30 Apr 2018 22:18:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754338AbeD3WSX (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Apr 2018 18:18:23 -0400
Received: from mail-yb0-f176.google.com ([209.85.213.176]:37167 "EHLO
        mail-yb0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752696AbeD3WSW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Apr 2018 18:18:22 -0400
Received: by mail-yb0-f176.google.com with SMTP id i13-v6so3601228ybl.4
        for <git@vger.kernel.org>; Mon, 30 Apr 2018 15:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=kIkD7wI/tLinX5vUOWGnRDEceibnPCCJTG0N8MlridU=;
        b=U9tYygoVawums18tHlm2qhnG7H2f2gG4ZOtN5hnCEfM0yWduY43kIv7H0GTUqZ4Gle
         TauEtRi1h8IxwaaidgLcljXE11wNMx3iIWbhRD0UDzdhTuN3MAhdBjidoJua+m5cv9IO
         xK9N4biavKDZSjkyLyC71QfTmO/zDAKFeW4BQNpDhNywUgLkjbhQvUjgc/c1BdEDlqe6
         zlgAmsEnZMIM89lOijZnNF56q7+iY2z9/Jse/Ol/MXZoqqq7FQ05VZldg4sFrv5psBiC
         e49uyHkZoepSlYeY5l8SQV1JM1LrUmRqlk20+6ekxFy03t7DwaxVhuln/L0NdWGH/FN4
         iN8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=kIkD7wI/tLinX5vUOWGnRDEceibnPCCJTG0N8MlridU=;
        b=MV+WvtPqk+CvVQcicQ1WKaGg7bqCG9DBaj6vJejAFL0OwAI6VVcrDWYnrw/tXVDBL6
         kZ6BaiQVWNz47FleFwFgqo1Z+nyGQsi546xEqbSHILUpJY+s1JWEID0QjQVz4r6KpNyb
         Qc8rFTu2vEj1OcXsHv6np6iry0xcCTY8jIra9T68Tegs/ep3AYVL423V3LzyS39IAQjN
         /NGaobM6HBtkequeZSSYeGooA+UV3JJMBCs0qPHyTMLDxKl8i2odPkn996UTD8e3yjoS
         RN86oYgL0FvgzQVy58iodMXjYxE96tCjwL0grDoQ6a7Qf5pN4Ga4iQ9QaB28biW1mHWW
         j00A==
X-Gm-Message-State: ALQs6tAl3wselc6KoIcM/X1ySIL9gH9zQM+xQkywaYUN3dMUcjH1norw
        WUWyo04byUaNtpley3LOhlX06MmApEGbIXMPeh+uJQ==
X-Google-Smtp-Source: AB8JxZoXRa3eAXgdiLe18qxkQD1IdIDzIH+jaP61rSy4WKS4E3q4PAh4EHdqxM5p1CbLGEGMjx7mtEbYr7dXFTQCw1Y=
X-Received: by 2002:a25:2704:: with SMTP id n4-v6mr8286825ybn.167.1525126701422;
 Mon, 30 Apr 2018 15:18:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a25:cf90:0:0:0:0:0 with HTTP; Mon, 30 Apr 2018 15:18:20
 -0700 (PDT)
In-Reply-To: <CAHqTa-1KCsbG=6T8M0PLuM5s-j972jiv=vvZHUiwOxwgpPWJeA@mail.gmail.com>
References: <20180430095044.28492-1-avarab@gmail.com> <CAHqTa-0xZteMjgJUZ-_Dv5KcX8sVVWHYu=OdRebVEfYfyP0QRw@mail.gmail.com>
 <CAGZ79kakirTjA32cTmByLpjnb3QKUL5eGEgPFFMhUnewC73S8Q@mail.gmail.com> <CAHqTa-1KCsbG=6T8M0PLuM5s-j972jiv=vvZHUiwOxwgpPWJeA@mail.gmail.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Mon, 30 Apr 2018 15:18:20 -0700
Message-ID: <CAGZ79kbisif8D7EiWzR_rtsc2BRNE4kKdCXtQcUk8A_Bjwq=2w@mail.gmail.com>
Subject: Re: [PATCH 0/4] subtree: move out of contrib
To:     Avery Pennarun <apenwarr@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        Stephen R Guglielmo <srguglielmo@gmail.com>,
        "A . Wilcox" <AWilcox@wilcox-tech.com>,
        David Aguilar <davvid@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 30, 2018 at 2:53 PM, Avery Pennarun <apenwarr@gmail.com> wrote:

> For the best of both worlds, I've often thought that a good balance
> would be to use the same data structure that submodule uses, but to
> store all the code in a single git repo under different refs, which we
> might or might not download (or might or might not have different
> ACLs) under different circumstances.

There has been some experimentation with having a simpler ref
surface on the submodule side,
https://public-inbox.org/git/cover.1512168087.git.jonathantanmy@google.com/

The way you describe the future of submodules, all we'd have to do
is to teach git-clone how to select the the "interesting" refs for your use
case. Any other command would assume all submodule data to be
in the main repository.

The difference to Jonathans proposal linked above, would be the
object store to be in the main repo and the refs to be prefixed
per submodule instead of "shadowed".

>  However, when some projects get
> really huge (lots of very big submodule dependencies), then repacking
> one-big-repo starts becoming unwieldy; in that situation git-subtree
> also fails completely.

Yes, but that is a general scaling problem of Git that could be tackled,
e.g. repack into multiple packs serially instead of putting everything
into one pack.

>> Submodules do not need to produce a synthetic project history
>> when splitting off again, as the history is genuine. This allows
>> for easier work with upstream.
>
> Splitting for easier work upstream is great, and there really ought to
> be an official version of 'git subtree split', which is good for all
> sorts of purposes.
>
> However, I suspect almost all uses of the split feature are a)
> splitting a subtree that you previously merged in, or b) splitting a
> subtree into a separate project that you want to maintain separately
> from now on.  Repeated splits in case (a) are only necessary because
> you're not using submodules, or in case (b) are only necessary because
> you didn't *switch* to submodules when it finally came time to split
> the projects.  (In both cases you probably didn't switch to submodules
> because you didn't like one of its tradeoffs, especially the need to
> track multiple repos when you fork.)

That makes sense.

>
> There's one exception, which is doing a one-time permanent merge of
> two projects into one.  That's a nice feature, but is probably used
> extremely rarely.  More often people get into a
> merge-split-merge-split cycle that would be better served by a
> slightly improved git-submodule.

This rare use case is how git-subtree came into existence in gits
contrib directory AFAICT,
https://kernel.googlesource.com/pub/scm/git/git/+/634392b26275fe5436c0ea131bc89b46476aa4ae
which is interesting to view in git-show, but I think defaults could
be tweaked there, as it currently shows me mostly a license file.

>> Conceptually Gerrit is doing
>>
>>   while true:
>>     git submodule update --remote
>>     if worktree is dirty:
>>         git commit "update the submodules"
>>
>> just that Gerrit doesn't poll but does it event based.
>
> ...and it's super handy :)  The problem is it's fundamentally
> centralized: because gerrit can serialize merges into the submodule,
> it also knows exactly how to update the link in the supermodule.  If
> there was wild branching and merging (as there often is in git) and
> you had to resolve conflicts between two submodules, I don't think it
> would be obvious at all how to do it automatically when pushing a
> submodule.  (This also works quite badly with git subtree --squash.)

With the poll based solution I don't think you'd run into many more
problems than you would with Gerrits solution.

In a nearby thread, we were just discussing the submodule merging
strategies,
https://public-inbox.org/git/1524739599.20251.17.camel@klsmartin.com/
which might seem confusing, but the implementation is actually easy
as we just fastforward-only in submodules.

>>
>> https://trends.google.com/trends/explore?date=all&q=git%20subtree,git%20submodule
>>
>> Not sure what to make of this data.
>
> Clearly people need a lot more help when using submodules than when
> using subtree :)

That could be true. :)

Thanks,
Stefan
