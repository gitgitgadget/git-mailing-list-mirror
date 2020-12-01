Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84D1C64E7A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 11:54:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F0742080A
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 11:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389461AbgLALyx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 06:54:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:47114 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389439AbgLALyx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 06:54:53 -0500
Received: (qmail 26175 invoked by uid 109); 1 Dec 2020 11:54:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 01 Dec 2020 11:54:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25931 invoked by uid 111); 1 Dec 2020 11:54:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 01 Dec 2020 06:54:12 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 1 Dec 2020 06:54:12 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] MaintNotes: use https:// instead of git:// when possible
Message-ID: <X8Yu5CephK3uvMeV@coredump.intra.peff.net>
References: <20201201094623.4290-1-avarab@gmail.com>
 <20201201095815.12850-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20201201095815.12850-1-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 01, 2020 at 10:58:15AM +0100, Ævar Arnfjörð Bjarmason wrote:

> Change advertised git:// links to https://. These all work as
> arguments to "git clone", but in addition they also have friendly web
> interfaces.

This is a good idea, I think. Not only for that reason, but because
https:// is more secure. You can verify tags from the maintainer's
signature, of course, but if you are just fetching some refs, you are
relying on the remote server not to lie to you. With https://, you at
least have some assurance that it is the remote server you intended to
talk to, and not a man-in-the-middle over the totally unauthenticated
git:// protocol.

> This leaves just git://ozlabs.org/~paulus/gitk as the only git://
> URL. As far as I can tell there's no web interface for it. There is
> e.g. https://git.ozlabs.org/?p=ppp.git which is a frontend for
> git://git.ozlabs.org/~paulus/ppp.git, but even though cloning the repo
> at git://git.ozlabs.org/~paulus/gitk.git works (not the "git" subdomain)

s/not/note/ in this last line?

-Peff
