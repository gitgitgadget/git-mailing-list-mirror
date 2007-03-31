From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Packing large repositories
Date: Sat, 31 Mar 2007 13:54:07 -0700
Message-ID: <7vslbl8780.fsf@assigned-by-dhcp.cox.net>
References: <56b7f5510703280005o7998d65pcbcd4636b46d8d23@mail.gmail.com>
	<Pine.LNX.4.64.0703280943450.6730@woody.linux-foundation.org>
	<20070330062324.GU13247@spearce.org>
	<alpine.LFD.0.83.0703300851270.3041@xanadu.home>
	<78639417-ACDB-484F-85BB-EC0AF694949A@adacore.com>
	<Pine.LNX.4.64.0703311033290.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Geert Bosch <bosch@adacore.com>, Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Dana How <danahow@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 31 22:54:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXkaU-0004ox-5f
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 22:54:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467AbXCaUyK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 16:54:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751594AbXCaUyK
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 16:54:10 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:35440 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751467AbXCaUyJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 16:54:09 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070331205409.NNPC24385.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 31 Mar 2007 16:54:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id hYu71W0081kojtg0000000; Sat, 31 Mar 2007 16:54:08 -0400
In-Reply-To: <Pine.LNX.4.64.0703311033290.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 31 Mar 2007 11:36:35 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43569>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> In other words, the 256-entry fan-out was meant to avoid the first eight 
> levels of binary lookup. But the thing is, we should be able to generally 
> do a *lot* better than any binary lookup by just doing a LINEAR SEARCH, 
> which is also more cache-friendly, and prefetches much better when it's 
> not in the cache.
> ...
>  - use newton-raphson to iterate closer. It should be a much faster way to 
>    find the rough area for the entry we're searching for than binary 
>    search. Two or three iterations should get us there, easily.

This is another egg of columbus moment that makes me feel it was
worth to have been in git community ;-).

I like it.
