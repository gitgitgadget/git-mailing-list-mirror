From: Marc Singer <elf@buici.com>
Subject: Re: gitweb testing with non-apache web server
Date: Thu, 3 Aug 2006 09:22:41 -0700
Message-ID: <20060803162241.GB1287@buici.com>
References: <20060803075403.GA5238@buici.com> <20060803155603.GS7533@daga.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Aug 03 18:22:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8fyA-0000QU-0a
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 18:22:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964778AbWHCQWn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 12:22:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932579AbWHCQWn
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 12:22:43 -0400
Received: from 206-124-142-26.buici.com ([206.124.142.26]:37013 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S932578AbWHCQWm
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 12:22:42 -0400
Received: (qmail 1535 invoked by uid 1000); 3 Aug 2006 16:22:41 -0000
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060803155603.GS7533@daga.cl>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24738>

On Thu, Aug 03, 2006 at 11:56:03AM -0400, Blu Corater wrote:
> On Thu, Aug 03, 2006 at 12:54:03AM -0700, Marc Singer wrote:
> > I would like to use gitweb with the Cherokee web server because the
> > host that I have on hand has very limited RAM, 32MiB.  Neither the
> > version of gitweb available on Debian (v264) nor the latest in the git
> > repo works.
> > 
> > I did some debugging on the latest repo version.  The lines
> > 
> >   our $project = ($cgi->param('p') || $ENV{'PATH_INFO'});
> >   if (defined $project) {
> >      ...
> > 
> > are being executed even though the url is
> > 
> >   http://server/git
> > 
> > I think that the problem is that Cherokee translates the request URL
> > into
> > 
> >   http://server/git/
> > 
> > which means that the $ENV{'PATH_INFO'} is the string "/" insted of
> > being undefined.
> > 
> > The error I'm seeing is that the request path is forbidden, but I
> > suspect that this is some sort of misunderstanding between the web
> > server and the script.
> 
> I am using Cherokee+GitWeb and the behaviour observed is that
> http://server/git will return the default Cherokee index page, but
> http://server/git/, with a slash at the end, works. 

Will you share your Cherokee configuration script?

The links look like this:

  http://scarlet/g?p=bsp.git;a=summary

even when I start with 

  http://scarlet/g

or

  http://scarlet/g/

So, I'm not sure I understand what you are saying.

> 
> -- 
> Blu.
> -
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
