From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Keep rename/rename conflicts of intermediate merges
 while doing recursive merge
Date: Sat, 31 Mar 2007 14:53:47 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0703311452300.4045@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070329141230.GB16739@hermes> <81b0412b0703290744h34b6ef01s4e6f90b1d7ed231b@mail.gmail.com>
 <81b0412b0703290804n13af6f40we79f7251562c540@mail.gmail.com>
 <20070329183237.GB2809@steel.home> <Pine.LNX.4.64.0703291232190.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703291237240.6730@woody.linux-foundation.org>
 <Pine.LNX.4.63.0703302239050.4045@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0703301728510.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703301754590.6730@woody.linux-foundation.org>
 <20070331104947.GA4377@steel.home> <20070331114938.GB4377@steel.home>
 <Pine.LNX.4.63.0703311445190.4045@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Junio C Hamano <junkio@cox.net>,
	Tom Prince <tom.prince@ualberta.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 31 14:53:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXd5d-00079H-6o
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 14:53:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751003AbXCaMxu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 08:53:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752004AbXCaMxu
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 08:53:50 -0400
Received: from mail.gmx.net ([213.165.64.20]:41379 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751003AbXCaMxt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 08:53:49 -0400
Received: (qmail invoked by alias); 31 Mar 2007 12:53:48 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp019) with SMTP; 31 Mar 2007 14:53:48 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+TFVx6a0CTmUgepoXTfQOvhJi1vL8nxA+rM69Ebh
	ycL+kgi1UF93Pj
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0703311445190.4045@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43553>

Hi,

On Sat, 31 Mar 2007, Johannes Schindelin wrote:

> On Sat, 31 Mar 2007, Alex Riesen wrote:
> 
> > This patch leaves the base name in the resulting intermediate tree, to
> > propagate the conflict from intermediate merges up to the top-level merge.
> 
> I'd rather have conflict files, i.e.
> 
> 	for each entry in the index which is unmerged,
> 		write the file in this form:
> 		<<<<<<
> 		[stage2]
> 		======
> 		[stage3]
> 		>>>>>>
> 
> 		mark as merged (i.e. remove stages 1--3 from the index, 
> 		and add the conflicted file as stage 0)

Side note: for the "src->dest1,dest2" case, I really would like to see a 
threeway merge. But I would want the above-mentioned behaviour _before_ 
that, to make sure that we have a reasonable fallback for hard cases.

Ciao,
Dscho
