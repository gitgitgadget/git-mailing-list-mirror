Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C5EC2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 22:33:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6474420679
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 22:33:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730087AbgKIWdb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 17:33:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:52026 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729336AbgKIWdb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Nov 2020 17:33:31 -0500
Received: (qmail 4719 invoked by uid 109); 9 Nov 2020 22:33:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 09 Nov 2020 22:33:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28167 invoked by uid 111); 9 Nov 2020 22:33:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 09 Nov 2020 17:33:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 9 Nov 2020 17:33:30 -0500
From:   Jeff King <peff@peff.net>
To:     Patrick Steinhardt <ps@pks.im>
Cc:     git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 0/4] update-ref: Allow creation of multiple
 transactions
Message-ID: <20201109223330.GC670413@coredump.intra.peff.net>
References: <cover.1604501265.git.ps@pks.im>
 <cover.1604908834.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1604908834.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 09, 2020 at 11:06:43AM +0100, Patrick Steinhardt wrote:

> this is the second version of this patch series implementing support for
> creation of multiple reference transactions in a single git-update-ref
> process.
> 
> There's two changes compared to v1:
> 
>     - A small refactoring of t1400, which refactors many tests to not
>       touch references via the filesystem but instead to use
>       git-update-ref and git-show-ref. There's still tests in there
>       which do, but converting them is harder as they create and read
>       broken references.
> 
>     - I've added another commit on top which disallows restarting of
>       transactions. E.g. writing "start\nstart\n" to git-update-ref is
>       now going to fail.

Thanks. Aside from the issues raised by Junio, this all looks good to me
(and I agree on the fourth one it is just a matter of the commit
message; what the code is doing is a definite improvement).

-Peff
