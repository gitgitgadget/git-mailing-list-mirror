From: Junio C Hamano <junkio@cox.net>
Subject: Re: several quick questions
Date: Tue, 14 Feb 2006 11:13:44 -0800
Message-ID: <7vy80drbx3.fsf@assigned-by-dhcp.cox.net>
References: <43F20532.5000609@iaglans.de>
	<Pine.LNX.4.64.0602140845080.3691@g5.osdl.org>
	<87k6bxvmj6.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 20:13:57 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F95cU-0006RM-Bz
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 20:13:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422666AbWBNTNr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 14:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422667AbWBNTNr
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 14:13:47 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:44444 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1422666AbWBNTNq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 14:13:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060214191239.NLBJ3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 14 Feb 2006 14:12:39 -0500
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87k6bxvmj6.wl%cworth@cworth.org> (Carl Worth's message of "Tue,
	14 Feb 2006 10:10:53 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16159>

Carl Worth <cworth@cworth.org> writes:

> 2) Ensure that bogus-branch exists somewhere (don't care where), then
>    move it:
>
> 	# Create the branch (if it doesn't exist)
> 	git checkout -b bogus-branch >& /dev/null
> 	# Switch to it (which doesn't happen above if it already existed)
> 	git checkout bogus-branch
> 	# Move the branch to the revision of interest
> 	git reset --hard <revision>

For moving around in history (like cg-seek if I understand
correctly), the above is the right and probably most efficient
way to do with the core-git tools.

	# setup
	$ git branch -f temp ;# make sure it exists
        $ git checkout temp ;# and switch to it
	# repeatedly...
        $ git reset --hard <revision1>
        # do interesting things
        $ git reset --hard <revision2>
        # do interesting things
        $ git reset --hard <revision3>
        # ...
        $ git reset --hard <revisionn>
        # do interesting things
        # once you are done
        $ git checkout master
        $ git branch -D temp
