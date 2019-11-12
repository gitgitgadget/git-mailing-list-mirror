Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C16611F4B5
	for <e@80x24.org>; Tue, 12 Nov 2019 12:12:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbfKLMMs (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 07:12:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:45220 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725865AbfKLMMs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 07:12:48 -0500
Received: (qmail 31970 invoked by uid 109); 12 Nov 2019 12:12:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 12 Nov 2019 12:12:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14240 invoked by uid 111); 12 Nov 2019 12:16:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Nov 2019 07:16:19 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Nov 2019 07:12:47 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 2/2] hex: drop sha1_to_hex()
Message-ID: <20191112121247.GA12074@sigill.intra.peff.net>
References: <20191111090332.GA2275@sigill.intra.peff.net>
 <20191111090418.GB12545@sigill.intra.peff.net>
 <20191111141805.GK4348@szeder.dev>
 <20191111142904.GB1934@sigill.intra.peff.net>
 <xmqqa791hgu1.fsf@gitster-ct.c.googlers.com>
 <20191112105759.GA9714@sigill.intra.peff.net>
 <20191112114458.GP4348@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191112114458.GP4348@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 12, 2019 at 12:44:58PM +0100, SZEDER Gábor wrote:

> > > 1:  8a030f1796 ! 1:  02d21d4117 hex: drop sha1_to_hex()
> > >     @@ Commit message
> > >          hex: drop sha1_to_hex()
> > >      
> > >          There's only a single caller left of sha1_to_hex(), since everybody now
> > >     -    uses oid_to_hex() instead. This case is in the sha1dc wrapper, where we
> > >     +    uses hash_to_hex() instead. This case is in the sha1dc wrapper, where we
> > >          print a hex sha1 when we find a collision. This one will always be sha1,
> > >     -    regardless of the current hash algorithm, so we can't use oid_to_hex()
> > >     +    regardless of the current hash algorithm, so we can't use hash_to_hex()
> > >          here. In practice we'd probably not be running sha1 at all if it isn't
> > >          the current algorithm, but it's possible we might still occasionally
> > >          need to compute a sha1 in a post-sha256 world.
> [...]
> And because of this the updated "since everybody uses hash_to_hex()"
> in the first hunk sounds a bit wrong, because barely anybody actually
> uses hash_to_hex().

You're right, I should have read more carefully.

-Peff
