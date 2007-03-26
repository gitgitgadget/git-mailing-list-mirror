From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git performance problems with many tags
Date: Sun, 25 Mar 2007 23:13:07 -0700
Message-ID: <7vwt14zg5o.fsf@assigned-by-dhcp.cox.net>
References: <20070326045341.GE10545@ws35.commsecure.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Tim Allen <tim@commsecure.com.au>
X-From: git-owner@vger.kernel.org Mon Mar 26 08:13:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HViS8-00039I-RX
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 08:13:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933620AbXCZGNJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 02:13:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933617AbXCZGNJ
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 02:13:09 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:54577 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933620AbXCZGNI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 02:13:08 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070326061307.UINW1312.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Mon, 26 Mar 2007 02:13:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id fJD71W0061kojtg0000000; Mon, 26 Mar 2007 02:13:07 -0400
In-Reply-To: <20070326045341.GE10545@ws35.commsecure.com.au> (Tim Allen's
	message of "Mon, 26 Mar 2007 14:53:41 +1000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43116>

Tim Allen <tim@commsecure.com.au> writes:

> However, operations like 'git-fetch' take much, much longer in our
> repository than in the kernel repository: a git-fetch that pulls no
> updates in the kernel repository takes 1.7s, while our repository
> (fetching from one repository to a clone on the same local disk) takes
> about 20 seconds.
> ...
> Does git have known scalability problems with large numbers of tags? Is
> there anything we can do to mitigate this slowdown, apart from just not
> using git's tag feature at all? Are there any details I've overlooked or
> misunderstood?

An optimization for "fetching between repositories with insane
number of refs" problem was merged after v1.5.0, so if you try
the current tip of 'master' (which happens to be at v1.5.1-rc2
right now), I suspect you may see significant improvements.
