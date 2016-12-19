Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E932203EA
	for <e@80x24.org>; Mon, 19 Dec 2016 14:06:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751995AbcLSOFj (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Dec 2016 09:05:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:58426 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752752AbcLSOFi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2016 09:05:38 -0500
Received: (qmail 4959 invoked by uid 109); 19 Dec 2016 14:05:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 19 Dec 2016 14:05:37 +0000
Received: (qmail 29795 invoked by uid 111); 19 Dec 2016 14:06:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 19 Dec 2016 09:06:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Dec 2016 09:05:35 -0500
Date:   Mon, 19 Dec 2016 09:05:35 -0500
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] parse-options: print "fatal:" before usage_msg_opt()
Message-ID: <20161219140535.ehrbosgn32nl27ki@sigill.intra.peff.net>
References: <20161214151009.4wdzjb44f6aki5ug@sigill.intra.peff.net>
 <20161219120719.GF24125@ash>
 <20161219134148.vxa4fz3jw2i23lfm@sigill.intra.peff.net>
 <CACsJy8BgfyDTUmNh_PvoVcz2q92eNTRZy5myegTdi8mu6imVUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8BgfyDTUmNh_PvoVcz2q92eNTRZy5myegTdi8mu6imVUQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 19, 2016 at 08:53:30PM +0700, Duy Nguyen wrote:

> >> Your commit message does not make clear if you want this "fatal" to be
> >> grep-able (by scripts) or not. If not, please _() the string.  Maybe
> >> this to reduce work for translators
> >>
> >>       /* TRANSLATORS: this is the prefix before usage error */
> >>       fprintf(stderr, "%s %s\n\n", _("fatal:"), msg);
> >
> > I don't think we translate any of our "fatal:", "error:", etc, do we?
> > It certainly doesn't look like it in usage.c.
> 
> I know. But those existed before the l10n starts, some of those belong
> to plumbing messages. This one is new.

We add lots of new messages which are themselves translated, and they
still get untranslated prefixes. It seems like consistency is more
important than translating this one spot. But then, I do not use a
translated git myself, so I would not see the difference either way.

-Peff
