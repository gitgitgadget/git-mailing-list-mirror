From: Jeff King <peff@peff.net>
Subject: Re: [QUESTION] '--color-words' for 'git add -p'?
Date: Fri, 29 Apr 2011 18:38:14 -0400
Message-ID: <20110429223814.GB3434@sigill.intra.peff.net>
References: <20110429164210.GA14937@kudu.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git-List <git@vger.kernel.org>
To: Valentin Haenel <valentin@fsfe.org>
X-From: git-owner@vger.kernel.org Sat Apr 30 00:38:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFwKN-0001tv-TX
	for gcvg-git-2@lo.gmane.org; Sat, 30 Apr 2011 00:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134Ab1D2WiS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 18:38:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45005
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932525Ab1D2WiQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 18:38:16 -0400
Received: (qmail 17031 invoked by uid 107); 29 Apr 2011 22:39:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 29 Apr 2011 18:39:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 Apr 2011 18:38:14 -0400
Content-Disposition: inline
In-Reply-To: <20110429164210.GA14937@kudu.in-berlin.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172502>

On Fri, Apr 29, 2011 at 06:42:10PM +0200, Valentin Haenel wrote:

> is it possible to use some kind of magic to get 'git add -p' to display
> diff with '--color-words' option? I tried GIT_DIFF_OPTS but w/o success.

No, it's not currently. The output of --color-words cannot be applied as
a patch, so we would have to do something like diff an extra time, match
up the hunks, show the user one hunk, and then apply the other.

In fact, that is what we already do to get color at all. It works very
well there, since we know the hunks will match exactly. I'm not 100%
sure, though, that color-words will produce exactly the same set of
hunks that a regular line-oriented diff will. Which would be a problem.

-Peff
