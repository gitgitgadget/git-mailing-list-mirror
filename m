From: Petr Baudis <pasky@suse.cz>
Subject: Re: Something looks like CVS modules
Date: Fri, 11 Nov 2005 22:29:53 +0100
Message-ID: <20051111212953.GX30496@pasky.or.cz>
References: <200511111313.27273.lan@ac-sw.com> <200511111642.25908.lan@ac-sw.com> <20051111105820.GN30496@pasky.or.cz> <200511111713.58018.lan@ac-sw.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 11 22:31:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EagTF-0000Ql-Ri
	for gcvg-git@gmane.org; Fri, 11 Nov 2005 22:30:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbVKKV35 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 16:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbVKKV34
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 16:29:56 -0500
Received: from w241.dkm.cz ([62.24.88.241]:56739 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751209AbVKKV34 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 16:29:56 -0500
Received: (qmail 9339 invoked by uid 2001); 11 Nov 2005 22:29:53 +0100
To: Alexander Litvinov <lan@ac-sw.com>
Content-Disposition: inline
In-Reply-To: <200511111713.58018.lan@ac-sw.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11637>

Dear diary, on Fri, Nov 11, 2005 at 12:13:57PM CET, I got a letter
where Alexander Litvinov <lan@ac-sw.com> said that...
> On Friday 11 November 2005 16:58, Petr Baudis wrote:
> > But this is troublesome, and doesn't fit into GIT's model at all. Do you
> > have any concrete example of a scenario where something like this would
> > be useful?
> 
> For eaxmle: I have java lib A. I setup project B in this way:
> B/src/
> B/A/src
> 
> Have another project C:
> C/src/
> C/A/src
> 
> Both of them share the same code from library's module. I can tag them, edit, 
> commit: do all work I usualy do. If I change something in B/A/src this will 
> be updated into C/A/src.

Aha. So it isn't so much about modules, but more about nested checkouts,
described in Cogito's TODO as:

* Subprojects
	Support a GIT project inside a GIT project:

		x/.git
		x/foo/bar/.git
		x/foo/bar/baz/.git
		x/quux/zot/.git

	That means cg-update working recursively and cg-add'n'stuff
	checking if there isn't another .git along the path of its
	argument.

	Needs more thought, especially wrt. fetching and merging
	recursive semantics.

Yes, that would be nice - it is something that you get kind of for-free
in CVS given its internal architecture, but needs specially crafted
support in the GIT environment. But when thinking about it (and we
discussed it with Jonas during one night bike ride through Copenhagen
some time ago ;), most of the problems with fetching and merging
semantics turn out to be actually largely artificial, and just doing
the intuitively right thing should be ok.

Patches welcome. Otherwise, I will get to it, but not very fast. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
