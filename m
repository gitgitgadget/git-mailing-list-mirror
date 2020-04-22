Return-Path: <SRS0=GtnF=6G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8209C54FCB
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 20:04:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6A4A2076E
	for <git@archiver.kernel.org>; Wed, 22 Apr 2020 20:04:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726640AbgDVUE0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Apr 2020 16:04:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:36424 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726079AbgDVUEZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Apr 2020 16:04:25 -0400
Received: (qmail 10282 invoked by uid 109); 22 Apr 2020 20:04:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 22 Apr 2020 20:04:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1469 invoked by uid 111); 22 Apr 2020 20:15:32 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Apr 2020 16:15:32 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 22 Apr 2020 16:04:24 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org, Ilya Tretyakov <it@it3xl.ru>
Subject: Re: [PATCH v2] credential: fix matching URLs with multiple levels in
 path
Message-ID: <20200422200424.GF558336@coredump.intra.peff.net>
References: <20200421225837.GB3515235@coredump.intra.peff.net>
 <20200422195109.2224035-1-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200422195109.2224035-1-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 07:51:09PM +0000, brian m. carlson wrote:

> Changes from v1:
> * Continue to encode slashes in usernames.
> * Add a test for encoding slashes in usernames.
> * Hoist existing tests near the other percent-encoding tests.
> * Update commit message.
> * Remove debugging information.

Thank for an easy-to-read explanation and patch (as usual). This version
looks good to me.

I think there's still an open question on:

  [credential "no-scheme.example.com"]

config sections. I feel like that's something we never really intended
to support and should discourage, but it seems as though it may be in
wide use. But it's definitely a separate patch, and it sounds like Dscho
is working on it.

-Peff
