From: Petr Baudis <pasky@ucw.cz>
Subject: Re: git pull on ia64 linux tree
Date: Thu, 28 Apr 2005 03:24:34 +0200
Message-ID: <20050428012434.GC3422@pasky.ji.cz>
References: <B8E391BBE9FE384DAA4C5C003888BE6F035B31D9@scsmsx401.amr.corp.intel.com> <Pine.LNX.4.58.0504271525520.18901@ppc970.osdl.org> <20050427225821.GI22956@pasky.ji.cz> <Pine.LNX.4.58.0504271632060.18901@ppc970.osdl.org> <20050428000729.GT22956@pasky.ji.cz> <Pine.LNX.4.58.0504271719380.18901@ppc970.osdl.org> <20050428003342.GW22956@pasky.ji.cz> <Pine.LNX.4.58.0504271805550.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Luck, Tony" <tony.luck@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 03:19:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQxgP-0004SB-8G
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 03:19:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261570AbVD1BYj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 21:24:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261571AbVD1BYj
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 21:24:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47791 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261570AbVD1BYh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 21:24:37 -0400
Received: (qmail 7706 invoked by uid 2001); 28 Apr 2005 01:24:34 -0000
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0504271805550.18901@ppc970.osdl.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 28, 2005 at 03:08:29AM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> 
> 
> On Thu, 28 Apr 2005, Petr Baudis wrote:
> >
> > > (Which is not really nice, because it means that some files get updated 
> > > and others don't, depending on how they were merged, but whatever..)
> > 
> > We always do checkout-cache -f -a after we do merge-cache, so it should
> > end up in a consistent state.
> 
> I agree that for the common case it doesn't really matter, since we'll 
> always update the working directory regardless.
> 
> It was more of a conceptual complaint. We do everything else purely in the
> index, so it's a bit confusing that in that intermediate stage _some_
> files end up being up-to-date, and others end up not.

This actually came all the way from git-merge-one-file-script.

I don't think the intermediate stage matters at all, actually; from the
user's point of view it is nearly instantenous, and the tree keeps
changing during the merge anyway, when you are trying to resolve
non-exact merges by the merge utility. From the user's point of view,
the act of merging is atomic and you always end up with something
consistent, unless cg-merge is killed. But in that case it's all messed
up anyway and you'll better just cg-cancel and try again.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
