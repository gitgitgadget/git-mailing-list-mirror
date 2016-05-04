From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 0/2] Add support for sending additional HTTP headers
Date: Wed, 4 May 2016 02:26:19 -0400
Message-ID: <20160504062618.GA9849@sigill.intra.peff.net>
References: <cover.1461837783.git.johannes.schindelin@gmx.de>
 <cover.1462342213.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed May 04 08:26:28 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axqGQ-0007dN-EK
	for gcvg-git-2@plane.gmane.org; Wed, 04 May 2016 08:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756973AbcEDG0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2016 02:26:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:33669 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751568AbcEDG0W (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2016 02:26:22 -0400
Received: (qmail 23392 invoked by uid 102); 4 May 2016 06:26:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 May 2016 02:26:21 -0400
Received: (qmail 6490 invoked by uid 107); 4 May 2016 06:26:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 May 2016 02:26:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 04 May 2016 02:26:19 -0400
Content-Disposition: inline
In-Reply-To: <cover.1462342213.git.johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293499>

On Wed, May 04, 2016 at 08:14:07AM +0200, Johannes Schindelin wrote:

> My use case is an army of build agents that need only limited and
> selective access to otherwise private repositories.
> 
> v6 supports submodules better by allowing
> 
> 	git -c http.extraheader submodule update
> 
> to work as one would expect intuitively.
> 
> Johannes Schindelin (2):
>   http: support sending custom HTTP headers

I think this one is in "next", with "will merge to master" in the latest
What's Cooking. So fortunately it does not have any changes in this
version of the series. :)

>   submodule: pass on http.extraheader config settings

IMHO this should come on top of jk/submodule-config-sanitize-fix (I was
surprised at first that your test worked at all, but that is because it
is using "clone", which is the one code path that works).

But I think we are waiting on going one of two paths:

  1. drop sanitizing entirely

  2. fix sanitizing and add more variables to it

If we go the route of (2), then we'd want my fix topic and this patch.
And if not, then we don't need any of it (just a patch dropping the
filtering, which AFAIK nobody has written yet).

-Peff
