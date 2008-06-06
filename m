From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] Allow git-apply to ignore the hunk headers
Date: Fri, 6 Jun 2008 15:27:11 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806061525410.1783@racer>
References: <alpine.DEB.1.00.0806051115570.21190@racer> <4847CCD9.6000305@viscovery.net> <alpine.DEB.1.00.0806051403370.21190@racer> <4847EBC3.8060509@viscovery.net> <alpine.DEB.1.00.0806051441560.21190@racer> <4847F49F.8090004@viscovery.net>
 <alpine.DEB.1.00.0806051548140.21190@racer> <48480123.7030903@viscovery.net> <alpine.DEB.1.00.0806051719170.21190@racer> <alpine.DEB.1.00.0806051720070.21190@racer> <7vabhz1t2f.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806052304300.21190@racer>
 <7v4p87zcv6.fsf@gitster.siamese.dyndns.org> <87iqwmzwcn.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Sergei Organov <osv@javad.com>
X-From: git-owner@vger.kernel.org Fri Jun 06 16:29:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4cwe-0007vC-D9
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 16:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757213AbYFFO2h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 10:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757121AbYFFO2h
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 10:28:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:35335 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756671AbYFFO2g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 10:28:36 -0400
Received: (qmail invoked by alias); 06 Jun 2008 14:28:34 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp054) with SMTP; 06 Jun 2008 16:28:34 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18mRapIGWQmgRq4MEeMIVAGWCr1QzVkIYF266VltN
	k+HVARCQNHaiN0
X-X-Sender: gene099@racer
In-Reply-To: <87iqwmzwcn.fsf@osv.gnss.ru>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84075>

Hi,

On Fri, 6 Jun 2008, Sergei Organov wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > You read a hunk header line "@@ -l,m +n,o @@", and start counting the 
> > diff text because you do not trust m and o.  When you read the last 
> > hunk in a patch e-mail, you may hit a e-mail signature separator, like 
> > what is given by format-patch output at the end.  Mistaking that as an 
> > extra preimage context to remove "^- $" is what I was worried about.
> 
> Don't you think it's time to fix git-format-patch to put some reliable 
> "end-of-patch" marker line before the signature? This change (along with 
> refusal to generate brain-damaged empty lines inside hunks) will make 
> git diffs easily parseable without information from hunk headers.

Actually, what do you think the numbers in the hunk headers are good for?  
They _are_ reliable end-of-hunk markers.  And if the next line does not 
exist, or does not start, it is end-of-diff.  Reliable. Simple.

Only when you need to get sloppy, things get worse.  I need to get sloppy.

But that's hardly the fault of format-patch.

Ciao,
Dscho
