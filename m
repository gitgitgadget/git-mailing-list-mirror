From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] Allow git-apply to ignore the hunk headers
Date: Fri, 6 Jun 2008 15:04:01 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806061502030.1783@racer>
References: <alpine.DEB.1.00.0806051115570.21190@racer> <4847CCD9.6000305@viscovery.net> <alpine.DEB.1.00.0806051403370.21190@racer> <4847EBC3.8060509@viscovery.net> <alpine.DEB.1.00.0806051441560.21190@racer> <4847F49F.8090004@viscovery.net>
 <alpine.DEB.1.00.0806051548140.21190@racer> <48480123.7030903@viscovery.net> <alpine.DEB.1.00.0806051719170.21190@racer> <alpine.DEB.1.00.0806051720070.21190@racer> <7vabhz1t2f.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806052304300.21190@racer>
 <7v4p87zcv6.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0806060030160.21190@racer> <4848E105.7050405@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Paolo Bonzini <bonzini@gnu.org>
X-From: git-owner@vger.kernel.org Fri Jun 06 16:07:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4caB-0006cn-TI
	for gcvg-git-2@gmane.org; Fri, 06 Jun 2008 16:06:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751933AbYFFOF1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Jun 2008 10:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751308AbYFFOF1
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jun 2008 10:05:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:60379 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751162AbYFFOF0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jun 2008 10:05:26 -0400
Received: (qmail invoked by alias); 06 Jun 2008 14:05:25 -0000
Received: from pacific.mpi-cbg.de (EHLO [10.8.0.10]) [141.5.10.38]
  by mail.gmx.net (mp030) with SMTP; 06 Jun 2008 16:05:25 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/tRjk5CILtVtM3pu0UaHG9HmfGrfS0gFnIpZsvSN
	y5eGgPSeyjaXCp
X-X-Sender: gene099@racer
In-Reply-To: <4848E105.7050405@gnu.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84071>

Hi,

On Fri, 6 Jun 2008, Paolo Bonzini wrote:

> > @@ -0,0 +0,0 @@
> > 	default:
> > -		return -1;
> > +		return len != 4 && memcmp(line - len, "-- \n", len);
> >   }
> 
> You're never returning -1 here, right?

You are a clever guy!  I really do not return -1 here.  But then, the 
return value is only checked for non-zeroness.  As is obvious from the 
part you did not quote.

> > However, this will not work if anybody has a signature starting with 
> > "@@ ", "+", " ", "-" or "diff "...
> 
> I think that the main worry is the patches made with git-format-patch, 
> and those are not problematic.

Actually, this change was done in v3 on _explicit_ request from Junio who 
wants to be able to use the patch for git-am, where we cannot rely on 
format-patch.

So yes, they _are_ problematic.

Thanks,
Dscho
