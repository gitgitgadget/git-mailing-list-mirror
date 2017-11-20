Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 091D0202F2
	for <e@80x24.org>; Mon, 20 Nov 2017 19:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752250AbdKTTUO (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Nov 2017 14:20:14 -0500
Received: from cloud.peff.net ([104.130.231.41]:34932 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752024AbdKTTUN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Nov 2017 14:20:13 -0500
Received: (qmail 1375 invoked by uid 109); 20 Nov 2017 19:20:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 20 Nov 2017 19:20:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14978 invoked by uid 111); 20 Nov 2017 19:20:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Mon, 20 Nov 2017 14:20:28 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Nov 2017 14:20:11 -0500
Date:   Mon, 20 Nov 2017 14:20:11 -0500
From:   Jeff King <peff@peff.net>
To:     Beat Bolli <dev+git@drbeat.li>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] contrib/git-jump: allow to configure the grep command
Message-ID: <20171120192011.i3nsulvnswshwdlr@sigill.intra.peff.net>
References: <20171119230536.1628-1-dev+git@drbeat.li>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171119230536.1628-1-dev+git@drbeat.li>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 20, 2017 at 12:05:36AM +0100, Beat Bolli wrote:

> Add the configuration option "jump.grepCmd" that allows to configure the
> command that is used to search in grep mode. This allows the users of
> git-jump to use ag(1) or ack(1) as search engines.

This patch looks good to me. The user needs to be careful to use some
option that shows the line number, but that's hopefully obvious from
your example.

> +# use the silver searcher for git jump grep
> +git config jump.grepCmd "ag --column"

I wondered what "vim -q" would do with the --column output. Quite
nicely, it puts the cursor right where you'd want it to be. I'm tempted
to teach "git grep" the same option. ;)

-Peff
