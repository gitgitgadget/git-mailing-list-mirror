From: Junio C Hamano <junkio@cox.net>
Subject: Re: Errors cloning large repo
Date: Fri, 09 Mar 2007 18:12:46 -0800
Message-ID: <7vabylzw0x.fsf@assigned-by-dhcp.cox.net>
References: <20070309234846.7641.qmail@web52613.mail.yahoo.com>
	<Pine.LNX.4.64.0703091641460.10832@woody.linux-foundation.org>
	<Pine.LNX.4.64.0703091800110.10832@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Anton Tropashko <atropashko@yahoo.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 10 03:12:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPr4n-0006hS-HT
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 03:12:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767730AbXCJCMs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 21:12:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767725AbXCJCMs
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 21:12:48 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:44477 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767730AbXCJCMr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 21:12:47 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070310021247.EPTX24587.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Fri, 9 Mar 2007 21:12:47 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id YqCm1W0021kojtg0000000; Fri, 09 Mar 2007 21:12:46 -0500
In-Reply-To: <Pine.LNX.4.64.0703091800110.10832@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 9 Mar 2007 18:03:39 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41839>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> It's indeed "git commit" that takes tons of memory, but for all the wrong 
> reasons. It does a "git diff-tree" to generate the diffstat, and *that* is 
> extremely expensive:
>
> 	git-diff-tree --shortstat --summary --root --no-commit-id HEAD --
>
> I suspect we shouldn't bother with the diffstat for the initial commit. 
> Just removing "--root" migth be sufficient.

Yes and no.  It was added as a response to sugestions from
people in "baby step tutorial" camp.

An option to disable the last diff-tree step, just like git-pull
has --no-summary option, would be perfectly fine, though.
