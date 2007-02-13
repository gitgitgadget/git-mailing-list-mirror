From: Junio C Hamano <junkio@cox.net>
Subject: Re: Including the release notes in the git-1.5.0 release?
Date: Tue, 13 Feb 2007 09:44:22 -0800
Message-ID: <7vzm7ix895.fsf@assigned-by-dhcp.cox.net>
References: <E1HGyPn-0003Te-9s@candygram.thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Feb 13 18:44:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH1ha-0006ob-W6
	for gcvg-git@gmane.org; Tue, 13 Feb 2007 18:44:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751358AbXBMRoY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 12:44:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751361AbXBMRoX
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 12:44:23 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:49954 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751358AbXBMRoX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 12:44:23 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070213174423.XFXY1306.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Tue, 13 Feb 2007 12:44:23 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id P5kN1W00j1kojtg0000000; Tue, 13 Feb 2007 12:44:22 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39553>

"Theodore Ts'o" <tytso@mit.edu> writes:

> As a suggestion, maybe it would be a good idea to actually include it as
> RELEASE-NOTES in the top-level source tree of git.   This will make it
> much more likely that people packaging git will include in
> /usr/share/doc/git.  
>
> Or better yet, maybe we should include it in the Documentation directory
> and set it up to be built as a manpage, git-release-notes.  This will
> make it much more likely that end users who are getting git from their
> Fedora, Debian, Red Hat, et. al distribution will actually see the
> release notes when they install the new package.

Indeed I was planning to use it as the announcement message, but
including it in the final tarball sounds sensible.

As the text assumes familiarity with git 1.3.0 or so, I am not
sure if making it as one of the manpages makes much sense.

Also there is a question of what to do when 1.6.0 comes out.
Will its release notes replace 1.5.0 one?  If so changes from
which version will it describe?

I suspect that doing something like:

	git cat-file todo:v1.5.0.txt >Documentation/v1.5.0.txt
	ln -s Documentation/v1.5.0.txt RELEASE-NOTES
        git add RELEASE-NOTES Documentation/v1.5.0.txt

and have pointer to v1.5.0.txt from Documentation/git.txt would
be a sensible and easy thing to do.
