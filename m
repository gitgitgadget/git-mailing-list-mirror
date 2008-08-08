From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFH] filter-branch: ancestor detection weirdness
Date: Fri, 8 Aug 2008 16:39:00 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808081632580.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <200808080148.27384.trast@student.ethz.ch> <1218153242-18837-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0808081341170.9611@pacific.mpi-cbg.de.mpi-cbg.de> <200808081614.44422.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Jan Wielemaker <J.Wielemaker@uva.nl>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Aug 08 16:35:39 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KRT3x-0002mu-KG
	for gcvg-git-2@gmane.org; Fri, 08 Aug 2008 16:35:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751452AbYHHOe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Aug 2008 10:34:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbYHHOe1
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Aug 2008 10:34:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:53124 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751152AbYHHOe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Aug 2008 10:34:26 -0400
Received: (qmail invoked by alias); 08 Aug 2008 14:34:24 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp058) with SMTP; 08 Aug 2008 16:34:24 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/tqionD6TtejGlTXFeZVfMiJHUgzgO5fD7qr2dFg
	9bCp2mcnlfSsal
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <200808081614.44422.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91670>

Hi,

On Fri, 8 Aug 2008, Thomas Rast wrote:

> I think a more careful use of rev-list -1 is actually a correct and easy 
> way to figure out an ancestor.

I have not looked at your patch closely, or at your explanation, but I am 
really certain that every attempt to replace the --boundary with a -1 must 
fail.

Let me show you why I think that.  Just look at this history:

A - B - C
  /
D

Where all commits except B touch the inside directory.  Two options:

- you make C a merge (that's what I tried with --boundary), or

- you record B, and C as a commit that does not introduce changes, which 
  is obviously wrong, or

- you record B as a merge, with identical content as A and D, which is 
  pretty tricky (which is why I avoided it).

Anyway, I am really swamped in work, and will not have time to review big 
changes or explanations.  Besides, filter-branch is no fun.  
rewrite-commits would have been, but Sven chickened out.

Ciao,
Dscho
