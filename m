Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 638621F404
	for <e@80x24.org>; Tue, 27 Feb 2018 22:20:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751775AbeB0WUF (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Feb 2018 17:20:05 -0500
Received: from cloud.peff.net ([104.130.231.41]:39626 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751633AbeB0WUE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Feb 2018 17:20:04 -0500
Received: (qmail 10722 invoked by uid 109); 27 Feb 2018 22:20:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 27 Feb 2018 22:20:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28372 invoked by uid 111); 27 Feb 2018 22:20:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 27 Feb 2018 17:20:53 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 27 Feb 2018 17:20:02 -0500
Date:   Tue, 27 Feb 2018 17:20:02 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
        Lars Schneider <larsxschneider@gmail.com>,
        Lars Schneider <lars.schneider@autodesk.com>,
        git <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        ramsay@ramsayjones.plus.com, Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v7 0/7] convert: add support for different encodings
Message-ID: <20180227222002.GF11187@sigill.intra.peff.net>
References: <xmqq7er3tqjq.fsf@gitster-ct.c.googlers.com>
 <FDF4DEB8-E71A-4BFC-9437-678C8F65BBDC@gmail.com>
 <20180226014445.GB8677@sigill.intra.peff.net>
 <20180226173533.GA7877@tor.lan>
 <20180226204635.GB12598@sigill.intra.peff.net>
 <20180227210517.GA17555@tor.lan>
 <20180227212537.GA6899@sigill.intra.peff.net>
 <xmqqd10qp07d.fsf@gitster-ct.c.googlers.com>
 <20180227215845.GA11187@sigill.intra.peff.net>
 <xmqqzi3unkxf.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzi3unkxf.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 27, 2018 at 02:10:20PM -0800, Junio C Hamano wrote:

> > I thought it solved that by the hosting folks never seeing the strange
> > binary-looking data. They see only utf8, which diffs well.
> 
> Ah, OK, that is a "fix" in a wider context (in a narrower context,
> "work around" is a more appropriate term ;-).
> 
> The reason why I have been nudging people toward considering in-repo
> encoding attribute is because forcing projects that already have
> their contents in a strange binary-looking encoding to switch is
> costly.  But perhaps having them pay one-time conversion pain is a
> better investment longer term.

Yeah, thanks for mentioning that. It should have gone in my "relative
merits" list. The conversion flag-day is definitely going to be a pain
for users, and doesn't help with diffing older versions.

-Peff
