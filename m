Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E40420248
	for <e@80x24.org>; Fri, 22 Mar 2019 16:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728247AbfCVQwe (ORCPT <rfc822;e@80x24.org>);
        Fri, 22 Mar 2019 12:52:34 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:35135 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727443AbfCVQwe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Mar 2019 12:52:34 -0400
Received: by mail-wm1-f65.google.com with SMTP id y197so2867352wmd.0
        for <git@vger.kernel.org>; Fri, 22 Mar 2019 09:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ywtvnvp/Ly71xdYpMp2Ed+5JF/s8enzI4D9Mr5D/VpA=;
        b=AlNkRBMrcDSZL2hjzQkjQwbnDfYLX8zWPPoZtmMLkOHpC1UEDRnfqtAB2qpbsghUsM
         BtGWc08wRXxx+PgzCCb3YEwetRZGy2j0biZ0yWJvyia5oJxHJRBNb9pyaBjjorqE7MlX
         er3RXW5REFfVtDoAoVg6d4aD7wFu8YPCecG2E07yYWOnDmB1lzgeRUAxXYyZdm2Bw2Le
         uyi5mKUD1c96MogQsJEy2Hmg9LcZndBMDpOhvhYqho8ZuZc2gZbo3QOMeeQpd5hWHZDH
         AN7DKr3bmKXHz16l84QZok6DjeG6nC7jZPmvm75GMgjHDBLT4M0mjWU3FbaoUWwagINQ
         qBcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ywtvnvp/Ly71xdYpMp2Ed+5JF/s8enzI4D9Mr5D/VpA=;
        b=il5uMfPZfzDVvg8YYxWDEXB9iqKYPUgNiZxkXMGRlbmQOQaJwHEgsVxaqv7eTg2zyV
         QCowBU/9xzr8C89XNsfE8gVVpWKfg7gJ8DXEK91AVxRSCnPq/iquVn1kKjp4rTGBmIq3
         ZH5LMlh8pQg3YJTN3gltDN8GEqSNKbtsNs6gBgQV7ks+raXOMQFf+w0MzCwHcnLf9zOR
         0O5PH0MreP9JdrzJnfdgo0ipbkXWfUvr/uKWdhb7ez2Q1V6pUY8RxYFlHG7rWwMx1/Gw
         KGkLtjiMeZBRgAEB9YfvENqdPyw5DTXALz9dMzygrUJdg/10YqYYbHVCcp1y4oo2sy98
         bcDA==
X-Gm-Message-State: APjAAAXB+Wvf0s7i3Ma6SwX5lffT46i6k7ClgmNd3hRJl5HiZx44BXLZ
        g+K2LfsmELTF+V/b2a5259E=
X-Google-Smtp-Source: APXvYqy4V+WUMmPOZBoa8lw3n3kleA5LimmihbotvWzkZd0zuedFlt6Xsjc3jjVtjmOSUU9MmtScbw==
X-Received: by 2002:a1c:3845:: with SMTP id f66mr3829820wma.41.1553273552407;
        Fri, 22 Mar 2019 09:52:32 -0700 (PDT)
Received: from szeder.dev (x4db501f9.dyn.telefonica.de. [77.181.1.249])
        by smtp.gmail.com with ESMTPSA id i28sm1984515wrc.32.2019.03.22.09.52.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Mar 2019 09:52:31 -0700 (PDT)
Date:   Fri, 22 Mar 2019 17:52:28 +0100
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: Re: [PATCH] commit-graph: don't show progress percentages while
 expanding reachable commits
Message-ID: <20190322165228.GG22459@szeder.dev>
References: <20190119202121.3590-11-avarab@gmail.com>
 <20190322102817.19708-1-szeder.dev@gmail.com>
 <87lg17cgf5.fsf@evledraar.gmail.com>
 <20190322111829.GC22459@szeder.dev>
 <87k1grc7al.fsf@evledraar.gmail.com>
 <20190322145550.GE22459@szeder.dev>
 <87ftrfc5b7.fsf@evledraar.gmail.com>
 <20190322154943.GF22459@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190322154943.GF22459@szeder.dev>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 22, 2019 at 04:49:43PM +0100, SZEDER Gábor wrote:
> On Fri, Mar 22, 2019 at 04:11:24PM +0100, Ævar Arnfjörð Bjarmason wrote:
> > 
> > On Fri, Mar 22 2019, SZEDER Gábor wrote:
> > 
> > > On Fri, Mar 22, 2019 at 03:28:34PM +0100, Ævar Arnfjörð Bjarmason wrote:
> > >>
> > >> On Fri, Mar 22 2019, SZEDER Gábor wrote:
> > >>
> > >> > On Fri, Mar 22, 2019 at 12:11:26PM +0100, Ævar Arnfjörð Bjarmason wrote:
> > >> >>
> > >> >> On Fri, Mar 22 2019, SZEDER Gábor wrote:
> > >> >>
> > >> >> > Commit 49bbc57a57 (commit-graph write: emit a percentage for all
> > >> >> > progress, 2019-01-19) was a bit overeager when it added progress
> > >> >> > percentages to the "Expanding reachable commits in commit graph" phase
> > >> >> > as well, because most of the time the number of commits that phase has
> > >> >> > to iterate over is not known in advance and grows significantly, and,
> > >> >> > consequently, we end up with nonsensical numbers:
> > >> >> >
> > >> >> >   $ git commit-graph write --reachable
> > >> >> >   Expanding reachable commits in commit graph: 138606% (824706/595), done.
> > >> >> >   [...]
> > >> >> >
> > >> >> >   $ git rev-parse v5.0 | git commit-graph write --stdin-commits
> > >> >> >   Expanding reachable commits in commit graph: 81264400% (812644/1), done.
> > >> >> >   [...]
> > >> >> >
> > >> >> > Therefore, don't show progress percentages in the "Expanding reachable
> > >> >> > commits in commit graph" phase.
> > >> >>
> > >> >> There's indeed a bug here as your examples show, but there *are* cases
> > >> >> where it's correct, as the commit message for my patch on "master" shows
> > >> >> there's cases where we correctly.
> > >> >>
> > >> >> So this "fixes" things by always removing the progress, why not instead
> > >> >> pass down the state to close_reachable() about what we're walking over,
> > >> >> so we can always show progress, or at least in some cases?
> > >> >
> > >> > The cases where it does display correct percentages are exceptional,
> > >> > and doesn't worth the effort to try to find out whether ther current
> > >> > operation happens to be such a case.
> > >>
> > >> It's the "write" entry point without arguments that displays the correct
> > >> progress. So not exceptional, but yeah, it's not what we use on "gc".
> > >
> > > Bit it displays the correct number only if all the reachable commits
> > > are in packfiles, which is not necessarily the case (e.g. unpacked
> > > small packs during 'git fetch').
> > 
> > No, argument-less "write" only considers packed commits.
> 
> No, it considers packed commits as starting points, and then expands
> to all reachable commits, that's what that loop in question is about.
> 
>   $ git init
>   Initialized empty Git repository in /tmp/test/.git/
>   $ echo >file
>   $ git add file
>   $ git commit -q -m initial
>   $ echo 1 >file
>   $ git commit -q -m 1 file
>   $ git rev-parse HEAD | git pack-objects
>   .git/objects/pack/pack
>   Enumerating objects: 1, done.
>   Counting objects: 100% (1/1), done.
>   ece3ff72952af2b28e048fa5c58db88c44312876
>   Writing objects: 100% (1/1), done.
>   Total 1 (delta 0), reused 0 (delta 0)
>   $ git commit-graph write
>   Computing commit graph generation numbers: 100% (2/2), done.
> 
> 
> > >> In any case, the problem is that sometimes we've walked the full set of
> > >> commits already, and some other times we haven't.
> > >
> > > ... and that we can't really be sure whether we've walked the full set
> > > of commits until after this loop.
> > 
> > I'm fairly sure we can when we start with a full walk. See my
> > explanation in <87imwbc6x8.fsf@evledraar.gmail.com>, but I may have
> > missed something.

BTW, if we know for _sure_ that we started with the full set of
commits, then we don't have to iterate over all the history in this
"Expanding reachable commits..." phase in the first place, because
there is nowhere to expand anyway.  Maybe we wouldn't even have to
call close_reachable() in that case.

