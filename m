From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] log_ref_write() -- do not chomp reflog message at
 the first LF
Date: Sun, 29 Jul 2007 20:02:21 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707292001580.14781@racer.site>
References: <724DFB31-0471-4A5E-95DF-F5F74876AC77@lrde.epita.fr>
 <7v8x90sp25.fsf@assigned-by-dhcp.cox.net> <20070728083536.540e471d.seanlkml@sympatico.ca>
 <7vodhwptba.fsf@assigned-by-dhcp.cox.net> <20070728092914.48f6305c.seanlkml@sympatico.ca>
 <7vk5skps1g.fsf@assigned-by-dhcp.cox.net> <20070728101156.20304d11.seanlkml@sympatico.ca>
 <7vd4ycp8ff.fsf@assigned-by-dhcp.cox.net> <7vzm1gnhin.fsf@assigned-by-dhcp.cox.net>
 <7vvec4nhfk.fsf_-_@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0707291248560.14781@racer.site>
 <7vsl77m4i1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Sean <seanlkml@sympatico.ca>, Benoit SIGOURE <tsuna@lrde.epita.fr>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 29 21:02:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFE2L-00025p-Fa
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 21:02:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762742AbXG2TCi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 15:02:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1764703AbXG2TCi
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 15:02:38 -0400
Received: from mail.gmx.net ([213.165.64.20]:56929 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752158AbXG2TCi (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 15:02:38 -0400
Received: (qmail invoked by alias); 29 Jul 2007 19:02:36 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp002) with SMTP; 29 Jul 2007 21:02:36 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18FzEg/m2EFEK7Iu3tz3SkvFo4TQ7V8Sm66NlJjHj
	SFUArLJHyncZsM
X-X-Sender: gene099@racer.site
In-Reply-To: <7vsl77m4i1.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54133>

Hi,

On Sun, 29 Jul 2007, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > It is not like the reflog messages have to be very verbose; they only have 
> > to give a hint what the commit was about, and the commit name is the 
> > important information.
> 
> I've considered it, but decided against it because:
> 
>  (1) I did not like the information lossage;
> 
>  (2) this is solely to help log messages coming from outside the
>      recommended convention, and having excess will not hurt the
>      normal usage;
> 
>  (3) it is not known if messages from outside the recommended
>      convention have enough information on its first line of the
>      first paragraph; the result of s/\n.*/.../ may not be
>      sufficient "hint";

Good catch.  Didn't think of that.

Ciao,
Dscho
