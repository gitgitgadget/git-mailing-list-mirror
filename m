From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-daemon: fix for rotating logs
Date: Mon, 28 Apr 2008 21:53:53 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804282153290.19187@eeepc-johanness>
References: <alpine.DEB.1.00.0804281523040.5399@eeepc-johanness> <7vtzhmaqpd.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804281908290.19187@eeepc-johanness> <20080428182114.GF26880@genesis.frugalware.org> <20080428182917.GA4794@glandium.org>
 <alpine.DEB.1.00.0804281937240.19187@eeepc-johanness> <20080428190047.GG26880@genesis.frugalware.org> <20080428192837.GB21950@cuci.nl> <alpine.DEB.1.00.0804282052050.19187@eeepc-johanness> <20080428204323.GA22815@cuci.nl>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Mon Apr 28 22:54:46 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqaMq-0005wH-QJ
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 22:54:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933676AbYD1Uxo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 16:53:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934640AbYD1Uxn
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 16:53:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:36880 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933022AbYD1Uxn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 16:53:43 -0400
Received: (qmail invoked by alias); 28 Apr 2008 20:53:41 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.st-andrews.ac.uk) [141.5.11.5]
  by mail.gmx.net (mp040) with SMTP; 28 Apr 2008 22:53:41 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19WA8U6+BxWb4Ilht6ioWZMk5ZUO026mhJVOVz8RY
	QpXFOoy2iYr3tL
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080428204323.GA22815@cuci.nl>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80608>

Hi,

On Mon, 28 Apr 2008, Stephen R. van den Berg wrote:

> Johannes Schindelin wrote:
> 
> >On Mon, 28 Apr 2008, Stephen R. van den Berg wrote:
> 
> >> >> I have no idea, but other programs must have the same problem.  I 
> >> >> should
> 
> >So do you have any ideas what is happening there?  It seems that after 
> >logrotate does its thing, syslog() is stuck in the close() call.
> 
> Erm, just so I understand the problem:
> - git-daemon is configured to use syslog(3) to log
> - git-daemon uses openlog(3)
> - git-daemon logs happily for a while
> - rotatelog rotates logfiles in /var/log and communicates with syslogd
>   to make sure syslogd starts new logfiles in /var/log
> - And then git-daemon hangs on which system/library call?

It seems that this happens, yes.

Ciao,
Dscho
