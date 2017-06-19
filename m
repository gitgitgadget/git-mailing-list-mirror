Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0CDD61FA7B
	for <e@80x24.org>; Mon, 19 Jun 2017 18:04:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751028AbdFSSEw (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 14:04:52 -0400
Received: from cloud.peff.net ([104.130.231.41]:44760 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750844AbdFSSEw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 14:04:52 -0400
Received: (qmail 16632 invoked by uid 109); 19 Jun 2017 17:59:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 19 Jun 2017 17:59:15 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30088 invoked by uid 111); 19 Jun 2017 18:04:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 19 Jun 2017 14:04:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 19 Jun 2017 14:04:50 -0400
Date:   Mon, 19 Jun 2017 14:04:50 -0400
From:   Jeff King <peff@peff.net>
To:     Kaartic Sivaraam <kaarticsivaraam91196@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, avarab@gmail.com,
        git@vger.kernel.org
Subject: Re: [PATCH 2/2] Add test for the new status message
Message-ID: <20170619180450.tjldpkltdwqad4ic@sigill.intra.peff.net>
References: <20170619024123.5438-1-kaarticsivaraam91196@gmail.com>
 <20170619024412.5861-1-kaarticsivaraam91196@gmail.com>
 <xmqqh8zcvbq8.fsf@gitster.mtv.corp.google.com>
 <1497895189.18850.9.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1497895189.18850.9.camel@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 19, 2017 at 11:29:49PM +0530, Kaartic Sivaraam wrote:

> Is there a way to test for the "Initial commit" message in the commit
> template?

You can do "git commit --dry-run", which produces the template on
stdout.

That should be good enough for our purposes here, as it's the same code
that produces the text that goes into the editor template. If you really
wanted to test what the editor sees, you could do something like:

  GIT_EDITOR='cat >editor-input' git commit

but I don't think it's worth the trouble.

-Peff
