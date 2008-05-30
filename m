From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-log vs git-rev-list
Date: Fri, 30 May 2008 21:46:35 +0200
Message-ID: <20080530194635.GI593@machine.or.cz>
References: <20080530165641.GG18781@machine.or.cz> <alpine.LFD.1.10.0805301021310.3141@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri May 30 21:47:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2AZb-0000sT-6n
	for gcvg-git-2@gmane.org; Fri, 30 May 2008 21:47:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753865AbYE3Tqn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 May 2008 15:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753741AbYE3Tqn
	(ORCPT <rfc822;git-outgoing>); Fri, 30 May 2008 15:46:43 -0400
Received: from w241.dkm.cz ([62.24.88.241]:41829 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653AbYE3Tqm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 May 2008 15:46:42 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 525D1204C03E; Fri, 30 May 2008 21:46:35 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LFD.1.10.0805301021310.3141@woody.linux-foundation.org>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83320>

On Fri, May 30, 2008 at 10:25:47AM -0700, Linus Torvalds wrote:
> On Fri, 30 May 2008, Petr Baudis wrote:
> > 
> >   * git log --pretty=format is actually sane and does not pollute the
> > output with spurious 'commit' lines
> 
> Why would you want to use "git-rev-list" at all?

Because it was the natural command to access history from a script to me
and nothing in the documentation hinted me that I shouldn't use it.

> The common case for git-rev-list is for things that git log simply won't 
> do, ie things like "git rev-list --all --objects" that is a nonsensical 
> operation to do on "git log".

Step back a bit: it's git-_REV_-list. Technically, --all --objects is
nonsensical operation to do on revision list either.

> >   I think that having two commands that by now do essentially the same
> > thing, but slightly differently, is rather messy UI. Thus, I'm wondering
> > if it would be worthwhile to make rev-list a thin git-log wrapper and
> > start phasing it out?
> 
> It already is. It's already phased out in the sense that I don't see why 
> you complain. If you don't like it, don't use it. It has legacy reasons 
> for existing, and it does *some* things that are simply not sensible at 
> all for "git log" (ie the non-commit things).

But there is no indication that it is phased out whatsoever. My point is
that presence of this command is confusing. If it is going to stand
around for non-commit things, it should be called 'git-object-list' or
something, and the difference to git-log should be made clear. But I
think there is no fundamental reason why git-log shouldn't be made able
to list non-commit objects either.

> >   Yes, git-rev-list is supposed to be a plumbing thing, but from my
> > porcelain, I actually have to use git-log anyway [..]
> 
> So why do you care?

Because it confused me, I'm probably not the first to be confused and it
will probably confuse others in the future too. The UI should be more
consistent.

-- 
				Petr "Pasky" Baudis
Whatever you can do, or dream you can, begin it.
Boldness has genius, power, and magic in it.	-- J. W. von Goethe
