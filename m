Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4B4320D0C
	for <e@80x24.org>; Wed, 21 Jun 2017 19:23:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751265AbdFUTXS (ORCPT <rfc822;e@80x24.org>);
        Wed, 21 Jun 2017 15:23:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:47868 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751028AbdFUTXS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2017 15:23:18 -0400
Received: (qmail 5910 invoked by uid 109); 21 Jun 2017 19:23:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 21 Jun 2017 19:23:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26674 invoked by uid 111); 21 Jun 2017 19:23:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 21 Jun 2017 15:23:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Jun 2017 15:23:15 -0400
Date:   Wed, 21 Jun 2017 15:23:15 -0400
From:   Jeff King <peff@peff.net>
To:     Christian =?utf-8?B?UsO2c2No?= <christian@croesch.de>
Cc:     git@vger.kernel.org
Subject: [PATCH 0/2] Re: git add -p does not work with custom comment char
 currently
Message-ID: <20170621192315.3umx4lszvzwjffnb@sigill.intra.peff.net>
References: <89d4e348-167e-b201-d243-63b1156b9ed0@croesch.de>
 <20170621182020.ywopkykzdfhlxi5o@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170621182020.ywopkykzdfhlxi5o@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2017 at 02:20:21PM -0400, Jeff King wrote:

> I can reproduce easily here with the script below. It looks like a
> regression in c9d961647 (i18n: add--interactive: mark edit_hunk_manually
> message for translation, 2016-12-14), which is in v2.12.0. It taught the
> script to write out with the comment char, but reading it back does not
> seem to work.
>
> [...]
>
> I think there's another bug, too, where the "patch did not apply
> cleanly" prompt goes into an infinite loop if it gets EOF.

Here are fixes for both.

  [1/2]: add--interactive: handle EOF in prompt_yesno
  [2/2]: add--interactive: quote commentChar regex

 git-add--interactive.perl  | 3 ++-
 t/t3701-add-interactive.sh | 8 ++++++++
 2 files changed, 10 insertions(+), 1 deletion(-)

-Peff
