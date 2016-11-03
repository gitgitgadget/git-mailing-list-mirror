Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EBF752021E
	for <e@80x24.org>; Thu,  3 Nov 2016 20:44:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752504AbcKCUon (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Nov 2016 16:44:43 -0400
Received: from cloud.peff.net ([104.130.231.41]:38299 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751500AbcKCUol (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2016 16:44:41 -0400
Received: (qmail 16828 invoked by uid 109); 3 Nov 2016 20:44:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Nov 2016 20:44:41 +0000
Received: (qmail 16860 invoked by uid 111); 3 Nov 2016 20:45:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 03 Nov 2016 16:45:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Nov 2016 16:44:38 -0400
Date:   Thu, 3 Nov 2016 16:44:38 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Sixt <j6t@kdbg.org>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/4] t0021: put $TEST_ROOT in $PATH
Message-ID: <20161103204438.zfe653c2bsv3zqkx@sigill.intra.peff.net>
References: <20161102181625.e2uprqdlzl7z2xrz@sigill.intra.peff.net>
 <20161102181824.mi6lmfnfckvrav7n@sigill.intra.peff.net>
 <d36d8b51-f2d7-a2f5-89ea-369f49556e10@kdbg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d36d8b51-f2d7-a2f5-89ea-369f49556e10@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 03, 2016 at 09:40:01PM +0100, Johannes Sixt wrote:

> >  TEST_ROOT="$(pwd)"
> > +PATH=$TEST_ROOT:$PATH
> 
> This causes problems on Windows. We need the following squashed in.
> 
> ---- 8< ----
> [PATCH] squash! t0021: put $TEST_ROOT in $PATH
> 
> We have to use $PWD instead of $(pwd) because on Windows the
> latter would add a C: style path to bash's Unix-style $PATH
> variable, which becomes confused by the colon after the
> drive letter. ($PWD is a Unix-style path.)

Thanks. I have to admit I remain confused about which one to use at any
given invocation (I would have thought that switching to $PWD causes
problems elsewhere in the script, but I guess file redirection is
capable of handling either type).

-Peff
