From: Marc Singer <elf@buici.com>
Subject: Re: gitweb testing with non-apache web server
Date: Thu, 3 Aug 2006 13:27:03 -0700
Message-ID: <20060803202703.GA13147@buici.com>
References: <20060803075403.GA5238@buici.com> <20060803155603.GS7533@daga.cl> <20060803162241.GB1287@buici.com> <20060803192152.GT7533@daga.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Aug 03 22:27:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8jme-0003GK-BH
	for gcvg-git@gmane.org; Thu, 03 Aug 2006 22:27:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750905AbWHCU1F (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 Aug 2006 16:27:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751056AbWHCU1F
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Aug 2006 16:27:05 -0400
Received: from 206-124-142-26.buici.com ([206.124.142.26]:13284 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S1750905AbWHCU1D
	(ORCPT <rfc822;git@vger.kernel.org>); Thu, 3 Aug 2006 16:27:03 -0400
Received: (qmail 14071 invoked by uid 1000); 3 Aug 2006 20:27:03 -0000
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060803192152.GT7533@daga.cl>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24753>

On Thu, Aug 03, 2006 at 03:21:52PM -0400, Blu Corater wrote:
> Here is the interesting part of my cherokee.conf
> 
> ------------------------------------------
> UserDir public_html {
>     Directory / {
>        Handler common
>     }
> 
>     Directory /scm/ {
>         Handler cgi {
>                 ScriptAlias /home/blu/bin/gitweb.cgi
>         }
>     }
> }
> -----------------------------------------
> 
> So, I have the gitweb.cgi executable in a bin directory on my home and I
> am telling Cherokee that when it sees the url http://server/~blu/scm/, it
> should execute /home/blu/bin/gitweb.cgi
> 
> If I request http://server/~blu/scm, Cherokee returns Cherokee's default
> index page. Only if I request http://server/~blu/scm/, Cherokee returns
> the expected output from gitweb.
> 
> Now, if I add 
> 
>     Directory /test/ {
> 	Handler cgi
>     }
> 
> And copy gitweb.cgi to ~/public_html/test/, it seems there is no problem.
> 
> I can request http://server/~blu/test/gitweb.cgi or
> http://server/~blu/test/gitweb.cgi/ and get the expected gitweb output.
> 
> It looks more like a Cherokee problem to me, but I don't have time to
> investigate further right now.

Hmm.  I was hopeful when I saw that your configuration was different
from mine.  However, it seems to be something else.  BTW, I'm running
cherokee on ARM.

========================================
Directory / {
    Handler common
}

Directory /g/ {
    Handler cgi {
        Scriptalias /usr/lib/cgi-bin/git.cgi
    }
}
Directory /git/ {
    Handler cgi {
        Scriptalias /usr/lib/cgi-bin/gitweb.cgi
    }
}
========================================

gitweb.cgi is an old version.  git.cgi is the latest release.

I can see the project overview page, but all of the links bring me
back to the same top-level page, no summary, not logs.  I've verified
that the web server's user can read the git repo. 

I don't doubt that this is a cherokee issue.

Cheers.
