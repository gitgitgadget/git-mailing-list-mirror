From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git pull error message woes
Date: Thu, 19 Jun 2008 14:57:44 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0806191446590.19665@iabervon.org>
References: <1213860773.6444.9.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Matthias Kestenholz <mk@spinlock.ch>
X-From: git-owner@vger.kernel.org Thu Jun 19 20:58:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9PLH-0005uq-65
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 20:58:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753303AbYFSS5r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 14:57:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752210AbYFSS5r
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 14:57:47 -0400
Received: from iabervon.org ([66.92.72.58]:47320 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751896AbYFSS5r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 14:57:47 -0400
Received: (qmail 5733 invoked by uid 1000); 19 Jun 2008 18:57:44 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Jun 2008 18:57:44 -0000
In-Reply-To: <1213860773.6444.9.camel@localhost>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85511>

On Thu, 19 Jun 2008, Matthias Kestenholz wrote:

> Hi,
> 
> I noticed strange behavior while pulling git.git today (this isn't new,
> it just occurred to me for the first time today that there is something
> wrong going on)
> 
> I run the 'pu' branch most of the time, and do not create a local branch
> because 'pu' is constantly rebased. I just run git checkout origin/pu
> after pulling (I know I should fetch if I don't want to fetch+merge, but
> it's hard to retrain the fingers)
> 
> Although I am on no branch ($curr_branch is empty), I get the error
> message from error_on_no_merge_candidates instead of being notified that
> I am on no branch currently. Something around line 150-160 in
> git-pull.sh does not seem to work as it should.

There's no reason you couldn't pull when on no branch. It's just that, 
without a branch, there's nowhere to get a default ref to merge, which 
leads to having nothing to merge (if you don't give anything specific), 
which leads to that error.

On the other hand, you could do:

 git pull <some URL> <some branch>

and git would happily merge the specified branch of the specified 
repository for you. So the reason that git-pull doesn't give you the error 
you expect is that that's not necessarily an error at all.

	-Daniel
*This .sig left intentionally blank*
