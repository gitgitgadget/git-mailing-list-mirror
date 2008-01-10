From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] bundle, fast-import: detect write failure
Date: Thu, 10 Jan 2008 12:37:56 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801101234580.31053@racer.site>
References: <874pdmhxha.fsf@rho.meyering.net> <alpine.LSU.1.00.0801101204120.31053@racer.site> <87myrdhnn5.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git list <git@vger.kernel.org>
To: Jim Meyering <jim@meyering.net>
X-From: git-owner@vger.kernel.org Thu Jan 10 13:38:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCwg4-0001t5-RU
	for gcvg-git-2@gmane.org; Thu, 10 Jan 2008 13:38:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097AbYAJMiE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jan 2008 07:38:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754090AbYAJMiD
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jan 2008 07:38:03 -0500
Received: from mail.gmx.net ([213.165.64.20]:39295 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754059AbYAJMiB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jan 2008 07:38:01 -0500
Received: (qmail invoked by alias); 10 Jan 2008 12:37:58 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp006) with SMTP; 10 Jan 2008 13:37:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/SD64dPYrSS99SsFDhZQiksz2fno0iFIsKS4/buy
	4r2mczG/StfL3K
X-X-Sender: gene099@racer.site
In-Reply-To: <87myrdhnn5.fsf@rho.meyering.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70066>

Hi,

On Thu, 10 Jan 2008, Jim Meyering wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
>
> > I recently read an article which got me thinking about close().  The 
> > author maintained that many mistakes are done by being overzealously 
> > defensive; die()ing in case of a close() failure (when open() 
> > succeeded!) might be just wrong.
> 
> No.  Whether open succeeded is a separate matter. Avoiding an unreported 
> write (or close-writable-fd) failure is not being "overzealously 
> defensive."

Are you aware what this code does?  It writes a ".keep" file.  Whose 
purpose is to _exist_, and whose purpose is fulfilled, even if the write 
or the push-back did not succeed.

I could not care less what the manual says.  What is important is if the 
defensive programming is done mindlessly, and therefore can fail so not 
gracefully.

Ciao,
Dscho
