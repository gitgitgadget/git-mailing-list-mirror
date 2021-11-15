Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03C7EC433F5
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 01:13:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DAF8861104
	for <git@archiver.kernel.org>; Tue, 16 Nov 2021 01:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377534AbhKPBQE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Nov 2021 20:16:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:59252 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243861AbhKOTMm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Nov 2021 14:12:42 -0500
Received: (qmail 13785 invoked by uid 109); 15 Nov 2021 19:09:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 15 Nov 2021 19:09:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16783 invoked by uid 111); 15 Nov 2021 19:09:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 15 Nov 2021 14:09:43 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 15 Nov 2021 14:09:42 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Teng Long <dyroneteng@gmail.com>, git@vger.kernel.org,
        gitster@pobox.com
Subject: Re: [PATCH 0/3] support `--oid-only` in `ls-tree`
Message-ID: <YZKwduZgH4BEpFzd@coredump.intra.peff.net>
References: <20211115115153.48307-1-dyroneteng@gmail.com>
 <211115.86mtm5saz7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211115.86mtm5saz7.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 15, 2021 at 04:13:24PM +0100, Ævar Arnfjörð Bjarmason wrote:

> But I'd much rather see this be done with adding strbuf_expand() to
> ls-tree. I.e. its docs say that it can emit:

I had a similar thought, but that's a much bigger task. I think it would
be reasonable to add --oid-only to match the existing --name-only, etc.
If we later add a custom --format option, then it can easily be folded
in and explained as "this is an alias for --format=%(objectname)", just
like --name-only would become "this is an alias for --format=%(path)".

-Peff
