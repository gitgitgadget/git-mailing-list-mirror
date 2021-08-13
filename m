Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51413C4338F
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 16:06:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26C2760F00
	for <git@archiver.kernel.org>; Fri, 13 Aug 2021 16:06:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241370AbhHMQHV (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Aug 2021 12:07:21 -0400
Received: from cloud.peff.net ([104.130.231.41]:48058 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241152AbhHMQHU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Aug 2021 12:07:20 -0400
Received: (qmail 30875 invoked by uid 109); 13 Aug 2021 16:06:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 13 Aug 2021 16:06:53 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31959 invoked by uid 111); 13 Aug 2021 16:06:53 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 13 Aug 2021 12:06:53 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 13 Aug 2021 12:06:52 -0400
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Junio C Hamano' <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.33.0-rc2 (Build/Test Report)
Message-ID: <YRaYnDR6RlgJRr/P@coredump.intra.peff.net>
References: <009101d7904e$a3703e50$ea50baf0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <009101d7904e$a3703e50$ea50baf0$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 13, 2021 at 10:22:19AM -0400, Randall S. Becker wrote:

> >Just a report that t0301.9 hung again on 2.32.0-rc1 on the NonStop
> >ia64 platform, and t5563.8 hung on the x86 platform. These did not

We don't seem to have a t5563. Do you mean t5562?

> 2.32.0-rc2 passes on the NonStop x86 platform. ia64 is slower and
> still running. The test failure is t9001 because there is no sendmail
> on the platform. Is there a suitable dependency that I can use add to
> bypass this test?

Hmm, we shouldn't be depending on platform sendmail for the tests (after
all, we do not want to actually send mail!). What does the failure look
like?

-Peff
