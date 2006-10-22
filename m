From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: Add "next" link to commitdiff view
Date: Sun, 22 Oct 2006 16:16:22 -0700
Message-ID: <7vd58k0wmx.fsf@assigned-by-dhcp.cox.net>
References: <200610230037.57183.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 01:16:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbmYN-0003JT-CZ
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 01:16:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750785AbWJVXQY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 19:16:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750831AbWJVXQY
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 19:16:24 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:4591 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750785AbWJVXQX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Oct 2006 19:16:23 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061022231623.FJHV2704.fed1rmmtao03.cox.net@fed1rmimpo02.cox.net>;
          Sun, 22 Oct 2006 19:16:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id dbGS1V00G1kojtg0000000
	Sun, 22 Oct 2006 19:16:27 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200610230037.57183.jnareb@gmail.com> (Jakub Narebski's message
	of "Mon, 23 Oct 2006 00:37:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29805>

Jakub Narebski <jnareb@gmail.com> writes:

> Add a kind of "next" view in the bottom part of navigation bar for
> "commitdiff" view.
>
> For commitdiff between two commits:
>   (from: _commit_)
> For commitdiff for one single parent commit:
>   (parent: _commit_)
> For commitdiff for one merge commit
>   (merge: _commit_ _commit_ ...)
> For commitdiff for root (parentless) commit
>   (initial)
> where _link_ denotes hyperlink. SHA1 is shortened to 7 characters on
> display, everything is perhaps unnecessary esc_html on display.
>
> Signed-off-by: Jakub Narebski <jnareb@gmail.com>

Would it even be necessary to use any SHA-1 name in these cases,
I wonder.  Would it make the page less useful if we replace all
of the above _commit_ with a fixed string, say, "parent"?

I always hated gitweb diffs that prefix each filepair with their
full 40-byte SHA-1 blob object names.  It just adds noise to the
output without adding any meaningful information.
