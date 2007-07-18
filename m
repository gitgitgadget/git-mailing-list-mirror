From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH] Makefile: create an install-symlinks target
Date: Wed, 18 Jul 2007 16:33:29 +0200
Message-ID: <20070718143329.GD4815@xp.machine.xx>
References: <86bqe9lwy8.fsf@lola.quinscape.zz> <Pine.LNX.4.64.0707181344520.14781@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 18 16:33:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBAb1-0003mq-0T
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 16:33:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731AbXGROdQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 10:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755836AbXGROdQ
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 10:33:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:42887 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753731AbXGROdP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 10:33:15 -0400
Received: (qmail invoked by alias); 18 Jul 2007 14:33:14 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp018) with SMTP; 18 Jul 2007 16:33:14 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX1/CbtFfEezCngHTuGZMOGM5H2PMlgUF8OE8tCVRix
	corJMhViZs/4bu
Mail-Followup-To: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	David Kastrup <dak@gnu.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707181344520.14781@racer.site>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52865>

On Wed, Jul 18, 2007 at 01:48:21PM +0100, Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 18 Jul 2007, David Kastrup wrote:
> 
> > Use this, for example, to do
> > rm -rf /opt/git
> > make prefix=/opt/git install
> > make symlinkprefix=/usr/local prefix=/opt/git install-symlinks
> 
> You mean
> 
> 	This target allows you to have git installed in one location,
> 	and have symbolic links to all of the programs installed in 
> 	another	location.  For example, if git was installed to /opt/git
> 	with
> 
> 		make prefix=/opt/git install
> 
> 	you can install symbolic links in /usr/local/bin with
> 
> 		make symlinkprefix=/usr/local prefix=/opt/git \
> 			install-symlinks
> 
> Hmm.  Why not install it with a proper package manager in the correct 
> place to begin with?  Somehow I find so many symbolic links ugly.
> 

Seeing this excellent explantion from Dscho, this sound exactly like a
perfect use case for xstow [1].

It allows you to install your application into e.g. /usr/local/stow/git
and by running 'xstow git' in /usr/local/stow it would create all the
necessary links in /usr/local/{bin,share,doc} or any other place you
want.

-Peter

[1]: http://xstow.sourceforge.net/
