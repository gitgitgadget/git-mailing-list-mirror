From: Junio C Hamano <junkio@cox.net>
Subject: Re: file name case-sensitivity issues
Date: Tue, 23 May 2006 18:40:50 -0700
Message-ID: <7vd5e4xkrh.fsf@assigned-by-dhcp.cox.net>
References: <20060523210615.GB5869@steel.home>
	<Pine.LNX.4.64.0605232239070.15915@dildano.hawaga.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 24 03:41:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiiMt-0007nu-Tj
	for gcvg-git@gmane.org; Wed, 24 May 2006 03:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932171AbWEXBk4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 21:40:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932175AbWEXBk4
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 21:40:56 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:30604 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932171AbWEXBk4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 May 2006 21:40:56 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060524014056.MNUG27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 23 May 2006 21:40:56 -0400
To: Ben Clifford <benc@hawaga.org.uk>
In-Reply-To: <Pine.LNX.4.64.0605232239070.15915@dildano.hawaga.org.uk> (Ben
	Clifford's message of "Tue, 23 May 2006 22:43:15 +0000 (GMT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20655>

Ben Clifford <benc@hawaga.org.uk> writes:

> $ ls
> bar
> $ git ls-files -d
> FOO
> $ git ls-tree HEAD
> 100644 blob b7d6715e2df11b9c32b2341423273c6b3ad9ae8a    FOO
> 100644 blob 5f8b81e197a2cb27816112fb5a6b86b7031ffde8    bar
>
> The checkout is losing the FOO file but the merged tree object has the 
> merged FOO in it.

That's interesting.  I wonder how...  Does this sequence remove FOO
on that filesystem?

	$ date >FOO
        $ rm -f foo
        $ ls

Also if you do the final "git pull" using resolve strategy, does
it change the result (say "git pull -s resolve . side" instead)?
