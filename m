Return-Path: <SRS0=lIKx=5L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED50C43331
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BED3120714
	for <git@archiver.kernel.org>; Thu, 26 Mar 2020 08:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726318AbgCZIu5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Mar 2020 04:50:57 -0400
Received: from cloud.peff.net ([104.130.231.41]:51978 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726210AbgCZIu5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Mar 2020 04:50:57 -0400
Received: (qmail 1702 invoked by uid 109); 26 Mar 2020 08:50:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 26 Mar 2020 08:50:57 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12486 invoked by uid 111); 26 Mar 2020 09:00:51 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Mar 2020 05:00:51 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Mar 2020 04:50:56 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 5/5] tests: increase the verbosity of the GPG-related
 prereqs
Message-ID: <20200326085056.GF2200716@coredump.intra.peff.net>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
 <pull.728.v2.git.git.1585114881.gitgitgadget@gmail.com>
 <5e89b512513af0e2e16dc93c86ae3d1145061a82.1585114881.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5e89b512513af0e2e16dc93c86ae3d1145061a82.1585114881.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 25, 2020 at 05:41:21AM +0000, Johannes Schindelin via GitGitGadget wrote:

> Let's fix this by no longer redirecting the output not to `/dev/null`.
> This is now possible because the affected prereqs were turned into lazy
> ones (and are therefore evaluated via `test_eval_` which respects the
> `--verbose` option).
> 
> Note that we _still_ redirect `stdout` to `/dev/null` for those commands
> that sign their `stdin`, as the output would be binary (and useless
> anyway, because the reader would not have anything against which to
> compare the output).

This looks good. You could drop the redirection of stdin in one case,
too (since test_eval_ already does so) but I don't mind leaving it as
documentation.

-Peff
