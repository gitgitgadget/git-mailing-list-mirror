Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 751B3C433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 10:45:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 404706525D
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 10:45:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229878AbhCIKoo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 05:44:44 -0500
Received: from cloud.peff.net ([104.130.231.41]:56798 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230183AbhCIKoX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 05:44:23 -0500
Received: (qmail 30101 invoked by uid 109); 9 Mar 2021 10:44:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 09 Mar 2021 10:44:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9299 invoked by uid 111); 9 Mar 2021 10:44:25 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 09 Mar 2021 05:44:25 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 9 Mar 2021 05:44:22 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 6/7] object tests: add test for unexpected objects in tags
Message-ID: <YEdRhulqevMjlrLc@coredump.intra.peff.net>
References: <Pine.LNX.4.21.0506212033590.30848-100000@iabervon.org>
 <20210308200426.21824-7-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210308200426.21824-7-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 08, 2021 at 09:04:25PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Fix a blind spot in the tests added in 0616617c7e1 (t: introduce tests
> for unexpected object types, 2019-04-09), there were no meaningful
> tests for checking how we reported on finding the incorrect object
> type in a tag, i.e. one that broke the "type" promise in the tag
> header.

Isn't this covered by tests 16 and 17 ("traverse unexpected non-commit
tag", both "lone" and "seen")? And likewise the matching "non-tree" and
"non-blob" variants afterwards?

The only thing we don't seem to cover is an unexpected non-tag. I don't
mind adding that, but why wouldn't we just follow the template of the
existing tests?

-Peff
