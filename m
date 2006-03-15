From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Invoke git-repo-config directly.
Date: Wed, 15 Mar 2006 13:33:18 -0800
Message-ID: <7vek13ieap.fsf@assigned-by-dhcp.cox.net>
References: <20060314211022.GA12498@localhost.localdomain>
	<Pine.LNX.4.64.0603141351470.3618@g5.osdl.org>
	<20060314224027.GB14733@localhost.localdomain>
	<Pine.LNX.4.64.0603141506130.3618@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Wed Mar 15 22:33:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FJdcW-00078u-2p
	for gcvg-git@gmane.org; Wed, 15 Mar 2006 22:33:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbWCOVdW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Mar 2006 16:33:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751488AbWCOVdW
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Mar 2006 16:33:22 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:29672 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751434AbWCOVdW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Mar 2006 16:33:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060315213020.XLUU17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 15 Mar 2006 16:30:20 -0500
To: Qingning Huo <qhuo@mayhq.co.uk>
In-Reply-To: <Pine.LNX.4.64.0603141506130.3618@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 14 Mar 2006 15:07:39 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17616>

Linus Torvalds <torvalds@osdl.org> writes:

> I agree that it is inconsistent as-is. So a patch to make it use the 
> "git-repo-config" form (the argument being that internally, we use the 
> full names) might be good if just for consistency.

If we do the dash-form for consistency's sake, we should do
PATH="`git --exec-path`:$PATH" in git-setup-sh when/before we do
so.  For scripts that do not use git-setup-sh they must have
their own.

This would make difference if/when we switch to
/usr/lib/git/exec, but until then it is not.
