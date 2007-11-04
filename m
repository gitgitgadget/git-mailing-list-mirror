From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add more tests for git-clean
Date: Sun, 4 Nov 2007 23:49:50 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711042348540.4362@racer.site>
References: <1194202941253-git-send-email-shawn.bohrer@gmail.com>
 <11942029442710-git-send-email-shawn.bohrer@gmail.com>
 <7vve8hr3ch.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Shawn Bohrer <shawn.bohrer@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 00:50:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IopF0-0007Be-9P
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 00:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753971AbXKDXuk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2007 18:50:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753972AbXKDXuk
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 18:50:40 -0500
Received: from mail.gmx.net ([213.165.64.20]:46652 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753837AbXKDXuk (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 18:50:40 -0500
Received: (qmail invoked by alias); 04 Nov 2007 23:50:38 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp047) with SMTP; 05 Nov 2007 00:50:38 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18PbLt7haMPXKXF1mTjE6B8rzgGX0bzf+9L0+FM6j
	3Waozibk2A2DMB
X-X-Sender: gene099@racer.site
In-Reply-To: <7vve8hr3ch.fsf@gitster.siamese.dyndns.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63461>

Hi,

On Sun, 4 Nov 2007, Junio C Hamano wrote:

> Shawn Bohrer <shawn.bohrer@gmail.com> writes:
> 
> > +test_expect_success 'git-clean with prefix' '
> > +
> > +	mkdir -p build docs &&
> > +	touch a.out src/part3.c docs/manual.txt obj.o build/lib.so &&
> > +	cd src/ &&
> > +	git-clean &&
> > +	cd - &&
> 
> This is wrong for two reasons.
> 
>  - Is "cd -" portable?
> 
>  - What happens when git-clean fails?  This test fails, and then
>    it goes on to the next test without cd'ing back.

So it should be

	(cd src/ && git clean) &&

right?  (Note that I also removed the dash, since it will be a builtin 
after the next commit.)

Ciao,
Dscho
