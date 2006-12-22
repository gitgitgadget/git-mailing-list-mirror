From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] libgit.a: add some UTF-8 handling functions
Date: Fri, 22 Dec 2006 22:36:05 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612222233150.19693@wbgn013.biozentrum.uni-wuerzburg.de>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de>
 <20061221085907.GA2244@cepheus> <Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <200612211623.14236.litvinov2004@gmail.com> <7vejqtaz7q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612220351520.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0612221030440.18171@xanadu.home> <7vslf7zrdp.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0612222201200.19693@wbgn013.biozentrum.uni-wuerzburg.de>
 <7virg3y624.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 22:36:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxs3o-0001O1-1g
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 22:36:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752869AbWLVVgJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 16:36:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752793AbWLVVgJ
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 16:36:09 -0500
Received: from mail.gmx.net ([213.165.64.20]:42821 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752356AbWLVVgH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 16:36:07 -0500
Received: (qmail invoked by alias); 22 Dec 2006 21:36:05 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 22 Dec 2006 22:36:05 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virg3y624.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35224>

Hi,

On Fri, 22 Dec 2006, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > This adds utf8_byte_count(), utf8_strlen() and print_wrapped_text().
> >
> > The most important is probably utf8_strlen(), which returns the length
> > of the text, if it is in UTF-8, otherwise -1.
> >
> > Note that we do not go the full nine yards: we could also check that
> > the character is encoded with the minimum amount of bytes, as pointed
> > out by Uwe Kleine-Koenig.
> >
> > The function print_wrapped_text() can be used to wrap text to a certain
> > line length.
> 
> If you do wrapped_text, I think you do not _want_ strlen (the
> definition to me of strlen is "number of characters in the
> string").  What you want is a function that returns the number
> of columns consumed when displayed on monospace terminal.

To me, characters are the symbols occupying one "column" each. Bytes are 
the 8-bit thingies that you usually use to encode the characters.

Ciao,
Dscho
