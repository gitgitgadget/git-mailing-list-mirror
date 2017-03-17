Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1CAFD20951
	for <e@80x24.org>; Fri, 17 Mar 2017 12:20:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751794AbdCQMUN (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Mar 2017 08:20:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:45849 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751453AbdCQMUL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Mar 2017 08:20:11 -0400
Received: (qmail 21838 invoked by uid 109); 17 Mar 2017 11:18:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 11:18:17 +0000
Received: (qmail 3943 invoked by uid 111); 17 Mar 2017 11:18:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 17 Mar 2017 07:18:29 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Mar 2017 07:18:14 -0400
Date:   Fri, 17 Mar 2017 07:18:14 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 4/5] Makefile: add USE_SHA1DC knob
Message-ID: <20170317111814.tkzeqfyr3aiyxsxr@sigill.intra.peff.net>
References: <20170316220456.m4yz2kbvzv6waokn@sigill.intra.peff.net>
 <20170316220911.43zernzq643m5mmk@sigill.intra.peff.net>
 <xmqqtw6salmm.fsf@gitster.mtv.corp.google.com>
 <20170317001115.xau6nzp6i7ilkqxv@sigill.intra.peff.net>
 <xmqqh92sa31r.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh92sa31r.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 16, 2017 at 10:24:32PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Thu, Mar 16, 2017 at 03:43:13PM -0700, Junio C Hamano wrote:
> >
> >> Jeff King <peff@peff.net> writes:
> >> 
> >> > +ifdef USE_SHA1DC
> >> > +	LIB_OBJS += sha1dc/sha1.o
> >> > +	LIB_OBJS += sha1dc/ubc_check.o
> >> > +	BASIC_CFLAGS += -DSHA1_SHA1DC
> >> 
> >> The name of this CPP symbol is one difference between this and
> >> Linus's version.  Wouldn't "-DSHA1_DC" make more sense?
> >
> > I'm fine with either. Somehow SHA1_DC felt too short, but it doesn't
> > really matter in practice.
> 
> I'm fine with either, too.  It was just double SHA1 felt a bit
> strange, when the naming convention was SHA1_ followed by the
> characteristic attribute of the implementation (e.g. came from
> Mozilla, etc.) and I thought "Detecting Collision" was the notable
> characteristic of this one.

Yeah, I thought "DC" by itself was funny, but I guess "BLK" by itself is
no less funny. I'm happy to re-roll it if you prefer the other.

-Peff
