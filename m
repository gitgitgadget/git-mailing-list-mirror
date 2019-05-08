Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2EAF1F488
	for <e@80x24.org>; Wed,  8 May 2019 22:25:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbfEHWZF (ORCPT <rfc822;e@80x24.org>);
        Wed, 8 May 2019 18:25:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:52508 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726700AbfEHWZE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 May 2019 18:25:04 -0400
Received: (qmail 4059 invoked by uid 109); 8 May 2019 22:25:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 08 May 2019 22:25:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28680 invoked by uid 111); 8 May 2019 22:25:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 08 May 2019 18:25:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 May 2019 18:25:02 -0400
Date:   Wed, 8 May 2019 18:25:02 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Eric Wong <e@80x24.org>,
        git@vger.kernel.org,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3] repack: enable bitmaps by default on bare repos
Message-ID: <20190508222502.GA19990@sigill.intra.peff.net>
References: <20190314091254.nescpfp3n6mbjpmh@dcvr>
 <87zhoz8b9o.fsf@evledraar.gmail.com>
 <20190410225721.GA32262@sigill.intra.peff.net>
 <xmqq1s1qy2ox.fsf@gitster-ct.c.googlers.com>
 <20190504013713.GC17551@sigill.intra.peff.net>
 <87a7g2iuem.fsf@evledraar.gmail.com>
 <20190507074506.GF28060@sigill.intra.peff.net>
 <8736lqisyx.fsf@evledraar.gmail.com>
 <20190508071105.GA14043@sigill.intra.peff.net>
 <87sgtohqk9.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sgtohqk9.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 08, 2019 at 06:13:58PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > I do wonder if this really needs to be part of the progress bar. The
> > goal of the progress bar is to give the user a sense that work is
> > happening, and (if possible, but not for "enumerating") an idea of when
> > it might finish. If the trace code can already do detailed timings, then
> > shouldn't we just be encouraging people to use that?
> [...]
>      -       progress->title = title;
>      +       progress->title = "Reticulating splines";

Heh, OK, that's a fair reductio ad absurdum of my point. I guess what I
was trying to say is that we don't need to go overboard with accuracy as
long as we're giving a vague sense of the work. Precision measurements
can be handled through a different system.

But I don't mind if you can find a way to do these kind of cascaded
progress meters in a way that is pleasing to the eye and not hard to
handle in the callers of the code.

-Peff
