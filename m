From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Convert emailing part of hooks--update to hooks--post-receive
Date: Sun, 25 Mar 2007 00:13:45 -0700
Message-ID: <7vaby1aj86.fsf@assigned-by-dhcp.cox.net>
References: <200703231023.58911.andyparkins@gmail.com>
	<7vlkhmg6c3.fsf@assigned-by-dhcp.cox.net>
	<200703241550.05590.andyparkins@gmail.com>
	<Pine.LNX.4.64.0703240858370.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Mar 25 09:14:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVMvS-0007gL-Pk
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 09:14:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753226AbXCYHNr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 03:13:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753232AbXCYHNr
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 03:13:47 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:60144 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753226AbXCYHNq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 03:13:46 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070325071347.FPOE1312.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Sun, 25 Mar 2007 03:13:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id evDl1W0051kojtg0000000; Sun, 25 Mar 2007 03:13:46 -0400
In-Reply-To: <Pine.LNX.4.64.0703240858370.6730@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 24 Mar 2007 09:12:28 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43036>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 24 Mar 2007, Andy Parkins wrote:
>> 
>> Oh dear; I had no idea that packed refs made the ref file itself 
>> disappear.
>
> Everybody should do
>
> 	git pack-refs --all --prune
>
> occasionally to see this. In fact, I think we should probably make that 
> part of "git gc" (which currently doesn't pack branches at all, just tags, 
> since it omits the "--all").

*Warning*

As described in 1.5.0 release notes, packed and then pruned refs
are not visible by commit walkers older than 1.5.0.  So
everybody should refrain from doing the above on a public
"distribution point" repository that can be accessed over http
until everybody upgrades.
