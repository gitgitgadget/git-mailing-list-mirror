From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCH] test_interactive: interactive debugging in test scripts
Date: Mon, 16 Jan 2012 17:07:12 -0500
Message-ID: <20120116220712.GA30785@padd.com>
References: <4F133069.10308@web.de>
 <20120115232413.GA14724@sigill.intra.peff.net>
 <20120116154953.GA21238@padd.com>
 <4F148211.70106@web.de>
 <20120116201123.GA18699@sigill.intra.peff.net>
 <4F148D3B.4070206@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Mon Jan 16 23:07:27 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rmui2-0001iV-RV
	for gcvg-git-2@lo.gmane.org; Mon, 16 Jan 2012 23:07:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756887Ab2APWHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Jan 2012 17:07:17 -0500
Received: from honk.padd.com ([74.3.171.149]:48789 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751245Ab2APWHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2012 17:07:16 -0500
Received: from arf.padd.com (unknown [50.55.142.76])
	by honk.padd.com (Postfix) with ESMTPSA id 4C36FE8C;
	Mon, 16 Jan 2012 14:07:15 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id F008031446; Mon, 16 Jan 2012 17:07:12 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <4F148D3B.4070206@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188659>

Jens.Lehmann@web.de wrote on Mon, 16 Jan 2012 21:48 +0100:
> Am 16.01.2012 21:11, schrieb Jeff King:
> > On Mon, Jan 16, 2012 at 09:01:21PM +0100, Jens Lehmann wrote:
> > 
> >> So I vote for your patch as it takes my initial idea even further. I
> >> really like that HOME, TERM and SHELL are honored in your version
> >> leaving the user with a fully functional shell of his choice.
> > 
> > I'm actually mildly negative on this feature, as it interferes with the
> > tests themselves. Probably TERM and SHELL don't matter. But $HOME means
> > git will read your personal .gitconfig, not any config (or lack thereof)
> > in the trash directory.
> 
> Good point, I haven't thought of that ... so yes, at least $HOME should
> go.

I, too, have stumbled over differences that are due to picking up
something in $HOME.  It takes a minute to realize what's going
on.

TERM can interfere with at least one test: c2116a1 (test-lib: fix TERM
to dumb for test repeatability, 2008-03-06).  SHELL can cause
issues when it is more feature-ful than SHELL_PATH.

On the other hand, it's frustrating to work in an environment
without my shell aliases, git aliases, readline customizations,
personal path, and assorted environment variables.

I'm comfortable with the (rare?) possibility of confusion.  But
perhaps it is unwise to support a feature with so many caveats,
even if it is only for debugging.

		-- Pete
