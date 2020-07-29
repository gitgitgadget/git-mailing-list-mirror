Return-Path: <SRS0=QOHA=BI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D15C433E1
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 21:56:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7DB902082E
	for <git@archiver.kernel.org>; Wed, 29 Jul 2020 21:56:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727791AbgG2Vz7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 17:55:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:41730 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgG2Vz7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 17:55:59 -0400
Received: (qmail 9572 invoked by uid 109); 29 Jul 2020 21:55:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 29 Jul 2020 21:55:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10715 invoked by uid 111); 29 Jul 2020 21:55:58 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 29 Jul 2020 17:55:58 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 29 Jul 2020 17:55:58 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 6/7] doc/git-log: move "-t" into diff-options list
Message-ID: <20200729215558.GA2994526@coredump.intra.peff.net>
References: <20200729201002.GA2989059@coredump.intra.peff.net>
 <20200729201210.GF2989342@coredump.intra.peff.net>
 <xmqqzh7i81tk.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqzh7i81tk.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 29, 2020 at 02:10:31PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The "-t" option is infrequently used; it doesn't deserve a spot near the
> > top of the options list. Let's push it down into the diff-options
> > include, near the definition of --raw.
> 
> True.  It does not have any effect unless --raw is in use (i.e.  it
> does have an effect to "git show --patch-with-raw" or anything that
> (also) shows "--raw" output), and it makes sense to have "-t" near
> "--raw".

It affects --name-status, etc, too. But yeah, I would think the primary
use is with --raw.

-Peff
