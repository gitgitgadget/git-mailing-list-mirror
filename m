From: Junio C Hamano <junkio@cox.net>
Subject: Re: Stupid question on getting branch from yesterday
Date: Wed, 14 Feb 2007 13:25:58 -0800
Message-ID: <7vire4mnx5.fsf@assigned-by-dhcp.cox.net>
References: <17875.25882.784307.731860@lisa.zopyra.com>
	<Pine.LNX.4.64.0702141250300.20368@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 14 22:26:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHRdd-0002yy-LX
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 22:26:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932630AbXBNV0B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 16:26:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932634AbXBNV0A
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 16:26:00 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:41133 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932630AbXBNV0A (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 16:26:00 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214212559.LFUU21177.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Feb 2007 16:25:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PZRz1W00A1kojtg0000000; Wed, 14 Feb 2007 16:25:59 -0500
In-Reply-To: <Pine.LNX.4.64.0702141250300.20368@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 14 Feb 2007 13:13:09 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39754>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> So depending on what your situation is, this sequence actually works:
>
> 	#
> 	# Create and check out a "fixes" branch that has the 
> 	# known-broken commit as its head commit
> 	#
> 	git checkout -b fixes <BROKEN-COMMIT>
>
> 	.. edit edit edit to fix the broken commit ..
>
> 	#
> 	# Then, just _replace_ the broken commit with the fixed state
> 	# by doing a "git commit --amend"
> 	#
> 	git commit -a --amend
>
> 	#
> 	# ok, now the "fixed-branch" is in good shape, but we
> 	# want to re-surrect our original 'master' branch WITH the 
> 	# fix, and based on the fixed branch, so we rebase the
> 	# master branch# _onto_ the fixed state in "fixes", with
> 	# the broken commit (that we do _not_ want to include) as
> 	# the base.
> 	#
> 	git rebase --onto fixes <BROKEN-COMMIT> master
>
> Somebody else should verify that "git rebase" thing.

Looks fine.
