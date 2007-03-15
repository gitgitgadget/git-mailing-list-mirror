From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/5] diff --quiet
Date: Thu, 15 Mar 2007 11:37:52 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703151136470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vwt1j8z0e.fsf@assigned-by-dhcp.cox.net> 
 <7vodmv7bza.fsf@assigned-by-dhcp.cox.net>  <81b0412b0703141614m70f4a565qc001e06e60b0ffd5@mail.gmail.com>
  <7v8xdz5qn0.fsf@assigned-by-dhcp.cox.net> <81b0412b0703150119l705eefb6h6af44b9452db83e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 11:38:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRnLX-0008Ic-Mg
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 11:38:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932073AbXCOKhz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 06:37:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932102AbXCOKhz
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 06:37:55 -0400
Received: from mail.gmx.net ([213.165.64.20]:53088 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932073AbXCOKhy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 06:37:54 -0400
Received: (qmail invoked by alias); 15 Mar 2007 10:37:53 -0000
X-Provags-ID: V01U2FsdGVkX1+eh1ATlO6eL7S2pbSxp+RRR94TyCgW+r03rmmi88
	qSOPouZZtsIgYz
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <81b0412b0703150119l705eefb6h6af44b9452db83e2@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42277>

Hi,

On Thu, 15 Mar 2007, Alex Riesen wrote:

> On 3/15/07, Junio C Hamano <junkio@cox.net> wrote:
> > > Now I'm happy :)
> > >
> > > ~/linux$ time git diff-tree -r -s v2.6.16 v2.6.20
> > >
> > > real    0m0.137s
> > > user    0m0.117s
> > > sys     0m0.020s
> > > ~/linux$ time ~/projects/git-diff/git-diff-tree -r --quiet v2.6.16
> > v2.6.20
> > >
> > > real    0m0.006s
> > > user    0m0.000s
> > > sys     0m0.007s
> > 
> > You do not need diff-tree --quiet to do that!
> > 
> >         $ git-rev-parse v2.6.16^{tree} v2.6.20^{tree}
> > 
> 
> Why would I want to benchmark --quiet with rev-parse?

It is not benchmarking, but it is a faster solution: you can see if two 
trees are different by comparing their SHA-1s.

(That, however, works only if you do not want something like "git diff 
-w"...)

Ciao,
Dscho
