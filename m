From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] gc: call "prune --expire 2.weeks.ago" by default
Date: Wed, 12 Mar 2008 20:38:14 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803122035580.1656@racer.site>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site> <7vskywadum.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803112234470.2947@xanadu.home> <alpine.LSU.1.00.0803121833210.1656@racer.site> <47D8193B.901@nrlssc.navy.mil> <m3prtzyens.fsf@localhost.localdomain>
 <alpine.LSU.1.00.0803122005330.1656@racer.site> <7viqzr69ka.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 20:39:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZWmt-0000bj-B9
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 20:38:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161AbYCLTiN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 15:38:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753764AbYCLTiL
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 15:38:11 -0400
Received: from mail.gmx.net ([213.165.64.20]:40155 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752744AbYCLTiK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 15:38:10 -0400
Received: (qmail invoked by alias); 12 Mar 2008 19:38:08 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp048) with SMTP; 12 Mar 2008 20:38:08 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+SV01Mf2OSM3+Qq/bnDjXggWSCzJapt88k8xjjHT
	TJlHsKaLNF5Px+
X-X-Sender: gene099@racer.site
In-Reply-To: <7viqzr69ka.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76977>

Hi,

On Wed, 12 Mar 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Okay, so I just remove the !approxidate() check.  Then, "gc.pruneExpire = 
> > never" should work as you expect it to.
> 
> Huh?  date.c::special[] has "never" defined for this exact reason.

Oops.  I thought that approxidate() returns 0 on error, but apparently 
this is not so.  Instead, it returns "now"!

So first of all, my patch is incorrect, and second: invalid dates cannot 
be caught reliably.

Darn.

Ciao,
Dscho "who'll think about a way around that"
