From: Junio C Hamano <junkio@cox.net>
Subject: Deprecation/Removal schedule
Date: Sun, 04 Feb 2007 22:48:17 -0800
Message-ID: <7v8xfdnlqm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 05 07:48:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDxeI-00083o-1E
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 07:48:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752749AbXBEGsS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 01:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752751AbXBEGsS
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 01:48:18 -0500
Received: from fed1rmmtai18.cox.net ([68.230.241.41]:43384 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752749AbXBEGsS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 01:48:18 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070205064817.FPP1302.fed1rmmtao105.cox.net@fed1rmimpo01.cox.net>;
          Mon, 5 Feb 2007 01:48:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KioH1W00B1kojtg0000000; Mon, 05 Feb 2007 01:48:17 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38730>

We seem to have accumulated some crufts, duplicated and/or
disused features.  I think we should start planning deprecation
and removal.

Here are potential candidates we might want to mark as
"scheduled for removal".  Note that I threw in a bit more than
what I seriously consider bloat, so your favorite may appear in
the list.

* git-applymbox and git-applypatch

  Does anybody rely on them?  I think new users are all using
  git-am (this is just what _I_ think -- please consider this
  message as a poll to voice your objection).

* git-whatchanged

  This has been identical to git-log with different default
  options.

* git-p4import, git-quiltimport and contrib/gitview

  These have seen almost no activity since their appearance.  It
  could be that they are already perfect and many people are
  using them happily, but I find it a bit hard to believe.

* git-diff-stages

  Judging from the fact that nobody complained what it does is
  not accessible from "git diff" wrapper, I suspect nobody is
  interested in comparing the stages while merging (I certainly
  do not use it myself).

* git-lost-found

  Although it has served us well, I think it is about to outlive
  its usefulness, thanks to the recent "reflog by default"
  change.

* git-local-fetch, git-ssh-fetch and git-ssh-upload

  In-tree git-fetch does not use these commit walkers as the
  backend.  They might be used by Cogito and people's scripts so
  I am not seriously pushing for their removal.  http-fetch is
  here to stay so it's not like removing them would reduce the
  burden to maintain the commit walkers anyway.

* contrib/colordiff

  This has long outlived its usefulness.
