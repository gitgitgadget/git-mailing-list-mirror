From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: [PATCH] Simplify crud() in ident.c
Date: Mon, 3 Dec 2007 22:37:02 +0100
Message-ID: <20071203213702.GD17671@steel.home>
References: <20071203191143.GB17671@steel.home> <Pine.LNX.4.64.0712032046480.27959@racer.site>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Dec 03 22:37:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzIz6-00082V-7o
	for gcvg-git-2@gmane.org; Mon, 03 Dec 2007 22:37:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751245AbXLCVhH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 16:37:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751071AbXLCVhH
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 16:37:07 -0500
Received: from mo-p07-ob.rzone.de ([81.169.146.189]:17923 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751145AbXLCVhF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 16:37:05 -0500
X-RZG-CLASS-ID: mo07
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBsEfFs=
Received: from tigra.home (Fcbaf.f.strato-dslnet.de [195.4.203.175])
	by post.webmailer.de (fruni mo19) (RZmta 14.5)
	with ESMTP id C020b2jB3Iex59 ; Mon, 3 Dec 2007 22:37:02 +0100 (MET)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 71CA4277AE;
	Mon,  3 Dec 2007 22:37:02 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 56D5756D22; Mon,  3 Dec 2007 22:37:02 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0712032046480.27959@racer.site>
User-Agent: Mutt/1.5.15+20070412 (2007-04-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66962>

Johannes Schindelin, Mon, Dec 03, 2007 21:47:09 +0100:
> On Mon, 3 Dec 2007, Alex Riesen wrote:
> > +	return  c <= 32  ||
> > +		c == '.' ||
> > +		c == ',' ||
> > +		c == ':' ||
> > +		c == ';' ||
> > +		c == '<' ||
> > +		c == '>' ||
> > +		c == '"' ||
> > +		c == '\'';
> 
> Or enhance ctype.c.
> 

That's be nice, but the "crud" conflicts with existing classification,
so I'd have to change the is*-macros as well. Don't feel like it.

I believe the code is never in hotpath anyway so the shorter the
better.
