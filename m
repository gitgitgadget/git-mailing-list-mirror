From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Ignore commits for which cvsps can't identify a branch
Date: Fri, 10 Feb 2006 13:21:58 -0800
Message-ID: <7vmzgyvrih.fsf@assigned-by-dhcp.cox.net>
References: <200602102102.k1AL2Xkd010415@biesi.no-ip.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 22:22:09 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1F7fiS-0003SQ-00
	for <gcvg-git@gmane.org>; Fri, 10 Feb 2006 22:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbWBJVWE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 16:22:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751386AbWBJVWE
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 16:22:04 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:55224 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751385AbWBJVWB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 16:22:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060210212032.XWNU6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Feb 2006 16:20:32 -0500
To: Christian Biesinger <cbiesinger@web.de>
In-Reply-To: <200602102102.k1AL2Xkd010415@biesi.no-ip.org> (Christian
	Biesinger's message of "Fri, 10 Feb 2006 22:02:33 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15887>

Christian Biesinger <cbiesinger@web.de> writes:

> cvps sometimes can't identify a branch for a specific revision, it shows
> messages like:
>   WARNING: revision 1.36.2.2 of file Makefile.in on unnamed branch
> and uses #CVSPS_NO_BRANCH as branch name in its output.
>
> This checkin makes it so that git-cvsimport ignores such branches,
> and when they
> appear as ancestor branch, it maps them to HEAD.

Does continuing with this kind of "fixups" produce usable
history, perhaps just some changes missing but trees contained
in other commits are still faithful reproductions of what the
CVS repository would have given you?  Or does it result in
unusable history?

Depending on the nature of corruption and its expected use,
sometimes silently corrupt conversion result is worse than not
having it at all.  If you are going to use it primarily for
archaeology, it is much more useful to have a more-or-less
correct conversion than not having anything at all, but if you
are building on top of it, you at least would want to have the
correct tree at the tip of the branch you build upon.  I cannot
offhand tell how this workaround affects the conversion result,
hence this question.

> I hope I did this right, I'm not so familiar with git...

The only gripe I might have is your log message is too wide.
Other than that it looks like it properly follows the the
formatting and submitting convention.
