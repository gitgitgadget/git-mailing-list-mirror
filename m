Return-Path: <SRS0=R55k=B3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B05C2C433E1
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 22:08:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9290F20674
	for <git@archiver.kernel.org>; Mon, 17 Aug 2020 22:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729948AbgHQWIp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Aug 2020 18:08:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:33688 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728426AbgHQWIo (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Aug 2020 18:08:44 -0400
Received: (qmail 7030 invoked by uid 109); 17 Aug 2020 22:08:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 17 Aug 2020 22:08:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23148 invoked by uid 111); 17 Aug 2020 22:08:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 17 Aug 2020 18:08:43 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 17 Aug 2020 18:08:43 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] fast-export: factor out print_oid()
Message-ID: <20200817220843.GA1858228@coredump.intra.peff.net>
References: <1eb633f5-31ec-5d8d-69ac-35d0fb9772da@web.de>
 <20200813151856.GE2244@syl.lan>
 <3ddf0a14-77ac-7546-e03a-704432305bdb@web.de>
 <20200813172545.GB1597339@coredump.intra.peff.net>
 <d25987e5-df7e-d153-bbe4-a4e391ed4454@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d25987e5-df7e-d153-bbe4-a4e391ed4454@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 15, 2020 at 09:14:49AM +0200, René Scharfe wrote:

> > I think this is a bad direction unless you're going to do it for all of
> > the other anonymize_*() functions, as well, for consistency. And there
> > it gets tricky because the caller is able to use the anonymizing
> > knowledge in more places.
> >
> > I actually liked your original version better.
> 
> OK, how about embracing the static and do something like this?
> 
> -- >8 --
> Subject: [PATCH] fast-export: add format_oid() and format_path()

TBH, I don't find it an improvement because of the extra buffer
handling. But I admit that I don't really care between any of the
solutions posted here. They all appear to be correct, and just trading
off various properties so that none is definitively better than the
other. (And none of them is so bad that I feel compelled to avoid it).

So I'd be OK with any of them (or leaving it as-is).

-Peff
