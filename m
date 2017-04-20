Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DA141FA26
	for <e@80x24.org>; Thu, 20 Apr 2017 19:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965491AbdDTTHA (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 15:07:00 -0400
Received: from cloud.peff.net ([104.130.231.41]:37084 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S946807AbdDTTG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 15:06:59 -0400
Received: (qmail 27012 invoked by uid 109); 20 Apr 2017 19:06:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 19:06:57 +0000
Received: (qmail 7271 invoked by uid 111); 20 Apr 2017 19:07:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 15:07:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Apr 2017 15:06:54 -0400
Date:   Thu, 20 Apr 2017 15:06:54 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Sixt <j6t@kdbg.org>,
        David Turner <dturner@twosigma.com>, git@vger.kernel.org
Subject: Re: [PATCH] test-lib: abort when can't remove trash directory
Message-ID: <20170420190654.24ufwrhpllpdpmkk@sigill.intra.peff.net>
References: <CAM0VKjm1m4v9vTpwFEejBuD3NuGm+kAdEV-_rzCXCz2G4m5NGw@mail.gmail.com>
 <20170420165230.5951-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170420165230.5951-1-szeder.dev@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 20, 2017 at 06:52:30PM +0200, SZEDER Gábor wrote:

> We had two similar bugs in the tests sporadically triggering error
> messages during the removal of the trash directory, see commits
> bb05510e5 (t5510: run auto-gc in the foreground, 2016-05-01) and
> ef09036cf (t6500: wait for detached auto gc at the end of the test
> script, 2017-04-13).  The test script succeeded nonetheless, because
> these errors are ignored during housekeeping in 'test_done'.
> 
> However, such an error is a sign that something is fishy in the test
> script.  Print an error message and abort the test script when the
> trash directory can't be removed successfully or is already removed,
> because that's unexpected and we woud prefer somebody notice and
> figure out why.
> 
> Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>

I think this is a good idea, and the patch itself looks good. Thanks.

-Peff
