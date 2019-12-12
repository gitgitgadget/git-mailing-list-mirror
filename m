Return-Path: <SRS0=AaZj=2C=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EB9C43603
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 03:49:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D59092173E
	for <git@archiver.kernel.org>; Thu, 12 Dec 2019 03:49:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727767AbfLLDt2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 22:49:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:44722 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727589AbfLLDt2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 22:49:28 -0500
Received: (qmail 9676 invoked by uid 109); 12 Dec 2019 03:49:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 12 Dec 2019 03:49:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11138 invoked by uid 111); 12 Dec 2019 03:53:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Dec 2019 22:53:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Dec 2019 22:49:27 -0500
From:   Jeff King <peff@peff.net>
To:     mattr94@gmail.com
Cc:     Junio C Hamano <gitster@pobox.com>,
        'Emily Shaffer' <emilyshaffer@google.com>, git@vger.kernel.org,
        'Philip Oakley' <philipoakley@iee.email>
Subject: Re: [PATCH v2] config: add string mapping for enum config_scope
Message-ID: <20191212034927.GA1200720@coredump.intra.peff.net>
References: <20191211233820.185153-1-emilyshaffer@google.com>
 <20191212031003.GA1196215@coredump.intra.peff.net>
 <1062901d5b09d$eafbc420$c0f34c60$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1062901d5b09d$eafbc420$c0f34c60$@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 11, 2019 at 10:40:37PM -0500, mattr94@gmail.com wrote:

> Just to mention, that I am working on submitting a feature to expand
> config with a --show-scope option via gitgitgadget.

That makes sense (hopefully it can be combined with --show-origin, too,
to get all of the information).

> I still have some kinks to iron out before it's ready for submission,
> but maybe it would make sense to wait for that? Or to wait for the
> rest of the patches this was taken from to actually materialize?

In general, yes, I think it makes sense for a patch like this to come as
part of a larger topic, that all gets merged at once. That way we don't
end up with unused cruft.

It sounds like the issue is that there are two topics that use this.
The simplest thing may be to have a common topic branch that both build
on, but with a note never to merge it directly (that last part would be
done by Junio, but the submitter would want to give that guidance along
with the patch).

I _think_ that would be easy to handle with the way Junio handles the
topics, but he may correct me.

-Peff
