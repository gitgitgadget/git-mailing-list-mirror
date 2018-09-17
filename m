Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F09BC1F404
	for <e@80x24.org>; Mon, 17 Sep 2018 02:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727147AbeIQIEY (ORCPT <rfc822;e@80x24.org>);
        Mon, 17 Sep 2018 04:04:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:50496 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727089AbeIQIEY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Sep 2018 04:04:24 -0400
Received: (qmail 13985 invoked by uid 109); 17 Sep 2018 02:39:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 17 Sep 2018 02:39:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 700 invoked by uid 111); 17 Sep 2018 02:39:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 16 Sep 2018 22:39:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Sep 2018 22:39:13 -0400
Date:   Sun, 16 Sep 2018 22:39:13 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: What's cooking in git.git (Sep 2018, #03; Fri, 14)
Message-ID: <20180917023912.GC22024@sigill.intra.peff.net>
References: <xmqqy3c3agkr.fsf@gitster-ct.c.googlers.com>
 <CACsJy8DXT8rF_WYE3C0ak7E8_8j=kRS+Yhi1pZjKd5Rr4OsM_A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACsJy8DXT8rF_WYE3C0ak7E8_8j=kRS+Yhi1pZjKd5Rr4OsM_A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Sep 16, 2018 at 08:39:03AM +0200, Duy Nguyen wrote:

> On Fri, Sep 14, 2018 at 11:56 PM Junio C Hamano <gitster@pobox.com> wrote:
> > * jn/gc-auto (2018-07-17) 3 commits
> >  - gc: do not return error for prior errors in daemonized mode
> >  - gc: exit with status 128 on failure
> >  - gc: improve handling of errors reading gc.log
> >
> >  "gc --auto" ended up calling exit(-1) upon error, which has been
> >  corrected to use exit(1).  Also the error reporting behaviour when
> >  daemonized has been updated to exit with zero status when stopping
> >  due to a previously discovered error (which implies there is no
> >  point running gc to improve the situation); we used to exit with
> >  failure in such a case.
> >
> >  What's the donness of this one?
> >  cf. <20180717201348.GD26218@sigill.intra.peff.net>
> 
> This topic has stayed in 'pu' for a long time. I thought it was
> concluded that this was a good change? Jeff, Jonathan?

I read over the thread again. I don't think I actually have any
complaints about the patches as-is. There was some discussion from Junio
and Ævar about the third one. I don't have a strong opinion. My
experience has been that "gc --auto" is garbage anyway on the server
side, but I think Ævar's experience is that it's reasonable for small to
medium sites (which seems plausible to me).

The message-id quoted there is my "this looks good". I mentioned a few
possible nits, but I think it would be OK with or without them
addressed.

-Peff
