From: Jeff King <peff@peff.net>
Subject: Re: git remote rm non-existant-remote
Date: Sun, 28 Jun 2009 12:11:41 -0400
Message-ID: <20090628161141.GA7796@sigio.peff.net>
References: <540FF00B-9DE7-4C89-9EC3-264B5BDD9CDE@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Sun Jun 28 18:10:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MKwxH-0006Qk-6U
	for gcvg-git-2@gmane.org; Sun, 28 Jun 2009 18:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752708AbZF1QJt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Jun 2009 12:09:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752207AbZF1QJs
	(ORCPT <rfc822;git-outgoing>); Sun, 28 Jun 2009 12:09:48 -0400
Received: from peff.net ([208.65.91.99]:41475 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751935AbZF1QJs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Jun 2009 12:09:48 -0400
Received: (qmail 7809 invoked by uid 1000); 28 Jun 2009 16:11:41 -0000
Content-Disposition: inline
In-Reply-To: <540FF00B-9DE7-4C89-9EC3-264B5BDD9CDE@silverinsanity.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122412>

On Sun, Jun 28, 2009 at 10:47:23AM -0400, Brian Gernhardt wrote:

> I was working on updating the remotes for one of my repositories
> (adding a variety of forks) and renamed the origin branch.  When I
> was done, I tried to use "git remote rm origin" to remove the
> branches for the now dead origin.  What git-remote did was remove all
> of my remotes and the merge information for my master branch (which
> was moved off the origin remote).
> 
> This is a data loss bug.  Very bad.  `git remote rm` should either
> refuse to remove a non-existent remote or (preferably) simply remove
> any branches that exist for that remote.

Ouch. That is indeed a serious bug. However, I can't reproduce with
current 'next'; which version of git are you using?

> When time allows I'll look into fixing this, but I thought I'd post
> in case somebody had more tuits than me this week.

I think it would be nice to have it delete partial cruft left over, but
I suspect just changing it to refuse the deletion will be a one-liner.
It would be nice to get at least that out to 'maint' branches as
appropriate.

-Peff
