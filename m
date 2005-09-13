From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 00/22] cache cursors: an introduction
Date: Mon, 12 Sep 2005 17:14:24 -0700
Message-ID: <7vd5nd6cyn.fsf@assigned-by-dhcp.cox.net>
References: <20050912145543.28120.7086.stgit@dexter.citi.umich.edu>
	<7vaciiawrm.fsf@assigned-by-dhcp.cox.net>
	<43261675.10905@citi.umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 13 02:15:53 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEyRe-0003xs-8Z
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 02:14:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbVIMAO3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 20:14:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932383AbVIMAO2
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 20:14:28 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:41912 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932382AbVIMAO0 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2005 20:14:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050913001424.LLZP8185.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Sep 2005 20:14:24 -0400
To: cel@citi.umich.edu
In-Reply-To: <43261675.10905@citi.umich.edu> (Chuck Lever's message of "Mon,
	12 Sep 2005 19:59:49 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8457>

Chuck Lever <cel@citi.umich.edu> writes:

> btw, with daniel's changes i don't see where we're using 
> active_cache_changed any more.

That came from an earlier botched attempt of mine to optimize
out writing of cache (eh, index file these days it is called but
back then it was "cache") when read-tree ended up not modifying
the cache contents (e.g. reading HEAD immediately after checking
it out).  My implementation was quite buggy and Linus fixed it
in the ee267527aa80807f37caf1d00bcf1b5263945adb commit by adding
the variable while disabling the optimization for safety.  And
the optimization has not been re-enabled ever since.  I think
you can remove the variable now.
