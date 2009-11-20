From: Petr Baudis <pasky@suse.cz>
Subject: Re: [RFC] teamGIT bonjour support
Date: Fri, 20 Nov 2009 10:12:09 +0100
Message-ID: <20091120091209.GN17748@machine.or.cz>
References: <2fcfa6df0908280002y221a22e6md27db56865472144@mail.gmail.com>
 <20091120090529.GM17748@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>, teamgit@googlegroups.com
To: Abhijit Bhopatkar <bain@devslashzero.com>
X-From: git-owner@vger.kernel.org Fri Nov 20 10:12:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBPXf-0008M1-I7
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 10:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754073AbZKTJMK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 04:12:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752636AbZKTJMI
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 04:12:08 -0500
Received: from w241.dkm.cz ([62.24.88.241]:43453 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753080AbZKTJME (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 04:12:04 -0500
Received: by machine.or.cz (Postfix, from userid 2001)
	id C541C862095; Fri, 20 Nov 2009 10:12:09 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20091120090529.GM17748@machine.or.cz>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133318>

On Fri, Nov 20, 2009 at 10:05:30AM +0100, Petr Baudis wrote:
>   Hi!
> 
> On Fri, Aug 28, 2009 at 12:32:39PM +0530, Abhijit Bhopatkar wrote:
> > I plan to do this on LAN using bonjour service discovery
> 
> I wonder why so much emphasis for this? It seems like a nifty
> convenience bit, but I don't think making this idea too central is any
> good. What if you get a second office at the other end of the world?
> What if part of your team is working on a deployment at customer site?
> What if part of your team works from home over a VPN?  What if your
> team is collaborating over the internet on an open project?  What if...?
> 
> That said, it sounds like a great idea to have let's say a post-commit
> hook that will start an upload job:
> 
> 	extbranch="$(whoami)/$(git symbolic-ref HEAD | sed 's#refs/heads/##')"

Thanks to sitaram, now I know that probably the best way is:

  	extbranch="$(whoami)/$(git describe --contains --all HEAD)"
	
(But now you *really* need to check if HEAD is a heads ref first or you
will push out to something totally bogus.)

P.S.: Heh, I would never guess what that git describe command already
does, talk about intuitiveness. ;-) (Of course, when you know exactly
what the switches do, it totally makes sense.)

-- 
				Petr "Pasky" Baudis
A lot of people have my books on their bookshelves.
That's the problem, they need to read them. -- Don Knuth
