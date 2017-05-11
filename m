Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01E671FF34
	for <e@80x24.org>; Thu, 11 May 2017 07:56:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755137AbdEKH41 (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 May 2017 03:56:27 -0400
Received: from cloud.peff.net ([104.130.231.41]:49191 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754536AbdEKH40 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2017 03:56:26 -0400
Received: (qmail 28573 invoked by uid 109); 11 May 2017 07:56:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 07:56:26 +0000
Received: (qmail 9974 invoked by uid 111); 11 May 2017 07:56:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 11 May 2017 03:56:57 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 11 May 2017 03:56:24 -0400
Date:   Thu, 11 May 2017 03:56:24 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Sebastian Schuberth <sschuberth@gmail.com>,
        Raphael Stolt <raphael.stolt@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: Possible bug in includeIf / conditional includes
Message-ID: <20170511075624.572rujfaedzihpn4@sigill.intra.peff.net>
References: <C1ACB28C-F1B4-42A1-8135-797DEFD9F03C@gmail.com>
 <b80c68fa-fe1e-3cf8-3c7e-527a4d941108@gmail.com>
 <CACBZZX7CgeW1OK+g9Mbir62MMaCx4sHFZngUuWz_H241Sb355g@mail.gmail.com>
 <20170511062616.f7rg6f5cgrqeh7gf@sigill.intra.peff.net>
 <20170511062924.6euaynsbyocjcw3q@sigill.intra.peff.net>
 <CACBZZX4ob04fG9ZZtvbdcqrYOKijoZohVdUCNyeayHZtdtNyxQ@mail.gmail.com>
 <20170511074257.xueofze3dv3xwrql@sigill.intra.peff.net>
 <xmqqbmqzbzh0.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqbmqzbzh0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 11, 2017 at 12:54:19AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Thu, May 11, 2017 at 09:19:50AM +0200, Ævar Arnfjörð Bjarmason wrote:
> >
> >> 1. It says "The included file is expanded immediately, as if its
> >> contents had been found at the location of the include directive.". At
> >> first I thought this referred to glob expansion, not
> >> s/expanded/interpolated/, the example section uses "expand" in the
> >> context of pathnames, which caused the confusion.
> >
> > Perhaps it should say "The contents of the included file are expanded
> > immediately, as if they had been found at..."?
> 
> Or s/expanded/inserted/, perhaps?  The word "expand" does not quite
> click to me in this context.  Just like Ævar, I associate the word
> with an act of replacing some template-with-blank with the result of
> blanks-in-the-template-filled.

Yeah, that is much better. I think "expand" here originally meant "read
the contents of", but when we talk about the contents already there is
nothing left to expand.

I agree "inserted" is probably the right word (or even just "read" or
"parsed" or something).

-Peff
