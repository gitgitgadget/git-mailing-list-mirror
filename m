From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: allowing aliases to override builtins to support default
 options
Date: Sat, 7 Mar 2009 04:10:31 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0903070407480.10279@pacific.mpi-cbg.de>
References: <76718490903061430s2fbea2dfibe06282fd22b1588@mail.gmail.com>  <alpine.DEB.1.00.0903070336200.10279@pacific.mpi-cbg.de> <76718490903061857y5446098by3633559697508c2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 07 04:10:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lfmvo-00058d-2C
	for gcvg-git-2@gmane.org; Sat, 07 Mar 2009 04:10:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754535AbZCGDJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 6 Mar 2009 22:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754501AbZCGDJE
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Mar 2009 22:09:04 -0500
Received: from mail.gmx.net ([213.165.64.20]:41132 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754190AbZCGDJB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Mar 2009 22:09:01 -0500
Received: (qmail invoked by alias); 07 Mar 2009 03:08:58 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp015) with SMTP; 07 Mar 2009 04:08:58 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19PV3pdMZ1PW4uORbFnj8xe9K8JVsJA2pXrZfF9xo
	yA2Pr/8Uljl25m
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <76718490903061857y5446098by3633559697508c2e@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6899999999999999
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/112511>

Hi,

On Fri, 6 Mar 2009, Jay Soffian wrote:

> For example, what if:
> 
> 1. The aliases applied only to porcelain commands, not to plumbing.

Inconsistency like this is bad for a couple of reasons.  Just 3 out of 
them:

- it makes it hard for users to understand,

- it is prone for subtle breakages,

- the code will be complicated, and therefore ugly.

> 2. The aliases worked only if stdout was a terminal, using the same 
>    method that git uses for detecting when it is okay to start a pager.

This would be even more complicated to understand for the regular Git user 
who just wants to use the darned thing and not care about its internals.

> 3. git took --alias-builtins and --no-alias-builtins just like it takes 
>    --paginate and --no-pager to override (2).

And this makes it even more complicated.

I'd rather stay with our current notion that aliases cannot override Git 
programs.  This is _very_ easy to explain, and also _very_ easy to defend.

Ciao,
Dscho
