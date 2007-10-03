From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add test case for ls-files --with-head
Date: Wed, 3 Oct 2007 16:36:13 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710031634300.28395@racer.site>
References: <1191390255.16292.2.camel@koto.keithp.com>
 <7vtzp8g2s2.fsf@gitster.siamese.dyndns.org> <87y7ekr86e.wl%cworth@cworth.org>
 <47038669.30302@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Carl Worth <cworth@cworth.org>, Junio C Hamano <gitster@pobox.com>,
	Keith Packard <keithp@keithp.com>,
	Git Mailing List <git@vger.kernel.org>
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Oct 03 17:37:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Id6I6-0005Uu-LS
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 17:37:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727AbXJCPhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 11:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752731AbXJCPhb
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 11:37:31 -0400
Received: from mail.gmx.net ([213.165.64.20]:45177 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752240AbXJCPha (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 11:37:30 -0400
Received: (qmail invoked by alias); 03 Oct 2007 15:37:28 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp052) with SMTP; 03 Oct 2007 17:37:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+JJYg7d9KJDbkCkN6lz08MpdT85TKTenlWYKz0rm
	p9gyC8bjsndH/I
X-X-Sender: gene099@racer.site
In-Reply-To: <47038669.30302@viscovery.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59845>

Hi,

On Wed, 3 Oct 2007, Johannes Sixt wrote:

> Carl Worth schrieb:
> > +for num in $(seq -f%04g 1 50); do
> > +	touch sub/file-$num
> > +	echo file-$num >> expected
> > +done
> 
> seq is not universally available. Can we have that as
> 
> for i in 0 1 2 3 4; do
> 	for j in 0 1 2 3 4 5 6 7 8 9; do
> 		> sub/file-$i$j
> 		echo file-$i$j >> expected
> 	done
> done

Or as

	i=1
	while test $i -le 50
	do
		num=$(printf %04d $i)
		> sub/file-$num
		echo file-$num >> expected
		i=$(($i+1))
	done

This version should be as portable, with the benefit that it is easier to 
change for different start and end values.

Ciao,
Dscho
