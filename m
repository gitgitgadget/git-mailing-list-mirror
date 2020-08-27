Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2039C433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 04:15:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA93B2075E
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 04:15:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726322AbgH0EPA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 00:15:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:42172 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726256AbgH0EO5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 00:14:57 -0400
Received: (qmail 13120 invoked by uid 109); 27 Aug 2020 04:14:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 27 Aug 2020 04:14:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22276 invoked by uid 111); 27 Aug 2020 04:14:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 27 Aug 2020 00:14:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 27 Aug 2020 00:14:56 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 3/2] credential-cache: use child_process.args
Message-ID: <20200827041456.GB3346457@coredump.intra.peff.net>
References: <xmqqd03dwe2x.fsf@gitster.c.googlers.com>
 <20200826194650.4031087-1-gitster@pobox.com>
 <20200826194650.4031087-3-gitster@pobox.com>
 <xmqqzh6ht7fg.fsf_-_@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzh6ht7fg.fsf_-_@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 26, 2020 at 02:37:39PM -0700, Junio C Hamano wrote:

> As child_process structure has an embedded strvec args for
> formulating the command line, let's use it instead of using
> an out-of-line argv[] whose length needs to be maintained
> correctly.

I forgot to mention in my other reply: I think this fails to mention the
actual functional change, which is switching from the dashed form to
using the "git" wrapper.

-Peff
