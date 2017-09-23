Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C96BE20281
	for <e@80x24.org>; Sat, 23 Sep 2017 15:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751059AbdIWPrG (ORCPT <rfc822;e@80x24.org>);
        Sat, 23 Sep 2017 11:47:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:48112 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750913AbdIWPrF (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 23 Sep 2017 11:47:05 -0400
Received: (qmail 19106 invoked by uid 109); 23 Sep 2017 15:47:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 23 Sep 2017 15:47:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13053 invoked by uid 111); 23 Sep 2017 15:47:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Sat, 23 Sep 2017 11:47:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Sep 2017 11:47:02 -0400
Date:   Sat, 23 Sep 2017 11:47:02 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH v2 5/6] object_array: add and use `object_array_pop()`
Message-ID: <20170923154702.ltyg6ctqlcup6ars@sigill.intra.peff.net>
References: <20170920200229.bc4yniz6otng2zyz@sigill.intra.peff.net>
 <cover.1506120291.git.martin.agren@gmail.com>
 <80eaae517f73f57137db6adfcaef2e8ce16576c1.1506120292.git.martin.agren@gmail.com>
 <20170923042757.ozl4qnmrsnd64mfc@sigill.intra.peff.net>
 <CAN0heSpMqRHuQ98AC3Qne=0ygSHxFXQ4buLp0Lvtf19uUo8adQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSpMqRHuQ98AC3Qne=0ygSHxFXQ4buLp0Lvtf19uUo8adQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 23, 2017 at 11:49:16AM +0200, Martin Ågren wrote:

> >>  void add_object_array_with_path(struct object *obj, const char *name, struct object_array *array, unsigned mode, const char *path);
> >> +/*
> >> + * Returns NULL if the array is empty. Otherwise, returns the last object
> >> + * after removing its entry from the array. Other resources associated
> >> + * with that object are left in an unspecified state and should not be
> >> + * examined.
> >> + */
> >> +struct object *object_array_pop(struct object_array *array);
> >
> > I'm very happy to see a comment over the declaration here. But I think
> > it's a bit more readable if we put a blank line between the prior
> > function and the start of that comment.
> 
> Yes, that looks strange. :( I could re-roll and/or ask Junio to fiddle
> with it. On closer look, this file is pretty close to documenting all
> functions and there are some other comment-formatting issues. So here's
> a promise that I'll get back to clean this up more generally in the not
> too distant future. Would that be an acceptable punt? :-?

Yeah, I don't think it is a show-stopper (and I think there is a
reasonable chance Junio will just mark it up as he applies).

-Peff
