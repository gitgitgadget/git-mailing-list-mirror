Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5168C433FE
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 18:49:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235518AbhKVSw4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 13:52:56 -0500
Received: from cloud.peff.net ([104.130.231.41]:36572 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233392AbhKVSwy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 13:52:54 -0500
Received: (qmail 22032 invoked by uid 109); 22 Nov 2021 18:49:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 22 Nov 2021 18:49:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23626 invoked by uid 111); 22 Nov 2021 18:49:46 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 22 Nov 2021 13:49:46 -0500
Authentication-Results: peff.net; auth=none
Date:   Mon, 22 Nov 2021 13:49:45 -0500
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Enzo Matsumiya <ematsumiya@suse.de>
Subject: Re: [PATCH 0/5] run-command API: get rid of "argv"
Message-ID: <YZvmSRz4oAzSHZgG@coredump.intra.peff.net>
References: <YZseJ4jOVIK3+bUD@coredump.intra.peff.net>
 <cover-0.5-00000000000-20211122T153605Z-avarab@gmail.com>
 <YZvY+BJhxaFIOdnJ@coredump.intra.peff.net>
 <xmqq7dd0giwp.fsf@gitster.g>
 <211122.86o86cxcnu.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <211122.86o86cxcnu.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 22, 2021 at 07:33:10PM +0100, Ævar Arnfjörð Bjarmason wrote:

> 
> On Mon, Nov 22 2021, Junio C Hamano wrote:
> 
> > Jeff King <peff@peff.net> writes:
> >
> >> I'm on the fence on how important it is to do these cleanups. IMHO they
> >> are half of what really sells the change in the first place (since the
> >> other bug can pretty easily be fixed without it).
> >
> > Yes.  I actually think these have much better value for their
> > complexity, compared to the other "half" of the topic ;-)
> >
> >> But maybe it is piling too much onto what is already a pretty big
> >> change. The cleanups could be done individually later.
> >
> > I am OK with that, too.  But I do agree that the series is too big
> > to sit in front of a fix for a bug, for which a much simpler and
> > focused approach has already been discussed, to block it.
> 
> I'm happy to re-roll this on top of the more narrow fix. FWIW the bug's
> there since at least v2.30.0 (just tested that, probably much older), so
> in that sense there's no urgency either way.

I suspect it has been a problem since 43b0190224 (pager: lose a separate
argv[], 2016-02-16) in v2.7.3. So yeah, definitely not urgent, but I do
think we can get out a 2-line minimal fix to start with.

-Peff
