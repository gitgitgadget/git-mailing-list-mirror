From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] new test from the submodule chapter of the user manual
Date: Thu, 20 Sep 2007 19:47:32 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709201946410.28395@racer.site>
References: <20070920003413.GJ16235@genesis.frugalware.org>
 <7v1wcum0ox.fsf@gitster.siamese.dyndns.org> <Pine.LNX.4.64.0709201133590.28395@racer.site>
 <20070920170831.GQ16235@genesis.frugalware.org> <20070920175952.GC30391@tasint.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Miklos Vajna <vmiklos@frugalware.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	"J. Bruce Fields" <bfields@citi.umich.edu>
To: Joel Becker <Joel.Becker@oracle.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 20:48:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IYR58-0000XQ-A7
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 20:48:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757121AbXITSs1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Sep 2007 14:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757247AbXITSs1
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Sep 2007 14:48:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:38300 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757121AbXITSs0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Sep 2007 14:48:26 -0400
Received: (qmail invoked by alias); 20 Sep 2007 18:48:25 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp033) with SMTP; 20 Sep 2007 20:48:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18UHX8pbBkUkaHlEt8U6QstHgyU0occkDVbA1Suvu
	BAf7wEsd46CnpI
X-X-Sender: gene099@racer.site
In-Reply-To: <20070920175952.GC30391@tasint.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58796>

Hi,

On Thu, 20 Sep 2007, Joel Becker wrote:

> On Thu, Sep 20, 2007 at 07:08:31PM +0200, Miklos Vajna wrote:
> > +test_expect_success "create the submodules" '
> > +	for i in a b c d
> > +	do
> > +		mkdir $i &&
> > +		cd $i &&
> > +		git init &&
> > +		echo "module $i" > $i.txt &&
> > +		git add $i.txt &&
> > +		git commit -m "Initial commit, submodule $i" &&
> > +		cd ..
> > +	done
> 
> 	Silly question: why use the '&&' when you can 'set -e'?  As it
> currently stands, a failure will still go back around the loop...

A "set -e" will make the script exit AFAIR.  That's not what we want.  A 
simple "|| break" after the "cd .." will work, though.

Ciao,
Dscho
