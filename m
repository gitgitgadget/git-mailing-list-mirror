From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Avoid C++ comments, use C comments instead
Date: Mon, 10 Jul 2006 00:46:28 -0700
Message-ID: <7vzmfhdhrf.fsf@assigned-by-dhcp.cox.net>
References: <20060710065751.22902.43316.stgit@dv.roinet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 09:46:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzqTR-0003xm-RH
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 09:46:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbWGJHqb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 03:46:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWGJHqa
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 03:46:30 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:24551 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750903AbWGJHqa (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 03:46:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060710074629.SZVA27857.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Jul 2006 03:46:29 -0400
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <20060710065751.22902.43316.stgit@dv.roinet.com> (Pavel Roskin's
	message of "Mon, 10 Jul 2006 02:57:51 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23600>

Pavel Roskin <proski@gnu.org> writes:

> From: Pavel Roskin <proski@gnu.org>
>
> This doesn't make the code uglier or harder to read, yet it makes the
> code more portable.  This also simplifies checking for other potential
> incompatibilities.  "gcc -std=c89 -pedantic" can flag many incompatible
> constructs as warnings, but C++ comments will cause it to emit an error.
>
> Signed-off-by: Pavel Roskin <proski@gnu.org>

The title should probably read "avoid C99 comments", but coming
from the previous century, I tend to agree with this.

The struct/array initializer stuff by Shawn makes them harder to
read (for structs, it moves initialization to actual code) and
more error prone (for arrays, now the initializers need to be
carefully kept ordered), but we do not have too many of them in
the code, so I do not think it is a not much of a practical
problem.  It is sad that some people stay behind and we need to
cater to them, though.
