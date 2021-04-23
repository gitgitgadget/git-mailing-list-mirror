Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64367C43460
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 10:07:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21A21613D5
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 10:07:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241786AbhDWKIN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 06:08:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:33212 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229823AbhDWKIM (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 06:08:12 -0400
Received: (qmail 6218 invoked by uid 109); 23 Apr 2021 10:07:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 23 Apr 2021 10:07:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6762 invoked by uid 111); 23 Apr 2021 10:07:38 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 23 Apr 2021 06:07:38 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 23 Apr 2021 06:07:35 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] git: support separate arg for `--config-env`'s value
Message-ID: <YIKcZxEDsG7qsE4G@coredump.intra.peff.net>
References: <cover.1618847606.git.ps@pks.im>
 <d52db89bc2f40a9df5e9fafe4e1bb8c173a7f45f.1618847606.git.ps@pks.im>
 <874kg14490.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <874kg14490.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 20, 2021 at 12:52:43PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Mitigate this inconsistency by accepting both syntaxes and add tests to
> > verify both work.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> 
> This whole series LGTM.

Me too. Thanks for finding it (and Patrick for fixing it).

> > +		} else if (!strcmp(cmd, "--config-env")) {
> > +			if (*argc < 2) {
> > +				fprintf(stderr, _("no config key given for --config-env\n" ));
> 
> 
> I found this use of fprintf() slightly odd, why not error(), but then
> went back and read the function and saw that it has N number of
> "fprintf(stderr, [...])" already.
> 
> That could probably all be converted to error(), but better to be
> consistent for now.

Yep. Likewise the weird extra space at the end of the string.

-Peff
