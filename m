Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A0D6C433ED
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 14:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 564A3613C6
	for <git@archiver.kernel.org>; Tue,  6 Apr 2021 14:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345094AbhDFOyW (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Apr 2021 10:54:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:42610 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239488AbhDFOyS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Apr 2021 10:54:18 -0400
Received: (qmail 7591 invoked by uid 109); 6 Apr 2021 14:54:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 06 Apr 2021 14:54:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29250 invoked by uid 111); 6 Apr 2021 14:54:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Apr 2021 10:54:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Apr 2021 10:54:08 -0400
From:   Jeff King <peff@peff.net>
To:     Andrey Bienkowski <hexagonrecursion@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: Subject: Encoding of git diff --name-only stdout
Message-ID: <YGx2EMHnwXWbp4ET@coredump.intra.peff.net>
References: <CAAunPhfjUSO0Po4sO7Hwxjq7_p0ke7VOD=XRizG1Fqkzymcgmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAunPhfjUSO0Po4sO7Hwxjq7_p0ke7VOD=XRizG1Fqkzymcgmg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 06, 2021 at 12:20:45PM +0000, Andrey Bienkowski wrote:

> Hi. I want to parse the output of git diff --name-only and git diff
> --name-status, but the documentation https://git-scm.com/docs/git-diff
> does not say what encoding it is in. Is it always utf8 on all
> platforms? If not is there a flag to make it so? Once I get an answer
> to this question I'll submit a PR to add the missing documentation.

There's some discussion in Documentation/i18n.txt, which is included in
various manpages (e.g., https://git-scm.com/docs/git-log#_discussion)
but it doesn't seem to be mentioned in git-diff.

The short answer is: mostly utf8, but historically on platforms that
don't care (like Linux) you could get away with other encodings.

-Peff
