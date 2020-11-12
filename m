Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C162C2D0E4
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 18:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AFB5922228
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 18:42:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726416AbgKLSmb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 13:42:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:56230 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726303AbgKLSmb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 13:42:31 -0500
Received: (qmail 21717 invoked by uid 109); 12 Nov 2020 18:42:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 12 Nov 2020 18:42:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 444 invoked by uid 111); 12 Nov 2020 18:42:30 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 12 Nov 2020 13:42:30 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 12 Nov 2020 13:42:30 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: [PATCH 0/5] Remove now-unused git-parse-remote
Message-ID: <20201112184230.GC701197@coredump.intra.peff.net>
References: <CAGZ79kb57HzJQ4VLFD_NMKvEnriPVXoAAPimg6BG_Z+PPjJ4aQ@mail.gmail.com>
 <20201111151754.31527-1-avarab@gmail.com>
 <20201111173738.GB9902@coredump.intra.peff.net>
 <87a6vmhdka.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87a6vmhdka.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Nov 12, 2020 at 03:09:25PM +0100, Ævar Arnfjörð Bjarmason wrote:

> > To be clear, I find it pretty unlikely that anybody is using the rather
> > esoteric functions in this file, but that's usually when I get most
> > surprised. :)
> 
> I think it's fine to just remove it, I'll note that in a v2 commit
> message. I.e. the convention at the time was just to create these *.sh
> libraries as documented, but I don't think anyone used them outside of
> git.git.

OK. I'm fine with that interpretation as long as we are doing it
consciously. It might be worth noting in the release notes (not only the
removal here, but our general attitude towards these shell libraries).

> If they did maybe we should move them to contrib and ... create the same
> bitrot as with the *.sh builtins :)

Please no. :)

> > I expected to see a "delete" line for git-parse-remote.sh here. I
> > thought at first maybe you were leaving the empty shell so that people
> > could continue to source it (keeping the promise in the manpage, but not
> > providing any actual functions). But it looks like the final patch stops
> > building it at all, leaving the now-useless source file.
> 
> That was just a mistake on my part, I meant to "git rm" it but
> forgot. Will fix it v2.

Makes sense.

-Peff
