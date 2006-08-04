From: Marc Singer <elf@buici.com>
Subject: Re: gitweb testing with non-apache web server
Date: Thu, 3 Aug 2006 23:11:22 -0700
Message-ID: <20060804061122.GA15755@buici.com>
References: <20060803202703.GA13147@buici.com> <20060803235536.GJ17966@craic.sysops.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Blu Corater <blu@daga.cl>
X-From: git-owner@vger.kernel.org Fri Aug 04 08:11:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8su7-0002e8-FR
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 08:11:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751244AbWHDGLY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 02:11:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751408AbWHDGLY
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 02:11:24 -0400
Received: from 206-124-142-26.buici.com ([206.124.142.26]:11228 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S1751244AbWHDGLX
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 02:11:23 -0400
Received: (qmail 16530 invoked by uid 1000); 4 Aug 2006 06:11:22 -0000
To: Francis Daly <francis@daoine.org>
Content-Disposition: inline
In-Reply-To: <20060803235536.GJ17966@craic.sysops.org>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24777>

On Fri, Aug 04, 2006 at 12:55:36AM +0100, Francis Daly wrote:
> > Marc Singer wrote: 
> > On Thu, Aug 03, 2006 at 03:21:52PM -0400, Blu Corater wrote:
> 
> Hi there,
> 
> > > If I request http://server/~blu/scm, Cherokee returns Cherokee's default
> > > index page. Only if I request http://server/~blu/scm/, Cherokee returns
> > > the expected output from gitweb.
> 
> This is due to one apparent bug in Cherokee's Directory handling.
> 
> > I can see the project overview page, but all of the links bring me
> > back to the same top-level page, no summary, not logs.  I've verified
> > that the web server's user can read the git repo. 
> 
> And this is due a a different, but arguably related, one.  (The 301
> handler ignores things it shouldn't.)
> 
> > I don't doubt that this is a cherokee issue.
> 
> Cherokee's handling of both Directory and Request sections with cgi and
> Scriptalias seems a bit funky (in different ways).  If you want to use
> Cherokee configured this way, you may find it handy to add
> 
> $my_uri .= '/';
> to your version of gitweb.cgi shortly after it is set -- that should
> break most of the generated links in a way that causes them to work with
> this server.
> 
> $my_url is only used in a few places, but it may be worth doing the same
> thing to it too.

That does it.  

> 
> Or use a web server which isn't broken in this particular way.

:-) There doesn't seem to be much of the 'small' variety.  Though now
I'll look into lighttpd as well.

> 
> Good luck,

Cheers.
