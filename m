From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Simplify crud() in ident.c
Date: Mon, 3 Dec 2007 22:48:19 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0712032247140.27959@racer.site>
References: <20071203191143.GB17671@steel.home> <Pine.LNX.4.64.0712032046480.27959@racer.site>
 <20071203213702.GD17671@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 03 23:49:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzK6Y-0000yH-Hl
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 23:49:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750885AbXLCWtN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 17:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751034AbXLCWtN
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 17:49:13 -0500
Received: from mail.gmx.net ([213.165.64.20]:32981 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750866AbXLCWtM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 17:49:12 -0500
Received: (qmail invoked by alias); 03 Dec 2007 22:49:11 -0000
Received: from unknown (EHLO openvpn-client) [138.251.11.103]
  by mail.gmx.net (mp033) with SMTP; 03 Dec 2007 23:49:11 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19g2QVBMuJgBaJ+u1Xr1JQH+dwp9dvjcBGv5HHTfc
	t9mvlTQfbR6Tim
X-X-Sender: gene099@racer.site
In-Reply-To: <20071203213702.GD17671@steel.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66968>

Hi,

On Mon, 3 Dec 2007, Alex Riesen wrote:

> Johannes Schindelin, Mon, Dec 03, 2007 21:47:09 +0100:
> > On Mon, 3 Dec 2007, Alex Riesen wrote:
> > > +	return  c <= 32  ||
> > > +		c == '.' ||
> > > +		c == ',' ||
> > > +		c == ':' ||
> > > +		c == ';' ||
> > > +		c == '<' ||
> > > +		c == '>' ||
> > > +		c == '"' ||
> > > +		c == '\'';
> > 
> > Or enhance ctype.c.
> > 
> 
> That's be nice, but the "crud" conflicts with existing classification,
> so I'd have to change the is*-macros as well. Don't feel like it.
> 
> I believe the code is never in hotpath anyway so the shorter the
> better.

Really?

	return !!strchr(".,:;<>\"\\", c);

Ciao,
Dscho
