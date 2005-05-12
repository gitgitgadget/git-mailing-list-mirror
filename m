From: Matt Mackall <mpm@selenic.com>
Subject: Re: Mercurial 0.4e vs git network pull
Date: Thu, 12 May 2005 13:57:35 -0700
Message-ID: <20050512205735.GE5914@waste.org>
References: <20050512094406.GZ5914@waste.org> <20050512182340.GA324@pasky.ji.cz> <20050512201116.GC5914@waste.org> <20050512201406.GJ324@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	mercurial@selenic.com, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Thu May 12 22:51:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWKdy-0002al-J8
	for gcvg-git@gmane.org; Thu, 12 May 2005 22:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262121AbVELU6H (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 16:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262120AbVELU6H
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 16:58:07 -0400
Received: from waste.org ([216.27.176.166]:56993 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262118AbVELU5o (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2005 16:57:44 -0400
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-1) with ESMTP id j4CKvZp0003820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 12 May 2005 15:57:35 -0500
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id j4CKvZ7H003817;
	Thu, 12 May 2005 15:57:35 -0500
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
In-Reply-To: <20050512201406.GJ324@pasky.ji.cz>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, May 12, 2005 at 10:14:06PM +0200, Petr Baudis wrote:
> Dear diary, on Thu, May 12, 2005 at 10:11:16PM CEST, I got a letter
> where Matt Mackall <mpm@selenic.com> told me that...
> > On Thu, May 12, 2005 at 08:23:41PM +0200, Petr Baudis wrote:
> > > Dear diary, on Thu, May 12, 2005 at 11:44:06AM CEST, I got a letter
> > > where Matt Mackall <mpm@selenic.com> told me that...
> > > > Mercurial is more than 10 times as bandwidth efficient and
> > > > considerably more I/O efficient. On the server side, rsync uses about
> > > > twice as much CPU time as the Mercurial server and has about 10 times
> > > > the I/O and pagecache footprint as well.
> > > > 
> > > > Mercurial is also much smarter than rsync at determining what
> > > > outstanding changesets exist. Here's an empty pull as a demonstration:
> > > > 
> > > >  $ time hg merge hg://selenic.com/linux-hg/
> > > >  retrieving changegroup
> > > > 
> > > >  real    0m0.363s
> > > >  user    0m0.083s
> > > >  sys     0m0.007s
> > > > 
> > > > That's a single http request and a one line response.
> > > 
> > > So, what about comparing it with something comparable, say git pull over
> > > HTTP? :-)
> > 
> > ..because I get a headache every time I try to figure out how to use git? :-P
> > 
> > Seriously, have a pointer to how this works?
> 
> Either you use cogito and just pass cg-clone an HTTP URL (to the git
> repository as in the case of rsync -
> http://www.kernel.org/pub/scm/cogito/cogito.git should work), or you
> invoke git-http-pull directly (passing it desired commit ID of the
> remote HEAD you want to fetch, and the URL; see
> Documentation/git-http-pull.txt).

Does this need an HTTP request (and round trip) per object? It appears
to. That's 2200 requests/round trips for my 800 patch benchmark.

How does git find the outstanding changesets?

-- 
Mathematics is the supreme nostalgia of our time.
