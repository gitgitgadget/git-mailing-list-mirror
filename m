Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA98C433E0
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 00:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A524D2074B
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 00:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730983AbgGaAok (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Jul 2020 20:44:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:43188 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730892AbgGaAok (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Jul 2020 20:44:40 -0400
Received: (qmail 17711 invoked by uid 109); 31 Jul 2020 00:44:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 31 Jul 2020 00:44:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22699 invoked by uid 111); 31 Jul 2020 00:44:39 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 30 Jul 2020 20:44:39 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 30 Jul 2020 20:44:39 -0400
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git List Mailing <git@vger.kernel.org>
Subject: Re: Avoiding 'master' nomenclature
Message-ID: <20200731004439.GB240563@coredump.intra.peff.net>
References: <CAHk-=wgutLH=mPdJkLU_E6gO4q0FcG+=EEQJVVQeb+OxG9CfgQ@mail.gmail.com>
 <xmqqime69jfc.fsf@gitster.c.googlers.com>
 <CAHk-=wisOOrfEvab9S417MnPSY8dVkbDOKa6ccdi1Bg3X1PMaw@mail.gmail.com>
 <CAHk-=wi2dsROeg=mij5C8O=UBVZGEpOUp=Bn-arQ7i+Wscynnw@mail.gmail.com>
 <20200729205846.GA2992025@coredump.intra.peff.net>
 <CAHk-=wg7r=y_tYpWuRwNFP0JU5D4g=UN1puCzkvQP4bey0-Hmw@mail.gmail.com>
 <20200730002944.GB2996059@coredump.intra.peff.net>
 <CAHk-=wgdKi+Mhq3TKVKLKTm0RBxjHpg7C2co8xRnvPuV5sgJUw@mail.gmail.com>
 <20200730005243.GD2996059@coredump.intra.peff.net>
 <CAHk-=whzL9AUsQrF=ncq_frWOmstHjXx=-em0QuGc76KXdeOMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAHk-=whzL9AUsQrF=ncq_frWOmstHjXx=-em0QuGc76KXdeOMQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 29, 2020 at 05:57:52PM -0700, Linus Torvalds wrote:

> The reason I ended up with my hook is that a number of people send me
> their pull requests using the ssh address anyway, because they as
> maintainers end up having kernel.org accounts, and that's how they
> interact with it.
> 
> So I actually end up wanting to rewrite it to use the public address
> even if the insteadOf logic didn't trigger, because those ssh
> addresses just don't make sense in the public history, and there's an
> easy 1:1 translation to the public mirrors.

Ah, that makes sense. So the feature you'd want really is "rewrite this
when mentioning the url publicly". I do think it may be a problem other
folks have, but it's also easily solved (and more) with a hook. Since
nobody else has mentioned it, I'm willing to punt on it for now. If it
comes up again, we should think about having a friendlier way to do it.

Thanks for clarifying.

-Peff
