From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFH] How to get git-gui.sh history
Date: Sat, 21 Apr 2007 02:17:21 -0700
Message-ID: <7vtzvaulwe.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550704210204p1f231076p6a68cb9d6038f4e3@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 21 11:17:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfBiy-0000Zo-Ap
	for gcvg-git@gmane.org; Sat, 21 Apr 2007 11:17:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750755AbXDUJRX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 05:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbXDUJRX
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 05:17:23 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:40542 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750755AbXDUJRW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 05:17:22 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070421091723.TUSK1257.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Sat, 21 Apr 2007 05:17:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id plHM1W00N1kojtg0000000; Sat, 21 Apr 2007 05:17:22 -0400
In-Reply-To: <e5bfff550704210204p1f231076p6a68cb9d6038f4e3@mail.gmail.com>
	(Marco Costalba's message of "Sat, 21 Apr 2007 11:04:40 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45155>

"Marco Costalba" <mcostalba@gmail.com> writes:

> From today git:
>
> $ git rev-list --all -- git-gui/git-gui.sh | wc
>      7       7     287
> $ git rev-list --all --full-history -- git-gui/git-gui.sh | wc
>      9       9     369
>
> So only the merges from git://repo.or.cz/git-gui are shown.

Remember, git does not have concept of "file identity".  Path
filtering feature of "git log" family of commands is just that:
filtering by path.

You are asking for commits that have difference in the specified
paths (in your case, "git-gui/git-gui.sh") from their parents.

Shawn's git-gui repository does not have such a path at all.  He
has git-gui.sh at the toplevel.

$ git rev-list -- git-gui.sh | wc -l
158
