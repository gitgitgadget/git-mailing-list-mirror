Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33013C433FE
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 15:29:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC8BB23B45
	for <git@archiver.kernel.org>; Thu, 10 Dec 2020 15:29:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391742AbgLJP2q (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Dec 2020 10:28:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:56966 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391535AbgLJP2h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Dec 2020 10:28:37 -0500
Received: (qmail 32696 invoked by uid 109); 10 Dec 2020 15:27:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Dec 2020 15:27:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28578 invoked by uid 111); 10 Dec 2020 15:27:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Dec 2020 10:27:54 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Dec 2020 10:27:54 -0500
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "Brian M. Carlson" <sandals@crustytoothpaste.net>,
        Aaron Schrab <aaron@schrab.com>,
        Denton Liu <liu.denton@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v2 1/2] Add project-wide .vimrc configuration
Message-ID: <X9I+eisn7sQuWZ1J@coredump.intra.peff.net>
References: <20201209065537.48802-1-felipe.contreras@gmail.com>
 <20201209065537.48802-2-felipe.contreras@gmail.com>
 <X9EI8c9yeX136ewm@coredump.intra.peff.net>
 <CAMP44s19FKYT5LNUxbGZP3czFmhe9t5B-FAfH+V2btNvMNW31g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAMP44s19FKYT5LNUxbGZP3czFmhe9t5B-FAfH+V2btNvMNW31g@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 09, 2020 at 07:55:55PM -0600, Felipe Contreras wrote:

> >   - t0 is specifying not to indent function return types when they
> >     appear on a separate line. But our style is not to put those return
> >     types on a separate line, anyway. Do we need this?
> 
> Right. I recall at some point it was annoying me that types were auto
> indented magically at wrong times. Testing "ts" that doesn't seem to
> happen anymore, but it also doesn't seem to be working at all.
> 
> Do you see some difference from "t0" and "ts" with:
> 
>   void
>   main(void) { }

No, but picking it does seem to impact a larger example. If I open up
wt-status.c and modify the first function to be:

  static const char *
  color(int slot, struct wt_status *s)
  {

then reindenting it with t0 versus ts makes a difference (and I do
prefer the t0 behavior). But we would not use that split-line style in
our project in the first place, I don't think.

-Peff
