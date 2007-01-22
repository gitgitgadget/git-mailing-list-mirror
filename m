From: Junio C Hamano <junkio@cox.net>
Subject: Re: modifying commit's author
Date: Mon, 22 Jan 2007 12:48:27 -0800
Message-ID: <7v8xfuss84.fsf@assigned-by-dhcp.cox.net>
References: <20070122203734.GB23187@fieldses.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 22 21:48:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H965r-0007LN-5O
	for gcvg-git@gmane.org; Mon, 22 Jan 2007 21:48:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbXAVUsa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Jan 2007 15:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932606AbXAVUs3
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Jan 2007 15:48:29 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:57760 "EHLO
	fed1rmmtao09.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932612AbXAVUs2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jan 2007 15:48:28 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070122204827.YJLJ18767.fed1rmmtao09.cox.net@fed1rmimpo02.cox.net>;
          Mon, 22 Jan 2007 15:48:27 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ELol1W00b1kojtg0000000; Mon, 22 Jan 2007 15:48:46 -0500
To: "J. Bruce Fields" <bfields@fieldses.org>
In-Reply-To: <20070122203734.GB23187@fieldses.org> (J. Bruce Fields's message
	of "Mon, 22 Jan 2007 15:37:34 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37449>

"J. Bruce Fields" <bfields@fieldses.org> writes:

> If I got the author wrong on a commit, is there a quick way to fix it
> (e.g. by passing the right arguments or environment variables to commit
> --amend)?

I usually do "format-patch -$n; reset --hard HEAD~$n; edit
00??-*.patch; am 00??-*.patch" myself when I got into that
situation to rebuild the branch, and haven't personally felt
need for an option to --amend, but it might make sense to teach
git-commit --amend to allow --author option to override it; I
think it currently ignores --author when given without erroring
out.

It may become a question if we would want to allow updating the
timestamp as well, but when people asked for --author I did not
hear from anybody who wanted to have --authortime, so not being
able to do so probably is Ok.
