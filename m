Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F243B2022A
	for <e@80x24.org>; Mon,  7 Nov 2016 20:26:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751592AbcKGU0k (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Nov 2016 15:26:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:39838 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751564AbcKGU0k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2016 15:26:40 -0500
Received: (qmail 8013 invoked by uid 109); 7 Nov 2016 20:26:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Nov 2016 20:26:39 +0000
Received: (qmail 15398 invoked by uid 111); 7 Nov 2016 20:27:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 07 Nov 2016 15:27:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Nov 2016 15:26:37 -0500
Date:   Mon, 7 Nov 2016 15:26:37 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     git@vger.kernel.org, sbeller@google.com, bburky@bburky.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v4 1/2] lib-proto-disable: variable name fix
Message-ID: <20161107202637.ooaddlkfntw37xg3@sigill.intra.peff.net>
References: <1478292933-7873-1-git-send-email-bmwill@google.com>
 <1478547323-47332-1-git-send-email-bmwill@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1478547323-47332-1-git-send-email-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 07, 2016 at 11:35:22AM -0800, Brandon Williams wrote:

> Small fix to use '$desc' instead of '$1' in lib-proto-disable.sh.

Even for a trivial fixup like this, I think it's good to say why.
Because what seems trivial and obvious to you while working on the patch
may not be so to a reviewer, or somebody reading it 6 months later.

Just something simple like:

  The test_proto function assigns the positional parameters to named
  variables, but then still refers to "$desc" as "$1". Using $desc is
  more readable and less error-prone.

-Peff
