From: Petr Baudis <pasky@suse.cz>
Subject: Re: [ANNOUNCE] TopGit v0.3
Date: Sun, 21 Sep 2008 16:24:45 +0200
Message-ID: <20080921142445.GJ10360@machine.or.cz>
References: <20080909231009.GD10544@machine.or.cz> <1221120192.8962.7.camel@heerbeest> <20080912110017.GW10360@machine.or.cz> <1221222433.29747.8.camel@heerbeest> <20080912131530.GZ10360@machine.or.cz> <20080912181442.GA5407@lapse.rw.madduck.net> <1221648520.30402.12.camel@heerbeest>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: martin f krafft <madduck@madduck.net>, git@vger.kernel.org
To: Jan Nieuwenhuizen <janneke-list@xs4all.nl>
X-From: git-owner@vger.kernel.org Sun Sep 21 16:25:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhPsp-00005h-Mt
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 16:25:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751575AbYIUOYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 10:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751611AbYIUOYr
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 10:24:47 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60067 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751554AbYIUOYr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 10:24:47 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id E92AA393B308; Sun, 21 Sep 2008 16:24:45 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1221648520.30402.12.camel@heerbeest>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96398>

On Wed, Sep 17, 2008 at 12:48:40PM +0200, Jan Nieuwenhuizen wrote:
> On vr, 2008-09-12 at 19:14 +0100, martin f krafft wrote:
> 
> > I've considered this question a lot before and could not come up
> > with anything; you cannot undo a merge.
> 
> Isn't that overly pessimistic?  Can't we have git create a merge
> commit that can be reverted with git revert?
> 
> For our ooo-build use case, I'm hoping to use [top]git as "a better 
> patch" and hope to have mostly orthogonal topic branches.  With patch,
> to "undo a merge" usually means patch -R and remove the patch from
> the dependency list.  I can hardly imagine something easily possible
> with patch is still impossible with git.

The problem is that you can undo the merge content, but not the history
information. So this revert can e.g. propagate even into branches which
still *should* depend on the other branch, you get into trouble when you
want to make your branch depend on the other one anyway, etc.

				Petr "Pasky" Baudis
