Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DE6A1F453
	for <e@80x24.org>; Mon, 28 Jan 2019 17:11:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732235AbfA1QJt (ORCPT <rfc822;e@80x24.org>);
        Mon, 28 Jan 2019 11:09:49 -0500
Received: from cloud.peff.net ([104.130.231.41]:51492 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1732662AbfA1QJq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Jan 2019 11:09:46 -0500
Received: (qmail 2709 invoked by uid 109); 28 Jan 2019 16:09:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 28 Jan 2019 16:09:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26446 invoked by uid 111); 28 Jan 2019 16:09:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 28 Jan 2019 11:09:52 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Jan 2019 11:09:44 -0500
Date:   Mon, 28 Jan 2019 11:09:44 -0500
From:   Jeff King <peff@peff.net>
To:     Sergey Lukashev <lukashev.s@ya.ru>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: unclear docs
Message-ID: <20190128160944.GB23588@sigill.intra.peff.net>
References: <57362151548583138@iva8-37fc2ad204cd.qloud-c.yandex.net>
 <13169311548590123@iva1-16f33c6a446b.qloud-c.yandex.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <13169311548590123@iva1-16f33c6a446b.qloud-c.yandex.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jan 27, 2019 at 02:55:23PM +0300, Sergey Lukashev wrote:

> Well, I have two problems:
> 1) The endings I get with core.autocrlf=false depend on whether I have
>    * text=auto (a file was commited with LFs). At least in git 2.20.1

That sounds right. The default is that Git will never touch your line
endings (going into or out of the working tree). Turning on the
"text=auto" attribute for everything will tell it to start doing so
(according to core.eol, which on Windows is CRLF).

> 2) If the quote holds true then autocrlf=false is actually "true" (for
>    output conversion) on Windows by default because default core.eol
>    is 'native', which is CRLF. I believe autocrlf=false is supposed to
>    mean "no any conversion, input or output, read or write the repo as
>    is".

No, it only means "do not use the autocrlf feature". If you've
separately configured text attributes, it does not disable them.

-Peff
