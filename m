From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3 2/2] git-add: introduce --edit (to edit the diff vs.
 the index)
Date: Fri, 6 Jun 2008 15:21:01 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806061514510.1783@racer>
References: <alpine.DEB.1.00.0806051115570.21190@racer> <4847CCD9.6000305@viscovery.net> <alpine.DEB.1.00.0806051403370.21190@racer> <4847EBC3.8060509@viscovery.net> <alpine.DEB.1.00.0806051441560.21190@racer> <4847F49F.8090004@viscovery.net>
 <alpine.DEB.1.00.0806051548140.21190@racer> <48480123.7030903@viscovery.net> <alpine.DEB.1.00.0806051719170.21190@racer> <alpine.DEB.1.00.0806051720070.21190@racer> <7vabhz1t2f.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806052304300.21190@racer>
 <alpine.DEB.1.00.0806060005581.21190@racer> <alpine.DEB.1.00.0806060007000.21190@racer> <48490B3A.4020900@free.fr>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-677868837-1212762070=:1783"
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Olivier Marin <dkr+ml.git@free.fr>
X-From: git-owner@vger.kernel.org Fri Jun 06 16:23:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4cqg-0005Iw-Us
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 16:23:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756844AbYFFOW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 10:22:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756817AbYFFOW3
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 10:22:29 -0400
Received: from mail.gmx.net ([213.165.64.20]:37467 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756776AbYFFOW2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 10:22:28 -0400
Received: (qmail invoked by alias); 06 Jun 2008 14:22:25 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp025) with SMTP; 06 Jun 2008 16:22:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/pwzhbNGPpS1oT5j04lMzRUY2Nj/HOMHC6FCAdvN
	cv9v3zJIK+Rkyh
X-X-Sender: gene099@racer
In-Reply-To: <48490B3A.4020900@free.fr>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84073>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-677868837-1212762070=:1783
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 6 Jun 2008, Olivier Marin wrote:

> Johannes Schindelin a écrit :
> > 
> > +int edit_patch(int argc, const char **argv, const char *prefix)
> > +{
> 
> [...]
> 
> > +	if (!result)
> > +		result = run_command(&child);
> > +	free(child.argv);
> > +
> > +	launch_editor(file, NULL, NULL);
> 
> Here, it does not launch the editor I defined with core.editor because 
> you call edit_patch() before calling git_config() in cmd_add().

Will fix.

> Also, wouldn't be better to have the edit_patch stuff in 
> add--interactive instead ? It seems to work the same way than the 
> --patch option.

Actually, no.  It does something completely different.  For example, it 
avoids calling a perl script.  At least as long as your editor is not a 
Perl script.

Ciao,
Dscho

--8323329-677868837-1212762070=:1783--
