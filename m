Return-Path: <SRS0=S8Id=BG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0ED0BC433E3
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 19:42:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E803720738
	for <git@archiver.kernel.org>; Mon, 27 Jul 2020 19:42:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727823AbgG0TmS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Jul 2020 15:42:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:39042 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726196AbgG0TmR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Jul 2020 15:42:17 -0400
Received: (qmail 18809 invoked by uid 109); 27 Jul 2020 19:42:16 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 27 Jul 2020 19:42:16 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17455 invoked by uid 111); 27 Jul 2020 19:42:15 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 27 Jul 2020 15:42:15 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 27 Jul 2020 15:42:15 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, chriscool@tuxfamily.org, gitster@pobox.com
Subject: Re: [PATCH v2 0/4] upload-pack: custom allowed object filters
Message-ID: <20200727194215.GB795313@coredump.intra.peff.net>
References: <cover.1595468657.git.me@ttaylorr.com>
 <20200723204325.GM11341@szeder.dev>
 <20200724165133.GA15287@syl.lan>
 <20200727193432.GO11341@szeder.dev>
 <20200727193657.GC62919@syl.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200727193657.GC62919@syl.lan>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 27, 2020 at 03:36:57PM -0400, Taylor Blau wrote:

> > >      and stop grepping stderr for the right message.
> >
> > No, please check them, I love those error messages :)
> 
> Isn't the problem that these messages only sometimes make it to the
> client depending on what protocol is in use? If so, the right thing to
> do would be to not grep for them, since it will make that test flakey.
> 
> Maybe I'm misunderstanding you/the problem...

You'd have to omit them for tests over certain protocols, but it would
always be robust to check them over local-filesystem clones and fetches.
So it may be that some tests need them and some do not.

-Peff
