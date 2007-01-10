From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Replacing the system call pread() with lseek()/xread()/lseek()
 sequence.
Date: Wed, 10 Jan 2007 01:30:47 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701100128410.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45A40C15.1070200@shadowen.org> <20070109232540.GA30023@spearce.org>
 <7v7ivvivej.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 01:30:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4RMi-00018D-NA
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 01:30:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932557AbXAJAau (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 19:30:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932586AbXAJAau
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 19:30:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:52207 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932557AbXAJAat (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 19:30:49 -0500
Received: (qmail invoked by alias); 10 Jan 2007 00:30:48 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp030) with SMTP; 10 Jan 2007 01:30:48 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v7ivvivej.fsf@assigned-by-dhcp.cox.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36442>

Hi,

On Tue, 9 Jan 2007, Junio C Hamano wrote:

> The caller of pread() does not care the current position, but that is 
> not to mean it does not care the position after pread() returns.  The 
> current callers do not care, though.

Not completely true. We fixed in v1.4.4.1~23 a bug which was triggered by 
NO_MMAP. Since this recently became the default for cygwin, 
"git-index-pack --fix-thin" would fail in most cases.

Ciao,
Dscho
