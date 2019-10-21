Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF8511F4C0
	for <e@80x24.org>; Mon, 21 Oct 2019 19:54:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730202AbfJUTyO (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 Oct 2019 15:54:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:54184 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1730192AbfJUTyO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Oct 2019 15:54:14 -0400
Received: (qmail 20041 invoked by uid 109); 21 Oct 2019 19:54:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 21 Oct 2019 19:54:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9991 invoked by uid 111); 21 Oct 2019 19:57:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 21 Oct 2019 15:57:20 -0400
Authentication-Results: peff.net; auth=none
Date:   Mon, 21 Oct 2019 15:54:13 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [RFC PATCH 1/7] Makefile: alphabetically sort += lists
Message-ID: <20191021195413.GB3959@sigill.intra.peff.net>
References: <cover.1571246693.git.liu.denton@gmail.com>
 <02a16f9bdf740841d9a4be765e72b9fa5ae5d75c.1571246693.git.liu.denton@gmail.com>
 <xmqqimon6yar.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910212043200.46@tvgsbejvaqbjf.bet>
 <xmqqblu9lw00.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqblu9lw00.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 22, 2019 at 04:49:19AM +0900, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> ... I do not particularly see this change (there may be similar
> >> ones) desirable.  I'd find it it be much more natural to sort
> >> "commit-anything" after "commit", and that is true with or without
> >> the common extension ".o" added to these entries.
> >>
> >> In short, flipping these entries because '.' sorts later than '-' is
> >> making the result look "less sorted", at least to me.
> >
> > The problem with this argument is that it disagrees with ASCII, as `-`
> > has code 0x2d while `.` has code 0x2e, i.e. it is lexicographically
> > _larger_.
> 
> I am saying that sorting these in ASCII order did not produce result
> that is easy to the eyes.
> 
> You are saying that Denton's patch sorted these lines in ASCII order.
> 
> I agree with you that it did correctly sort them in ASCII order.
> 
> That does not make the patch right ;-)

What's the purpose of sorting them, though? I thought it was less for
aesthetics and more to to keep lines deterministic (to avoid two
branches adding the same line in different places, thus causing
weirdness when the two are merged). In that case, I think we care less
about the exact order and more that anybody can easily reproduce the
same sort (by running "10:!sort" or whatever you weird emacs-types would
type).

-Peff
