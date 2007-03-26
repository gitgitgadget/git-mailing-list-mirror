From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-rm: don't remove newly added file without -f
Date: Mon, 26 Mar 2007 14:11:42 -0700
Message-ID: <7v1wjbwvzl.fsf@assigned-by-dhcp.cox.net>
References: <8aa486160703260759v438d445ev82161600d8e8bf02@mail.gmail.com>
	<20070326185539.GA1650@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Santi =?utf-8?Q?B=C3=A9jar?= <sbejar@gmail.com>,
	git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 26 23:11:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVwTk-0000hp-2p
	for gcvg-git@gmane.org; Mon, 26 Mar 2007 23:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750898AbXCZVLo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Mar 2007 17:11:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753231AbXCZVLo
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Mar 2007 17:11:44 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:45019 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750898AbXCZVLn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Mar 2007 17:11:43 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070326211143.LNMA28911.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Mon, 26 Mar 2007 17:11:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id fZBi1W0081kojtg0000000; Mon, 26 Mar 2007 17:11:43 -0400
In-Reply-To: <20070326185539.GA1650@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 26 Mar 2007 14:55:39 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43188>

Jeff King <peff@peff.net> writes:

> Given this set of commands:
>
>   $ echo "newly added file" >new
>   $ git add new
>   $ git rm new
>
> the file "new" was previously removed from the working
> directory and the index. Because it was not in HEAD, it is
> available only by searching for unreachable objects.

I am not sure if this is a problem, as the user asked it to be
removed.  It somehow feels to me that the change (I am not
convinced your patch should be called a "fix" rather than a
"behaviour change") would cause more confusion.

Unstaging request would have looked like "git reset HEAD new",
wouldn't it?
