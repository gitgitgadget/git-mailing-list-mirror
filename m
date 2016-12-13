Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10E49203EC
	for <e@80x24.org>; Tue, 13 Dec 2016 17:34:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934077AbcLMRea (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Dec 2016 12:34:30 -0500
Received: from cloud.peff.net ([104.130.231.41]:55828 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934081AbcLMRdo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2016 12:33:44 -0500
Received: (qmail 18949 invoked by uid 109); 13 Dec 2016 17:33:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Dec 2016 17:33:43 +0000
Received: (qmail 16612 invoked by uid 111); 13 Dec 2016 17:34:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 13 Dec 2016 12:34:24 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 13 Dec 2016 12:33:41 -0500
Date:   Tue, 13 Dec 2016 12:33:41 -0500
From:   Jeff King <peff@peff.net>
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Ariel <asgit@dsgml.com>,
        git@vger.kernel.org
Subject: Re: git add -p with new file
Message-ID: <20161213173341.wemlunlixdp6277h@sigill.intra.peff.net>
References: <alpine.DEB.2.11.1612062012540.13185@cherryberry.dsgml.com>
 <20161209141129.r53b4rbtgd76fn2a@sigill.intra.peff.net>
 <alpine.DEB.2.11.1612091331170.13185@cherryberry.dsgml.com>
 <20161210085556.nwg3pbay367jqin5@sigill.intra.peff.net>
 <xmqq37hvphji.fsf@gitster.mtv.corp.google.com>
 <20161211130034.ygj5l2gbx33uknlk@sigill.intra.peff.net>
 <dc698b79-6311-a2a3-c564-a43ef071e62b@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dc698b79-6311-a2a3-c564-a43ef071e62b@gmx.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Dec 12, 2016 at 09:31:03PM +0100, Stephan Beyer wrote:

> I am also a "git add -p"-only user (except for new files and merges).
> However, I usually keep a lot of untracked files in my repositories.
> Files that I do not (git)ignore because I want to see them when I type
> "git status".
> 
> Hence, the imagination only that "git add -p" starts to ask me for each
> untracked file feels like a lot of annoying "n" presses. I could imagine
> that it is okay-ish when it asks about the untracked files *after* all
> tracked paths have been processed (I guess this has been proposed
> before), so that I can safely quit.

Yeah, this is the "some people might be annoyed" that I mentioned
originally. If your workflow leaves a lot of untracked files that you
don't care about it, then I think you'd want this feature disabled
entirely via a config option (or vice versa, that it would only be
enabled by config option).

> I am also not really sure what problem this feature is trying to solve.
> If the "problem"(?) is that it should act more like "git add" instead of
> "git add -u", for whatever reason, this may be fine (but the
> configuration option is a must-have then).

I think the problem is just that "add -p" does not give the whole story
of what you might want to do before making a commit.

> > I'd also probably add interactive.showUntracked to make the whole thing
> > optional (but I think it would be OK to default it to on).
> Hm, "interactive.showUntracked" is a confusing name because "git add -i"
> (interactive) already handles untracked files.

Sure, that was just meant for illustration. I agree there's probably a
better name.

-Peff
