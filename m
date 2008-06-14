From: Vaclav Hanzl <hanzl@noel.feld.cvut.cz>
Subject: Document clone of clone loosing branches?
Date: Sat, 14 Jun 2008 15:05:48 +0200 (CEST)
Message-ID: <20080614.150548.71104932.hanzl@noel.feld.cvut.cz>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 14 15:40:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7VzT-00011X-S1
	for gcvg-git-2@gmane.org; Sat, 14 Jun 2008 15:40:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701AbYFNNj2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jun 2008 09:39:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754589AbYFNNj2
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Jun 2008 09:39:28 -0400
Received: from magi4.feld.cvut.cz ([147.32.198.214]:56659 "EHLO mepi"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1754577AbYFNNj1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jun 2008 09:39:27 -0400
X-Greylist: delayed 1706 seconds by postgrey-1.27 at vger.kernel.org; Sat, 14 Jun 2008 09:39:26 EDT
Received: from localhost (localhost [127.0.0.1])
	by mepi (Postfix) with ESMTP id 4FC57FD806
	for <git@vger.kernel.org>; Sat, 14 Jun 2008 15:05:48 +0200 (CEST)
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85014>

I wander whether man git-clone is correct when it says "creates
remote-tracking branches for each branch in the cloned repository".

IMHO remote-tracking branches in the original repository _are_
branches and they are _not_ cloned (when using git-clone with no
options) - maybe this is worth noting very explicitly?

When git newby like me converts a CVS repository, containing just few
short old branches (stable release bug fixes) and then clones it
around, with naive belief that clone is a 1:1 copy or something close,
nasty surprise can happen:

 - converted repository has those branches, OK
 - clone of it also has them, but as a remote tracking branches
 - clone of clone has it as dangling objects only (can go away later)

Trying to play it safe, I used git-clone many times while starting
with git, and I got really nervous when I first discovered that my old
stable release bug fix branch is not visible in some repositories :-)

Is it just my failure to read those few hundred man pages carefully
enough (I did my best :-) ), or something worth fixing in man
git-clone and tutorials?

Regards,

Vaclav Hanzl
