Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42ED71F42D
	for <e@80x24.org>; Sat,  2 Jun 2018 05:19:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750776AbeFBFNr (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Jun 2018 01:13:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:59962 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750748AbeFBFNr (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Jun 2018 01:13:47 -0400
Received: (qmail 27842 invoked by uid 109); 2 Jun 2018 05:13:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 02 Jun 2018 05:13:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30685 invoked by uid 111); 2 Jun 2018 05:13:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 02 Jun 2018 01:13:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 02 Jun 2018 01:13:45 -0400
Date:   Sat, 2 Jun 2018 01:13:45 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, wink@saville.com,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH v4] json_writer: new routines to create data in JSON
 format
Message-ID: <20180602051344.GA28311@sigill.intra.peff.net>
References: <20180326143136.47116-1-git@jeffhostetler.com>
 <20180326143136.47116-2-git@jeffhostetler.com>
 <CACsJy8DcGp29iJDZKUz0JM-bvbE_G3KnqWyLk_efjd7T3URTYw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8DcGp29iJDZKUz0JM-bvbE_G3KnqWyLk_efjd7T3URTYw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 02, 2018 at 06:41:06AM +0200, Duy Nguyen wrote:

> On Mon, Mar 26, 2018 at 4:31 PM,  <git@jeffhostetler.com> wrote:
> > +static inline void assert_in_array(const struct json_writer *jw)
> > +{
> > +       if (!jw->open_stack.len)
> > +               die("json-writer: array: missing jw_array_begin()");
> 
> When you reroll, please consider marking all these string for
> translation with _(), unless these are for machine consumption.

Actually, these are all basically asserts, I think. So ideally they'd be
BUG()s and not translated.

-Peff
