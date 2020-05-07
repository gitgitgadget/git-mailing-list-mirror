Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AA9AC38A24
	for <git@archiver.kernel.org>; Thu,  7 May 2020 11:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C2AE208CA
	for <git@archiver.kernel.org>; Thu,  7 May 2020 11:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725969AbgEGLjg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 07:39:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:40014 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725848AbgEGLjg (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 07:39:36 -0400
Received: (qmail 30949 invoked by uid 109); 7 May 2020 11:39:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 May 2020 11:39:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16135 invoked by uid 111); 7 May 2020 11:39:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 May 2020 07:39:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 May 2020 07:39:35 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH] t/t0000-basic: make sure subtests also use
 TEST_SHELL_PATH
Message-ID: <20200507113935.GB3027470@coredump.intra.peff.net>
References: <20200507010746.83418-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200507010746.83418-1-carenas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 06, 2020 at 06:07:46PM -0700, Carlo Marcelo Arenas Belón wrote:

> 3f824e91c8 (t/Makefile: introduce TEST_SHELL_PATH, 2017-12-08) allows for
> setting a shell for running the tests, but the generated subtests weren't
> updated.

Yeah, this makes sense. The primary benefit of $TEST_SHELL_PATH was to
get better support for special testing options (like using bash's
trace_fd with "-x"). But based on recent patches I guess you were
wanting to test the behavior of an unusual shell. And if we're testing
how the test framework runs, certainly using TEST_SHELL_PATH is the most
sensible thing.

-Peff
