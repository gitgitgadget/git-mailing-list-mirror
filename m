From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Mar 2011, #06; Thu, 31)
Date: Fri, 1 Apr 2011 13:06:10 -0400
Message-ID: <20110401170610.GA23014@sigill.intra.peff.net>
References: <7v62qzhqp4.fsf@alter.siamese.dyndns.org>
 <20110401152623.GA4553@sigill.intra.peff.net>
 <7vbp0phpmx.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 19:06:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5hnd-0005oR-74
	for gcvg-git-2@lo.gmane.org; Fri, 01 Apr 2011 19:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758410Ab1DARGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Apr 2011 13:06:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52853
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757715Ab1DARGL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Apr 2011 13:06:11 -0400
Received: (qmail 12382 invoked by uid 107); 1 Apr 2011 17:06:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Apr 2011 13:06:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Apr 2011 13:06:10 -0400
Content-Disposition: inline
In-Reply-To: <7vbp0phpmx.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170596>

On Fri, Apr 01, 2011 at 10:01:42AM -0700, Junio C Hamano wrote:

> >> * jc/add-u-migration (2011-03-22) 3 commits
> >>  - add: make "add -u/-A" update full tree without pathspec (step 3)
> >>  - add: make "add -u/-A" update full tree without pathspec (step 2)
> >>   (merged to 'next' on 2011-03-31 at 962e058)
> >>  + add: make "add -u/-A" update full tree without pathspec
> [...]
> > I have been meaning to look closer at this. Were you wanting to get the
> > first stage of the transition into 1.7.5?
> 
> I was tempted to but I think it would be far more pleasant if the first
> step were to add the warning against "add -u" without pathspec that is ran
> from a subdirectory to advise "if you meant 'from here', say '.', if you
> meant 'everywhere', say ':/'---for now we pretend you said '.' to match
> the traditional behaviour."

Yes, I think that is definitely the right first step.

> It is adding even more confusion to add the "in this repository, 'add -u'
> is tree-wide" configuration variable without giving people who need to
> override that in unfamiliar repositories (read: scripts).
> 
> Right now, we don't have a good advice to force the tree-wide behaviour
> other than "cd $(git rev-parse --show-cdup)/. && git add -u", which is
> quite a mouthful.
> 
> We know how the magic "this pathspec is from the root" should work, and I
> think we even saw "should look like this" patches, but haven't applied to
> any branch so far yet.

That reasoning makes sense. Let's let the :/ patches develop and cook
for post-1.7.5, then, and worry about it in the next cycle when we can
build on top of them.

-Peff
