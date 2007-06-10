From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 04/21] Refactor verification of "tagger" line to be more
 similar to verification of "type" and "tagger" lines
Date: Sun, 10 Jun 2007 08:49:35 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706100846250.4059@racer.site>
References: <Pine.LNX.4.64.0706072348110.4046@racer.site>
 <7vzm3aig7j.fsf@assigned-by-dhcp.cox.net> <200706090210.36270.johan@herland.net>
 <200706090214.11589.johan@herland.net> <7vr6olf1m7.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johan Herland <johan@herland.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 09:52:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxIED-0007jA-U3
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 09:52:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762090AbXFJHwt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Jun 2007 03:52:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762015AbXFJHws
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 03:52:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:49119 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762001AbXFJHws (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 03:52:48 -0400
Received: (qmail invoked by alias); 10 Jun 2007 07:52:46 -0000
Received: from rdcg01.wifihubtelecom.net (EHLO [10.140.3.169]) [213.174.113.122]
  by mail.gmx.net (mp053) with SMTP; 10 Jun 2007 09:52:46 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19fwhNihVJfYuwZPtY3vGSm7+wot58S8zNt7fc5n0
	2pL6eDA1wzxKgX
X-X-Sender: gene099@racer.site
In-Reply-To: <7vr6olf1m7.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49667>

Hi,

On Sat, 9 Jun 2007, Junio C Hamano wrote:

> Johan Herland <johan@herland.net> writes:
> 
> > +	if (!tag_line++)
> >  		return error("char" PD_FMT ": could not find next \"\\n\"", type_line - data);
> > -	tag_line++;

BTW if you _are_ verbosing the output, you might just as well make it 
useful.

The common format is "filename:line[:column]:message", not "char[n]", 
which is a misnomer to begin with, since you are talking about an offset, 
not a char (remember, characters are those things that are displayed in 
place for a given number, so I fully expected char32 to be a space).

Ciao,
Dscho
