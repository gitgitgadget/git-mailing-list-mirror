From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git-status producing incorrect results
Date: Thu, 14 Feb 2008 16:51:04 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802141650080.30505@racer.site>
References: <20080214164505.GA21932@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	=?ISO-8859-15?Q?Kristian_H=F8gsberg?= <krh@redhat.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Feb 14 17:51:46 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JPhJI-0006y9-0Y
	for gcvg-git-2@gmane.org; Thu, 14 Feb 2008 17:51:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754839AbYBNQvJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Feb 2008 11:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754078AbYBNQvI
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Feb 2008 11:51:08 -0500
Received: from mail.gmx.net ([213.165.64.20]:60419 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753507AbYBNQvH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Feb 2008 11:51:07 -0500
Received: (qmail invoked by alias); 14 Feb 2008 16:51:05 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp035) with SMTP; 14 Feb 2008 17:51:05 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18CzdZvbD4CxUH6nE8krR+7P/7MyQWd+8gOPHwV2m
	szKcceK9uSqiix
X-X-Sender: gene099@racer.site
In-Reply-To: <20080214164505.GA21932@coredump.intra.peff.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73889>

Hi,

On Thu, 14 Feb 2008, Jeff King wrote:

> There seems to be a bug in "git-status" in next (but not in master). I
> bisected it to:
> 
>   commit d1f2d7e8ca65504722108e2db710788f66c34c6c
>   Author: Linus Torvalds <torvalds@linux-foundation.org>
>   Date:   Sat Jan 19 17:27:12 2008 -0800
> 
>   Make run_diff_index() use unpack_trees(), not read_tree()
> 
> Basically, doing a partial commit when a new file has been added to the
> index but isn't part of the partial commit will cause that new file to
> be listed as part of the index.

I experienced the same bug, but when I looked in the tests, I had the 
impression that it tested for that very bug, and succeeded.  And I did not 
have time to look into it further.

Speaking of tests... How about it?

Ciao,
Dscho
