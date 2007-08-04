From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: rc4 - make quick-install-doc is broken
Date: Sat, 4 Aug 2007 17:21:18 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0708041719490.14781@racer.site>
References: <46B49617.3070402@gmail.com> <Pine.LNX.4.64.0708041637450.14781@racer.site>
 <46B4A2B0.9080208@gmail.com> <Pine.LNX.4.64.0708041704040.14781@racer.site>
 <46B4A5FD.3070107@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 18:28:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IHMUZ-0000xC-GU
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 18:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763509AbXHDQ2h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 4 Aug 2007 12:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760381AbXHDQ2h
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Aug 2007 12:28:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:60186 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759289AbXHDQ2g (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Aug 2007 12:28:36 -0400
Received: (qmail invoked by alias); 04 Aug 2007 16:21:54 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp033) with SMTP; 04 Aug 2007 18:21:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/zQaV0aaXzKR7jVF8mAjeZ9JT9QU2EouusG/jB35
	KnLq3syURiiXCF
X-X-Sender: gene099@racer.site
In-Reply-To: <46B4A5FD.3070107@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54880>

Hi,

On Sat, 4 Aug 2007, Mark Levedahl wrote:

> Johannes Schindelin wrote:
> > 
> > Could you please
> > 
> > 	GIT_TRACE=1 make quick-install-doc
> > 
> > ? It breaks here, too, but because I have no origin/man branch.
> > 
> > Ciao,
> > Dscho
> > 
> > 
> >   
> git>GIT_TRACE=1 make prefix=/usr quick-install-doc
> make -C Documentation quick-install
> make[1]: Entering directory `/usr/src/git/Documentation'
> make -C ../ GIT-VERSION-FILE
> make[2]: Entering directory `/usr/src/git'
> make[2]: `GIT-VERSION-FILE' is up to date.
> make[2]: Leaving directory `/usr/src/git'
> sh ./install-doc-quick.sh origin/man /usr/share/man
> trace: built-in: git 'rev-parse' '--git-dir'
> trace: built-in: git 'rev-parse' '--verify' 'origin/man^0'
> trace: built-in: git 'read-tree' 'origin/man'
> trace: built-in: git 'checkout-index' '-a' '-f' '--prefix=/usr/share/man/'
> make[1]: Leaving directory `/usr/src/git/Documentation'

At this point, could you try debugging it?  For example, set a break point 
in set_work_tree(), since that is the only function that commit touches, 
and see what it returns both before and after the bad commit?

Ciao,
Dscho
