From: Boyd Lynn Gerber <gerberb@zenez.com>
Subject: Re: git-svn-import or CVS import from local HD rather than remote.
Date: Thu, 12 Jun 2008 16:20:36 -0600
Message-ID: <Pine.LNX.4.64.0806121615290.18454@xenau.zenez.com>
References: <Pine.LNX.4.64.0806121214210.18454@xenau.zenez.com>
 <20080612185545.GN29404@genesis.frugalware.org> <Pine.LNX.4.64.0806121315540.18454@xenau.zenez.com>
 <alpine.LNX.1.00.0806121523370.19665@iabervon.org>
 <Pine.LNX.4.64.0806121348340.18454@xenau.zenez.com>
 <alpine.LNX.1.00.0806121652220.19665@iabervon.org>
 <Pine.LNX.4.64.0806121457490.18454@xenau.zenez.com>
 <alpine.LNX.1.00.0806121759300.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Git List <git@vger.kernel.org>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Jun 13 00:21:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6vAi-0004OD-EO
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 00:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754845AbYFLWUi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2008 18:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754379AbYFLWUi
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 18:20:38 -0400
Received: from zenez.com ([166.70.62.2]:20819 "EHLO xenau.zenez.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754003AbYFLWUh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 18:20:37 -0400
Received: by xenau.zenez.com (Postfix, from userid 1000)
	id D8974E814E; Thu, 12 Jun 2008 16:20:36 -0600 (MDT)
Received: from localhost (localhost [127.0.0.1])
	by xenau.zenez.com (Postfix) with ESMTP id C7027E8123;
	Thu, 12 Jun 2008 16:20:36 -0600 (MDT)
In-Reply-To: <alpine.LNX.1.00.0806121759300.19665@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84806>

On Thu, 12 Jun 2008, Daniel Barkalow wrote:
> On Thu, 12 Jun 2008, Boyd Lynn Gerber wrote:
> > On Thu, 12 Jun 2008, Daniel Barkalow wrote:
> > > On Thu, 12 Jun 2008, Boyd Lynn Gerber wrote:
> > > > 
> > > > This is really frustrating.
> > > > 
> > > > I have tried every combination of file://localhost/ file:///
> > > > 
> > > > This is what I get
> > > > 
> > > > git-svn clone file:///working/svn/network/wireshark/ -T trunk -b 
> > > > branches -t tags wireshark Initialized empty Git repository in .git/ 
> > > > Couldn't open a repository: Unable to open an ra_local session to URL: 
> > > > Unable to open repository 'file:///working/svn/network/wireshark' at 
> > > > /usr/bin/git-svn line 1048
> > > > 
> > > > > ls -la /working/svn/network/wireshark/
> > > > total 16
> > > > drwxr-xr-x  8 gerberb zenez  208 2008-06-10 12:44 .
> > > > drwxr-xr-x  9 gerberb zenez  240 2008-06-12 13:00 ..
> > > > drwxr-xr-x  6 gerberb zenez  240 2008-06-12 12:14 .svn
> > > > drwxr-xr-x  6 gerberb zenez  152 2008-06-10 12:43 historic
> > > > drwxr-xr-x  5 gerberb zenez  152 2008-06-10 12:46 prereleases
> > > > drwxr-xr-x 86 gerberb zenez 2728 2008-06-10 12:37 releases
> > > > drwxr-xr-x 26 gerberb zenez 7016 2008-06-10 12:39 trunk
> > > > drwxr-xr-x 25 gerberb zenez 7136 2008-06-10 11:45 trunk-1.0
> > > 
> > > That looks like a SVN working copy, not an SVN repository. Maybe you 
> > > want file:///master/svn/...?
> > 
> > I tried /master/svn/network/... as well.  Same results.  I can cd 
> > /master/svn/network/... svn update and I get any updates from the URL.
> 
> That means it's a SVN working copy; SVN working copies don't contain the 
> project history, so it's impossible to import from them. 
> 
> Basically, if you can't use your master copy for "svn co <URL>", you can't 
> use it for "git svn".

OK, but when I have web-dav running I am able to do a svn co URL.
 
> > I really do not want to run web-dav.  I am able to do it if I run web-dav 
> > and have my server as a svn master.  I have had security issues with 
> > web-dav and I really want to avoid running it at all costs.
> 
> The SVN FAQ has information on running a SVN master without any web 
> service. You should probably read that.

That is what I have been going over and play with for the last about 2 
hours.  Thanks for the hints.  

> Alternatively, you could give up on having any local SVN-based storage, 
> and have /master/svn/... be a git repository that you update from the 
> upstream SVN server with "git svn".

The problem is I have over 100 projects in my /master/svn/... we use them 
to do checkouts.  I am able to check out from my /master/svn/ with svn, I 
just can not seem to get the same to work with git.  But it probably is 
just me being dumb or missing something.  I am going to finish going over 
the various FAQ's again.  I am sure I am missing something.  I am sure 
there has to be a way without having web-dav running.

Thanks,

--
Boyd Gerber <gerberb@zenez.com>
ZENEZ	1042 East Fort Union #135, Midvale Utah  84047
