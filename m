From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Optimized cvsexportcommit: calling 'cvs status' only
 once instead of once per changed file.
Date: Wed, 9 May 2007 14:25:36 +0200 (CEST)
Message-ID: <Pine.LNX.4.64.0705091424190.4167@racer.site>
References: <0056A63A-D511-4FDD-82A6-A13B06E237E9@zib.de>
 <Pine.LNX.4.64.0705091303280.4167@racer.site> <4BA4CF7D-40CB-4A55-ADDC-56DE179FD6C1@zib.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed May 09 14:25:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HllEn-0007Ae-VQ
	for gcvg-git@gmane.org; Wed, 09 May 2007 14:25:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756307AbXEIMZg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 08:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756385AbXEIMZg
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 08:25:36 -0400
Received: from mail.gmx.net ([213.165.64.20]:46122 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755763AbXEIMZc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 08:25:32 -0400
Received: (qmail invoked by alias); 09 May 2007 12:25:31 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp020) with SMTP; 09 May 2007 14:25:31 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18jL+02FqEjv85dhoG1kv5JDE/duJiuY9q+UlS4Zz
	0PWWeEJjpR5Rx7
X-X-Sender: gene099@racer.site
In-Reply-To: <4BA4CF7D-40CB-4A55-ADDC-56DE179FD6C1@zib.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46701>

Hi,

On Wed, 9 May 2007, Steffen Prohaska wrote:

> On May 9, 2007, at 1:04 PM, Johannes Schindelin wrote:
> 
> > On Wed, 9 May 2007, Steffen Prohaska wrote:
> > 
> > > The old implementation executed 'cvs status' for each file touched by
> > > the patch to be applied.
> > 
> > I did not follow development of that script closely, but could it be that
> > this is a safety valve, to make it unlikely to commit something which was
> > changed by somebody else in the meantime?
> 
> Right. My patch doesn't change the functionality of the safety check. It's
> just a magnitude faster if you commit a lot of files. I'm now able to apply a
> patch that changes 900 files to a cvs working copy using ssh over DSL. I
> wasn't before, at least not in reasonable time.

What I was trying to get at: if you commit 900 files, and after the 450th 
file somebody _else_ commits a file, which just so happens to be one of 
your 450 remaining files, that safety check no longer holds.

CVS is slow.

Ciao,
Dscho
