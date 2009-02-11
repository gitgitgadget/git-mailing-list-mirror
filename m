From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: RFC: Flat directory for notes, or fan-out?  Both!
Date: Wed, 11 Feb 2009 13:35:12 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902111329030.10279@pacific.mpi-cbg.de>
References: <alpine.DEB.1.00.0902092200170.10279@pacific.mpi-cbg.de> <200902100158.46884.bss@iguanasuicide.net> <20090210131600.GD17305@coredump.intra.peff.net> <200902101958.21284.bss@iguanasuicide.net> <alpine.LFD.2.00.0902101825360.3590@localhost.localdomain>
 <49924642.6000609@vilain.net> <alpine.LFD.2.00.0902101953170.3590@localhost.localdomain> <49925CAB.505@vilain.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	"Boyd Stephen Smith Jr." <bss@iguanasuicide.net>,
	Jeff King <peff@peff.net>, git@vger.kernel.org,
	spearce@spearce.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Feb 11 13:36:11 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXEJl-0004Hl-Jf
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 13:35:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755538AbZBKMe1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 07:34:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754496AbZBKMe1
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 07:34:27 -0500
Received: from mail.gmx.net ([213.165.64.20]:56952 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755244AbZBKMe0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 07:34:26 -0500
Received: (qmail invoked by alias); 11 Feb 2009 12:34:24 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp070) with SMTP; 11 Feb 2009 13:34:24 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+euzYq78OeC7+zGGI0LLrFocjgcO0tBR2KE8lvaZ
	GfKhOJZam+kL0/
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <49925CAB.505@vilain.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.66
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109412>

Hi,

On Wed, 11 Feb 2009, Sam Vilain wrote:

> I just already wrote the code to handle an arbitrary split for the 
> features written so far[1]. If *I* can write it, in C, it means it must 
> not be that complicated ;-)

I think I either missed your mail or had to ignore it due to too much day 
job work.

It is a good first step, of course the next step would be to load the 
trees on-demand.

Oh, and the best approach to handle the "to Trie or not to Trie" question 
would be to be strict in what we emit (12/28 it seems, by authority of 
Linus), and liberal in what we accept, IMHO.  That is, accept whatever 
partition of the SHA-1, stopping on the first we found (smaller number of 
slashes, or when that is equal, the smaller first prefixes).

We can always discuss ways to handle merging later, I guess.

Ciao,
Dscho
