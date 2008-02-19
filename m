From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http-push: push <remote> :<branch> deletes remote
 branch
Date: Tue, 19 Feb 2008 13:31:31 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802191328040.30505@racer.site>
References: <20080218130726.GA26854@localhost> <alpine.LSU.1.00.0802181339470.30505@racer.site> <20080218155546.GA8934@localhost> <alpine.LSU.1.00.0802181733400.30505@racer.site> <20080219125840.GA14049@localhost> <alpine.LSU.1.00.0802191313290.30505@racer.site>
 <20080219132410.GA6553@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Clemens Buchacher <drizzd@aon.at>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Feb 19 14:32:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRSa8-0005gv-2F
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 14:32:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751764AbYBSNbr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 08:31:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751548AbYBSNbr
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 08:31:47 -0500
Received: from mail.gmx.net ([213.165.64.20]:37768 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751376AbYBSNbq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 08:31:46 -0500
Received: (qmail invoked by alias); 19 Feb 2008 13:31:44 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 19 Feb 2008 14:31:44 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+nK+1oH3enJ3tCxu7a80n/3/a98j8pIjCdoUDpS2
	EcOQXVTJCvmrL4
X-X-Sender: gene099@racer.site
In-Reply-To: <20080219132410.GA6553@glandium.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74402>

Hi,

On Tue, 19 Feb 2008, Mike Hommey wrote:

> On Tue, Feb 19, 2008 at 01:17:24PM +0000, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> 
> > On Tue, 19 Feb 2008, Clemens Buchacher wrote:
> > 
> > > On Mon, Feb 18, 2008 at 05:34:45PM +0000, Johannes Schindelin wrote:
> > >
> > > > Thanks for the patch, I think it good.  Now, if we only had 
> > > > automated tests... ;-)
> > > 
> > > Thank you. Implementing a test should be fairly difficult, since we 
> > > need at least a WebDAV capable webserver, right? Do you having 
> > > something in mind?
> > 
> > Actually, thinking about it again, it should not be _that_ difficult.  
> > We would need to ship a httpd.conf.in, pick a port (maybe 8111, 
> > because that is already used in t5703-daemon.sh), generate httpd.conf 
> > and then start Apache with that.
> > 
> > If Apache does not want to start, skip this test.  (This might happen 
> > due to Apache not being installed, or the DAV modules not being 
> > installed, or Apache not finding them, or...)
> 
> Except that means coping with the fact that modules are probably not 
> installed in the same place on all distros, or can have been built in 
> apache instead of being DSOs, etc. The server itself doesn't even have 
> the same name across distros (httpd vs. apache vs. apache2)

I think this would not be too much of a hassle.  These days, an Apache2 is 
installed on many machines, and it is better to have tests, than to have 
no tests, even if they are not exercised everywhere, right?

Besides, for those machines that do not have Apache installed (such as 
MinGW based setups), we can always add yet another environment variable, 
say "HTTP_PUSH_TEST_URL" to tell the test that there is already a 
web server set up at that URL, ready to be used.

Ciao,
Dscho
