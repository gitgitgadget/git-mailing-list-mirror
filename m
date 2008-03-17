From: Petr Baudis <pasky@suse.cz>
Subject: repo.or.cz renovation
Date: Mon, 17 Mar 2008 18:49:34 +0100
Message-ID: <20080317174934.GC6803@machine.or.cz>
References: <20080313231413.27966.3383.stgit@rover> <76718490803131707g34fd40d4q21c69391c2597bc@mail.gmail.com> <20080314002205.GL10335@machine.or.cz> <1205454999.2758.14.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: "J.H." <warthog19@eaglescrag.net>
X-From: git-owner@vger.kernel.org Mon Mar 17 18:50:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JbJTT-0003iz-Mw
	for gcvg-git-2@gmane.org; Mon, 17 Mar 2008 18:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752120AbYCQRtg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Mar 2008 13:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752075AbYCQRtg
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Mar 2008 13:49:36 -0400
Received: from w241.dkm.cz ([62.24.88.241]:48575 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751946AbYCQRtf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Mar 2008 13:49:35 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 35A57204C063; Mon, 17 Mar 2008 18:49:34 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1205454999.2758.14.camel@localhost.localdomain>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77449>

On Thu, Mar 13, 2008 at 05:36:39PM -0700, J.H. wrote:
> 
> > You are of course right - I wanted to do the rename, but forgot to write
> > it in the actual code. :-)
> > 
> > There is a more conceptual problem though - in case of such big sites,
> > it really makes more sense to explicitly regenerate the cache
> > periodically instead of making random clients to have to wait it out.
> > We could add a 'force_update' parameter to accept from localhost only
> > that will always regenerate the cache, but that feels rather kludgy -
> > can anyone think of a more elegant solution? (I don't think taking the
> > @projects generating code out of gitweb and then having to worry during
> > gitweb upgrades is any better.)
> 
> You could do something similar to the gitweb caching I'm doing,
> basically if a file isn't generated you make a user wait (no good way
> around this really).  If a cache exists show it to the user unless the
> cache is older than $foo.  If a re-generation needs to happen it happens
> in the background so the user who triggers the regeneration sees
> something immediately vs. having to wait (at the cost of showing out of
> date data)

By the way, the index page is so far really the only bottleneck I'm
seeing, other than that even project pages for huge repositories are
shown pretty quickly. Did you ever try to just cache the index page on
kernel.org? What sort of impact did it have? What evere the hotspots -
project pages for the main repositories or some less obvious pages?

Just caching the index would be far less intrusive change than
introducing caching everywhere and it might help to bring kernel.org
gitweb back in sync with mainline. :-)

-- 
				Petr "Pasky" Baudis
Whatever you can do, or dream you can, begin it.
Boldness has genius, power, and magic in it.	-- J. W. von Goethe
