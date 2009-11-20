From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: [RFC] teamGIT bonjour support
Date: Fri, 20 Nov 2009 10:49:32 +0100
Message-ID: <20091120094932.GA3528@atjola.homenet>
References: <2fcfa6df0908280002y221a22e6md27db56865472144@mail.gmail.com>
 <20091120090529.GM17748@machine.or.cz>
 <20091120091209.GN17748@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Abhijit Bhopatkar <bain@devslashzero.com>,
	git <git@vger.kernel.org>, teamgit@googlegroups.com
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Nov 20 10:49:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBQ7h-0008Fp-I6
	for gcvg-git-2@lo.gmane.org; Fri, 20 Nov 2009 10:49:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434AbZKTJtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Nov 2009 04:49:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753872AbZKTJtc
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Nov 2009 04:49:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:46595 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753717AbZKTJtb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Nov 2009 04:49:31 -0500
Received: (qmail invoked by alias); 20 Nov 2009 09:49:37 -0000
Received: from i59F57935.versanet.de (EHLO atjola.homenet) [89.245.121.53]
  by mail.gmx.net (mp029) with SMTP; 20 Nov 2009 10:49:37 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+D3y98hGSDy3ITphm9X45J4tcmIPm2Loe8Iz6myw
	MlaT4QqAfChxCy
Content-Disposition: inline
In-Reply-To: <20091120091209.GN17748@machine.or.cz>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133321>

On 2009.11.20 10:12:09 +0100, Petr Baudis wrote:
> On Fri, Nov 20, 2009 at 10:05:30AM +0100, Petr Baudis wrote:
> >   Hi!
> > 
> > On Fri, Aug 28, 2009 at 12:32:39PM +0530, Abhijit Bhopatkar wrote:
> > > I plan to do this on LAN using bonjour service discovery
> > 
> > I wonder why so much emphasis for this? It seems like a nifty
> > convenience bit, but I don't think making this idea too central is any
> > good. What if you get a second office at the other end of the world?
> > What if part of your team is working on a deployment at customer site?
> > What if part of your team works from home over a VPN?  What if your
> > team is collaborating over the internet on an open project?  What if...?
> > 
> > That said, it sounds like a great idea to have let's say a post-commit
> > hook that will start an upload job:
> > 
> > 	extbranch="$(whoami)/$(git symbolic-ref HEAD | sed 's#refs/heads/##')"
> 
> Thanks to sitaram, now I know that probably the best way is:
> 
>   	extbranch="$(whoami)/$(git describe --contains --all HEAD)"
> 	
> (But now you *really* need to check if HEAD is a heads ref first or you
> will push out to something totally bogus.)

Hm, I'd go for:
$(whoami)/$(git rev-parse --symbolic-full-name HEAD | sed s,refs/heads/,,)

gives the shortname of the checked out branch head, or HEAD when you're
on a detached HEAD.

Bjoern ;-)
