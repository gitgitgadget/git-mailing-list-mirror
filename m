Return-Path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0A7620189
	for <e@80x24.org>; Wed, 22 Jun 2016 20:06:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751432AbcFVUGL (ORCPT <rfc822;e@80x24.org>);
	Wed, 22 Jun 2016 16:06:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:58745 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750835AbcFVUGL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Jun 2016 16:06:11 -0400
Received: (qmail 8525 invoked by uid 102); 22 Jun 2016 20:06:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Jun 2016 16:06:10 -0400
Received: (qmail 5142 invoked by uid 107); 22 Jun 2016 20:06:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 22 Jun 2016 16:06:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Jun 2016 16:06:08 -0400
Date:	Wed, 22 Jun 2016 16:06:08 -0400
From:	Jeff King <peff@peff.net>
To:	Junio C Hamano <gitster@pobox.com>
Cc:	Jonathan Nieder <jrnieder@gmail.com>,
	Andrea Stacchiotti <andreastacchiotti@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH] doc: git-htmldocs.googlecode.com is no more
Message-ID: <20160622200607.GD1697@sigill.intra.peff.net>
References: <146652690896.29270.13813898006180324611.reportbug@duelitri>
 <20160622024151.GA20206@google.com>
 <xmqq60t1noon.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq60t1noon.fsf@gitster.mtv.corp.google.com>
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

On Wed, Jun 22, 2016 at 10:00:56AM -0700, Junio C Hamano wrote:

> Peff suggested to use the github pages that are connected to the
> "git" org, and helped its initial set-up.  When I update the
> prebuilt docs, in addition to the listed locations, I also push to
> the gh-pages branch of https://github.com/git/htmldocs repository
> and the result appears in https://git.github.io/htmldocs/git.html
> 
> Even though we do have index.html -> git.html, gh-pages does not
> seem to let you follow it, so you need to start from git.html, and I
> suspect that it is why the below says "I wasn't able to find it" for
> (5).

Yeah, I looked into this a little back then, and I think it is simply
that the Pages builder does not handle symlinks at all. You could push
out index.html as a true copy rather than a symlink, but I think just
pointing to "git.html" as the entry page of the site is reasonable, too
(we could even make index.html a true overview page later if we want).

> So perhaps list both?  I do not know how beefy repo.or.cz is, or how
> well connected it is to the rest of the world, but if I have to pick
> only one, I'd feel safer if we didn't have to exploit the "blob_plain/:"
> backdoor.

Beefiness aside, the GitHub version will be served out of a CDN, which
means it should perform way better for the user, as it will often get
served from a geographically local cache.

-Peff
