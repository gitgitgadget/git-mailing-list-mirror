From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] libgit.a: add some UTF-8 handling functions
Date: Fri, 22 Dec 2006 13:27:47 -0800
Message-ID: <7virg3y624.fsf@assigned-by-dhcp.cox.net>
References: <11655782712452-git-send-email-zeisberg@informatik.uni-freiburg.de>
	<20061221085907.GA2244@cepheus>
	<Pine.LNX.4.63.0612211050450.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<200612211623.14236.litvinov2004@gmail.com>
	<7vejqtaz7q.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612220351520.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0612221030440.18171@xanadu.home>
	<7vslf7zrdp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612222201200.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 22 22:28:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1Gxrvr-0008P7-8S
	for gcvg-git@gmane.org; Fri, 22 Dec 2006 22:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752513AbWLVV1u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 22 Dec 2006 16:27:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752752AbWLVV1u
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Dec 2006 16:27:50 -0500
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:51856 "EHLO
	fed1rmmtao08.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752513AbWLVV1t (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Dec 2006 16:27:49 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061222212749.IJYP16632.fed1rmmtao08.cox.net@fed1rmimpo01.cox.net>;
          Fri, 22 Dec 2006 16:27:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1xT61W0031kojtg0000000; Fri, 22 Dec 2006 16:27:06 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612222201200.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Fri, 22 Dec 2006 22:03:53 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35223>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> This adds utf8_byte_count(), utf8_strlen() and print_wrapped_text().
>
> The most important is probably utf8_strlen(), which returns the length
> of the text, if it is in UTF-8, otherwise -1.
>
> Note that we do not go the full nine yards: we could also check that
> the character is encoded with the minimum amount of bytes, as pointed
> out by Uwe Kleine-Koenig.
>
> The function print_wrapped_text() can be used to wrap text to a certain
> line length.

If you do wrapped_text, I think you do not _want_ strlen (the
definition to me of strlen is "number of characters in the
string").  What you want is a function that returns the number
of columns consumed when displayed on monospace terminal.
