Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-8.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E0F321F597
	for <e@80x24.org>; Mon, 30 Jul 2018 17:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731700AbeG3T3u (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Jul 2018 15:29:50 -0400
Received: from mail-pg1-f170.google.com ([209.85.215.170]:42622 "EHLO
        mail-pg1-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727468AbeG3T3u (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jul 2018 15:29:50 -0400
Received: by mail-pg1-f170.google.com with SMTP id y4-v6so7642507pgp.9
        for <git@vger.kernel.org>; Mon, 30 Jul 2018 10:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Prm//KOnsh0oB1GE8UtRZFsdf1bdYmEkHiZSWFoBSLo=;
        b=P7edFLxZls6NcG/9ib3aA1ZudqEHBy1TeGJdK3zXm70tpRgqkrmHPZmy5g3jbzSRoY
         BMeTsBAcqybMTNs05GqaLSlpNM+AIpp9N7XbIg7ofy7DRT/Cm3TavlFZMNjMFz2yzTQk
         4cgZIpgqfbnN3/QTPRB9tY7bOttvox6Oa/e/+5JiwvHUV8dRXRH6AcSViwmbfWeqEzVj
         85ZYWZFpz6FOvjNyYAom5LmDiKYk/cN2AE2GaZa1gRoGnqVkE3tixJPTtwm5K64SEOAM
         3+SPZEqbvtURayntX0ybrtxAha4seVNctc0z7EaHBwG1Xhyg0DW3834XeIp/xOlSLm4p
         d6wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Prm//KOnsh0oB1GE8UtRZFsdf1bdYmEkHiZSWFoBSLo=;
        b=uCi8EdshzQaI3C7BoRbPDQi0Mj54oVHwuw3Aekkf/DaAt+W6dETLqXqylZpHB/PRY8
         w8M6ib4Isa3G43WiYnykQSlYByYLAmVsud7SZi+F+R4ySG67siq4fy79k85kipZ14z3i
         9EDkheG8Z62A0AEpE1CIOlON94gkWWV/F/cflvhDQ/6MkLPA4OqOWlv/p0v6kcen+aBu
         bmgZznllIoLDH9OX4hhS4ym4XIrRaNw+bc5rQiNp1tw+TypsbYlkQZ1EUMqiZ3hBt7id
         ATc3lsFe/pr6+1yySsmPrZem/62BD7nCwhLN8IrEnNudDrvtqtvPnSoi27p4GxrvVcZm
         qDqg==
X-Gm-Message-State: AOUpUlFG7mVKDzyylb1leJTH3kADvun9zVoo0WN3VeKviwA05Kt2XPc0
        4QX/o7ihNGfAMAomxKC9pfAjQA==
X-Google-Smtp-Source: AAOMgpdxhKf9/S5QvSf1VsAmLI3RIrhtmzprR6HqsS2dyoELnywGR8GgqBUwQoLQDjGyal5lXd6TSw==
X-Received: by 2002:a63:a5c:: with SMTP id z28-v6mr17165028pgk.209.1532973223520;
        Mon, 30 Jul 2018 10:53:43 -0700 (PDT)
Received: from google.com ([2620:0:100e:422:ff43:9291:7eda:b712])
        by smtp.gmail.com with ESMTPSA id g69-v6sm26171624pfd.23.2018.07.30.10.53.42
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Jul 2018 10:53:42 -0700 (PDT)
Date:   Mon, 30 Jul 2018 10:53:41 -0700
From:   Brandon Williams <bmwill@google.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [BUG] fetching sometimes doesn't update refs
Message-ID: <20180730175341.GB154732@google.com>
References: <20180729121900.GA16770@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180729121900.GA16770@sigill.intra.peff.net>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 07/29, Jeff King wrote:
> I've noticed for the past couple of weeks that some of my fetches don't
> seem to actually update refs, but a follow-up fetch will. I finally
> managed to catch it in the act and track it down. It bisects to your
> 989b8c4452 (fetch-pack: put shallow info in output parameter,
> 2018-06-27). 
> 
> A reproduction recipe is below. I can't imagine why this repo in
> particular triggers it, but it was the one where I initially saw the
> problem (and doing a tiny reproduction does not seem to work). I'm
> guessing it has something to do with the refs, since the main change in
> the offending commit is that we recompute the refmap.

I've noticed this behavior sporadically as well, though I've never been
able to reliably reproduce it, so thanks for creating a reproduction
recipe.  I suspected that it had to do with the ref-in-want series so
thanks for tracking that down too.  We'll take a look.

> 
> -- >8 --
> # clone the repo as it is today
> git clone https://github.com/cmcaine/tridactyl.git
> cd tridactyl
> 
> # roll back the refs so that there is something to fetch
> for i in refs/heads/master refs/remotes/origin/master; do
> 	git update-ref $i $i^
> done
> 
> # and delete the now-unreferenced objects, pretending we are an earlier
> # clone that had not yet fetched
> rm -rf .git/logs
> git repack -ad
> 
> # now fetch; this will get the objects but fail to update refs
> git fetch
> 
> # and fetching again will actually update the refs
> git fetch
> -- 8< --
> 
> -Peff

-- 
Brandon Williams
