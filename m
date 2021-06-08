Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB432C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:40:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 958916023E
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 06:40:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229526AbhFHGmN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 02:42:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:48618 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229507AbhFHGmM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 02:42:12 -0400
Received: (qmail 28162 invoked by uid 109); 8 Jun 2021 06:40:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Jun 2021 06:40:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7042 invoked by uid 111); 8 Jun 2021 06:40:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 08 Jun 2021 02:40:22 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 8 Jun 2021 02:40:19 -0400
From:   Jeff King <peff@peff.net>
To:     "Randall S. Becker" <rsbecker@nexbridge.com>
Cc:     'Junio C Hamano' <gitster@pobox.com>,
        'Taylor Blau' <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.32.0-rc3 - t5300 Still Broken on NonStop
 ia64/x86
Message-ID: <YL8Q08sPWCMYN9Y1@coredump.intra.peff.net>
References: <002701d757d8$1a8d9dc0$4fa8d940$@nexbridge.com>
 <YLfc2+Te7Y3UY+Sm@nand.local>
 <YLfgy94sbmStC0mR@coredump.intra.peff.net>
 <YLfl4jkuwSCiNrrS@nand.local>
 <YLfm8cqY6EjQuhcO@coredump.intra.peff.net>
 <xmqqk0na2yyc.fsf@gitster.g>
 <YLmkI4a4J60KFY2W@coredump.intra.peff.net>
 <xmqq7dja2oyd.fsf@gitster.g>
 <015301d75b07$132a0aa0$397e1fe0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <015301d75b07$132a0aa0$397e1fe0$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Jun 06, 2021 at 03:06:31PM -0400, Randall S. Becker wrote:

> Just something to note: I was running git gc --aggressive on OpenSSL
> today and got the same error as in this case. I'm assuming that the
> fix will apply to that too. In this situation, the gc ran for over 2
> hours until failing. This may be a more widely available test
> condition for fsync() EINTR, possibly.

Thanks. One of my original questions was that we'd expect to see this in
the wild, and not just the test suite. But it sounds like now we have. :)
So I feel better that we have a full understanding of the issue.

-Peff
