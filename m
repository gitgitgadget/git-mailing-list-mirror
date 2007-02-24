From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fixup no-progress for fetch & clone
Date: Sat, 24 Feb 2007 02:47:42 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702240245500.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0702232002480.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vfy8w3add.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0702240217550.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <7vvehs1gxy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 24 02:56:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HKm9B-0003xI-MK
	for gcvg-git@gmane.org; Sat, 24 Feb 2007 02:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933324AbXBXB4X (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Feb 2007 20:56:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933329AbXBXB4X
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Feb 2007 20:56:23 -0500
Received: from mail.gmx.net ([213.165.64.20]:45378 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933324AbXBXB4W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Feb 2007 20:56:22 -0500
Received: (qmail invoked by alias); 24 Feb 2007 01:47:42 -0000
X-Provags-ID: V01U2FsdGVkX1/r9Z9NtQjrFTC+OriLFcfOw9kXBfH3GTuRO8o4eR
	oKRA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <7vvehs1gxy.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40489>

Hi,

On Fri, 23 Feb 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Since most servers will not have a no-progress aware upload-pack, how 
> > about this? (It is slightly ugly, but at least works...)
> 
> Please no.
> 
> What's "slight" about this ugliness?
> 
> > +		if (no_progress && band != 3 && len > 7 + 5 &&
> > +				!prefixcmp(buf + 7 + len - 5, "done\r"))
> > +			continue;

This is not the part I found ugly. In sideband, there is a lot of 7+len, 
8+len, buf+7.

The part I found ugly is having to touch builtin-archive.c

But I agree that we should not include that in mainline git. But at least 
this patch is in the open for people who care deeply about no-progress 
_now_...

Ciao,
Dscho
