Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14D0CC433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 21:11:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F095061355
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 21:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229602AbhJSVOD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:14:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:41948 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229483AbhJSVOC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 17:14:02 -0400
Received: (qmail 7416 invoked by uid 109); 19 Oct 2021 21:11:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Oct 2021 21:11:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15254 invoked by uid 111); 19 Oct 2021 21:11:48 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Oct 2021 17:11:48 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 19 Oct 2021 17:11:47 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH] git config doc: fix recent ASCIIDOC formatting regresison
Message-ID: <YW80k4kCPG6VJfW/@coredump.intra.peff.net>
References: <20211008091614.732584-3-bagasdotme@gmail.com>
 <patch-1.1-36700e581d2-20211019T123057Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <patch-1.1-36700e581d2-20211019T123057Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 19, 2021 at 02:31:34PM +0200, Ævar Arnfjörð Bjarmason wrote:

> Fix a regression in 8c328561332 (blame: document --color-* options,
> 2021-10-08), which added an extra newline before the "+" syntax.

Thanks, this looks like an obviously correct fix. I think asciidoc's
pickiness around "+" has bitten us before. Asciidoctor is more lenient
here, and the rendered result looks the same before and after your
patch, but we should definitely make it look good in both.

> The "Documentation/doc-diff HEAD~ HEAD" output with this applied is:

I just want to call this out not only as a good way to review this
patch, but a great way in general to review any patches which touch
documentation. Running:

  doc-diff 8c328561332^ 8c328561332

shows the original problem pretty clearly.

>  Documentation/config/color.txt | 2 --
>  1 file changed, 2 deletions(-)

Patch looks good. There's a small typo in the subject:

> Subject: [PATCH] git config doc: fix recent ASCIIDOC formatting regresison

s/regresison/regression/

-Peff
