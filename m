Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 40AD61F744
	for <e@80x24.org>; Wed, 20 Jul 2016 16:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753477AbcGTQGo (ORCPT <rfc822;e@80x24.org>);
	Wed, 20 Jul 2016 12:06:44 -0400
Received: from cloud.peff.net ([50.56.180.127]:47602 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753416AbcGTQGk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jul 2016 12:06:40 -0400
Received: (qmail 16525 invoked by uid 102); 20 Jul 2016 16:06:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 12:06:39 -0400
Received: (qmail 22464 invoked by uid 107); 20 Jul 2016 16:07:02 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 20 Jul 2016 12:07:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Jul 2016 10:06:36 -0600
Date:	Wed, 20 Jul 2016 10:06:36 -0600
From:	Jeff King <peff@peff.net>
To:	Jeff Hostetler <jeffhost@microsoft.com>
Cc:	git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v1 4/6] Expanded branch header for Porcelain Status V2
Message-ID: <20160720160635.GC24902@sigill.intra.peff.net>
References: <1468966258-11191-1-git-send-email-jeffhost@microsoft.com>
 <1468966258-11191-5-git-send-email-jeffhost@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1468966258-11191-5-git-send-email-jeffhost@microsoft.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Tue, Jul 19, 2016 at 06:10:56PM -0400, Jeff Hostetler wrote:

> +	} else {
> +		/*
> +		 * TODO All of various print routines allow for s->branch to be null.
> +		 * TODO When can this happen and what should we report here?
> +		 */
> +		fprintf(s->fp, " %s", "(unknown)");
> +	}

IIRC, it happens when HEAD points to a broken ref. So something like:

  git init
  echo broken >.git/refs/heads/master

would cause resolving HEAD to return NULL.

-Peff
