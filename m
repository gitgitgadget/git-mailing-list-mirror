From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: That improved git-gui blame viewer..
Date: Wed, 13 Jun 2007 15:58:00 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706131553390.4059@racer.site>
References: <alpine.LFD.0.98.0706091117510.20321@woody.linux-foundation.org>
  <7vveduqxxr.fsf@assigned-by-dhcp.pobox.com> 
 <e5bfff550706112316j42c7c8e8uf8383de990ca9707@mail.gmail.com> 
 <7vbqflll55.fsf@assigned-by-dhcp.pobox.com> 
 <e5bfff550706120427g7ad9d38bpc34d9ea284ace693@mail.gmail.com> 
 <20070612135303.GT6073@spearce.org>  <7v645thto7.fsf@assigned-by-dhcp.pobox.com>
  <e5bfff550706130411g151b76e3sa2e351aff5dbb35b@mail.gmail.com> 
 <e5bfff550706130544m40e2f210p2412ef7fde2867a1@mail.gmail.com> 
 <Pine.LNX.4.64.0706131344430.4059@racer.site>
 <e5bfff550706130708k601514c9o1ba2747582027699@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 17:01:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyULf-0006Q9-2J
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 17:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758010AbXFMPBY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 11:01:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757758AbXFMPBY
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 11:01:24 -0400
Received: from mail.gmx.net ([213.165.64.20]:37900 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756619AbXFMPBX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 11:01:23 -0400
Received: (qmail invoked by alias); 13 Jun 2007 15:01:21 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp054) with SMTP; 13 Jun 2007 17:01:21 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19rAXAgVKprhahRmhq47N2OuS42B4fvU1I0gbeAeA
	jNb+lPrKB5/Jco
X-X-Sender: gene099@racer.site
In-Reply-To: <e5bfff550706130708k601514c9o1ba2747582027699@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50071>

Hi,

On Wed, 13 Jun 2007, Marco Costalba wrote:

> On 6/13/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > >
> > > then running: git log --pretty=raw -z --parents --boundary HEAD > tmp.txt
> > 
> > Isn't that a bit unfair? You should have passed "--pretty=raw" to
> > rev-list, too.
> > 
> > Since you already have that tree, could you try rev-list _with_
> > "--pretty=raw", just for comparison?
> > 
> 
> Of course, here we are
> 
> running: git rev-list --pretty=raw --parents --boundary HEAD > tmp.txt
> 
> times are: 1,16s - 1,11s - 1,13s

I just tested on cygwin. The funny thing is, I never get anything like 8 
seconds (this is on git.git itself).

For me it is

~1.0s	rev-list _without_ --pretty=raw
~1.6s	rev-list _with_ --pretty=raw
~1.4s	log _with_ --pretty=raw
~3.5s	log _with_ --pretty=raw _and_ -z (!)

So, your delay could stem from -z doing weird things.

For fun, I also did it with the MinGW port:

~0.7s	rev-list _without_ --pretty=raw
~1.0s	rev-list _with_ --pretty=raw
~0.8s	log _with_ --pretty=raw
~1.9s	log _with_ --pretty=raw _and_ -z (!)

Draw your conclusions, gentlemen.

Ciao,
Dscho
