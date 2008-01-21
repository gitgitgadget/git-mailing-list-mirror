From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] read-cache.c: fix timestamp comparison
Date: Mon, 21 Jan 2008 19:06:14 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801211905100.5731@racer.site>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com> <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org>
 <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org> <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> <7vfxwvfmd8.fsf_-_@gitster.siamese.dyndns.org> <7vr6gb3nv1.fsf@gitster.siamese.dyndns.org>
 <alpine.LFD.1.00.0801202114580.2957@woody.linux-foundation.org> <7vd4rv3ds5.fsf@gitster.siamese.dyndns.org> <7vtzl71x1c.fsf@gitster.siamese.dyndns.org> <7vprvv1wnu.fsf@gitster.siamese.dyndns.org> <7vlk6j1wjj.fsf@gitster.siamese.dyndns.org>
 <7vhch71vvb.fsf@gitster.siamese.dyndns.org> <7v8x2j1sul.fsf@gitster.siamese.dyndns.org> <7vzluzzhud.fsf_-_@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0801211022350.2957@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Mon Jan 21 20:06:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JH1ys-0001Fe-PH
	for gcvg-git-2@gmane.org; Mon, 21 Jan 2008 20:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752002AbYAUTGV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jan 2008 14:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751804AbYAUTGV
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Jan 2008 14:06:21 -0500
Received: from mail.gmx.net ([213.165.64.20]:54276 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751163AbYAUTGU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jan 2008 14:06:20 -0500
Received: (qmail invoked by alias); 21 Jan 2008 19:06:16 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp020) with SMTP; 21 Jan 2008 20:06:16 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Brrd5JzUBbli9fQk0LBTMje69PxFLFA1z/rqFyN
	3leFxRJ/nWbzdU
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.1.00.0801211022350.2957@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71309>

Hi,

On Mon, 21 Jan 2008, Linus Torvalds wrote:

> On Mon, 21 Jan 2008, Junio C Hamano wrote:
> >
> > The mtime recorded in the cache entry is not time_t anymore but of 
> > type (unsigned int).  This casts the comparison and also adds fuzz 
> > factor of 1 second.
> 
> I really don't think this is the right fix.

Junio, have you tried Hannes' fix (using ln instead of cp -p)?  I would 
not be surprised if the same happened on Linux as on Windows, only much 
rarer, since Linux is so darned fast...

Ciao,
Dscho
