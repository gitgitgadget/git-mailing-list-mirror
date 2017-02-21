Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 96DC7201B0
	for <e@80x24.org>; Tue, 21 Feb 2017 17:48:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753474AbdBURsc (ORCPT <rfc822;e@80x24.org>);
        Tue, 21 Feb 2017 12:48:32 -0500
Received: from cloud.peff.net ([104.130.231.41]:59353 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751275AbdBURsb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Feb 2017 12:48:31 -0500
Received: (qmail 20554 invoked by uid 109); 21 Feb 2017 17:48:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Feb 2017 17:48:30 +0000
Received: (qmail 13962 invoked by uid 111); 21 Feb 2017 17:48:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 21 Feb 2017 12:48:33 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 21 Feb 2017 12:48:28 -0500
Date:   Tue, 21 Feb 2017 12:48:28 -0500
From:   Jeff King <peff@peff.net>
To:     "Sokolov, Konstantin" <konstantin.sokolov.ext@siemens.com>
Cc:     "gitster@pobox.com" <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Inconsistent results of git blame --porcelain when detecting
 copies from other files
Message-ID: <20170221174828.ddu3vjal4meafc7f@sigill.intra.peff.net>
References: <71BF70CE41AEE741896AF3A5450D86F11F4268FF@DEFTHW99EH3MSX.ww902.siemens.net>
 <xmqqd1ecim8a.fsf@gitster.mtv.corp.google.com>
 <20170220221540.6vemjdvyvwonpqyt@sigill.intra.peff.net>
 <71BF70CE41AEE741896AF3A5450D86F11F42694F@DEFTHW99EH3MSX.ww902.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <71BF70CE41AEE741896AF3A5450D86F11F42694F@DEFTHW99EH3MSX.ww902.siemens.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 21, 2017 at 12:25:37PM +0000, Sokolov, Konstantin wrote:

> Thanks for going into the issue. As far as I understand 2.12 won't
> change the discussed behavior of --procelain. We will switch to
> --line-procelain. After the current discussion it seems to be less
> error prone, more future-proof and our current parser can handle it
> without any changes.

Right, the 2.12 change is only fixing a case where the "previous"
key/value line was not repeated at the correct spots. The same parsing
rules still hold.

-Peff
