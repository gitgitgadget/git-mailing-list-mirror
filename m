From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Replacing the system call pread() with real mmap().
Date: Sun, 7 Jan 2007 18:10:55 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701071810220.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070106170330.GA8041@scotty.home> <20070107060007.GA10351@spearce.org>
 <20070107111712.GB9909@scotty.home> <20070107112445.GE10351@spearce.org>
 <20070107163637.GE9909@scotty.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 18:11:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3bXy-0004OO-5i
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 18:11:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964785AbXAGRK6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 7 Jan 2007 12:10:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932618AbXAGRK6
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Jan 2007 12:10:58 -0500
Received: from mail.gmx.net ([213.165.64.20]:49063 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932613AbXAGRK6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jan 2007 12:10:58 -0500
Received: (qmail invoked by alias); 07 Jan 2007 17:10:56 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp029) with SMTP; 07 Jan 2007 18:10:56 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: "Stefan-W. Hahn" <stefan.hahn@s-hahn.de>
In-Reply-To: <20070107163637.GE9909@scotty.home>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36178>

Hi,

On Sun, 7 Jan 2007, Stefan-W. Hahn wrote:

> Also sprach Shawn O. Pearce am Sun, 07 Jan 2007 at 06:24:45 -0500:
> > Better to emulate pread using lseek/xread/lseek:
> > 
> > 	off_t p = lseek(fd, offset, SEEK_SET);
> > 	xread(fd, buf, count);
> > 	lseek(fd, p, SEEK_SET);
> > 
> > If you look at the history for contrib/mmap.c you will see an
> > implementation like that before it was called git_mmap().
> 
> This doesn't work;I tried it before.

Care to elaborate? It worked pretty well on _all_ cygwin setups I tested 
with.

Ciao,
Dscho
