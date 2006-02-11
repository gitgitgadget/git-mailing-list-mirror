From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git 1.1.6.g4d44 make test FAILURE report
Date: Fri, 10 Feb 2006 18:17:07 -0800
Message-ID: <7vvevmtza4.fsf@assigned-by-dhcp.cox.net>
References: <43ED0368.7020204@gmail.com>
	<7vhd76vqrg.fsf@assigned-by-dhcp.cox.net> <43ED3FD3.7020005@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 11 03:17:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7kKJ-0005ZT-TB
	for gcvg-git@gmane.org; Sat, 11 Feb 2006 03:17:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932084AbWBKCRK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 21:17:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932090AbWBKCRK
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 21:17:10 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:50156 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932084AbWBKCRI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 21:17:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060211021350.GIWK20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Feb 2006 21:13:50 -0500
To: A Large Angry SCM <gitzilla@gmail.com>
In-Reply-To: <43ED3FD3.7020005@gmail.com> (A. Large Angry's message of "Fri,
	10 Feb 2006 17:37:23 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15915>

A Large Angry SCM <gitzilla@gmail.com> writes:

> Also, git-var complains when used by an account with an empty gcos
> field; thereby, breaking all the non-C git commands even when the user
> is not committing.
>
> If the _intent_ was to force commiters and author names in commits,
> why was the test not placed only in commit-tree.c?

git-var was more or less intentional.  Scripts such as
git-applypatch, git-commit and git-tag use the command to grab
COMMITTER_IDENT to generate sign-off line and tagger information
when asked, and commit-tree.c changes alone would not catch
them.

A user eventually would make commit so it may not be a too bad
to _strongly_ encourage setting up these environment variables,
by being nasty ;-).  I agree it would be _very_ annoying until
you either fix your gecos and/or environment.

Ideas welcome.
