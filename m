Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3476C433E3
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 18:34:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D627420772
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 18:34:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726701AbgHRSeT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 14:34:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:34664 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726435AbgHRSeR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 14:34:17 -0400
Received: (qmail 16468 invoked by uid 109); 18 Aug 2020 18:34:17 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Aug 2020 18:34:17 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31965 invoked by uid 111); 18 Aug 2020 18:34:17 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Aug 2020 14:34:17 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 18 Aug 2020 14:34:16 -0400
From:   Jeff King <peff@peff.net>
To:     Matheus Tavares <matheus.bernardino@usp.br>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] checkout_entry(): remove unreachable error() call
Message-ID: <20200818183416.GA2479537@coredump.intra.peff.net>
References: <a170ee42e6d642d380e6b761e8889b05e452414a.1597772501.git.matheus.bernardino@usp.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a170ee42e6d642d380e6b761e8889b05e452414a.1597772501.git.matheus.bernardino@usp.br>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 18, 2020 at 02:46:55PM -0300, Matheus Tavares wrote:

> This if statement never evaluates to true since we already check
> state->force a few lines above, and immediately return when it is
> false.

Yep. Looks like this was unreachable even when it was added back in
d48a72f337 (Fix replacing of a directory with a file/symlink in
git-checkout-cache, 2005-07-14).

-Peff
