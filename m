Return-Path: <SRS0=uwne=C7=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FD0CC4741F
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 05:03:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54CD723A6A
	for <git@archiver.kernel.org>; Tue, 22 Sep 2020 05:03:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728823AbgIVFDg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Sep 2020 01:03:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:36472 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728290AbgIVFDc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Sep 2020 01:03:32 -0400
Received: (qmail 13698 invoked by uid 109); 22 Sep 2020 05:03:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 22 Sep 2020 05:03:32 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29313 invoked by uid 111); 22 Sep 2020 05:03:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 22 Sep 2020 01:03:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 22 Sep 2020 01:03:31 -0400
From:   Jeff King <peff@peff.net>
To:     Alex Riesen <alexander.riesen@cetitec.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] config: option transfer.ipversion to set transport
 protocol version for network fetches
Message-ID: <20200922050331.GB528837@coredump.intra.peff.net>
References: <20200915135428.GA28038@pflmari>
 <xmqqtuvxwkbz.fsf@gitster.c.googlers.com>
 <xmqqk0wtv204.fsf@gitster.c.googlers.com>
 <20200917140254.GA28281@pflmari>
 <xmqqbli4ox0h.fsf@gitster.c.googlers.com>
 <20200918071647.GA17896@pflmari>
 <xmqq363fnir9.fsf@gitster.c.googlers.com>
 <20200921163901.GB4541@pflmari>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200921163901.GB4541@pflmari>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Sep 21, 2020 at 06:39:01PM +0200, Alex Riesen wrote:

> > By the way, I have a mild preference to call the option after the
> > phrase "protocol-family", without "IP", so that we won't be limited
> > to Internet protocols.  IOW, --ipversions is a bad name for the new
> > commnad line option in my mind.
> 
> I have nothing against protocol-family, with or without "transport-".
> I just didn't want to ... over-generalize it prematurely: currently,
> the transport family is very fixed on IP on many levels.

I'll echo Junio's mild preference. I like it also because
"--ipversion=6" feels too terse in the argument, but "--ipversion=ipv6"
feels redundant.  Saying "--protocol-family=ipv6" is more characters,
but strikes me as more clear. (Or "transport-family" or whatever).

-Peff
