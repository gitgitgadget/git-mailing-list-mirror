From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: SEGV in git-merge recursive:
Date: Sat, 31 Mar 2007 13:22:27 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0703311319190.4045@wbgn013.biozentrum.uni-wuerzburg.de>
References: <20070329075010.GA3493@hermes> <81b0412b0703290429k63642a34u6bea1e08803ffba7@mail.gmail.com>
 <20070329125803.GA16739@hermes> <81b0412b0703290634j6e62ba89tce3c8c963be3fb92@mail.gmail.com>
 <20070329141230.GB16739@hermes> <81b0412b0703290744h34b6ef01s4e6f90b1d7ed231b@mail.gmail.com>
 <81b0412b0703290804n13af6f40we79f7251562c540@mail.gmail.com>
 <20070329183237.GB2809@steel.home> <Pine.LNX.4.64.0703291232190.6730@woody.linux-foundation.org>
 <Pine.LNX.4.64.0703291237240.6730@woody.linux-foundation.org>
 <Pine.LNX.4.63.0703302239050.4045@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0703301728510.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>,
	Tom Prince <tom.prince@ualberta.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 31 13:22:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXbfF-0000G8-Gy
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 13:22:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752921AbXCaLWa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 07:22:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752960AbXCaLWa
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 07:22:30 -0400
Received: from mail.gmx.net ([213.165.64.20]:59671 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752921AbXCaLW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 07:22:29 -0400
Received: (qmail invoked by alias); 31 Mar 2007 11:22:28 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO wbgn013.biozentrum.uni-wuerzburg.de) [132.187.25.13]
  by mail.gmx.net (mp001) with SMTP; 31 Mar 2007 13:22:28 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18DLmkq470DFvJZT5zQnUrUHeqrNlxiT1TNAtC3lT
	Sm5kwbhJ0Oo1B6
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0703301728510.6730@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43546>

Hi,

On Fri, 30 Mar 2007, Linus Torvalds wrote:

> On Fri, 30 Mar 2007, Johannes Schindelin wrote:
> 
> > IMHO, there is actually no way merge_trees() can fix the conflicts 
> > enough to write a tree.
> > 
> > So, the only way I see to avoid that SEGV is to something like this:
> 
> I disagree.
> 
> It's much better to give a bad intermediate tree than to give up entirely.

Hmm.

What we _could_ do: if the index still contains unmerged entries, then we 
collapse these into files with conflict markers (in case the file cannot 
be written, because a directory of the same name exists, we have to save 
with a unique name, complaining loudly about it, i.e. without using 
output()).

I will not have time to implement this until later this week, though.

Ciao,
Dscho
