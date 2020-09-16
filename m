Return-Path: <SRS0=vH5l=CZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F2DC433E2
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:57:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B92EF20732
	for <git@archiver.kernel.org>; Wed, 16 Sep 2020 18:57:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727994AbgIPS5i (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Sep 2020 14:57:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:58762 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727725AbgIPS5g (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Sep 2020 14:57:36 -0400
Received: (qmail 25896 invoked by uid 109); 16 Sep 2020 18:57:33 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 16 Sep 2020 18:57:33 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 31337 invoked by uid 111); 16 Sep 2020 18:57:33 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 16 Sep 2020 14:57:33 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 16 Sep 2020 14:57:32 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Antoine =?utf-8?Q?Beaupr=C3=A9?= <anarcat@debian.org>,
        Simon Legner <Simon.Legner@gmail.com>
Subject: Re: [PATCH 00/15] remote-mediawiki: various fixes to make tests pass
Message-ID: <20200916185732.GE33925@coredump.intra.peff.net>
References: <20200916102918.29805-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200916102918.29805-1-avarab@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 16, 2020 at 12:29:03PM +0200, Ævar Arnfjörð Bjarmason wrote:

> I had occasion to look at remote-mediawiki and I couldn't even get the
> test suite to run. The patches below have more detail but there's
> issues like a hard error on any Perl release newer than ones released
> in 2013, and the MediaWiki release it tries to use spewing errors on
> any modern PHP version.
> 
> This series fixes these issues. With it applied it's possible to run
> the tests, and they all pass.

These all look reasonable. I left a few minor comments, but frankly, I
care little enough about this clearly unmaintained bit of contrib/ that
I would be happy either way.

I am a little puzzled about what we want the future of contrib/mw-to-git
to be. It sounds like there have been a few minor improvements in the
external GitHub project (though clearly lacking a bunch of fixes you
have here). Should we be pushing these fixes up to that version and then
either:

  - considering that project the upstream, and reimporting from them
    once the fixes are merged there

  - ejecting it from contrib/; it can live on as a separate project

-Peff
