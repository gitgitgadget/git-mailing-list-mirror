Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8E60C20A78
	for <e@80x24.org>; Wed,  1 Feb 2017 23:19:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750863AbdBAXTo (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 18:19:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:48070 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbdBAXTo (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 18:19:44 -0500
Received: (qmail 22895 invoked by uid 109); 1 Feb 2017 23:19:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Feb 2017 23:19:43 +0000
Received: (qmail 15008 invoked by uid 111); 1 Feb 2017 23:19:45 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.42.43.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Feb 2017 18:19:45 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Feb 2017 00:19:39 +0100
Date:   Thu, 2 Feb 2017 00:19:39 +0100
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     cornelius.weig@tngtech.com, git@vger.kernel.org
Subject: Re: [PATCH] doc: add note about ignoring --no-create-reflog
Message-ID: <20170201231939.hxhhujpzyb2cqq7a@sigill.intra.peff.net>
References: <20170201220727.18070-1-cornelius.weig@tngtech.com>
 <xmqq4m0do86p.fsf@gitster.mtv.corp.google.com>
 <20170201223520.b4er3av67ev5m3ls@sigill.intra.peff.net>
 <xmqqmve5mrpe.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmve5mrpe.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 01, 2017 at 03:11:57PM -0800, Junio C Hamano wrote:

> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index 5516a47b54..102e426fd8 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -91,6 +91,9 @@ OPTIONS
>  	based sha1 expressions such as "<branchname>@\{yesterday}".
>  	Note that in non-bare repositories, reflogs are usually
>  	enabled by default by the `core.logallrefupdates` config option.
> +	The negated form `--no-create-reflog` does not override the
> +	default, even though it overrides `--create-reflog` that appears
> +	earlier on the command line.

Should this perhaps say "currently" or "this may change in the future",
so that people (including those who might want to fix it later) know
that it's a limitation and not intentional?

I'd also probably say it a little shorter, like:

  The negated form `--no-create-reflog` only overrides an earlier
  `--create-reflog`, but currently does not negate the setting of
  `core.logallrefupdates`.

I guess that really isn't much shorter (I wondered if you could cut out
the "overrides --create-reflog" part, since that is the normal and
expected behavior, but I had trouble wording it to do so).

-Peff
