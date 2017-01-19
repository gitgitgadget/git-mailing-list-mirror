Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 91E2820A17
	for <e@80x24.org>; Thu, 19 Jan 2017 16:39:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753273AbdASQjj (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jan 2017 11:39:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:41552 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753467AbdASQio (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2017 11:38:44 -0500
Received: (qmail 29256 invoked by uid 109); 19 Jan 2017 16:38:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Jan 2017 16:38:44 +0000
Received: (qmail 6480 invoked by uid 111); 19 Jan 2017 16:39:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 19 Jan 2017 11:39:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jan 2017 11:38:41 -0500
Date:   Thu, 19 Jan 2017 11:38:41 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 1/3] color.c: fix color_parse_mem() with value_len == 0
Message-ID: <20170119163841.zhtpz6rxdieaywuy@sigill.intra.peff.net>
References: <20170109103258.25341-1-pclouds@gmail.com>
 <20170119114123.23784-1-pclouds@gmail.com>
 <20170119114123.23784-2-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170119114123.23784-2-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 19, 2017 at 06:41:21PM +0700, Nguyễn Thái Ngọc Duy wrote:

> In this code we want to match the word "reset". If len is zero,
> strncasecmp() will return zero and we incorrectly assume it's "reset" as
> a result.

This is probably a good idea. This _is_ user-visible, so it's possible
somebody was using empty config as a synonym for "reset". But since it
was never documented, I feel like relying on that is somewhat crazy.

-Peff
