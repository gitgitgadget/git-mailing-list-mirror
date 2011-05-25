From: Jeff King <peff@peff.net>
Subject: Re: gitk normal use on linux repo and severe memory pressure
Date: Wed, 25 May 2011 14:27:34 -0400
Message-ID: <20110525182734.GA26407@sigill.intra.peff.net>
References: <BANLkTinrj2AOCMMWazf2F4eKy7Sy56K0vg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 20:27:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPIo3-0002WA-5F
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 20:27:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753167Ab1EYS1h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 14:27:37 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:40390
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752309Ab1EYS1h (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 14:27:37 -0400
Received: (qmail 3440 invoked by uid 107); 25 May 2011 18:27:36 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 May 2011 14:27:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 May 2011 14:27:34 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTinrj2AOCMMWazf2F4eKy7Sy56K0vg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174443>

On Wed, May 25, 2011 at 11:20:24AM -0400, Martin Langhoff wrote:

> An anecdotical report: Right today, I fired up gitk on a linux-2.6.39
> checkout to review some new patches. While discussing the patches with
> other developers on irc, my machine (arguably, RAM-constrained at 1GB)
> started to hit swap heavily.

Yeah, gitk on linux-2.6 tops out at around 1.6GB on my machine. Ouch.
That's 6-7K per commit. In git.git, it's similar (7-8K per commit).
For comparison, all of "git log --pretty=raw" for linux-2.6 is only
about 180M, or ~0.7K per commit.

Obviously there is going to be some overhead with organizing the data,
but that is really quite a lot.

> Are there efforts afoot to teach gitk to read in _some_ history and
> pause, continuing if the user scrolls down? Not sure if searches are
> done in-memory in gitk -- which probably complicates things.

Not that I know of. But it seems like there might be some room to
optimize gitk's storage. I know absolutely nothing about how commits are
stored now, though, so it's possible I'm completely wrong.

-Peff
