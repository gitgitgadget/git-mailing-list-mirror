From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-kill: rewrite history removing a commit
Date: Wed, 31 Jan 2007 12:26:52 -0800
Message-ID: <7v7iv3uelv.fsf@assigned-by-dhcp.cox.net>
References: <20070131195533.GE21097@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
X-From: git-owner@vger.kernel.org Wed Jan 31 21:27:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCM2r-0000Wb-3P
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 21:27:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030211AbXAaU0y (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 15:26:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030287AbXAaU0y
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 15:26:54 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:38777 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030211AbXAaU0x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 15:26:53 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070131202653.ZVYJ25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Wed, 31 Jan 2007 15:26:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id HwSs1W00j1kojtg0000000; Wed, 31 Jan 2007 15:26:53 -0500
In-Reply-To: <20070131195533.GE21097@mellanox.co.il> (Michael S. Tsirkin's
	message of "Wed, 31 Jan 2007 21:55:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38293>

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

> Below is a simple script that rewrites history reverting a single commit.
> This differs from git-revert in that a commit is completely removed,
> and is especially useful before one has published a series of
> commits.
>
> Do you find this useful? Comments?
> Drop me a line.

"Do you find this useful" is a loaded question.

I do it all the time with git-rebase, so the need to remove a
botched commit from the history and rebuild the remainder is
certainly there, meaning "what your patch does IS useful".

I do it all the time with git-rebase, so I personally do not
need a new tool to do this, meaning "your patch is not useful to
me".

When I find master~8 and master~9 to be undesirable, I would do:

	$ git rebase --onto master~10 master~8

which rebuilds master~7 and onward on top of master~10, thereby
dropping two commits.
