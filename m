From: Petr Baudis <pasky@suse.cz>
Subject: Re: repo.or.cz wishes?
Date: Wed, 29 Aug 2007 11:54:00 +0200
Message-ID: <20070829095400.GF1219@pasky.or.cz>
References: <20070826235944.GM1219@pasky.or.cz> <Pine.LNX.4.64.0708270933450.28586@racer.site> <20070828041059.GK18160@spearce.org> <20070828111913.GA31120@thunk.org> <Pine.LNX.4.64.0708281230310.28586@racer.site> <20070829042005.GT18160@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Aug 29 11:54:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQKFU-0000Eq-Ta
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 11:54:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755950AbXH2JyF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 05:54:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755822AbXH2JyE
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 05:54:04 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44564 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755414AbXH2JyB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 05:54:01 -0400
Received: (qmail 488 invoked by uid 2001); 29 Aug 2007 11:54:00 +0200
Content-Disposition: inline
In-Reply-To: <20070829042005.GT18160@spearce.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56922>

On Wed, Aug 29, 2007 at 06:20:05AM CEST, Shawn O. Pearce wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Tue, 28 Aug 2007, Theodore Tso wrote:
> > > On Tue, Aug 28, 2007 at 12:10:59AM -0400, Shawn O. Pearce wrote:
> > > > At day-job I have a hard rule that you cannot even push into an A, let 
> > > > alone rewind a branch in it or delete a branch from it.
> > > 
> > > Why don't you even allow people to push into A?  That should be safe....
> > 
> > Nope:
> > 
> > for b in $(git ls-remote /that/other/repo | sed "s/^[^ ]* //")
> > do
> > 	git push /that/other/repo :$b
> > done
> 
> Well, at day-job I use contrib/hooks/update-paranoid to deny all
> push access into my A's (/that/other/repo).  But that could just
> as easily be configured to allow branch creation and branch update
> (fast-forward) but no rewind or delete.
> 
> When I symlink A's refs into B I also don't allow B to update,
> create, rewind or delete the symlinked refs via push.  This way
> you can't do something weird to A like upload new objects into B's
> ODB but then change A's refs to point to objects that A's own ODB
> doesn't have.
> 
> Hmm, I wonder of Pasky handles that correctly on repo.or.cz...

I don't handle it at all, but if you don't have permissions to modify A
you simply won't be able to do anything weird to A. If you have the
permissions, I'm still not sure if Git will keep symlinked refs over
ref updates; if so, hey, you had the permissions for A and it's your
reponsibility if you screw up.

-- 
				Petr "Pasky" Baudis
Early to rise and early to bed makes a male healthy and wealthy and dead.
                -- James Thurber
