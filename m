From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/5] diff --quiet
Date: Thu, 15 Mar 2007 18:43:02 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703151841180.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <7vwt1j8z0e.fsf@assigned-by-dhcp.cox.net> 
 <7vodmv7bza.fsf@assigned-by-dhcp.cox.net>  <81b0412b0703141614m70f4a565qc001e06e60b0ffd5@mail.gmail.com>
  <7v8xdz5qn0.fsf@assigned-by-dhcp.cox.net> 
 <81b0412b0703150119l705eefb6h6af44b9452db83e2@mail.gmail.com> 
 <Pine.LNX.4.63.0703151136470.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <81b0412b0703150655y3d2a71d3t8db6e334ecf23ca1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 15 18:43:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HRtyp-0004u6-Hp
	for gcvg-git@gmane.org; Thu, 15 Mar 2007 18:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932263AbXCORnH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Mar 2007 13:43:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933439AbXCORnH
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Mar 2007 13:43:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:49157 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932263AbXCORnG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Mar 2007 13:43:06 -0400
Received: (qmail invoked by alias); 15 Mar 2007 17:43:02 -0000
X-Provags-ID: V01U2FsdGVkX1+jlKJlPY6joAZFknuzieeRyDoZWG87lm/uQX7KzZ
	HdJJe2tOB5Zz5C
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <81b0412b0703150655y3d2a71d3t8db6e334ecf23ca1@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42295>

Hi,

On Thu, 15 Mar 2007, Alex Riesen wrote:

> On 3/15/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > >         $ git-rev-parse v2.6.16^{tree} v2.6.20^{tree}
> > > >
> > >
> > > Why would I want to benchmark --quiet with rev-parse?
> > 
> > It is not benchmarking, but it is a faster solution: you can see if two
> > trees are different by comparing their SHA-1s.
> 
> Can the same be done for index? (index-tree comparison)

Theoretically, yes. Only that Junio did not accept my short-cut ":dir/" 
notation to mean "take the cache-tree from the index, or if it is dirty, 
construct it". However, in the latter case, it would not be a speed 
improvement, but the opposite.

> > (That, however, works only if you do not want something like "git diff
> > -w"...)
> 
> Why? Can't "git diff -w" quit early?

No, but "-w" means "ignore white space", which means that blobs can be 
deemed equal, even if they differ at the byte-per-byte level.

Ciao,
Dscho
