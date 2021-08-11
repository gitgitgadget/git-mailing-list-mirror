Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1BAAC4338F
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 23:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7CF7D61058
	for <git@archiver.kernel.org>; Wed, 11 Aug 2021 23:12:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbhHKXNU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Aug 2021 19:13:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:44878 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232684AbhHKXNT (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Aug 2021 19:13:19 -0400
Received: (qmail 23795 invoked by uid 109); 11 Aug 2021 23:12:55 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Aug 2021 23:12:55 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16119 invoked by uid 111); 11 Aug 2021 23:12:56 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Aug 2021 19:12:56 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 11 Aug 2021 19:12:54 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?Q?Du=C5=A1an_=C4=8Cervenka?= | ACRIOS 
        <cervenka@acrios.com>
Cc:     git@vger.kernel.org
Subject: Re: Git merge improvement - "remove spaces/tabs from beginning of
 line and end of line"
Message-ID: <YRRZdmlfBjJTUimj@coredump.intra.peff.net>
References: <2632907.cDO7J6XS3R@kuhadatko-gl552vw>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2632907.cDO7J6XS3R@kuhadatko-gl552vw>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 11, 2021 at 12:25:10AM +0200, Dušan Červenka | ACRIOS wrote:

> Several times it happened that i added or removed condition in code but a lot 
> of code stayed. Only indention was changed. If there was also other change on 
> some line i had a conflict. And several times it happened that a lot of code 
> was appended instead of replaced (if some line was similar with same 
> indention). This made merging messed and confusing. If we would remove this 
> spaces noise from beginning and end, we could get more acquired merge. What do 
> you think? Of course this is only for looking for most matching lines. At the 
> end the code should keep all necessary spaces.

Have you looked at the whitespace options you can pass to the
merge-recursive strategy?  E.g.:

  git merge -Xignore-space-at-eol some-branch

It may not do quite what you want, though (it sounds like you are more
interested in matching context with whitespace changes than ignoring
spaces on modified lines).

-Peff
