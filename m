From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/10] color and pager improvements
Date: Thu, 18 Aug 2011 14:58:20 -0700
Message-ID: <20110818215820.GA7767@sigill.intra.peff.net>
References: <20110818045821.GA17377@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Steffen Daode Nurpmeso <sdaoden@googlemail.com>,
	Ingo =?utf-8?Q?Br=C3=BCckl?= <ib@wupperonline.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Aug 18 23:58:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuAbd-0001Ty-9z
	for gcvg-git-2@lo.gmane.org; Thu, 18 Aug 2011 23:58:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754461Ab1HRV6Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Aug 2011 17:58:24 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46358
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754225Ab1HRV6Y (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2011 17:58:24 -0400
Received: (qmail 25377 invoked by uid 107); 18 Aug 2011 21:59:04 -0000
Received: from 173-164-171-125-SFBA.hfc.comcastbusiness.net (HELO sigill.intra.peff.net) (173.164.171.125)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Aug 2011 17:59:04 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Aug 2011 14:58:20 -0700
Content-Disposition: inline
In-Reply-To: <20110818045821.GA17377@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179631>

On Wed, Aug 17, 2011 at 09:58:23PM -0700, Jeff King wrote:

> While looking at the pager and color code today, I decided to tackle two
> long-standing bugs, which entailed a lot of refactoring of the color
> code. The result fixes some minor bugs, and is a little nicer for
> calling code to use.

And here are two patches on top of the previous 10 to help Ingo's
problem a bit.

  [11/10]: support pager.* for aliases
  [12/10]: support pager.* for external commands

With these, you can do "git config pager.stash false" to turn off paging
on "stash list" and "stash show" (and turn it back on with "git -p
stash list", of course).

I'm slightly tempted to allow things like "pager.stash.list" and
"pager.branch.list". It wouldn't be too hard to implement. But I'm not
sure anybody actually cares. I think Ingo's original complaint was
simply that pager.stash didn't actually do anything, not that he wanted
some separate config for the various subcommands.

-Peff
