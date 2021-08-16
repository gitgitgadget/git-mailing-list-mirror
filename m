Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F425C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 16:19:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBC1C60F58
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 16:19:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbhHPQUW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:20:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:48518 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229556AbhHPQUW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Aug 2021 12:20:22 -0400
Received: (qmail 20071 invoked by uid 109); 16 Aug 2021 16:19:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 16 Aug 2021 16:19:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15691 invoked by uid 111); 16 Aug 2021 16:19:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 16 Aug 2021 12:19:49 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 16 Aug 2021 12:19:49 -0400
From:   Jeff King <peff@peff.net>
To:     Konstantin Ryabitsev <konstantin@linuxfoundation.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ben Goldberg <ben@benaaron.dev>, git@vger.kernel.org
Subject: Re: send-email issue
Message-ID: <YRqQJTyBW6j6b2pW@coredump.intra.peff.net>
References: <24a88faf-5339-8449-80c4-f6085bd1e098@benaaron.dev>
 <b4b1dda4-6bf7-f4b1-88c5-9d579a7c56d3@benaaron.dev>
 <20210813180056.ctzivmakj4bj5apa@nitro.local>
 <xmqq35rbtx84.fsf@gitster.g>
 <20210816131143.6ifcbpxp6ilo2nv5@nitro.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210816131143.6ifcbpxp6ilo2nv5@nitro.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 16, 2021 at 09:11:43AM -0400, Konstantin Ryabitsev wrote:

> > I do not think it is feasible to immediately rename the two choices
> > to SSL/TLS vs StartTLS without transition period, but the first
> > patch in the three-patch series there to update the documentation
> > alone may have helped this case.
> > 
> > We may also want to error out when seeing an unknown option other
> > than 'ssl' and 'tls', as the necessary first step to make it
> > possible to later safely accept StartTLS as a synonym for 'tls' and
> > 'ssl/tls' as a synonym for 'ssl'.
> 
> Is it easier to just add less ambiguous aliases, eventually phasing out old
> terminology?
> 
> tls -> starttls
> ssl -> smtps
> 
> This way we don't have to change anything, and "smtps" is a valid way to refer
> to smtp over ssl (e.g. see /etc/services for 465/tcp).

FWIW, those options make quite a bit of sense to me (and I agree the
transition to them would be easy).

-Peff
