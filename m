Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC3EF1F97E
	for <e@80x24.org>; Thu, 11 Oct 2018 00:38:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbeJKIDN (ORCPT <rfc822;e@80x24.org>);
        Thu, 11 Oct 2018 04:03:13 -0400
Received: from cloud.peff.net ([104.130.231.41]:36452 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725971AbeJKIDN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Oct 2018 04:03:13 -0400
Received: (qmail 17711 invoked by uid 109); 11 Oct 2018 00:38:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 11 Oct 2018 00:38:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24408 invoked by uid 111); 11 Oct 2018 00:37:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 10 Oct 2018 20:37:42 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 Oct 2018 20:38:32 -0400
Date:   Wed, 10 Oct 2018 20:38:32 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gc: introduce an --auto-exit-code option for undoing
 3029970275
Message-ID: <20181011003832.GE13853@sigill.intra.peff.net>
References: <20181010174624.GC8786@sigill.intra.peff.net>
 <20181010192732.13918-1-avarab@gmail.com>
 <20181010203531.GA12949@sigill.intra.peff.net>
 <87tvltecvy.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tvltecvy.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 10, 2018 at 10:59:45PM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Callers who _are_ prepared to act on the exit code probably ought to
> > just use --auto-exit-code in their invocation.
> >
> > That said, I'm not entirely opposed to the matching config. There's
> > enough history here that somebody might want a sledgehammer setting to
> > go back to the old behavior.
> 
> If it's not a config option then as git is upgraded I'll need to change
> my across-server invocation to be some variant of checking git version,
> then etiher using the --auto-exit-code option or not (which'll error on
> older gits). Easier to be able to just drop in a config setting before
> the upgrade.

Yeah, that's the "there's enough history here" that I was referring to,
but I hadn't quite thought through a concrete example. That makes sense.

(Though I also think the other part of the thread is reasonable, too,
where we'd just have a command to abstract away "cat .git/gc.log" into
"git gc --show-detached-log" or something).

-Peff
