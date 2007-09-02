From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] rebase--interactive: do not use one-or-more (\+) in sed.
Date: Sun, 2 Sep 2007 15:20:52 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709021518260.28586@racer.site>
References: <200709010925.27926.johannes.sixt@telecom.at>
 <7vmyw6u5ca.fsf@gitster.siamese.dyndns.org> <7vejhiu565.fsf_-_@gitster.siamese.dyndns.org>
 <85abs5v9q1.fsf@lola.goethe.zz> <7vfy1xr1lz.fsf@gitster.siamese.dyndns.org>
 <46DABD15.4030208@fs.ei.tum.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Simon 'corecode' Schubert <corecode@fs.ei.tum.de>
X-From: git-owner@vger.kernel.org Sun Sep 02 16:21:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRqKA-0004Ey-Qa
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 16:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932779AbXIBOVJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 10:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756695AbXIBOVI
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 10:21:08 -0400
Received: from mail.gmx.net ([213.165.64.20]:33407 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756770AbXIBOVH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 10:21:07 -0400
Received: (qmail invoked by alias); 02 Sep 2007 14:21:04 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp036) with SMTP; 02 Sep 2007 16:21:04 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19DQasJ73hDfU6HvrI3Tij5Ib4UqpOqQQASD0h6Z2
	7rSuBOfWta6znz
X-X-Sender: gene099@racer.site
In-Reply-To: <46DABD15.4030208@fs.ei.tum.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57326>

Hi,

On Sun, 2 Sep 2007, Simon 'corecode' Schubert wrote:

> Junio C Hamano wrote:
> > > Just for the record: I believe that \{1,\} might be portable.
> > 
> > Yeah, I obviously looked at the page I quoted that describes
> > what's in and what's not in BRE definition ;-)
> > 
> > But in practice, I do not recall ever seeing an older sed that
> > did not understand one-or-more \+ *and* understood \{1,\}.  Do
> > you?
> 
> Yes, BSD sed (at least DragonFly's, so probably as well FreeBSD-4 (dunno
> about later)):
> 
> chlamydia % echo 5ab123x | sed -e 's/[a-z]\+/AAA/' 
> 5ab123x
> chlamydia % echo 5ab123x | sed -e 's/[a-z]\{1,\}/AAA/' 
> 5AAA123x
> chlamydia % echo 5ab123x | sed -E -e 's/[a-z]+/AAA/' 
> 5AAA123x

Thank you for a proper argument.  I usually ignore hand-waving POSIX 
arguments, but a real-world case changes the situation.

Ciao,
Dscho
