From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-commit: Refresh cache after adding files.
Date: Fri, 9 Nov 2007 17:24:39 +0000 (GMT)
Message-ID: <Pine.LNX.4.64.0711091722520.4362@racer.site>
References: <1194626427-2419-1-git-send-email-krh@redhat.com> 
 <Pine.LNX.4.64.0711091702190.4362@racer.site> <1194628412.30909.7.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-1347110213-1194629079=:4362"
Cc: gitster@pobox.com, git@vger.kernel.org
To: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Fri Nov 09 18:25:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IqXbO-0005xQ-RO
	for gcvg-git-2@gmane.org; Fri, 09 Nov 2007 18:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753623AbXKIRYv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Nov 2007 12:24:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754103AbXKIRYv
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Nov 2007 12:24:51 -0500
Received: from mail.gmx.net ([213.165.64.20]:46427 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750876AbXKIRYv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Nov 2007 12:24:51 -0500
Received: (qmail invoked by alias); 09 Nov 2007 17:24:49 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp005) with SMTP; 09 Nov 2007 18:24:49 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+ZtxgL9MWZR6ANQpenGno1m9AkeRQa26r8J/mWxE
	u9VlS9RIX/k/4J
X-X-Sender: gene099@racer.site
In-Reply-To: <1194628412.30909.7.camel@hinata.boston.redhat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64225>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-1347110213-1194629079=:4362
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 9 Nov 2007, Kristian H?gsberg wrote:

> On Fri, 2007-11-09 at 17:05 +0000, Johannes Schindelin wrote:
> 
> > On Fri, 9 Nov 2007, Kristian Høgsberg wrote:
> > 
> > > This fixes the race in the last test int t3700.
> > 
> > Well, it is not a race.  My fault.  I thought it was.
> > 
> > What you basically did was to make sure that the index is up-to-date 
> > after adding the files.  You might even want to say that in the commit 
> > message, and only then say that it fixes t3700, too.
> 
> OK, I guess what I was wondering was why write_cache() doesn't write out
> an up-to-date index.

write_cache() only writes the index, it does not update it.

> Do we need a call to refresh_cache() when we update the user cache but 
> commit an index created from read_tree+add_files?  I.e. after the 
> add_files_to_index() call on line 97?  The shell script doesn't do this, 
> it only runs update-index --refresh for the index that gets committed.

I think it would be sane to do so.

IIUC this basically means that "git add <file> && git commit" should do 
the same to the cache as "git commit <file>".

Thanks,
Dscho

--8323584-1347110213-1194629079=:4362--
