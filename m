Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C0441FBB0
	for <e@80x24.org>; Thu,  1 Dec 2016 18:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757927AbcLASwL (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 13:52:11 -0500
Received: from cloud.peff.net ([104.130.231.41]:49989 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753150AbcLASwK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 13:52:10 -0500
Received: (qmail 8837 invoked by uid 109); 1 Dec 2016 18:52:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 18:52:10 +0000
Received: (qmail 2044 invoked by uid 111); 1 Dec 2016 18:52:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 13:52:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 13:52:08 -0500
Date:   Thu, 1 Dec 2016 13:52:08 -0500
From:   Jeff King <peff@peff.net>
To:     Brandon Williams <bmwill@google.com>
Cc:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org,
        sbeller@google.com, jonathantanmy@google.com, gitster@pobox.com
Subject: Re: [PATCH v6 5/6] grep: enable recurse-submodules to work on <tree>
 objects
Message-ID: <20161201185208.5yikalvlnft5wwqk@sigill.intra.peff.net>
References: <1479840397-68264-1-git-send-email-bmwill@google.com>
 <1480555714-186183-1-git-send-email-bmwill@google.com>
 <1480555714-186183-6-git-send-email-bmwill@google.com>
 <c6b2ddad-ac09-3457-8289-88a3f52b7e4b@kdbg.org>
 <20161201175107.GB51406@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161201175107.GB51406@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 01, 2016 at 09:51:07AM -0800, Brandon Williams wrote:

> On 12/01, Johannes Sixt wrote:
> > Am 01.12.2016 um 02:28 schrieb Brandon Williams:
> > >+	git init "su:b" &&
> > 
> > Don't do that. Colons in file names won't work on Windows.
> > 
> > -- Hannes
> > 
> 
> This test is needed to see if the code still works with filenames that
> contain colons.  Is there a way to mark the test to not run on windows?

Junio suggested !MINGW, which seems sensible. Earlier I mentioned doing
the whole thing in-index, but I think that might get tricky because we
try to find the submodule as ".git/modules/<path>". So it probably isn't
worth the trouble.

-Peff
