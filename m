Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4AFDC64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 11:44:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15A2B2086A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 11:44:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730630AbgLALoI (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 06:44:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:47074 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728245AbgLALoI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 06:44:08 -0500
Received: (qmail 26058 invoked by uid 109); 1 Dec 2020 11:43:27 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Dec 2020 11:43:27 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25748 invoked by uid 111); 1 Dec 2020 11:43:26 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Dec 2020 06:43:26 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Dec 2020 06:43:26 -0500
From:   Jeff King <peff@peff.net>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] refspec: trivial cleanup
Message-ID: <X8YsXjN7MQrLnytw@coredump.intra.peff.net>
References: <20201201004649.57548-1-felipe.contreras@gmail.com>
 <20201201004649.57548-2-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20201201004649.57548-2-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 30, 2020 at 06:46:46PM -0600, Felipe Contreras wrote:

> We can remove one level of indentation and make the code clearer. So why
> not do so?

I know your question was rhetorical, but a good reason not to do so in
general is that the existing pattern reveals some intent. E.g., it
sometimes is the case that with the _current_ code we can return early
from a function or loop, but that is not inherent to what the code is
doing, and the early return or continue makes it harder to understand
that.

I don't think that is the case here, though. The continue actually
expresses the intent more clearly than the existing code.

So the patch looks good to me (as do the others in the series).

-Peff
