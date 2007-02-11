From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-am and workflow question
Date: Sat, 10 Feb 2007 22:45:48 -0800
Message-ID: <7vps8hdwf7.fsf@assigned-by-dhcp.cox.net>
References: <7vodo5153j.fsf@assigned-by-dhcp.cox.net>
	<20070210221852.GC32216@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Kumar Gala <galak@kernel.crashing.org>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
X-From: git-owner@vger.kernel.org Sun Feb 11 07:45:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HG8TB-0008Gk-KL
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 07:45:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753116AbXBKGpt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 01:45:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753121AbXBKGpt
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 01:45:49 -0500
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:64281 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753116AbXBKGpt (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 01:45:49 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070211064548.VQMY1349.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sun, 11 Feb 2007 01:45:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id N6lo1W00H1kojtg0000000; Sun, 11 Feb 2007 01:45:48 -0500
In-Reply-To: <20070210221852.GC32216@mellanox.co.il> (Michael S. Tsirkin's
	message of "Sun, 11 Feb 2007 00:18:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39275>

"Michael S. Tsirkin" <mst@mellanox.co.il> writes:

>> My second pass is actually applying the patch by piping each
>> e-mail message from my e-mail client to "git am -3 -s", and if I
>> do not like something in the patch, I make corrections and then
>> run "git commit --amend".
>
> git-commit --amend seems to rewrite the commit author which is
> annoying if you only want to modify the log message a little. As a
> work-around I copy the author info from the log and passing --author
> explicitly, but is there an easier way?

I am puzzled about this comment.  You should not have to do
anything funky at all.

"commit --amend" changes the committer information (because you
are now committing something different and at a different time
from what was recorded in the original commit object), but does
not touch the author information at all.

We _might_ have had a bug in an ancient version but I even doubt
it.
