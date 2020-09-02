Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25D84C433E2
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 08:04:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFDF72084C
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 08:04:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgIBIEg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 04:04:36 -0400
Received: from cloud.peff.net ([104.130.231.41]:47256 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBIEe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 04:04:34 -0400
Received: (qmail 32385 invoked by uid 109); 2 Sep 2020 08:04:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 02 Sep 2020 08:04:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4449 invoked by uid 111); 2 Sep 2020 08:04:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 02 Sep 2020 04:04:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 2 Sep 2020 04:04:32 -0400
From:   Jeff King <peff@peff.net>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philippe Blain via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH] Makefile: add support for generating JSON compilation
 database
Message-ID: <20200902080432.GB855335@coredump.intra.peff.net>
References: <pull.714.git.1598815707540.gitgitgadget@gmail.com>
 <20200830221004.GB241078@camp.crustytoothpaste.net>
 <xmqqsgc3h28s.fsf@gitster.c.googlers.com>
 <20200901073827.GA3967005@coredump.intra.peff.net>
 <20200902013351.GD241078@camp.crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200902013351.GD241078@camp.crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 02, 2020 at 01:33:51AM +0000, brian m. carlson wrote:

> Traditionally, editors had to learn about every language if they wanted
> to add special functionality like refactoring (e.g., renaming "struct
> foo" to "struct bar"), finding all the instances of a type, finding
> where a type or function was declared, or similar IDE features.  When
> Microsoft developed Visual Studio Code, they decided that they did not
> want to implement this functionality for every language under the sun,
> and instead developed the Language Server Protocol[0].
> [...]

Thanks for the explanation. I understand what LSP does, but the missing
link for me was how "here are the command-line flags to the compiler"
turned into something useful like "here's a list of identifiers". And
clangd fills in that gap (presumably re-running the front-end bits of
clang on the fly to pull out that kind of information).

-Peff
