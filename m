Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 152B81F859
	for <e@80x24.org>; Fri, 19 Aug 2016 13:54:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754606AbcHSNyM (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 09:54:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:58104 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1754040AbcHSNyL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 09:54:11 -0400
Received: (qmail 31290 invoked by uid 109); 19 Aug 2016 13:54:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Aug 2016 13:54:10 +0000
Received: (qmail 25593 invoked by uid 111); 19 Aug 2016 13:54:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 19 Aug 2016 09:54:13 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Aug 2016 09:54:08 -0400
Date:   Fri, 19 Aug 2016 09:54:08 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Sebastian Schuberth <sschuberth@gmail.com>,
        Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH v4] config: add conditional include
Message-ID: <20160819135408.ckyw6ruseicvg2jt@sigill.intra.peff.net>
References: <20160712164216.24072-1-pclouds@gmail.com>
 <20160714153311.2166-1-pclouds@gmail.com>
 <CACsJy8Bw0ZNu-6SB0P3dBZCLMJWJkbUqb64H_QOcn4UH+_AcNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8Bw0ZNu-6SB0P3dBZCLMJWJkbUqb64H_QOcn4UH+_AcNA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Aug 13, 2016 at 03:40:59PM +0700, Duy Nguyen wrote:

> Ping..

There was some discussion after v4. I think the open issues are:

  - the commit message is rather terse (it should describe motivation,
    and can refer to the docs for the "how")

  - the syntax might be more clear as:

       [include-if "gitdir:..."]

    or

       [include "gitdir-is:..."]

  - there is an open question of whether we would like to go this route,
    maintaining backwards compatibility syntactically (and thus having
    these includes quietly skipped in older versions), or introduce a
    breaking syntax that could be more convenient, like:

      [if-gitdir(...):section]
      conditional-but-no-include-necessary = true

    I do not have a strong opinion myself, though I had written the
    original [include] assuming syntactic compatibility, and I think it
    has worked out (e.g., you can manipulate include.path via "git
    config" just as you would any other key).

-Peff
