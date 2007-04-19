From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add test for symlinked .git/packed-refs
Date: Wed, 18 Apr 2007 23:06:45 -0700
Message-ID: <7vabx499u2.fsf@assigned-by-dhcp.cox.net>
References: <7v7isajfl1.fsf@assigned-by-dhcp.cox.net>
	<20070418081122.GB32634@xp.machine.xx>
	<Pine.LNX.4.64.0704181251040.19261@reaper.quantumfyre.co.uk>
	<7vfy6xird9.fsf@assigned-by-dhcp.cox.net>
	<20070418174350.GB5913@xp.machine.xx>
	<7vlkgph7i0.fsf@assigned-by-dhcp.cox.net>
	<20070418183156.GF5913@xp.machine.xx>
	<7v647th6cv.fsf@assigned-by-dhcp.cox.net>
	<20070418210819.GG5913@xp.machine.xx>
	<7v4pndfjym.fsf@assigned-by-dhcp.cox.net>
	<20070419053518.GK5913@xp.machine.xx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Julian Phillips <julian@quantumfyre.co.uk>
To: Peter Baumann <waste.manager@gmx.de>
X-From: git-owner@vger.kernel.org Thu Apr 19 08:06:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HePn8-0007MC-2H
	for gcvg-git@gmane.org; Thu, 19 Apr 2007 08:06:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030856AbXDSGGr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Apr 2007 02:06:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030859AbXDSGGr
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Apr 2007 02:06:47 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:61593 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030856AbXDSGGq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2007 02:06:46 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070419060646.VIRO1257.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 19 Apr 2007 02:06:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ou6l1W00y1kojtg0000000; Thu, 19 Apr 2007 02:06:46 -0400
cc: git@vger.kernel.org
In-Reply-To: <20070419053518.GK5913@xp.machine.xx> (Peter Baumann's message of
	"Thu, 19 Apr 2007 07:35:18 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44987>

Peter Baumann <waste.manager@gmx.de> writes:

> Signed-off-by: Peter Baumann <waste.manager@gmx.de>
> ---
> On Wed, Apr 18, 2007 at 02:31:29PM -0700, Junio C Hamano wrote:
>> 
>> Oh, I never questioned that you made that basic case work.  I
>> was worried about not making sure the symlink we are looking at
>> really is the case we are willing to handle, and not erroring
>> out if that is not the case, perhaps like the attached patch on
>> top of yours.
>> 
>> An additional test or two in t/t3210 would be nice to accompany
>> this change.
>> 
>
> Something like this?

That's a good start, but I expected to see at least tests for
two cases: a case in which .git/packed-refs symlink points at an
actual file (i.e. the original repository has run pack-refs) and
another case in which .git/packed-refs symlink is dangling
(i.e. the original repository hasn't run pack-refs).  I
understand that the borrower "worktree" can have .git/packed-refs
symlink pointing at the repositories .git/packed-refs yet to be
born.
