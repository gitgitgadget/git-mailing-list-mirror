From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] remote show: fix the -n option
Date: Mon, 9 Jun 2008 03:35:28 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806090330490.1783@racer>
References: <484B2DD3.8050307@free.fr> <1212927772-10006-1-git-send-email-dkr+ml.git@free.fr> <7v63sjk6yo.fsf@gitster.siamese.dyndns.org> <484C7CBE.4070700@free.fr> <484C7DCC.6080303@free.fr> <alpine.DEB.1.00.0806090212270.1783@racer>
 <484C901B.6000401@free.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1751066504-1212978936=:1783"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Mon Jun 09 04:38:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5XHI-0006bG-Et
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 04:38:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755663AbYFIChQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Jun 2008 22:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758049AbYFIChE
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jun 2008 22:37:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:41497 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1757257AbYFICgu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jun 2008 22:36:50 -0400
Received: (qmail invoked by alias); 09 Jun 2008 02:36:47 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 09 Jun 2008 04:36:47 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18AgrgGalsAXoXmR6QjAQtavl9+3SpdAVz5qBJDV6
	5wvjn1QAubIyGL
X-X-Sender: gene099@racer
In-Reply-To: <484C901B.6000401@free.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84358>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1751066504-1212978936=:1783
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 9 Jun 2008, Olivier Marin wrote:

> Johannes Schindelin a écrit :
> 
> >>  	struct option options[] = {
> >>  		OPT_GROUP("show specific options"),
> >> -		OPT__DRY_RUN(&dry_run),
> >> +		OPT_BOOLEAN('n', NULL, &no_query, "do not query remotes"),
> > 
> > Why?
> 
> Because I think it's something different. It's more like in "route -n" 
> than --dry-run in "patch --dry-run". Don't you think ?

No, I think that the information about stale branches and if the branches 
are up-to-date is missing.  In that sense, it is not like "route -n" at 
all, which just skips one convenience step, but really a dry run, because 
the result is different (as opposed to differently displayed).

> >> +			transport = transport_get(NULL, states.remote->url_nr > 0 ?
> > 
> > Please rewrap.
> 
> I'm not sure what you are talking about. Should I wrap after "NULL," 
> instead of "?"?

It is a too long line (way over 80 characters).  So yes, you should wrap 
after the NULL here.

> > Maybe we need two different values of got_states; not calling 
> > ls-remote and then showing things is okay, but calling ls-remote, 
> > getting an error and _then_ showing stuff is not okay, IMO.
> 
> In fact, it seems that get_ref_states() always return 0 or just die when 
> an error occur. And that transport_get_remote_refs() never return if 
> something goes wrong.
> 
> So, what about removing got_states and use !no_query instead ?

Hrmpf.  I did not mean to die() there...

Ciao,
Dscho

--8323329-1751066504-1212978936=:1783--
