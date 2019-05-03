Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	FROM_EXCESS_BASE64,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 958931F453
	for <e@80x24.org>; Fri,  3 May 2019 18:44:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfECSoX (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 May 2019 14:44:23 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:55529 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfECSoW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 May 2019 14:44:22 -0400
Received: by mail-wm1-f65.google.com with SMTP id y2so7897252wmi.5
        for <git@vger.kernel.org>; Fri, 03 May 2019 11:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=6wIQL+gaHNpRDkBJjankv4lA/SestLO9SEw9sBTgVZE=;
        b=s6Ni7bRA+JUQd8S36hs1QJaHtlcj2Vun5+Gd0wY6mLHtXnYUm6PfWLK6ND+tZ/n93i
         UVQFuigSNuuBXnjaA7xgNXnzZ7kvLkahTi347qpX+9krED7UA2ZHLn7fkDsdXwIfWjdi
         lXQmMMEdHnZWF3uXagXclBsNtONlpIkVTEcySOWo0323NWSJFMM2dAksbVu1gkz6HE87
         d76lLdk5Trcufmh+0HRpHSacRjSJjgl9UeulslDdpxvCqhUg9Bb0pOd+pH9XKnlIcFdH
         5xKauPUj9Hwvm41LPpcyDw+6PP6FUvFotubxn2l+nkw/VcSbNa41tbINw8arN27lCNoy
         dOgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=6wIQL+gaHNpRDkBJjankv4lA/SestLO9SEw9sBTgVZE=;
        b=qphjkQoGaZYOQojyYLn7M9OjCN8Cz21DmTG4p7idJWa+3OfvoLYHQgGTvdaTmrycEY
         8nin0bCGTcG556Px9isIUeZIVROeFXTl955YJtfkIQo9R/6kIwl6g0eKaK2P4ofC6YZO
         zcLBDPFvrEYRpEtGALcxP4f9Pz9q1JFukRLGclMtiWXIGuEA86JPA1WFK/mUzmRVaq82
         oy7DK6uxtnobDjfHBILmke4BK07QMD0JWQA3RlfHpfwoP5E5i6WjXz0L2d9EJwPXWBXl
         K4K45XeUEfTrXhjOzTCTn2Ws6vFah9zbdH4zYObFAXrOplNf3HRomPklcARSUYQySTsI
         zrmQ==
X-Gm-Message-State: APjAAAV1XUnxE3hMFLVzkfxAnvTeYxTfn9/cl2Ub0meW8d4PJxQL0MgE
        AqSgpeoYQrQ1KFcNWU2lKJA=
X-Google-Smtp-Source: APXvYqyzWm1ZWJP6P7lW7/rvsUpatcoNHEIB4D0DFl1+rg129UmbVbzA7SgPhM4Z/h1sffYv9XXG1w==
X-Received: by 2002:a1c:cf83:: with SMTP id f125mr6884771wmg.96.1556909061165;
        Fri, 03 May 2019 11:44:21 -0700 (PDT)
Received: from szeder.dev (x4db507c5.dyn.telefonica.de. [77.181.7.197])
        by smtp.gmail.com with ESMTPSA id v16sm1864420wru.76.2019.05.03.11.44.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 May 2019 11:44:20 -0700 (PDT)
Date:   Fri, 3 May 2019 20:44:18 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Thomas Gummerer <t.gummerer@gmail.com>
Subject: Re: [PATCH v3 0/4] remove extern from function declarations
Message-ID: <20190503184418.GJ14763@szeder.dev>
References: <cover.1555352526.git.liu.denton@gmail.com>
 <cover.1555487380.git.liu.denton@gmail.com>
 <20190422214901.GA14528@sigill.intra.peff.net>
 <20190425120758.GD8695@szeder.dev>
 <nycvar.QRO.7.76.6.1904301919580.45@tvgsbejvaqbjf.bet>
 <20190501100108.GA8954@archbookpro.localdomain>
 <20190502000422.GF14763@szeder.dev>
 <nycvar.QRO.7.76.6.1905031127170.45@tvgsbejvaqbjf.bet>
 <20190503144211.GH14763@szeder.dev>
 <20190503174503.GA8242@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190503174503.GA8242@sigill.intra.peff.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 03, 2019 at 01:45:03PM -0400, Jeff King wrote:
> On Fri, May 03, 2019 at 04:42:11PM +0200, SZEDER Gábor wrote:
> 
> > > Since you *could* include it, I now assume that Coccinelle does not need
> > > to follow the `#include`s (otherwise, it would have complained about not
> > > finding the `windows.h` header in your setup).
> > 
> > We invoke Coccinelle/spatch with the '--all-includes' option, see the
> > SPATCH_FLAGS make variable.  And it does indeed include header files:
> > I've seen it find something to transform in 'cache.h', and then the
> > resulting 'contrib/coccinelle/<whatever>.cocci.patch' included the
> > exact same transformation as many times as the number of files
> > including 'cache.h'... which is a lot :)
> 
> I think spatch is smart enough not to hit the same header multiple
> times. But the problem is that we invoke it once per file, so it
> actually processes cache.h many times. That's slow, but also produces
> bogus patches.
> 
> Jacob Keller's patches to collapse this to a single invocation do fix it
> (and I've used them selectively in the past rather than cleaning up the
> resulting patch manually ;) ).
> 
> Sort of tangential to your point, I guess, but it might be a topic to
> revisit.

I simply applied the changes manually to 'cache.h', and rerun 'make
contrib/coccinelle/<...>.cocci.patch'.  This approach is reliable and
has less undesirable side-effects :)  and it doesn't happen that often
to be a considerable burden.

