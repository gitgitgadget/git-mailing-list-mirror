From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] mergetool: Replace use of "echo -n" with printf(3) to be more portable
Date: Thu, 29 Mar 2007 15:02:42 -0700
Message-ID: <7vwt0z1zel.fsf@assigned-by-dhcp.cox.net>
References: <11751830653554-git-send-email-tytso@mit.edu>
	<11751830651770-git-send-email-tytso@mit.edu>
	<20070329155741.GA18413@moooo.ath.cx>
	<20070329170914.GA9435@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Mar 30 00:03:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX2i2-0002Ne-Am
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 00:03:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422652AbXC2WCp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 18:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422663AbXC2WCp
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 18:02:45 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:51588 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422652AbXC2WCo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 18:02:44 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070329220244.BKFP373.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Thu, 29 Mar 2007 18:02:44 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id gm2j1W0071kojtg0000000; Thu, 29 Mar 2007 18:02:43 -0400
In-Reply-To: <20070329170914.GA9435@thunk.org> (Theodore Tso's message of
	"Thu, 29 Mar 2007 13:09:14 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43481>

Theodore Tso <tytso@mit.edu> writes:

> Junio, I've prepared an alterate patch series.  If you haven't pulled
> from repo.or.cz, I'd appreciate it if you could pull from the
> mergetool branch (instead of master) instead:
>
> 	http://repo.or.cz/w/git/mergetool.git

Thanks; will do later tonight after I got home.

> (Apparently there's no way to forcibly reset the pointer of the master
> head on repo.or.cz, probably for security/sanity reasons, without
> going through an administrator.)

Really?  I push with '+' (aka "single force") all the time to
alt-git.git repository and haven't noticed that:

    [remote "repo"]
            url = repo.or.cz:srv/git/alt-git.git/
            push = refs/tags/ko-master:refs/heads/master
            push = refs/tags/ko-next:refs/heads/next
            push = +refs/tags/ko-pu:refs/heads/pu
            push = refs/tags/ko-maint:refs/heads/maint

Here, tags/ko-* keeps track of what I pushed out the official
k.org repositories, and my workflow has been:

    $ git push ko ;# push to k.org refs/heads/{master,next,...}
    $ git fetch ko ;# fetch them back to refs/tags/ko-*
    $ git push repo ;# update alt-git.git
