From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: MinGW port usable
Date: Tue, 30 Jan 2007 17:12:25 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701301708160.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200701292320.43888.johannes.sixt@telecom.at>
 <Pine.LNX.4.64.0701291438580.3611@woody.linux-foundation.org>
 <Pine.LNX.4.63.0701301524360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070130151803.GA25779@spearce.org> <Pine.LNX.4.63.0701301635050.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <20070130155653.GB25950@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <johannes.sixt@telecom.at>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Jan 30 17:15:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBvbg-0007x7-FD
	for gcvg-git@gmane.org; Tue, 30 Jan 2007 17:13:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965576AbXA3QM2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 11:12:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965578AbXA3QM2
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 11:12:28 -0500
Received: from mail.gmx.net ([213.165.64.20]:34192 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965576AbXA3QM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 11:12:27 -0500
Received: (qmail invoked by alias); 30 Jan 2007 16:12:26 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp032) with SMTP; 30 Jan 2007 17:12:26 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <20070130155653.GB25950@spearce.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38163>

Hi,

On Tue, 30 Jan 2007, Shawn O. Pearce wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > On Tue, 30 Jan 2007, Shawn O. Pearce wrote:
> > > Just curious, but were these tests run with mmap(), or NO_MMAP?
> > 
> > Both with NO_MMAP=YesPlease.
> 
> I wonder what the difference is between NO_MMAP=Yes and NO_MMAP=
> on Windows.

Cygwin:

	$ time git-rev-list next >/dev/null

	real    0m0.812s
	user    0m0.358s
	sys     0m0.203s

	$ time git-rev-list next >/dev/null

	real    0m0.797s
	user    0m0.358s
	sys     0m0.234s

	$ time git-rev-list next >/dev/null

	real    0m0.845s
	user    0m0.390s
	sys     0m0.265s

and

	$ time git-log next >/dev/null

	real    0m2.094s
	user    0m0.718s
	sys     0m1.077s

	$ time git-log next >/dev/null

	real    0m2.078s
	user    0m0.718s
	sys     0m1.062s

	$ time git-log next >/dev/null

	real    0m2.124s
	user    0m0.796s
	sys     0m1.046s

IOW, the numbers are slightly worse (!) than with mmap().

MinGW does not even have mmap().

Ciao,
Dscho
