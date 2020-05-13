Return-Path: <SRS0=6HsL=63=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B54DC43445
	for <git@archiver.kernel.org>; Wed, 13 May 2020 15:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 061B320690
	for <git@archiver.kernel.org>; Wed, 13 May 2020 14:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388923AbgEMOpP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 May 2020 10:45:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:45228 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388395AbgEMOpO (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 May 2020 10:45:14 -0400
Received: (qmail 5556 invoked by uid 109); 13 May 2020 14:45:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 May 2020 14:45:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21258 invoked by uid 111); 13 May 2020 14:45:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 13 May 2020 10:45:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 13 May 2020 10:45:13 -0400
From:   Jeff King <peff@peff.net>
To:     Daniel Stenberg <daniel@haxx.se>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] http, imap-send: stop using CURLOPT_VERBOSE
Message-ID: <20200513144513.GA639902@coredump.intra.peff.net>
References: <cover.1589218693.git.jonathantanmy@google.com>
 <1df9e9deb7831b32694ea453759bf5d21952e165.1589218693.git.jonathantanmy@google.com>
 <20200512231331.GA6605@camp.crustytoothpaste.net>
 <alpine.DEB.2.20.2005130812500.28445@tvnag.unkk.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.2005130812500.28445@tvnag.unkk.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 13, 2020 at 08:16:59AM +0200, Daniel Stenberg wrote:

> On Tue, 12 May 2020, brian m. carlson wrote:
> 
> Sorry for going slightly off-topic, but I figure this could help as a sort
> of PSA.
> 
> > Since everyone uses HTTPS, it's not possible to perform this debugging
> > using a tool like Wireshark unless you use a MITM CA cert, which seems
> > excessive.
> 
> When you want to Wireshark the connection with libcurl, your friend is
> SSLKEYLOGFILE. If you set that environment variable (assuming the libcurl
> TLS backend supports it - several do), libcurl will save the TLS secrets in
> the file that environment variable mentions - at run-time in a format that
> Wireshark understands.
> 
> Then you can analyze the traffic, in real time, with Wirehark without
> fiddling with a MITM etc.

Very cool. I didn't know about that at all. Now I want to debug some
https sessions... ;)

Thank you!

-Peff
