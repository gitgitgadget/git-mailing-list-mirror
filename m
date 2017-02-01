Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7340C20A78
	for <e@80x24.org>; Wed,  1 Feb 2017 23:33:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750837AbdBAXdD (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Feb 2017 18:33:03 -0500
Received: from cloud.peff.net ([104.130.231.41]:48088 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750726AbdBAXdD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2017 18:33:03 -0500
Received: (qmail 23619 invoked by uid 109); 1 Feb 2017 23:32:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Feb 2017 23:32:07 +0000
Received: (qmail 15217 invoked by uid 111); 1 Feb 2017 23:32:09 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.42.43.3)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Feb 2017 18:32:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 02 Feb 2017 00:32:03 +0100
Date:   Thu, 2 Feb 2017 00:32:03 +0100
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     cornelius.weig@tngtech.com, git@vger.kernel.org
Subject: Re: [PATCH] doc: add note about ignoring --no-create-reflog
Message-ID: <20170201233202.p462dggidiiyx6s6@sigill.intra.peff.net>
References: <20170201220727.18070-1-cornelius.weig@tngtech.com>
 <xmqq4m0do86p.fsf@gitster.mtv.corp.google.com>
 <20170201223520.b4er3av67ev5m3ls@sigill.intra.peff.net>
 <xmqqmve5mrpe.fsf@gitster.mtv.corp.google.com>
 <20170201231939.hxhhujpzyb2cqq7a@sigill.intra.peff.net>
 <xmqqefzhmr02.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqefzhmr02.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 01, 2017 at 03:27:09PM -0800, Junio C Hamano wrote:

> I had the same trouble wording.  Another thing I noticed was that I
> deliberately left it vague what "default" this does not override,
> because it appears to me that those who do not set logallrefupdates
> will get the compiled-in default and that is also not overriden.
> 
> IOW, "does not negate the setting of core.logallrefupdates" will
> open us to reports "I do not have the configuration set, but I still
> get reflog even when --no-create-reflog is given".
> 
>    The negated form `--no-create-reflog` currently does not negate
>    the default; it overrides an earlier `--create-reflog`, though.
> 
> perhaps?

True. I thought the default was "off", and that we merely set the config
when initializing a repo. But looking again, it really is checking
is_bare_repository() at runtime.

I still think it is OK to mention, as the description of
core.logallrefupdates is where we document the behavior and the
defaults. So even with "I do not have it set", that is still the key to
find more information.

I do not care that strongly either way, though. This is a minor issue,
and I suspect just about any note would be helpful.

-Peff
