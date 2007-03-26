From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-rm: don't remove newly added file without -f
Date: Mon, 26 Mar 2007 23:17:14 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0703262314090.4045@wbgn013.biozentrum.uni-wuerzburg.de>
References: <8aa486160703260759v438d445ev82161600d8e8bf02@mail.gmail.com>
 <20070326185539.GA1650@coredump.intra.peff.net> <7v1wjbwvzl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>,
	Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 23:17:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVwZ7-0003fO-0s
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 23:17:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751884AbXCZVRR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 17:17:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752150AbXCZVRR
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 17:17:17 -0400
Received: from mail.gmx.net ([213.165.64.20]:51947 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751884AbXCZVRQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 17:17:16 -0400
Received: (qmail invoked by alias); 26 Mar 2007 21:17:14 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp044) with SMTP; 26 Mar 2007 23:17:14 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18oVHAkgRcouLZtMrhUUHFiMT0C5sV4o4/9hvM5H+
	UXcsmPqsRW5xEA
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7v1wjbwvzl.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43189>

Hi,

On Mon, 26 Mar 2007, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Given this set of commands:
> >
> >   $ echo "newly added file" >new
> >   $ git add new
> >   $ git rm new
> >
> > the file "new" was previously removed from the working
> > directory and the index. Because it was not in HEAD, it is
> > available only by searching for unreachable objects.
> 
> I am not sure if this is a problem, as the user asked it to be
> removed.  It somehow feels to me that the change (I am not
> convinced your patch should be called a "fix" rather than a
> "behaviour change") would cause more confusion.

I agree it would add to confusion.

It is well established that "git rm" also removes the file _in the working 
directory_.

If you don't want the file to be deleted, but only the corresponding 
entry _in the index_, use "git rm --cached".

Ciao,
Dscho
