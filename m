From: Petr Baudis <pasky@suse.cz>
Subject: Re: Git vs Monotone
Date: Thu, 31 Jul 2008 20:52:51 +0200
Message-ID: <20080731185251.GR32184@machine.or.cz>
References: <bd6139dc0807311113n50dda9f0t1aab46b724510de2@mail.gmail.com> <20080731183317.GA31085@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sverre Rabbelier <alturin@gmail.com>,
	Git Mailinglist <git@vger.kernel.org>
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Jul 31 20:54:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOdHx-00017h-4R
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 20:54:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753957AbYGaSwz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jul 2008 14:52:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754007AbYGaSwz
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jul 2008 14:52:55 -0400
Received: from w241.dkm.cz ([62.24.88.241]:59833 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753852AbYGaSwy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jul 2008 14:52:54 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 44E59393B306; Thu, 31 Jul 2008 20:52:51 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080731183317.GA31085@cuci.nl>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90962>

On Thu, Jul 31, 2008 at 08:33:17PM +0200, Stephen R. van den Berg wrote:
> Sverre Rabbelier wrote:
> >If I clone the git mirror of our monotone repository, I find a
> >checkout size of 148 MB after git-repack--running git-gc also
> >increased the size by 2 MB, but I'll stick with the initial checkout
> >size for fairness. If I multiply this by my 11 checkouts, I will have
> >1628 MB. This is even more compelling for me, as I now save 728 MB of
> >disk space with monotone."
> 
> You have at least two options to reduce diskspace:
> a. Clone once from remote, then clone from that clone, it should
>    hardlink the larger packfiles to the initial clone and therefore not
>    cost you a lot.
> b. Clone once from remote, and create 11 branches inside the new cloned
>    repo.  Switch branches while doing development.
> 
> Most git users pick b.  It's easier to work with.  Having 11 unpacked
> repos means that all the object files in those trees are almost up to
> date, but it adds to the complexity of comparing changes and merging
> changes between branches.  The compilation speed can be increased with
> ccache if need be.

c. Still clone from the remote, but set up alternates to a single
local "reference repository". Then all common objects will be stored
only once in this reference repository. The advantage to (a) is that
your remotes are actually set up sensibly.

(Note that the blog post talks about .git + checkout sizes, in case
someone got confused like I did, counting only .git. :-)

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
