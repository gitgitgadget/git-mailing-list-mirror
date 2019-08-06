Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 281681F731
	for <e@80x24.org>; Tue,  6 Aug 2019 18:10:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731696AbfHFSKq (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Aug 2019 14:10:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:35856 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728756AbfHFSKp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Aug 2019 14:10:45 -0400
Received: (qmail 21188 invoked by uid 109); 6 Aug 2019 18:10:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 06 Aug 2019 18:10:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4814 invoked by uid 111); 6 Aug 2019 18:13:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 06 Aug 2019 14:13:06 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 6 Aug 2019 14:10:44 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        git@vger.kernel.org, Jiang Xin <worldhello.net@gmail.com>
Subject: Re: [PATCH v3] l10n: reformat some localized strings for v2.23.0
Message-ID: <20190806181044.GA7005@sigill.intra.peff.net>
References: <20190730033512.7226-1-worldhello.net@gmail.com>
 <20190806171952.15588-1-jn.avila@free.fr>
 <xmqqo912ji1k.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqo912ji1k.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 06, 2019 at 10:54:47AM -0700, Junio C Hamano wrote:

> Jean-Noël Avila <jn.avila@free.fr> writes:
> 
> > Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
> > ---
> >  builtin/checkout.c |  2 +-
> >  builtin/fetch.c    | 15 +++++++++++----
> >  2 files changed, 12 insertions(+), 5 deletions(-)
> 
> Thanks.  Folks, does this look sensible (it does to me)?

Yes, modulo a funny indent in the final hunk (git-am will complain about
it).

I think we can take this as-is, but I did notice one thing when I
actually looked carefully at the surrounding code...

> >  	if (advice_fetch_show_forced_updates) {
> >  		if (!fetch_show_forced_updates) {
> > -			warning(_("Fetch normally indicates which branches had a forced update, but that check has been disabled."));
> > -			warning(_("To re-enable, use '--show-forced-updates' flag or run 'git config fetch.showForcedUpdates true'."));
> > +                  warning(_(warn_show_forced_updates));

This is controlled by advice.fetchShowForcedUpdates. Should these
warning() calls actually be advise()? In which case everything I said
about newlines and prefixes would then just work out, because advise()
does prefix each line independently. I'm happy to punt on that until
post-release, though, in the name of calming things down rather than
stirring them up. :)

-Peff
