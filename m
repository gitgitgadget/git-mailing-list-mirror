Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 45278208B4
	for <e@80x24.org>; Thu, 10 Aug 2017 17:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752658AbdHJReI (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 13:34:08 -0400
Received: from cloud.peff.net ([104.130.231.41]:34652 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752486AbdHJReH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 13:34:07 -0400
Received: (qmail 18504 invoked by uid 109); 10 Aug 2017 17:34:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 17:34:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6293 invoked by uid 111); 10 Aug 2017 17:34:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 13:34:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2017 13:34:05 -0400
Date:   Thu, 10 Aug 2017 13:34:05 -0400
From:   Jeff King <peff@peff.net>
To:     Mischa POSLAWSKY <git@shiar.nl>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/4] http: drop support for curl < 7.19.4
Message-ID: <20170810173405.pz6afvevatydkatg@sigill.intra.peff.net>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
 <20170809120201.2eagzkljervqeusx@sigill.intra.peff.net>
 <20170810123641.GG2363@shiar.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170810123641.GG2363@shiar.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 02:36:41PM +0200, Mischa POSLAWSKY wrote:

> Jeff King wrote:
> > -#if LIBCURL_VERSION_NUM >= 0x071301
> >  	curl_easy_setopt(result, CURLOPT_POSTREDIR, CURL_REDIR_POST_ALL);
> > -#elif LIBCURL_VERSION_NUM >= 0x071101
> >  	curl_easy_setopt(result, CURLOPT_POST301, 1);
> > -#endif
> 
> This seems to be an unintended behavioural change: the second condition
> wouldn't have applied previously and overrides the first option
> (equivalent to CURLOPT_POSTREDIR = CURL_REDIR_POST_301).

Thanks, you're right. I'll fix it in my re-roll.

-Peff
