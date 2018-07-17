Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B4AED1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 19:59:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730238AbeGQUeG (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 16:34:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:50088 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730027AbeGQUeA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 16:34:00 -0400
Received: (qmail 16060 invoked by uid 109); 17 Jul 2018 19:59:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Jul 2018 19:59:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25216 invoked by uid 111); 17 Jul 2018 19:59:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 17 Jul 2018 15:59:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jul 2018 15:59:47 -0400
Date:   Tue, 17 Jul 2018 15:59:47 -0400
From:   Jeff King <peff@peff.net>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] gc: exit with status 128 on failure
Message-ID: <20180717195946.GC26218@sigill.intra.peff.net>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180717065151.GA177907@aiede.svl.corp.google.com>
 <20180717065416.GC177907@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180717065416.GC177907@aiede.svl.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 11:54:16PM -0700, Jonathan Nieder wrote:

> A value of -1 returned from cmd_gc gets propagated to exit(),
> resulting in an exit status of 255.  Use die instead for a clearer
> error message and a controlled exit.

This feels a little funny because we know we're going to turn some of
these back in the next patch. That said, I'm OK with it, since this
version is already written.

-Peff
