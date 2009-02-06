From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Chicken/egg problem building from a 'git clone'
Date: Fri, 6 Feb 2009 12:34:07 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902061232000.7377@intel-tinevez-2-302>
References: <Pine.LNX.4.44.0902052238510.4851-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Joi Ellis <gyles19@visi.com>
X-From: git-owner@vger.kernel.org Fri Feb 06 12:35:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LVOzk-0003LR-L6
	for gcvg-git-2@gmane.org; Fri, 06 Feb 2009 12:35:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921AbZBFLeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Feb 2009 06:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752584AbZBFLeO
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Feb 2009 06:34:14 -0500
Received: from mail.gmx.net ([213.165.64.20]:59356 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752051AbZBFLeN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Feb 2009 06:34:13 -0500
Received: (qmail invoked by alias); 06 Feb 2009 11:34:09 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp028) with SMTP; 06 Feb 2009 12:34:09 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+n0uoVhOanxgPSpJ3wMjjjMI6M9q4AV5aN955/IF
	1fmZeCJPmH8J60
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <Pine.LNX.4.44.0902052238510.4851-100000@localhost.localdomain>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108690>

Hi,

On Thu, 5 Feb 2009, Joi Ellis wrote:

> On Fri, 6 Feb 2009, Johannes Schindelin wrote:
> 
> > On Fri, 6 Feb 2009, Joi Ellis wrote:
> > 
> > > "make all" fails becuase my libaries are old:
> > > 
> > >     LINK git-fast-import
> > > fast-import.o: In function `store_object':
> > > /usr/local/src/git/git/fast-import.c:1086: undefined reference to `deflateBound'
> > > /usr/local/src/git/git/fast-import.c:1109: undefined reference to `deflateBound'
> > 
> > You need to install a newer libz.  (And this is not a chicken & egg 
> > problem.)
> 
> Yes, this *is* a chicken & egg problem.

No it is _not_.

A chicken and egg problem would be if your problem would go away if Git 
compiled cleanly.  But it does not.

> As I said in my original post, git will build on this machine if I have 
> a configure script to run first.  The configure script explicitly checks 
> for the version of libz and sets a DEFINE appropriately.

So why don't you DEFINE the thing explicitely?  From reading the Makefile, 
it appears as if

	$ make NO_DEFLATE_BOUND=YesPlease

should make it compile.  Of course, the documentation in the first part of 
the Makefile could be better, maybe you have suggestions?

Hth,
Dscho
