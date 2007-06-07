From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Accept dates before 2000/01/01 when specified as seconds
 since the epoch
Date: Thu, 7 Jun 2007 06:30:23 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0706070629180.4046@racer.site>
References: <11811175153355-git-send-email-johannes.sixt@telecom.at>
 <7vtztl5vvb.fsf@assigned-by-dhcp.cox.net> <46679320.6000309@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Jun 07 07:32:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HwAbw-0003oW-Qy
	for gcvg-git@gmane.org; Thu, 07 Jun 2007 07:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753664AbXFGFcf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 7 Jun 2007 01:32:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754611AbXFGFcf
	(ORCPT <rfc822;git-outgoing>); Thu, 7 Jun 2007 01:32:35 -0400
Received: from mail.gmx.net ([213.165.64.20]:60869 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753664AbXFGFce (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Jun 2007 01:32:34 -0400
Received: (qmail invoked by alias); 07 Jun 2007 05:32:32 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp046) with SMTP; 07 Jun 2007 07:32:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/lsOMSDy/l8CzOU7iR6n0ClqoWxmQwWQqAivzfDs
	Ww44L9UTpCnRfv
X-X-Sender: gene099@racer.site
In-Reply-To: <46679320.6000309@vilain.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49356>

Hi,

On Thu, 7 Jun 2007, Sam Vilain wrote:

> Junio C Hamano wrote:
> > I vaguely recall hitting the same issue soon after date.c was
> > done, and sending in a patch in the same spirit but with
> > different implementation (I essentially duplicated that "seconds
> > since epoch" without any cutoff as the last ditch fallback) long
> > time ago (this was before I took git over; the patch was rejected).
> > 
> > It almost makes me wonder if it is better to introduce a special
> > syntax to denote "seconds since epoch plus timezone offset" for
> > our Porcelain use, instead of keeping this arbitrary cut-off
> > date which nobody can agree on and which forces us to roll back
> > from time to time.  For one thing, such a syntax would allow us
> > to talk about a timestamp before the epoch.
> > 
> > Perhaps
> > 
> > 	"epoch" [-+] [0-9]+ " " [-+][0-9][0-9][0-9][0-9]
> 
> Probably a good idea, though it would break cg-admin-rewritehist.

FWIW I don't think we have to care that much about cg-admin-rewritehist, 
since it lives on as git-filter-branch, and we can adapt it as we go.

Ciao,
Dscho
