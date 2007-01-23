From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Repository Security
Date: Tue, 23 Jan 2007 15:29:21 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701231525250.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701221433.13257.andre@masella.no-ip.org>
 <Pine.LNX.4.63.0701231036400.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200701230823.17938.andre@masella.no-ip.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 23 15:29:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9MeM-0003E8-Vs
	for gcvg-git@gmane.org; Tue, 23 Jan 2007 15:29:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933006AbXAWO3Y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 Jan 2007 09:29:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933003AbXAWO3Y
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jan 2007 09:29:24 -0500
Received: from mail.gmx.net ([213.165.64.20]:39650 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933006AbXAWO3X (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jan 2007 09:29:23 -0500
Received: (qmail invoked by alias); 23 Jan 2007 14:29:21 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp035) with SMTP; 23 Jan 2007 15:29:21 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Andre Masella <andre@masella.no-ip.org>
In-Reply-To: <200701230823.17938.andre@masella.no-ip.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37525>

Hi,

On Tue, 23 Jan 2007, Andre Masella wrote:

> > > As I understand it, none of the repository backends allow any per-user
> > > per-branch access control.
> > The idea in git (unless you really want to get the same setup as in CVS,
> > which would be rather sad) is that every developer has at least one
> > repository. Write-access: only one developer.
> 
> Believe me: I was ready to throw a party when I got to shutdown CVS last 
> week.

Congratulations!

> Say I have two utterly separate repositories with two integrators. I 
> want to put them on a web server (and so same DAV share). There is 
> little to stop the integrator of one project (by intention or accident) 
> from modifying the other repository. It can be done, but doing it 
> requires one section of the httpd.conf per repository.

I thought you can do all the fancy WebDAV stuff with .htaccess?

> > I already hear the complaint: "But you need a central repository!". If 
> > you _have_ to have a central repository, designate the integrator's 
> > repository central.
> 
> Okay, say one regular developer wants share his changes with another 
> developer. He either has to mail patches, create an SSH account, or set 
> up one of git-daemon or WebDAV.

Most likely just start git-daemon. It's read-only (in the future, you 
might be able to enable anonymous push, but not right now), so you don't 
have to worry.

> And most of those require knowing the workstation name which is 
> inconvienient.

Umm. Oh. Okay. Didn't expect _that_ to be inconvenient.

> I would rather have each user able to push to a branch with their name 
> on it on a central server.

Really, the easiest is to setup a central server with SSH, where every 
user has an individual account. Administrating, say, a Linux box with 
literally thousands of users is a charm.

Ciao,
Dscho
