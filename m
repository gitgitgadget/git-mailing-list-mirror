From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Don't update index while recursing (was Re: Segfault
 during merge)
Date: Sat, 9 May 2009 09:57:57 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905090954520.27348@pacific.mpi-cbg.de>
References: <alpine.DEB.2.00.0905070102010.30999@narbuckle.genericorp.net> <alpine.DEB.1.00.0905071144370.18521@pacific.mpi-cbg.de> <alpine.DEB.2.00.0905072131470.30999@narbuckle.genericorp.net> <alpine.DEB.1.00.0905082229520.4601@intel-tinevez-2-302>
 <alpine.DEB.2.00.0905081436070.30999@narbuckle.genericorp.net> <alpine.DEB.1.00.0905090012410.4601@intel-tinevez-2-302> <alpine.DEB.2.00.0905081624230.30999@narbuckle.genericorp.net> <alpine.DEB.2.00.0905082224450.30999@narbuckle.genericorp.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Dave O <cxreg@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 09 09:58:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M2hRk-0005TS-BS
	for gcvg-git-2@gmane.org; Sat, 09 May 2009 09:58:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752827AbZEIH56 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 May 2009 03:57:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752498AbZEIH56
	(ORCPT <rfc822;git-outgoing>); Sat, 9 May 2009 03:57:58 -0400
Received: from mail.gmx.net ([213.165.64.20]:56428 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751370AbZEIH55 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 May 2009 03:57:57 -0400
Received: (qmail invoked by alias); 09 May 2009 07:57:57 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp047) with SMTP; 09 May 2009 09:57:57 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19rPR4Q6BRrbcniXcO3CDElRXlHgW52c1qr+FRRDq
	XzfUfGfdkzWcFx
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.2.00.0905082224450.30999@narbuckle.genericorp.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118652>

Hi,

On Fri, 8 May 2009, Dave O wrote:

> On Fri, 8 May 2009, Dave O wrote:
> 
> > Once again, I don't really know what the implications of the index 
> > operations that are happening here are, but the update_stages() call 
> > in a recursive merge must be doing surprising.
> 
> After writing this, I took another look around merge-recursive.c, and 
> realized that all the calls to update_stages() except this one were 
> careful only to do it when o->call_depth was 0.  This simple patch seems 
> to fully rectify the problem.

ACK.

Could you provide a commit message saying that call_depth > 0 requires 
trees to be constructed from the files with conflicts and that the stages 
thusly must not be updated?

Oh, and you may want to adjust the test I made from your script (you said 
you made it shorter, but you made the original version shorter, which does 
not run in the test suite unmodified).

And then a Signed-off-by, and you're good to go!

Sorry for my lousy attempt to help...

Ciao,
Dscho
