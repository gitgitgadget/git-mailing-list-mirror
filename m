Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55000C3DA66
	for <git@archiver.kernel.org>; Fri, 25 Aug 2023 21:57:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229822AbjHYV5F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Aug 2023 17:57:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229798AbjHYV4e (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Aug 2023 17:56:34 -0400
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1412D46
        for <git@vger.kernel.org>; Fri, 25 Aug 2023 14:56:04 -0700 (PDT)
Received: (qmail 27541 invoked by uid 109); 25 Aug 2023 21:56:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Aug 2023 21:56:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2634 invoked by uid 111); 25 Aug 2023 21:56:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Aug 2023 17:56:04 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 25 Aug 2023 17:56:03 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] .github/workflows: add coverity action
Message-ID: <20230825215603.GA2400192@coredump.intra.peff.net>
References: <4590e1381feb8962cadf2b40b22086531d662ef8.1692675172.git.me@ttaylorr.com>
 <20230825213201.GD2382334@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230825213201.GD2382334@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 25, 2023 at 05:32:01PM -0400, Jeff King wrote:

> > Coverity's website provides a service accepts "builds" (which is more or
> > less the collection of '*.o' files generated during a standard build
> > with "make") as input and generates reports as output. In order to
> > generate a report, we have to first compile Git and then upload the
> > build archive to Coverity.
> 
> I don't think this is quite right. You run a build with their
> "cov-build" wrapper, which does some magic. It _does_ invoke the actual
> compiler, but does some extra magic, too (I don't know the details, but
> it is running cov-translate and cov-emit on the actual source file).
> 
> This maybe seems like nit-picking, but it will play into some questions
> I have on the patch itself.

I guess I never actually asked those questions, but they were: why are
you asking for some specific version of gcc since we don't really care
much about the actual compiler.

But I think you don't care about the compiler version; you were just
trying to feed enough data to install-dependencies to get it to run.

-Peff
