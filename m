Return-Path: <SRS0=mJAO=7L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F1BC433E0
	for <git@archiver.kernel.org>; Fri, 29 May 2020 05:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9981207D4
	for <git@archiver.kernel.org>; Fri, 29 May 2020 05:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgE2Fur (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 May 2020 01:50:47 -0400
Received: from cloud.peff.net ([104.130.231.41]:59700 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725562AbgE2Fur (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 May 2020 01:50:47 -0400
Received: (qmail 1704 invoked by uid 109); 29 May 2020 05:50:47 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 29 May 2020 05:50:47 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21117 invoked by uid 111); 29 May 2020 05:50:47 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 29 May 2020 01:50:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 29 May 2020 01:50:45 -0400
From:   Jeff King <peff@peff.net>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [BUG] New git unable to show this commit completely?
Message-ID: <20200529055045.GA1294228@coredump.intra.peff.net>
References: <HK0P153MB0113E08900C5C8B8311A4B24BF8F0@HK0P153MB0113.APCP153.PROD.OUTLOOK.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <HK0P153MB0113E08900C5C8B8311A4B24BF8F0@HK0P153MB0113.APCP153.PROD.OUTLOOK.COM>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 29, 2020 at 05:43:29AM +0000, Dexuan Cui wrote:

> However, in Ubuntu 20.04, the git doesn't show the deleted file
> arch/x86/mach-generic/probe.c at all:

It does; it's part of this rename:

>  arch/x86/{mach-generic/probe.c => kernel/probe_32.c} | 92 ++++++++++++++++++

Rename detection was turned on by default in Git v2.0. You can get the
original output with:

  git show --stat --no-renames 7b38725318f4517af6168ccbff99060d67aba1c8

Or if you really don't like rename detection, you can disable it in the
config, like:

  git config --global diff.renames false

-Peff
