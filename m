Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1783AC433EF
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 07:05:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E80246126A
	for <git@archiver.kernel.org>; Mon,  4 Oct 2021 07:05:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbhJDHHH (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Oct 2021 03:07:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:60190 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhJDHHA (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Oct 2021 03:07:00 -0400
Received: (qmail 8191 invoked by uid 109); 4 Oct 2021 07:05:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 04 Oct 2021 07:05:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11657 invoked by uid 111); 4 Oct 2021 07:05:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 04 Oct 2021 03:05:08 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 4 Oct 2021 03:05:08 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] object-name tests: tighten up advise() output test
Message-ID: <YVqnpNQf3P5+WOMG@coredump.intra.peff.net>
References: <cover-0.2-00000000000-20211004T013611Z-avarab@gmail.com>
 <patch-1.2-7085f951a12-20211004T013611Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.2-7085f951a12-20211004T013611Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Oct 04, 2021 at 03:42:48AM +0200, Ævar Arnfjörð Bjarmason wrote:

> Change tests added in 1ffa26c4614 (get_short_sha1: list ambiguous
> objects on error, 2016-09-26) to only care about the OIDs that are
> listed, which is what the test is trying to check for.
> 
> This isn't needed by the subsequent commit, which won't change any of
> the output, but a mere tightening of the tests assertions to more
> closely match what we really want to test for here.

I think the next commit does change the output. It adds an extra empty
line which would cause these tests to fail.

> Now if the advise() message itself were change the phrasing around the
> list of OIDs we won't have this test break. We're assuming that such
> output won't have a need to indent anything except the OIDs.

It feels like we're trading one assumption for another. :)

I admit that don't care much either way, though.

-Peff
