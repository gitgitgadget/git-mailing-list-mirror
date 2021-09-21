Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA24C433FE
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 20:53:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2410361165
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 20:53:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234665AbhIUUzE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 16:55:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:52082 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232145AbhIUUzD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 16:55:03 -0400
Received: (qmail 6702 invoked by uid 109); 21 Sep 2021 20:53:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 21 Sep 2021 20:53:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5439 invoked by uid 111); 21 Sep 2021 20:53:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 21 Sep 2021 16:53:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 21 Sep 2021 16:53:33 -0400
From:   Jeff King <peff@peff.net>
To:     S R Wright <srw6666@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: .swp files
Message-ID: <YUpGTWyryurD8XkZ@coredump.intra.peff.net>
References: <e01bdada-1301-739a-9841-6a2182334a9f@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e01bdada-1301-739a-9841-6a2182334a9f@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 21, 2021 at 03:27:01PM -0500, S R Wright wrote:

> When git creates index.lock in the local .git directory,  does it also
> create .index.lock.swp (or any other .swp file)?  If so, can this behaviour
> be disabled?  VIM does this,  but it can be disabled.  Thanks!

No, it doesn't. Git will create index.lock, and then rename it into
place as "index" when its fully written. If something is creating a
".swp" variant, it is outside of Git (e.g., if somebody opened the file
with vim).

-Peff
