From: Junio C Hamano <junkio@cox.net>
Subject: Re: History rewriting swiss army knife
Date: Fri, 24 Mar 2006 14:47:43 -0800
Message-ID: <7vek0rzchc.fsf@assigned-by-dhcp.cox.net>
References: <20060324140831.GY18185@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 24 23:48:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FMv4e-0004V5-G2
	for gcvg-git@gmane.org; Fri, 24 Mar 2006 23:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932175AbWCXWsA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Mar 2006 17:48:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932147AbWCXWsA
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Mar 2006 17:48:00 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:64944 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932175AbWCXWr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Mar 2006 17:47:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060324224759.DLCW20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 24 Mar 2006 17:47:59 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060324140831.GY18185@pasky.or.cz> (Petr Baudis's message of
	"Fri, 24 Mar 2006 15:08:31 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17941>

Petr Baudis <pasky@suse.cz> writes:

>   It's never been so easy before - I've written cg-admin-rewritehist,
> which will execute your filters for each commit (which can rewrite the
> tree contents, just the tree itself through the index, committer/author
> information and commit message) while the script will obviously preserve
> all the other information like merges, author/committer information etc.

Hmph.  The above description sounds like you are not allowing
the user's custom script to drop existing parent (or graft a new
one) while rewriting.  I have not looked at how you are
interfacing with user's custom script, but I sort-of expected
you to throw a commit at it from older to newer (i.e. topo-order
in reverse), along with the names of already re-written commit
objects that are parents of taht commit, and have it build a
rewritten commit and report its object name back to you.

But it sounds like a useful tool in certain situations -- I
sounded mildly negative last night, but after you gave an
example of cleaning up a half-botched import, I changed my mind.
