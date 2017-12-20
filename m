Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B49FE1F404
	for <e@80x24.org>; Wed, 20 Dec 2017 16:34:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755516AbdLTQeB (ORCPT <rfc822;e@80x24.org>);
        Wed, 20 Dec 2017 11:34:01 -0500
Received: from cloud.peff.net ([104.130.231.41]:44242 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753433AbdLTQeB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Dec 2017 11:34:01 -0500
Received: (qmail 23187 invoked by uid 109); 20 Dec 2017 16:34:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 20 Dec 2017 16:34:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14353 invoked by uid 111); 20 Dec 2017 16:34:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with ESMTPA; Wed, 20 Dec 2017 11:34:26 -0500
Authentication-Results: peff.net; auth=pass (cram-md5) smtp.auth=relayok
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Dec 2017 11:33:58 -0500
Date:   Wed, 20 Dec 2017 11:33:58 -0500
From:   Jeff King <peff@peff.net>
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
Subject: Re: [PATCH 1/4] status: add --no-ahead-behind to porcelain V2
Message-ID: <20171220163358.GE31149@sigill.intra.peff.net>
References: <20171220144245.39401-1-git@jeffhostetler.com>
 <20171220144245.39401-2-git@jeffhostetler.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171220144245.39401-2-git@jeffhostetler.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 20, 2017 at 02:42:42PM +0000, Jeff Hostetler wrote:

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 9593bfa..9ccdf2b 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -3082,6 +3082,11 @@ status.submoduleSummary::
>  	submodule summary' command, which shows a similar output but does
>  	not honor these settings.
>  
> +status.noaheadbehind::
> +	Do not compute ahead/behind counts for a branch relative to its
> +	upstream branch.  This can be used to avoid a possibly very
> +	expensive computation on extremely large repositories.

I got tripped up by double-negatives here while testing something out
with your series. Could this be "status.aheadbehind", and default to
true?

-Peff
