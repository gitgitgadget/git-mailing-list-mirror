Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21FEC433DF
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 20:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 74B4120878
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 20:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726753AbgJMU6m (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 16:58:42 -0400
Received: from cloud.peff.net ([104.130.231.41]:59002 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726186AbgJMU6m (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 16:58:42 -0400
Received: (qmail 13099 invoked by uid 109); 13 Oct 2020 20:58:42 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 13 Oct 2020 20:58:42 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9108 invoked by uid 111); 13 Oct 2020 20:58:41 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 13 Oct 2020 16:58:41 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 13 Oct 2020 16:58:41 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Sean McAllister <smcallis@google.com>, git@vger.kernel.org,
        masayasuzuki@google.com, jrnieder@gmail.com
Subject: Re: [PATCH v2 2/3] replace CURLOPT_FILE With CURLOPT_WRITEDATA
Message-ID: <20201013205841.GA3678071@coredump.intra.peff.net>
References: <20201013191729.2524700-1-smcallis@google.com>
 <20201013191729.2524700-2-smcallis@google.com>
 <xmqq7drtkg6o.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq7drtkg6o.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 13, 2020 at 01:46:07PM -0700, Junio C Hamano wrote:

> Sean McAllister <smcallis@google.com> writes:
> 
> > CURLOPT_FILE has been deprecated since 2003.
> 
> I thought that Dscho already mention this, but updating the above
> description to mention that _WRITEDATA was introduce to overtake
> _FILE as an equivalent in the same timeframe would be more helpful
> to readers.

Yes. But more important:

  - when is _FILE going away (or has it already in some versions)?

  - when did _WRITEDATA appear?

IOW, as a reviewer I would want to make sure that we are not losing
support for any reasonable version of libcurl, or that we are at least
getting something in return (fixing an incompatibility with newer
versions).

From the link Dscho dug up it looks like the answer to the second one is
"long enough not to care", but the commit message should make that
plain.

-Peff
