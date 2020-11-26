Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65107C56202
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 08:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 208B120B80
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 08:21:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgKZIUx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 03:20:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:43548 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727130AbgKZIUw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 03:20:52 -0500
Received: (qmail 15755 invoked by uid 109); 26 Nov 2020 08:20:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 26 Nov 2020 08:20:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14680 invoked by uid 111); 26 Nov 2020 08:20:52 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 26 Nov 2020 03:20:52 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 26 Nov 2020 03:20:51 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC/PATCH 09/12] mktag: remove now-unused verify_tag() code
Message-ID: <X79lY/bPW8O1itjF@coredump.intra.peff.net>
References: <X7wq3ba3QoxjyyrQ@coredump.intra.peff.net>
 <20201126012854.399-10-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201126012854.399-10-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 26, 2020 at 02:28:51AM +0100, Ævar Arnfjörð Bjarmason wrote:

> The preceding commit removed the use of the verify_tag() function, but
> didn't remove this code to keep the diff smaller. Let's remove this
> unused code now.

I do appreciate keeping diffs readable, but IMHO this is making things
more confusing, because you had to add a new dummy call to verify_tag()
in the previous commit in order to keep the compiler from complaining
about the unused static function (I'm actually surprised that it doesn't
complain about the immediate "return 0" in that function, which makes
the rest of the function unambiguously unreachable).

-Peff
