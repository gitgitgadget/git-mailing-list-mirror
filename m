From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [3/5] Add http-pull
Date: Sat, 23 Apr 2005 00:40:08 +0200
Message-ID: <20050422224008.GD21204@pasky.ji.cz>
References: <200504212205.j3LM5J005103@unix-os.sc.intel.com> <Pine.LNX.4.21.0504221532120.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tony.luck@intel.com, Brad Roberts <braddr@puremagic.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 23 00:36:04 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DP6kR-0001cQ-Tr
	for gcvg-git@gmane.org; Sat, 23 Apr 2005 00:35:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261254AbVDVWkQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Apr 2005 18:40:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261257AbVDVWkQ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Apr 2005 18:40:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52897 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261254AbVDVWkJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 22 Apr 2005 18:40:09 -0400
Received: (qmail 24521 invoked by uid 2001); 22 Apr 2005 22:40:08 -0000
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0504221532120.30848-100000@iabervon.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Fri, Apr 22, 2005 at 09:46:35PM CEST, I got a letter
where Daniel Barkalow <barkalow@iabervon.org> told me that...
> On Thu, 21 Apr 2005 tony.luck@intel.com wrote:
> 
> > On Wed, 20 Apr 2005, Brad Roberts wrote:
> > > How about fetching in the inverse order.  Ie, deepest parents up towards
> > > current.  With that method the repository is always self consistent, even
> > > if not yet current.
> > 
> > Daniel Barkalow replied:
> > > You don't know the deepest parents to fetch until you've read everything
> > > more recent, since the history you'd have to walk is the history you're
> > > downloading.
> > 
> > You "just" need to defer adding tree/commit objects to the repository until
> > after you have inserted all objects on which they depend.  That's what my
> > "wget" based version does ... it's very crude, in that it loads all tree
> > & commit objects into a temporary repository (.gittmp) ... since you can
> > only use "cat-file" and "ls-tree" on things if they live in objects/xx/xxx..xxx
> > The blobs can go directly into the real repo (but to be really safe you'd
> > have to ensure that the whole blob had been pulled from the network before
> > inserting it ... it's probably a good move to validate everything that you
> > pull from the outside world too).
> 
> The problem with this general scheme is that it means that you have to
> start over if something goes wrong, rather than resuming from where you
> left off (and being able to use what you got until then).

Huh. Why? You just go back to history until you find a commit you
already have. If you did it the way as Tony described, if you have that
commit, you can be sure that you have everything it depends on too.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
