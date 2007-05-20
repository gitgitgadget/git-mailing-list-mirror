From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Tech 'git-apply' that spaces before a tab are candidate for stripping
Date: Sun, 20 May 2007 00:53:11 -0700
Message-ID: <7v8xbkrkwo.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550705190944y44cb57baiccb139b1d649face@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Git Mailing List" <git@vger.kernel.org>
To: "Marco Costalba" <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 20 09:53:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpgEE-00030J-1v
	for gcvg-git@gmane.org; Sun, 20 May 2007 09:53:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756822AbXETHxN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 03:53:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757170AbXETHxN
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 03:53:13 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:47994 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756822AbXETHxM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 03:53:12 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070520075313.DPUS6556.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Sun, 20 May 2007 03:53:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1KtB1X0031kojtg0000000; Sun, 20 May 2007 03:53:11 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47796>

"Marco Costalba" <mcostalba@gmail.com> writes:

> Currently 'git-apply' identify as stealth space a line starting with
> spaces followed by a tab.
>
> This patch updates the algorithm to find spaces + tab also in the
> middle of a line and not only at the beginning.
>
> As example lines like
>
> "#define MY_VALUE   \t 1"
>
> are now identified and cleaned up if option '--whitespace=strip' is
> used.

I specifically did not want to do the above, as it would also
munge something like this:

	const char string[] = "abc <HT> de";
