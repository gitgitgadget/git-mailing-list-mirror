From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] remote show: fix the -n option
Date: Mon, 9 Jun 2008 17:31:31 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806091729020.1783@racer>
References: <484B2DD3.8050307@free.fr> <1212927772-10006-1-git-send-email-dkr+ml.git@free.fr> <7v63sjk6yo.fsf@gitster.siamese.dyndns.org> <484C7CBE.4070700@free.fr> <484C7DCC.6080303@free.fr> <alpine.DEB.1.00.0806090212270.1783@racer> <484C901B.6000401@free.fr>
 <alpine.DEB.1.00.0806090330490.1783@racer> <484CAE95.3020008@free.fr> <alpine.DEB.1.00.0806090551070.1783@racer> <484D3C90.2050009@free.fr> <484D4FB3.2090309@freesurf.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-152906315-1213029100=:1783"
Cc: Olivier Marin <dkr+ml.git@free.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Olivier Marin <dkr@freesurf.fr>
X-From: git-owner@vger.kernel.org Mon Jun 09 18:33:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K5kJV-0002TD-Gh
	for gcvg-git-2@gmane.org; Mon, 09 Jun 2008 18:33:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751927AbYFIQcw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2008 12:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751922AbYFIQcw
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jun 2008 12:32:52 -0400
Received: from mail.gmx.net ([213.165.64.20]:38111 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751472AbYFIQcv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2008 12:32:51 -0400
Received: (qmail invoked by alias); 09 Jun 2008 16:32:49 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp045) with SMTP; 09 Jun 2008 18:32:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18YWFhWOVoYHEbdqdwKr9SHsGGnI+Ey74ERU4roCn
	XTTMZBDO0Il9yO
X-X-Sender: gene099@racer
In-Reply-To: <484D4FB3.2090309@freesurf.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84399>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-152906315-1213029100=:1783
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 9 Jun 2008, Olivier Marin wrote:

> Olivier Marin a écrit :
> > Johannes Schindelin a écrit :
> > 
> >> I would not like to remove the got_states.  I think this is the wrong 
> >> direction.  Rather change the die() into a return error().
> > 
> > OK, I will try that.
> > 
> 
> After reading some more code, I can say that changing die() in return 
> error() won't change anything here because, in get_ref_states() we only 
> die() if get_fetch_map() return an error. But guess what, 
> get_fetch_map() never return an error. It just die() or return 0. And I 
> can't change it without breaking "clone" and "fetch".

So you think it is okay, because the result is the same?  I think not.  I 
think this is exactly the way of thinking that makes reusing unlibified 
parts of Git's source code hard.  I think that this is exactly the style 
of programming I try to avoid, because it messes up clean concepts.

And I am utterly embarassed that we are talking about my code here.

Ciao,
Dscho

--8323329-152906315-1213029100=:1783--
