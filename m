From: Jeff King <peff@peff.net>
Subject: Re: Including branch info in git format-patch
Date: Thu, 19 Jun 2008 17:06:17 -0400
Message-ID: <20080619210617.GC6529@sigill.intra.peff.net>
References: <20080619154251.GA16475@jurassic> <20080619202843.GA6207@sigill.intra.peff.net> <7vskv9rvrc.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Mukund Sivaraman <muks@banu.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 23:07:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9RLl-0001XL-6f
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 23:07:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751398AbYFSVGZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 17:06:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbYFSVGZ
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 17:06:25 -0400
Received: from peff.net ([208.65.91.99]:4538 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751369AbYFSVGZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 17:06:25 -0400
Received: (qmail 20990 invoked by uid 111); 19 Jun 2008 21:06:20 -0000
Received: from c-24-98-46-248.hsd1.ga.comcast.net (HELO sigill.intra.peff.net) (24.98.46.248)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 19 Jun 2008 17:06:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jun 2008 17:06:17 -0400
Content-Disposition: inline
In-Reply-To: <7vskv9rvrc.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85529>

On Thu, Jun 19, 2008 at 01:54:15PM -0700, Junio C Hamano wrote:

> > You could potentially add a config option to put the branch name inside
> > the '[PATCH]' text. This text is generally stripped away before
> > applying, so it would still free up the receiver to apply on whatever
> > branch they wanted. I don't think it would make sense for git
> > development, since we typically use topic branches, so keeping it
> > configurable would make sense.
> 
> People would work on individual patches on topic branches that are named
> differently from the branch on the other end anyway (the branch that
> corresonds to the other end will be used for local integration testing in
> such a setup), so I do not see much point in stating which local branch
> happened to have been checked out when the patch was generated, in the
> output.

I think that is totally dependent on the workflow, which is what I was
trying to say above. It really depends on how the patch-submitter
organizes his branches.

> the project's convention what to do with it.  The side branch the patch
> was developed on may be named "quick-hack", which would not have any
> relevance to the final location of where that patch wants to be in.

I suspect you would do better to look at branch.quick-hack.merge, so
that you say "this was based on upstream's X", not "this is my
quick-hack".

But there are so many ways this could go wrong, since the patches you're
formatting might not even have anything to do with the branch you're on.

-Peff
