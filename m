From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] A new merge stragety 'subtree'.
Date: Sat, 17 Feb 2007 00:29:24 -0800
Message-ID: <7vzm7duqzf.fsf@assigned-by-dhcp.cox.net>
References: <7vfy95y2n9.fsf@assigned-by-dhcp.cox.net>
	<20070217071425.GD27864@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Feb 17 09:29:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIKwi-0002Wk-SP
	for gcvg-git@gmane.org; Sat, 17 Feb 2007 09:29:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946435AbXBQI30 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Feb 2007 03:29:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946454AbXBQI30
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Feb 2007 03:29:26 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:57815 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946435AbXBQI3Z (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Feb 2007 03:29:25 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070217082924.OIIW21177.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Sat, 17 Feb 2007 03:29:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id QYVQ1W00N1kojtg0000000; Sat, 17 Feb 2007 03:29:25 -0500
In-Reply-To: <20070217071425.GD27864@spearce.org> (Shawn O. Pearce's message
	of "Sat, 17 Feb 2007 02:14:25 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39974>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>> ...
>> Although I do not plan to commit anything in git-gui/ part of my
>> tree myself, bypassing Shawn, it is nice to know that it will
>> not introduce problems down the road.
>
> This does actually cause a problem if you merge a git.git commit
> into git-gui.git (by stripping the git-gui/ part off).  The problem
> is the entire git.git history would then become the second parent
> of the git-gui.git merge commit, and suddenly the git-gui.git
> repository increases by >11 MiB in size...  ;-)

Don't worry.  I am not asking you to actually perform such a merge
and make the relut as a part of _official_ git-gui.git history.

> To avoid pulling the entire git.git history into git-gui, I'd ask
> that anyone bypassing me (e.g. if I'm being horribly unresponsive
> one week) checkout the git-gui branch from git.git, apply the
> change(s) there, then merge that branch into git.git using the
> subtree strategy.

Actually, I do not think you even need to ask them to do that.
I am not planning to apply patches to git.git that touch
git-gui/ subdirectory myself, but if you see such a patch on the
list, you could first apply it to your copy of git.git
repository, and run your private edition of cherry-pick that
uses merge-subtree instead of merge-recursive to pick it out
onto your 'master' branch of git-gui.git repository.  That way,
the next time I'll pull from your git-gui.git repository, I will
get the change through you.

And the procedure would actually work _even_ _if_ (repeat, I do
not plan to do this) I applied such a patch to my tree before I
pull from you --- it will just result in an accidental clean
merge.
