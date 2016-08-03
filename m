Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 863DC1F40E
	for <e@80x24.org>; Wed,  3 Aug 2016 18:02:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753319AbcHCSC1 (ORCPT <rfc822;e@80x24.org>);
	Wed, 3 Aug 2016 14:02:27 -0400
Received: from cloud.peff.net ([50.56.180.127]:53983 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753269AbcHCSCX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2016 14:02:23 -0400
Received: (qmail 9769 invoked by uid 102); 3 Aug 2016 18:02:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 14:02:17 -0400
Received: (qmail 3653 invoked by uid 107); 3 Aug 2016 18:02:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 03 Aug 2016 14:02:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 03 Aug 2016 14:02:14 -0400
Date:	Wed, 3 Aug 2016 14:02:14 -0400
From:	Jeff King <peff@peff.net>
To:	Laszlo Ersek <lersek@redhat.com>
Cc:	public git mailing list <git@vger.kernel.org>
Subject: Re: appending a pattern to the default "diff.cpp.xfuncname"
Message-ID: <20160803180213.o7xpm4c4tw5rixmy@sigill.intra.peff.net>
References: <40ceebb8-b343-a5ca-e7ff-23cccc181528@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <40ceebb8-b343-a5ca-e7ff-23cccc181528@redhat.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Aug 03, 2016 at 12:16:14PM +0200, Laszlo Ersek wrote:

> I've used diff.<TYPE>.xfuncname with great success for file <TYPE>s that
> I defined myself. However, now I would like to append an extra pattern
> to the TYPE=cpp case (for which git has builtin patterns). Is there an
> easy way to do this?
> 
> I figured I could open-code the builtin patterns from "userdiff.c", and
> then append my new pattern to those, but it looks kinda gross :)

Unfortunately, no, the config system has no notion of "append to this
value". So you are stuck with extracting the builtin value (which
annoyingly, you cannot even get without looking at the source code!),
and repeating it in your config file.

-Peff
