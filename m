Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9F7731F803
	for <e@80x24.org>; Tue,  8 Jan 2019 18:05:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729159AbfAHSFY (ORCPT <rfc822;e@80x24.org>);
        Tue, 8 Jan 2019 13:05:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:58034 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728399AbfAHSFY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jan 2019 13:05:24 -0500
Received: (qmail 31971 invoked by uid 109); 8 Jan 2019 18:05:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 08 Jan 2019 18:05:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14667 invoked by uid 111); 8 Jan 2019 18:05:23 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 08 Jan 2019 13:05:23 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Jan 2019 13:05:22 -0500
Date:   Tue, 8 Jan 2019 13:05:22 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/11] jk/loose-object-cache sha1/object_id fixups
Message-ID: <20190108180522.GA4610@sigill.intra.peff.net>
References: <xmqqh8explya.fsf@gitster-ct.c.googlers.com>
 <3512c798-aa42-6fba-ee82-d33a8985be91@web.de>
 <20190107083150.GC21362@sigill.intra.peff.net>
 <b0049722-d019-fd5d-d93d-7b7363b4f244@web.de>
 <xmqqy37v59qz.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy37v59qz.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 08, 2019 at 09:39:48AM -0800, Junio C Hamano wrote:

> > I skimmed them; they look good to me.  6 and 8 are particularly
> > satisfying; getting rid of hash copy operations just feels nice. :)
> >
> > Junio only took 1 to 5 into pu; 6, 7 and its sidekick 8, 10 and 11
> > conflict with sb/more-repo-in-api; 9 could go in unmodified.
> 
> I think these later steps are based on something a lot newer than
> the result of applying your updates to the jk/loose-object-cache
> series they fix.  I think I untangled and backported one of the
> earlier commits but then I stopped after 05/11.

Sorry, I applied René's patches on top of master and then built on that,
treating it like a new topic. But of course your jk/loose-object-cache
is older.

> I do not think it is important to keep jk/loose-object-cache and
> these two follow-up topics mergeable to the maintenance track, so
> I'll see if the patches behave better if queued directly on top of
> 3b2f8a02 ("Merge branch 'jk/loose-object-cache'", 2019-01-04), or
> even a yet newer random point on 'master'.

Yeah, they should. I think one of them will need René's patch, which
changes the body of quick_has_loose(). I can roll it as a separate topic
if that's easier (or just wait a week or so until René's cleanups
graduate).

-Peff
