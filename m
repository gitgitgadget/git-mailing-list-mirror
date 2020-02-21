Return-Path: <SRS0=3Brp=4J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E95C35641
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 05:28:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E2F14208C4
	for <git@archiver.kernel.org>; Fri, 21 Feb 2020 05:28:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgBUF2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Feb 2020 00:28:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:50064 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725800AbgBUF2U (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Feb 2020 00:28:20 -0500
Received: (qmail 15739 invoked by uid 109); 21 Feb 2020 05:28:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 21 Feb 2020 05:28:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16126 invoked by uid 111); 21 Feb 2020 05:37:22 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Feb 2020 00:37:22 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 21 Feb 2020 00:28:18 -0500
From:   Jeff King <peff@peff.net>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/2] clone: pass --single-branch during
 --recurse-submodules
Message-ID: <20200221052818.GB1280313@coredump.intra.peff.net>
References: <20200221031027.204486-1-emilyshaffer@google.com>
 <20200221031027.204486-3-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200221031027.204486-3-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 20, 2020 at 07:10:27PM -0800, Emily Shaffer wrote:

> Previously, performing "git clone --recurse-submodules --single-branch"
> resulted in submodules cloning all branches even though the superproject
> cloned only one branch. Pipe --single-branch through the submodule
> helper framework to make it to 'clone' later on.

This looks good to me, with the exception of the open question I had
earlier about testing the case where the needed commit isn't covered by
the single branch.

-Peff
