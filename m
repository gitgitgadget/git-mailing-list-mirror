From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] merge-recursive: respect core.autocrlf
Date: Tue, 10 Jun 2008 00:35:34 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806100033350.1783@racer>
References: <"Storm-Olsen*"@MHS> <26299.4828321554$1213013668@news.gmane.org> <484D3225.3020900@viscovery.net> <alpine.DEB.1.00.0806092221420.1783@racer> <alpine.DEB.1.00.0806092223010.1783@racer> <7vod6affz6.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0806092305430.1783@racer> <7vprqqdwh7.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Marius Storm-Olsen <marius@trolltech.com>,
	git <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 01:37:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5qvu-0006Rq-2o
	for gcvg-git-2@gmane.org; Tue, 10 Jun 2008 01:37:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757908AbYFIXgz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 19:36:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757759AbYFIXgz
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 19:36:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:37676 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756702AbYFIXgy (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 19:36:54 -0400
Received: (qmail invoked by alias); 09 Jun 2008 23:36:52 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp064) with SMTP; 10 Jun 2008 01:36:52 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX180MDg6g5Y07Mpsk8s74zkX/PlkPZQO+E6bcp1/zi
	DIQvaUE5x9080M
X-X-Sender: gene099@racer
In-Reply-To: <7vprqqdwh7.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84455>

Hi,

On Mon, 9 Jun 2008, Junio C Hamano wrote:

> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> > ---
> >
> > 	On Mon, 9 Jun 2008, Junio C Hamano wrote:
> >
> > 	> Fairly straightforward fix, except that I suspect this needs to 
> > 	> be done only for regular files and not symlinks.
> > 	> 
> > 	> I think entry.c:write_entry() shows how this should be done.
> >
> > 	Right.  And the relevant clause is actually already there.  D'oh.
> 
> Well, you actually have "double d'oh".  "This ought to be a symlink but 
> the filesystem is lacking, so we instead write out what the readlink 
> from such a symlink would return" codepath should not 
> convert_to_worktree().

I actually thought about that a bit, and just assumed that the rest of the 
Git code respects autocrlf for "fake" symlinks.

IMO it makes no sense at all to write the textual symlink files without 
CR/LF when the user clearly asked for it with autocrlf = true.  After all, 
it _is_ a text file then.

But yes, I tried to save some time and did not check.

Ciao,
Dscho
