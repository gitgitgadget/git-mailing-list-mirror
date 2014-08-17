From: Jeff King <peff@peff.net>
Subject: Re: Feature Request: `git remote prune --all`
Date: Sun, 17 Aug 2014 03:18:05 -0400
Message-ID: <20140817071805.GC23808@peff.net>
References: <CAByVDef1_7x8Q1SL5wMtrKJQE51gvEOiKJ4xkpexXN5omBDn-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Travis Carden <travis.carden@gmail.com>
X-From: git-owner@vger.kernel.org Sun Aug 17 09:18:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIujK-0001LD-8B
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 09:18:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750861AbaHQHSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2014 03:18:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:53521 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750818AbaHQHSH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2014 03:18:07 -0400
Received: (qmail 5575 invoked by uid 102); 17 Aug 2014 07:18:07 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Aug 2014 02:18:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Aug 2014 03:18:05 -0400
Content-Disposition: inline
In-Reply-To: <CAByVDef1_7x8Q1SL5wMtrKJQE51gvEOiKJ4xkpexXN5omBDn-Q@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255350>

On Sat, Aug 16, 2014 at 07:52:44PM -0500, Travis Carden wrote:

> I would like to propose the addition of a `git remote prune --all`
> command option or similar mechanism for pruning all remotes in a
> repository. For lack of such a feature, I've been using the following
> bash alias:
> 
> alias git-remote-prune-all='for REMOTE in `git remote`; do echo
> "Pruning $REMOTE"; git remote prune $REMOTE; done;'

I think in general we've been moving "git remote" away from actually
interacting with the other side, and pushing those features into "git
fetch". These days you can use "git fetch --prune --all" to do what you
want.

Note that this isn't _exactly_ the same thing. Fetch's prune will do a
normal fetch and _also_ prune. There is no way to say "just prune, but
do not update existing refs". If that detail is important, I think I'd
rather see the feature go the other way from your request: teach
git-fetch a "--prune-only" mode.

-Peff
