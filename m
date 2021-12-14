Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFE96C433EF
	for <git@archiver.kernel.org>; Tue, 14 Dec 2021 13:40:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234494AbhLNNkw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Dec 2021 08:40:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:51448 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234480AbhLNNkv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Dec 2021 08:40:51 -0500
Received: (qmail 13698 invoked by uid 109); 14 Dec 2021 13:40:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Dec 2021 13:40:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24589 invoked by uid 111); 14 Dec 2021 13:40:50 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Dec 2021 08:40:50 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Dec 2021 08:40:50 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC PATCH v2 3/5] linear-assignment.c: take "size_t", not "int"
 for *_count
Message-ID: <Ybie4nePnPtFLRHa@coredump.intra.peff.net>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
 <RFC-cover-v2-0.5-00000000000-20211210T122901Z-avarab@gmail.com>
 <RFC-patch-v2-3.5-580b76c0759-20211210T122901Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <RFC-patch-v2-3.5-580b76c0759-20211210T122901Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 10, 2021 at 01:30:40PM +0100, Ævar Arnfjörð Bjarmason wrote:

> Future-proof and clarify the compute_assignment() interface by having
> it take a "size_t" for the count of its that it's processing. For the
> content itself we need to be able to store a "-1", but there's no
> reason we can't use a "size_t" for the size of the number of "int"'s
> we've got.

Makes sense. I'm happy to see the counts dealt with independently here,
and the reasoning that we can use a straight size_t. The earlier
refactoring is paying off a bit, though I think it would be possible
without it.

-Peff
