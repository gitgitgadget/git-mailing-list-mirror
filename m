From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-daemon: fix for rotating logs
Date: Mon, 28 Apr 2008 19:37:54 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804281937240.19187@eeepc-johanness>
References: <alpine.DEB.1.00.0804281523040.5399@eeepc-johanness> <7vtzhmaqpd.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0804281908290.19187@eeepc-johanness> <20080428182114.GF26880@genesis.frugalware.org> <20080428182917.GA4794@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Mon Apr 28 20:39:10 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqYFK-00082b-Lq
	for gcvg-git-2@gmane.org; Mon, 28 Apr 2008 20:38:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965101AbYD1Shs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2008 14:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932531AbYD1Shs
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Apr 2008 14:37:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:33336 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932196AbYD1Shq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2008 14:37:46 -0400
Received: (qmail invoked by alias); 28 Apr 2008 18:37:43 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO eeepc-johanness.st-andrews.ac.uk) [141.5.11.5]
  by mail.gmx.net (mp006) with SMTP; 28 Apr 2008 20:37:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19yMF5jAo1yyPkW31Msh1k7lL3qm3sANweizkuhwk
	AqCt4lFax8ceOi
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080428182917.GA4794@glandium.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80579>

Hi,

On Mon, 28 Apr 2008, Mike Hommey wrote:

> On Mon, Apr 28, 2008 at 08:21:14PM +0200, Miklos Vajna wrote:
> > On Mon, Apr 28, 2008 at 07:08:50PM +0100, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > > > With rotating logs, there is a problem when the syslog is opened 
> > > > > only once (in the beginning).  So open the log everytime we 
> > > > > write something, and close it directly after writing.
> > > > 
> > > > Gaah, this is ugly.
> > > > 
> > > > Is this something all the daemons need to deal with?
> > > 
> > > I have no idea, but it seems to fix a real issue.
> > 
> > logrotate supports sending a signal (typically SIGHUP) to the process 
> > after it rotated the log. Couldn't we just re-open the log on SIGHUP?
> 
> Isn't the problem that git-daemon loses its connection to the syslog 
> daemon when logrotate sighups syslog?

I have no idea, but other programs must have the same problem.  I should 
have shown some diligence and researched that.  Will do so now.

Ciao,
Dscho
