From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: "Argument list too long" in git remote update (Was: Git and GCC)
Date: Mon, 17 Dec 2007 22:59:57 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712172257380.9446@racer.site>
References: <4aca3dc20712051108s216d3331t8061ef45b9aa324a@mail.gmail.com>  
 <2007-12-05-21-23-14+trackit+sam@rfc1149.net>   <1196891451.10408.54.camel@brick>
 <jeeje0ogvk.fsf@sykes.suse.de>   <1196897840.10408.57.camel@brick>  
 <38a0d8450712130640p1b5d74d6nfa124ad0b0110d64@mail.gmail.com>
 <1197572755.898.15.camel@brick> <37BDCA73-4318-4BC8-9CCE-1DA30E4A09FC@adacore.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Harvey Harrison <harvey.harrison@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Tue Dec 18 00:00:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4Ox5-0003Qq-N5
	for gcvg-git-2@gmane.org; Tue, 18 Dec 2007 00:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758998AbXLQXAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 18:00:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757076AbXLQXAX
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 18:00:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:58103 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757029AbXLQXAV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 18:00:21 -0500
Received: (qmail invoked by alias); 17 Dec 2007 23:00:17 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp007) with SMTP; 18 Dec 2007 00:00:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX192wKF3FIp2CCW48J8NyxLengE/jbpCmV6uYY1YoD
	Mi7R4Yym6GtA41
X-X-Sender: gene099@racer.site
In-Reply-To: <37BDCA73-4318-4BC8-9CCE-1DA30E4A09FC@adacore.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68648>

Hi,

On Mon, 17 Dec 2007, Geert Bosch wrote:

> 		On Dec 13, 2007, at 14:05, Harvey Harrison wrote:
> > After the discussions lately regarding the gcc svn mirror.  I'm coming
> > up with a recipe to set up your own git-svn mirror.  Suggestions on the
> > following.
> > 
> > // Create directory and initialize git
> > mkdir gcc
> > cd gcc
> > git init
> > // add the remote site that currently mirrors gcc
> > // I have chosen the name gcc.gnu.org *1* as my local name to refer to
> > // this choose something else if you like
> > git remote add gcc.gnu.org git://git.infradead.org/gcc.git
> > // fetching someone else's remote branches is not a standard thing to do
> > // so we'll need to edit our .git/config file
> > // you should have a section that looks like:
> > [remote "gcc.gnu.org"]
> >       url = git://git.infradead.org/gcc.git
> >       fetch = +refs/heads/*:refs/remotes/gcc.gnu.org/*
> > // infradead's mirror puts the gcc svn branches in its own namespace
> > // refs/remotes/gcc.gnu.org/*
> > // change our fetch line accordingly
> > [remote "gcc.gnu.org"]
> >       url = git://git.infradead.org/gcc.git
> >       fetch = +refs/remotes/gcc.gnu.org/*:refs/remotes/gcc.gnu.org/*
> > // fetch the remote data from the mirror site
> > git remote update
> 
> With git version 1.5.3.6 on Mac OS X, this results in:
> potomac%:~/gcc%git remote update
> Updating gcc.gnu.org
> /opt/git/bin/git-fetch: line 220: /opt/git/bin/git: Argument list too long
> warning: no common commits
> [after a long wait and a good amount of network traffic]
> fatal: index-pack died of signal 13
> fetch gcc.gnu.org: command returned error: 126
> potomac%:~/gcc%
> 
> Any ideas on what to do to resolve this?

Unfortunately, the builtin remote did not make it into git's master yet, 
and it will probably miss 1.5.4.

Chances are that this would make the bug go away, but Junio said that on 
one of his machines, the regression tests fail with the builtin remote.

In the meantime, "git fetch gcc.gnu.org" should do what you want, 
methinks.

Hth,
Dscho
