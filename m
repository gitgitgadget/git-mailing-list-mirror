From: Petr Baudis <pasky@suse.cz>
Subject: Re: cloning/pulling hooks
Date: Wed, 29 Aug 2007 11:52:02 +0200
Message-ID: <20070829095202.GE1219@pasky.or.cz>
References: <1188319608.6106.63.camel@beauty> <20070828172709.GB1219@pasky.or.cz> <200708291005.08795.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Josh England <jjengla@sandia.gov>
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 29 11:52:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQKDa-0008RK-1M
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 11:52:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755590AbXH2JwG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 05:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755456AbXH2JwF
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 05:52:05 -0400
Received: from w241.dkm.cz ([62.24.88.241]:58237 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755492AbXH2JwE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 05:52:04 -0400
Received: (qmail 32673 invoked by uid 2001); 29 Aug 2007 11:52:02 +0200
Content-Disposition: inline
In-Reply-To: <200708291005.08795.andyparkins@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56920>

On Wed, Aug 29, 2007 at 11:05:07AM CEST, Andy Parkins wrote:
> On Tuesday 2007 August 28, Petr Baudis wrote:
> 
> > On Tue, Aug 28, 2007 at 06:46:48PM CEST, Josh England wrote:
> > > When cloning an existing repository, is there any way to grab
> > > the .git/hooks files as part of the clone (or pull)?
> >
> >   No. You can add the appropriate instructions to instructions how to
> > clone the repository, users have to install the hooks manually.
> >
> >   Now I went on with a large writeup on considerations for implementing
> > such a feature (including security), but then I scrapped it. What would
> > you like to use these hooks for? Really, perhaps it's best to instead do
> > any "post-commit" etc. checks at the push time instead of the commit
> > time, so that developers can still freely commit locally, e.g. I
> > sometimes do temporary commits on side branches of various work in
> > progress changes, then randomly merge them together etc. before I come
> > up with the final sequence of commits that I push out.
> 
> I've not done it for myself yet, but I had an idea about making an independent 
> branch in the repository itself containing the hook scripts for that project.  
> That way, the cloners get the scripts but still have to knowingly install 
> them themselves.
> 
> If you were feeling particularly brave, you could check that branch out 
> in .git/hooks.

Yes, that was one of my ideas as well; but one thing is that you may
want different hooks scripts for different branches or even different
times in a particular branch. So maybe .git-hooks/, with each change
printing a bit fat warning and setting -x. On the other hand maybe it
might be simpler to do the tests for which branch/commit are you working
on in the hooks themselves.

But overally, I'm still not convinced that there is a feasible use-case
for the cloned hooks at all. Someone has a particular example?

-- 
				Petr "Pasky" Baudis
Early to rise and early to bed makes a male healthy and wealthy and dead.
                -- James Thurber
