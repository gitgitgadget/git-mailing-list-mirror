Return-Path: <SRS0=BxWL=AF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB178C433DF
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 15:48:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D684C2088E
	for <git@archiver.kernel.org>; Wed, 24 Jun 2020 15:48:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403931AbgFXPs6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Jun 2020 11:48:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:41936 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404253AbgFXPsy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Jun 2020 11:48:54 -0400
Received: (qmail 21294 invoked by uid 109); 24 Jun 2020 15:48:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 24 Jun 2020 15:48:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30425 invoked by uid 111); 24 Jun 2020 15:48:54 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 24 Jun 2020 11:48:54 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 24 Jun 2020 11:48:53 -0400
From:   Jeff King <peff@peff.net>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 09/10] fast-export: allow seeding the anonymized mapping
Message-ID: <20200624154853.GB2088459@coredump.intra.peff.net>
References: <20200623152436.GA50925@coredump.intra.peff.net>
 <20200623152505.GI1435482@coredump.intra.peff.net>
 <CAPig+cQ1EGR6_8NJ+U3MQEseU1yT9k_AwdL8Mg7qZAB8Ev4y3g@mail.gmail.com>
 <20200623183525.GB1444619@coredump.intra.peff.net>
 <CAPig+cTBwZJnUYqeEjXp-hAOjHb783B+9kyy+h+HtiOTy_c_hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cTBwZJnUYqeEjXp-hAOjHb783B+9kyy+h+HtiOTy_c_hg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 23, 2020 at 04:35:37PM -0400, Eric Sunshine wrote:

> > I wrestled with the name, and I agree "seed" is overly technical. And I
> > came up with many similar variations of "anonymize-to", but they all
> > seemed ambiguous (e.g., it could be "to" a file that we're storing the
> > data in).
> >
> > Perhaps "--anonymize-map" would be less technical?
> 
> That's not too bad. It is better than --seed-anonymized. I haven't
> come up with any name which improves upon it.

I went with that in my reroll, and avoided using the word "seed" at all
in the documentation (I did keep the name "anonymized_seeds" as the
internal variable name for the hashmap, since just calling it "map"
there is ambiguous with all of the other maps).

-Peff
