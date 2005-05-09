From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Darcs-git: a few notes for Git hackers
Date: Mon, 9 May 2005 23:28:42 +0200
Message-ID: <20050509212842.GC15712@pasky.ji.cz>
References: <7ihdhc5le2.fsf@lanthane.pps.jussieu.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>, darcs-devel@abridgegame.org
X-From: git-owner@vger.kernel.org Mon May 09 23:21:59 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVFgu-00087k-R0
	for gcvg-git@gmane.org; Mon, 09 May 2005 23:21:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261533AbVEIV2q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 May 2005 17:28:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261534AbVEIV2q
	(ORCPT <rfc822;git-outgoing>); Mon, 9 May 2005 17:28:46 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40586 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261533AbVEIV2o (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 May 2005 17:28:44 -0400
Received: (qmail 16755 invoked by uid 2001); 9 May 2005 21:28:42 -0000
To: Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr>
Content-Disposition: inline
In-Reply-To: <7ihdhc5le2.fsf@lanthane.pps.jussieu.fr>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Mon, May 09, 2005 at 08:01:25PM CEST, I got a letter
where Juliusz Chroboczek <Juliusz.Chroboczek@pps.jussieu.fr> told me that...
> 1. Darcs-git uses the fact that Git updates are atomic when reading
> from a Git repository.  Darcs-git almost writes to Git repositories
> atomically, with one exception: it performs a non-atomic
> read/update/write cycle on .git/HEAD.
> 
> For that reason, I'm taking a high-level lock on .git repositories
> whenever I write them.  The lockfile is ``.git/lock''.  I haven't
> thought about whether Darcs can be easily coerced into accessing Git
> repos atomically; have people writing Git wrappers found the need for
> a global lock?

FWIW, Cogito does not lock at all yet - this is one of the things which
should be fixed soon.

>  - there's no way to have multiple simultaneous caches, short of
>    hacking at the values of Git's global variables by hand.

See the Brad Robert's patches of Apr 21. I've decided not to apply them
since it appears a lot has changed since then and it would be some pain;
but they may be a worthy starting point for a more up-to-date patch.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
