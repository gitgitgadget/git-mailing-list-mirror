Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 382B42047F
	for <e@80x24.org>; Mon,  7 Aug 2017 20:07:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751826AbdHGUH1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Aug 2017 16:07:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:59588 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751505AbdHGUH0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Aug 2017 16:07:26 -0400
Received: (qmail 28447 invoked by uid 109); 7 Aug 2017 20:07:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 Aug 2017 20:07:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10118 invoked by uid 111); 7 Aug 2017 20:07:48 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Mon, 07 Aug 2017 16:07:48 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Aug 2017 16:07:24 -0400
Date:   Mon, 7 Aug 2017 16:07:24 -0400
From:   Jeff King <peff@peff.net>
To:     Nicolas Morey-Chaisemartin <nicolas@morey-chaisemartin.com>
Cc:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH 1/4] imap-send: add wrapper to get server credentials if
 needed
Message-ID: <20170807200724.6pdfkmrrmmkdmmb6@sigill.intra.peff.net>
References: <9687e182-1e23-f84d-3fad-83fdf15dba4c@morey-chaisemartin.com>
 <CAN0heSoA_Xm+14V49hjJBMT7PS_ge0wyhmuvKiw-MHD99rApYQ@mail.gmail.com>
 <fdd74c52-7d9a-b12e-2e1f-524479201701@morey-chaisemartin.com>
 <CAN0heSqVmrFwP7LdjDJmH0JivoCc+DhGtUiTSBs=8nTppzG79A@mail.gmail.com>
 <20170807194257.jrdmpvoseauz37uc@sigill.intra.peff.net>
 <a4761418-0464-baa1-b415-836f33503eb8@morey-chaisemartin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a4761418-0464-baa1-b415-836f33503eb8@morey-chaisemartin.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 07, 2017 at 09:55:56PM +0200, Nicolas Morey-Chaisemartin wrote:

> > On the other hand, if we're hoping to get rid of this code in favor of
> > the curl-based approach, then it's not worth spending time on
> > cosmetic refactoring, as long as it still behaves correctly in the
> > interim.
> 
> Looking at the code, it seems the tunnel mode always uses the legacy imap approach.
> This would have to be ported to curl and stabilized before dropping the legacy code.

Urgh. That's an important mode, I'd think, and one that I have a feeling
curl may not be interested in supporting, just because of it's
complexity. And even if they did, it would take a while for that curl
version to become available.

So maybe the idea of deprecating the non-curl implementation is not
something that can happen anytime soon. :(

> In the meantime, it might be worth doing a bit of cleanup.

In which case, yeah, it is definitely worth cleaning up the existing
code. But I also agree with you that it's worth making sure the curl
version behaves as similarly as possible.

-Peff
