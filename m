From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 01/10] builtin/commit.c: convert trivial snprintf calls
 to xsnprintf
Date: Fri, 3 Jun 2016 05:04:48 -0400
Message-ID: <20160603090448.GF28401@sigill.intra.peff.net>
References: <20160603074724.12173-1-gitter.spiros@gmail.com>
 <20160603084917.GA28401@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 03 11:05:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8l2H-0007Ba-8e
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jun 2016 11:04:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbcFCJEw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jun 2016 05:04:52 -0400
Received: from cloud.peff.net ([50.56.180.127]:48328 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932097AbcFCJEv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jun 2016 05:04:51 -0400
Received: (qmail 1799 invoked by uid 102); 3 Jun 2016 09:04:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jun 2016 05:04:51 -0400
Received: (qmail 19250 invoked by uid 107); 3 Jun 2016 09:04:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Jun 2016 05:04:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Jun 2016 05:04:48 -0400
Content-Disposition: inline
In-Reply-To: <20160603084917.GA28401@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296291>

On Fri, Jun 03, 2016 at 04:49:18AM -0400, Jeff King wrote:

> I haven't looked carefully at each call site in detail yet, but from the
> previous rounds of sprintf handling, I'd guess each site falls into one
> of two categories:

So that being said, I did just look at several of them. And I think they
_do_ fall into these categories, but I think the solutions don't
necessarily. So what I would do is find solutions for each, and then go
back and group them by situation and solution-type using "git rebase
-i". It may be that you end up with 10 patches, or it may be that you
see some patterns. But I think grouping is helpful for reviewers,
because it communicates the patterns you found while doing the work.

-Peff
