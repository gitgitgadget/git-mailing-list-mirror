From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Support 64-bit indexes for pack files.
Date: Tue, 27 Feb 2007 21:35:53 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702272134040.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702261540.27080.ttelford.groups@gmail.com>
 <20070226235510.GF1639@spearce.org> <alpine.LRH.0.82.0702261916560.29426@xanadu.home>
 <20070227003118.GH1639@spearce.org> <alpine.LRH.0.82.0702262306100.29426@xanadu.home>
 <79B129C3-C1B5-43E3-97DA-1ADC70642B88@adacore.com>
 <alpine.LRH.0.82.0702270002100.29426@xanadu.home>
 <5FE0C988-0DA8-4BFB-8F0C-42F97808E6F8@adacore.com>
 <Pine.LNX.4.63.0702272102440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <F4EA27AD-EF1C-4BF2-8D52-945E0AE51006@adacore.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Troy Telford <ttelford.groups@gmail.com>, git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Tue Feb 27 21:36:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM93J-0005h1-CO
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 21:36:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933076AbXB0Uf6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 15:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933085AbXB0Uf6
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 15:35:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:56642 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933076AbXB0Uf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 15:35:57 -0500
Received: (qmail invoked by alias); 27 Feb 2007 20:35:55 -0000
X-Provags-ID: V01U2FsdGVkX1/opngFRujownRrQH6KjnndbUTNWh7o4/XpDW8EGx
	PTBg==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <F4EA27AD-EF1C-4BF2-8D52-945E0AE51006@adacore.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40790>

Hi,

On Tue, 27 Feb 2007, Geert Bosch wrote:

> 
> On Feb 27, 2007, at 15:05, Johannes Schindelin wrote:
> > On Tue, 27 Feb 2007, Geert Bosch wrote:
> > 
> > > The object-count at the beginning of the pack is a little strange 
> > > for local on-disk pack files, as it is data that can easily be 
> > > derived.
> > 
> > The SHA1 is also easily derived. So think of it as a doubly secure way 
> > to ensure integrity.
> > 
> > Remember, there were some people unable to accept that SHA1 collisions 
> > are _unlikely_...
> 
> Ah, you include the count because you don't trust the SHA1 and now you 
> can count that you got the right number of objects ;-)

I don't know if it was included for that reason, but you can excuse it 
that way. :-)

> It's just that I don't see a use for the count in a local on-disk pack. 
> In these cases we'll always have an index. We can keep the current 
> protocol for sending/receiving packs, no need to ever upgrade to v4 
> there.

But the protocol expects a valid pack! (Including a count...)

Besides, the pack index is a purely local thin, reconstructed from the 
pack when fetching...

Ciao,
Dscho
