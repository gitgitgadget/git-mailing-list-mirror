From: Junio C Hamano <junkio@cox.net>
Subject: Re: Comments on "status -v"
Date: Fri, 10 Feb 2006 13:09:41 -0800
Message-ID: <7vaccyx6ne.fsf@assigned-by-dhcp.cox.net>
References: <87slqtcr2f.wl%cworth@cworth.org>
	<7vfymtl43b.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602081726390.2458@g5.osdl.org>
	<7vmzgzy46f.fsf@assigned-by-dhcp.cox.net>
	<87u0b7uf91.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 22:09:48 2006
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1F7fWV-0002Uz-00
	for <gcvg-git@gmane.org>; Fri, 10 Feb 2006 22:09:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932202AbWBJVJo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 10 Feb 2006 16:09:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932203AbWBJVJo
	(ORCPT <rfc822;git-outgoing>); Fri, 10 Feb 2006 16:09:44 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:744 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932202AbWBJVJo (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Feb 2006 16:09:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060210210835.CWKX15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 10 Feb 2006 16:08:35 -0500
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87u0b7uf91.wl%cworth@cworth.org> (Carl Worth's message of "Fri,
	10 Feb 2006 12:32:10 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15884>

Carl Worth <cworth@cworth.org> writes:

> 1) I think the patch should come after the traditional status summary,
>    not before. If something is obviously "wrong" (non-updated file,
>    etc.) that will be more obvious in the summary, so it's good to
>    present that up front, and not bury it after the patch, (which
>    might make it initially invisible without scrolling).

Maybe.  A time for a quick poll.

> 2) Using the "^---$" separator to separate the the edited contents
>    into a commit message and ignored content seems risky to me.
>
>    Moving the patch after the summary (as discussed above) would help
>    greatly in avoiding the clobbered separator, but wouldn't address
>    the separator-appears-in-commit-message problem.

That is a good argument for (1).  Since the diff output never
has '^---$' in itself, instead of discarding everything after
the first '^---$', we could change the log cleanser to discard
after the _last_ '^---$'.  But coding this sanely is much
trickier with sed ;-).
