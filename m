From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: disallowing push to currently checked-out branch
Date: Mon, 16 Feb 2009 18:43:25 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902161839120.6289@intel-tinevez-2-302>
References: <7vk57ridyx.fsf@gitster.siamese.dyndns.org> <20090215232013.GA11543@zakalwe.fi> <20090216000443.GB3503@coredump.intra.peff.net> <alpine.DEB.1.10.0902151727330.14911@asgard.lang.hm> <alpine.DEB.1.10.0902151738450.14911@asgard.lang.hm>
 <alpine.LNX.1.00.0902160322530.19665@iabervon.org> <7veixybw7u.fsf@gitster.siamese.dyndns.org> <loom.20090216T101457-231@post.gmane.org> <20090216135812.GA20377@coredump.intra.peff.net> <49999ED6.7010608@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Sergio Callegari <sergio.callegari@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 16 18:45:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZ7X5-0002be-MU
	for gcvg-git-2@gmane.org; Mon, 16 Feb 2009 18:45:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752625AbZBPRnd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2009 12:43:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751271AbZBPRnc
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Feb 2009 12:43:32 -0500
Received: from mail.gmx.net ([213.165.64.20]:40997 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751252AbZBPRnc (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2009 12:43:32 -0500
Received: (qmail invoked by alias); 16 Feb 2009 17:43:27 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp008) with SMTP; 16 Feb 2009 18:43:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+hzFl66puh9NFYKsS/4M+0aRcj5xa4Wu4CrRbLhM
	5EGWxumDbVhLtM
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <49999ED6.7010608@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.68
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110217>

Hi,

On Mon, 16 Feb 2009, Sergio Callegari wrote:

> Jeff King wrote:
> 
> > If you set 'detach' option, this clueless user is not helped; he will 
> > happily keep working and would make tons of commits on detached HEAD, 
> > and next time he switches to another branch, will lose all of them.
>
> I guess that git does not let you commit on a detached head without 
> crying out loud.

Wrong.  It cries out loud when you detach, not when you commit to a 
detached HEAD.  For good reason: Already at the second commit it would 
stop being funny.

> Furthermore, one could do just a bit more than detaching, namely store 
> the fact that head got detached and the name of the branch where the 
> head was. With this, when the unconscious user types git status or git 
> commit the system could alert him that head got detached because someone 
> updated the branch behind his shoulders from remote...

And of course, you need a way to show the user all the updates the branch 
went through while the HEAD was detached, so that the user has a chance of 
understanding what happened in the meantime.

So much additional work, just to fix up the shortcomings of the 'detach' 
paradigm?  I take it as a clear mark of a not-so-elegant design.

Ciao,
Dscho
