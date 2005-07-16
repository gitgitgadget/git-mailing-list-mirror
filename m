From: Junio C Hamano <junkio@cox.net>
Subject: Barebone Porcelain.  Where to stop?
Date: Sat, 16 Jul 2005 10:37:45 -0700
Message-ID: <7vek9yirdi.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Jul 16 19:39:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dtqd2-0006JB-5Y
	for gcvg-git@gmane.org; Sat, 16 Jul 2005 19:39:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbVGPRjA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Jul 2005 13:39:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261778AbVGPRjA
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Jul 2005 13:39:00 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:60664 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261779AbVGPRht (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2005 13:37:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050716173746.GLCT16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 16 Jul 2005 13:37:46 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

I have been somewhat disturbed and confused by the fact that the
line between what Porcelain like Cogito does and what we ship as
part of "core GIT" is getting more and more blurred.  This was
especially so while I was working on the $GIT_DIR/branches/
patch.

This trend started when "git diff", "git commit" and friends
were added for the sake of usability of the bare Plumbing.
These basic commands are must and I do not have any objection to
have them in the "core GIT" suite, but at the same time I think
the core should not be competing with Porcelains, and feel that
a line should be drawn somewhere [*1*].

I'd like to hear opinions from the list.  Personally I think
what we have so far is about right, relative to what the current
crop of Porcelains offer.

This is me speaking as just "an individual developer".  Linus as
"the project lead", Pasky as the maintainer of the de-facto
standard Porcelain, and others on the list may have different
opinions.  I do not think the core GIT should be making drastic
innovations that Porcelain folks have not asked.  In my ideal
world, Porcelains would be the first to innovate in the UI and
use pattern area, and while doing so, would discover something
lacking from the core.  The purpose of the core GIT development
should primarily be to fill these needs.  Then, once "best
current practices" from Porcelains emerge, the infrastructure to
support them would become a part of core GIT; we might even
start shipping corresponding barebone Porcelain scripts to
codify that BCP using the same support infrastructure as part of
the "core GIT" suite [*2*].

Linus said that the current Plumbing already does all he wants
it to do.  I started sharing the same opinion.  I am finding
myself using my own Porcelain commands less frequently for doing
basic things, because the barebone Porcelain already fills much
of my needs.


[Footnotes]

*1* Yes, I publicly stated that one of my goals of my
involvement in GIT development was to make choice of Porcelain
more or less irrelevant, and that still stands, which means that
I am in favor of having rich enough barebone Porcelain shipped
with "core GIT".  But the problem I am having is now is how rich
is rich enough.

*2* ... and that is how we make the Porcelain less relevant ;-).
