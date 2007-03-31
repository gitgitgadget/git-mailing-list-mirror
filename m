From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Rename warn() to warning() to fix symbol conflicts on BSD and Mac OS
Date: Sat, 31 Mar 2007 01:15:31 -0700
Message-ID: <7vejn5ygkc.fsf@assigned-by-dhcp.cox.net>
References: <11752960251394-git-send-email-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Randal L. Schwartz" <merlyn@stonehenge.com>
To: Theodore Ts'o <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Sat Mar 31 10:15:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXYkP-0008GS-K9
	for gcvg-git@gmane.org; Sat, 31 Mar 2007 10:15:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752437AbXCaIPg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 31 Mar 2007 04:15:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752423AbXCaIPg
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Mar 2007 04:15:36 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:35243 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752437AbXCaIPe (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Mar 2007 04:15:34 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070331081534.ETAB373.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sat, 31 Mar 2007 04:15:34 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id hLFZ1W00F1kojtg0000000; Sat, 31 Mar 2007 04:15:34 -0400
In-Reply-To: <11752960251394-git-send-email-tytso@mit.edu> (Theodore Ts'o's
	message of "Fri, 30 Mar 2007 19:07:05 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43539>

Theodore Ts'o <tytso@mit.edu> writes:

> This fixes a problem reported by Randal Schwartz:
>
>>I finally tracked down all the (albeit inconsequential) errors I was getting
>>on both OpenBSD and OSX.  It's the warn() function in usage.c.  There's
>>warn(3) in BSD-style distros.  It'd take a "great rename" to change it, but if
>>someone with better C skills than I have could do that, my linker and I would
>>appreciate it.
>
> It was annoying to me, too, when I was doing some mergetool testing on
> Mac OS X, so here's a fix.

I'd take this for now, but I wonder where we should stop.  If
somebody exports error() or die(), would we end up renaming them
to git_error() and git_die()?
