From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] rebase -i: several cleanups
Date: Wed, 27 Jun 2007 11:33:22 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706271130020.4438@racer.site>
References: <Pine.LNX.4.64.0706251856300.4059@racer.site>
 <7vk5tqurrw.fsf@assigned-by-dhcp.pobox.com> <Pine.LNX.4.64.0706270216070.4438@racer.site>
 <7vodj2tazk.fsf@assigned-by-dhcp.pobox.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 27 12:39:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3Uva-0005JT-IR
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 12:39:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930AbXF0KjN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 06:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753678AbXF0KjN
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 06:39:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:37633 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753832AbXF0KjM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 06:39:12 -0400
Received: (qmail invoked by alias); 27 Jun 2007 10:39:10 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp058) with SMTP; 27 Jun 2007 12:39:10 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/xekgsBX3xkufnXu+4D6RglVZeugkDvpZR3Jhq4W
	WsougKpolJH6Oi
X-X-Sender: gene099@racer.site
In-Reply-To: <7vodj2tazk.fsf@assigned-by-dhcp.pobox.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51030>

Hi,

On Tue, 26 Jun 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> >> > +die_abort () {
> >> > +	rm -rf "$DOTEST" 2> /dev/null
> >> > +	die "$1"
> >> > +}
> >> 
> >> Why "2>/dev/null" here?
> >
> > Just to be sure. If it does not exist, it's no error. No sense alarming 
> > the user.
> 
> Yeah, but isn't that exactly why you have "-f" there?  On the
> other hand, if $DOTEST exists but for some reason couldn't be
> removed, we probably would want to know about it.
> 
>     $ rm -fr no-such
>     $ mkdir no-such
>     $ echo >no-such/file
>     $ rm -fr no-such
>     $ mkdir no-such
>     $ echo >no-such/file
>     $ chmod a-w no-such
>     $ rm -fr no-such
>     rm: cannot remove `no-such/file': Permission denied

Good point.

Okay, let's leave the 2> /dev/null out.

Ciao,
Dscho
