Return-Path: <SRS0=MMY4=4L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C56CBC35673
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 21:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 95DF920675
	for <git@archiver.kernel.org>; Sun, 23 Feb 2020 21:46:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgBWVqv (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 16:46:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:52118 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726302AbgBWVqv (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 16:46:51 -0500
Received: (qmail 3639 invoked by uid 109); 23 Feb 2020 21:46:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 23 Feb 2020 21:46:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4997 invoked by uid 111); 23 Feb 2020 21:55:55 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 23 Feb 2020 16:55:55 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 23 Feb 2020 16:46:50 -0500
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/3] t4117: check for files using `test_path_is_file`
Message-ID: <20200223214650.GB564691@coredump.intra.peff.net>
References: <dde0f85e5e3dd99a61b83df1b6eb572be8a3ff51.1582447606.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <dde0f85e5e3dd99a61b83df1b6eb572be8a3ff51.1582447606.git.martin.agren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 23, 2020 at 09:48:34AM +0100, Martin Ågren wrote:

> We `cat` files, but don't inspect or grab the contents in any way. These
> `cat` calls look like remnants from a debug session, so it's tempting to
> get rid of them. But they do actually verify that the files exist, which
> might not necessarily be the case for some failure modes of `git apply
> --reject`. Let's not lose that.
> 
> Convert the `cat` calls to use `test_path_is_file` instead. This is of
> course still a minor change since we no longer verify that the files can
> be opened for reading, but that is not something we usually worry about.

This reasoning makes sense to me. Thanks for being careful in thinking
about possible ramifications of removing these otherwise useless-looking
cat statements.

This is and the other two patches all look good to me.

-Peff
