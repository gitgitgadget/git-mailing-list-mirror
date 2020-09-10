Return-Path: <SRS0=4khD=CT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC77C43461
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 18:13:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 75AD62078B
	for <git@archiver.kernel.org>; Thu, 10 Sep 2020 18:13:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727028AbgIJSNN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Sep 2020 14:13:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:53742 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727023AbgIJSNF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Sep 2020 14:13:05 -0400
Received: (qmail 22763 invoked by uid 109); 10 Sep 2020 18:13:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 10 Sep 2020 18:13:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21928 invoked by uid 111); 10 Sep 2020 18:13:01 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 10 Sep 2020 14:13:01 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 10 Sep 2020 14:13:00 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 5/7] wt-status: consistently quote paths in "status
 --short" output
Message-ID: <20200910181300.GB1917207@coredump.intra.peff.net>
References: <20200908205224.4126551-1-gitster@pobox.com>
 <20200910170159.1278781-1-gitster@pobox.com>
 <20200910170159.1278781-6-gitster@pobox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200910170159.1278781-6-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Sep 10, 2020 at 10:01:57AM -0700, Junio C Hamano wrote:

> Tracked paths with SP in them were cquoted in "git status --short"
> output, but untracked, ignored, and unmerged paths weren't.

By the way, the long status output will quote paths as appropriate, but
_not_ apply this "we should quote spaces" rule. I'm not sure if that
came up in earlier discussion or not. Certainly we're free to do
whatever looks nicest to humans there, so maybe we prefer to avoid
quoting as much as possible.

-Peff
