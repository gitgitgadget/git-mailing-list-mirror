From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-mv: Keep moved index entries inact
Date: Mon, 21 Jul 2008 03:20:46 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807210319410.3305@eeepc-johanness>
References: <20080717130651.GU32184@machine.or.cz> <20080717223036.20680.9672.stgit@localhost> <7vej5pwhub.fsf@gitster.siamese.dyndns.org> <20080721002354.GK10151@machine.or.cz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Mon Jul 21 03:21:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKk5A-0004Wz-4H
	for gcvg-git-2@gmane.org; Mon, 21 Jul 2008 03:20:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755136AbYGUBT5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 20 Jul 2008 21:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755170AbYGUBT5
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Jul 2008 21:19:57 -0400
Received: from mail.gmx.net ([213.165.64.20]:49152 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754956AbYGUBT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Jul 2008 21:19:56 -0400
Received: (qmail invoked by alias); 21 Jul 2008 01:19:54 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp061) with SMTP; 21 Jul 2008 03:19:54 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18xzOdo4RwxOCz0HUSNyBYvvXzOrDQCMBOaomjoQl
	4Sp+jFnRH1r7uP
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080721002354.GK10151@machine.or.cz>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89287>

Hi,

On Mon, 21 Jul 2008, Petr Baudis wrote:

> On Sat, Jul 19, 2008 at 04:54:20PM -0700, Junio C Hamano wrote:
> > Petr Baudis <pasky@suse.cz> writes:
> > 
> > > +test_expect_success 'git mv should not change sha1 of moved cache entry' '
> > > +
> > > +	rm -fr .git &&
> > > +	git init &&
> > > +	echo 1 >dirty &&
> > > +	git add dirty &&
> > > +	entry="$(git ls-files --stage dirty | cut -f 1)"
> > 
> > "rev-parse :dirty"?
> 
> I want to make sure the whole index entry is intact, not just the sha1.

"rev-parse :dirty" will have to read the index to get at the object name 
of "dirty".  So there you have your index validation for you.

Ciao,
Dscho
