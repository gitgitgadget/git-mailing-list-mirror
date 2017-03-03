Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 036792023D
	for <e@80x24.org>; Fri,  3 Mar 2017 06:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751143AbdCCGku (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 01:40:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:37715 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751050AbdCCGku (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 01:40:50 -0500
Received: (qmail 9329 invoked by uid 109); 3 Mar 2017 06:33:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 06:33:31 +0000
Received: (qmail 25263 invoked by uid 111); 3 Mar 2017 06:33:38 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 01:33:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Mar 2017 01:33:29 -0500
Date:   Fri, 3 Mar 2017 01:33:29 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        sschuberth@gmail.com, Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
        Philip Oakley <philipoakley@iee.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v7 0/3] Conditional config include
Message-ID: <20170303063329.ji6do6eqjbpuwmxz@sigill.intra.peff.net>
References: <20170224131425.32409-1-pclouds@gmail.com>
 <20170301112631.16497-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170301112631.16497-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 01, 2017 at 06:26:28PM +0700, Nguyễn Thái Ngọc Duy wrote:

> I don't have a good answer for Jeff's PS about includeIf ugliness. I
> agree that includeif is ugly but includeIf looks a bit better. I don't
> see a better option (if only "include" does not start or end with a
> vowel...). Maybe includewith? Suggestions are welcome.

I actually think "include-if" _looks_ better, although maybe the
inconsistency with "-" is something we don't want to encourage (though I
also think the implicit include.<cond>.path was OK, too). Feel free to
just ignore me. I will live with it either way.

For those following on the mailing list, there is some discussion at:

  https://github.com/git/git/commit/484f78e46d00c6d35f20058671a8c76bb924fb33

I think that is mostly focused around another failing in the
error-handling of the config code, and that does not need to be
addressed by this series (though of course I'd welcome any fixes).

But there's a test failure that probably does need to be dealt with
before this graduates to 'next'.

-Peff
