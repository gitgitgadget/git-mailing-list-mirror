From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] [gitweb] Blame "linenr" link jumps to previous state at "orig_lineno"
Date: Thu, 04 Jan 2007 19:50:00 -0800
Message-ID: <7vk602jfo7.fsf@assigned-by-dhcp.cox.net>
References: <605150.6351.qm@web31807.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 04:50:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2g5p-0001pv-Ac
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 04:50:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030320AbXAEDuF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 Jan 2007 22:50:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbXAEDuE
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Jan 2007 22:50:04 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:52913 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030320AbXAEDuD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Jan 2007 22:50:03 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070105035001.RVLY9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Thu, 4 Jan 2007 22:50:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7FqG1W0081kojtg0000000; Thu, 04 Jan 2007 22:50:16 -0500
To: ltuikov@yahoo.com
In-Reply-To: <605150.6351.qm@web31807.mail.mud.yahoo.com> (Luben Tuikov's
	message of "Thu, 4 Jan 2007 18:37:45 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35977>

Luben Tuikov <ltuikov@yahoo.com> writes:

> A quick show-and-tell of this patch is after applying it, open
> "blame" on a file, click on a linenr link of a block which
> has only a single line changed -- the diff between what
> you're seeing now and before is at least that line.  This you can
> data-mine with gitweb back to where the line was introduced.  Similar
> argument applies to blocks of more than one line.

One non-question and one question:

 - This favors the first parent, which is obviously the right
   thing for most of the time.  I wonder what happens to a
   merge, though, but I realize that a line attributed to a
   merge is even rarer, and such a line is introduced by the
   "evil merge".

 - I wonder if the line number is correct for the parent
   commit.  How well does this work when you clicked a line that
   was added at the end of the file, where the $orig_lineno goes
   beyond the whole file in the parent?
