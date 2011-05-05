From: Jeff King <peff@peff.net>
Subject: Re: error with $ git push origin HEAD:newbranch
Date: Thu, 5 May 2011 06:59:14 -0400
Message-ID: <20110505105914.GA464@sigill.intra.peff.net>
References: <loom.20110505T103708-225@post.gmane.org>
 <20110505093752.GB29595@sigill.intra.peff.net>
 <loom.20110505T114511-660@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: chris <jugg@hotmail.com>
X-From: git-owner@vger.kernel.org Thu May 05 12:59:30 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHwHJ-0003kY-1N
	for gcvg-git-2@lo.gmane.org; Thu, 05 May 2011 12:59:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664Ab1EEK7R (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 May 2011 06:59:17 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53586
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753623Ab1EEK7R (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2011 06:59:17 -0400
Received: (qmail 30408 invoked by uid 107); 5 May 2011 11:01:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 May 2011 07:01:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 May 2011 06:59:14 -0400
Content-Disposition: inline
In-Reply-To: <loom.20110505T114511-660@post.gmane.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172826>

On Thu, May 05, 2011 at 10:06:21AM +0000, chris wrote:

> Yes, indeed.  I suppose it must be the situation that I've never done that
> before then.  While I certainly I have pushed a detached head before, it must 
> have always been to an existing branch.
> 
> Thanks for clarifying this.
> 
> It is slightly surprising that git-push doesn't default to assuming one means 
> refs/heads/newbranch in this case.  I don't see a reason not to?

Consider something like:

  $ git checkout v1.5
  $ git push origin HEAD:foo

Would you want "foo" to be a branch or a tag? I can see arguments for
either.

Rather than trying to guess, it's fairly easy to disambiguate. For a
branch, either:

  $ git push origin HEAD:refs/heads/foo

or

  $ git branch foo
  $ git push origin HEAD

would work, depending on whether or not you want a local branch.

-Peff
