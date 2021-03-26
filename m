Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFA3C433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 11:05:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 233E461A14
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 11:05:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229622AbhCZLEx (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 07:04:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:49778 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229589AbhCZLEh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 07:04:37 -0400
Received: (qmail 32175 invoked by uid 109); 26 Mar 2021 11:04:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Mar 2021 11:04:37 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4704 invoked by uid 111); 26 Mar 2021 11:04:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Mar 2021 07:04:36 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Mar 2021 07:04:36 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] doc lint: lint and fix missing "GIT" end sections
Message-ID: <YF2/xPMvwhm+OOVz@coredump.intra.peff.net>
References: <cover-0.6-00000000000-20210326T103454Z-avarab@gmail.com>
 <patch-5.6-d4004b6a7cb-20210326T103454Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-5.6-d4004b6a7cb-20210326T103454Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 26, 2021 at 11:36:50AM +0100, Ævar Arnfjörð Bjarmason wrote:

> Lint for and fix the three manual pages that were missing the standard
> "Part of the linkgit:git[1] suite" end section.

This is a definite improvement. Two thoughts come to mind, though:

  1. Do we need a separate script for this? Couldn't the existing linter
     script check this while it is reading all of the files (it knows
     which ones are supposed to be manpages because they are annotated
     with the --section option). That would be more efficient, and
     probably a little less code.

  2. Instead of linting, could we just be automatically sticking this
     boilerplate in as part of the build (either through some asciidoc
     magic, or even just a plain old "cat")? Even better than being
     reminded that you forgot something is making it impossible to
     forget it in the first place.

-Peff
