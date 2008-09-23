From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] TopGit v0.3
Date: Tue, 23 Sep 2008 15:27:28 +0200
Message-ID: <20080923132728.GV10360@machine.or.cz>
References: <1221120192.8962.7.camel@heerbeest> <20080912110017.GW10360@machine.or.cz> <1221222433.29747.8.camel@heerbeest> <20080912131530.GZ10360@machine.or.cz> <20080912181442.GA5407@lapse.rw.madduck.net> <1221648520.30402.12.camel@heerbeest> <20080921142445.GJ10360@machine.or.cz> <1222074825.6698.13.camel@heerbeest> <20080922152712.GN10360@machine.or.cz> <1222175590.10363.14.camel@heerbeest>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: martin f krafft <madduck@madduck.net>, git@vger.kernel.org,
	Jan Holesovsky <kendy@suse.cz>
To: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
X-From: git-owner@vger.kernel.org Tue Sep 23 15:28:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ki7wV-0006IW-2T
	for gcvg-git-2@gmane.org; Tue, 23 Sep 2008 15:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751415AbYIWN1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Sep 2008 09:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751404AbYIWN1a
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Sep 2008 09:27:30 -0400
Received: from w241.dkm.cz ([62.24.88.241]:42100 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751219AbYIWN1a (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Sep 2008 09:27:30 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 2D00F3939B57; Tue, 23 Sep 2008 15:27:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1222175590.10363.14.camel@heerbeest>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96560>

  Hi,

On Tue, Sep 23, 2008 at 03:13:10PM +0200, Jan Nieuwenhuizen wrote:
> On ma, 2008-09-22 at 17:27 +0200, Petr Baudis wrote:
> [about adding and removing topic branch dependencies]
> 
> > Do you really expect you will need this kind of functionality often,
> > though?
> 
> Yes.  This is what people are used to and do now with our patches based
> system.  We cannot take away such basic functionality.  Also, currently
> it is very easy to do, however, it is quite error prone.  That's also 
> why using [top]git would be so great.
> 
> There are ~300 topic branches.  Usually, a combination of most of these
> is used as the master branch.  There are a number of scenarios where
> you would want to add/remove some of these topic branches from master.
> 
> The most pressing case for this is for packagers making a release.
> Unless we also make their life easier, we can forget about moving to 
> [top]git.

  I think that would be possible to do, too. ;-) It really depends on
how general your patch tree is - what we can't make to work is just the
most generic case, but e.g. if master is a *leaf* branch nothing else
depends on and it can't get the branch through multiple paths, you can
do the dependency removal rather easily (if it can get through multiple
paths, you can still do it but you might have to deal with big
conflicts).

  But if you scenario indeed is totally generic, I'm afraid I don't know
how to make TopGit remove dependencies, except perhaps for the price of
massive complexity and massive slowdown (pretty much redoing all the
history walking etc.). Maybe someone else comes by with a genial
solution...

-- 
				Petr "Pasky" Baudis
The next generation of interesting software will be done
on the Macintosh, not the IBM PC.  -- Bill Gates
