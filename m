From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Try 2: Allow PERL_PATH="/usr/bin/env perl"
Date: Thu, 03 May 2007 17:43:35 -0700
Message-ID: <7vy7k5xvt4.fsf@assigned-by-dhcp.cox.net>
References: <463A6930.8090603@larsen.st>
	<7vfy6dzf25.fsf@assigned-by-dhcp.cox.net> <463A71D7.5060506@larsen.st>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Bryan Larsen <bryan@larsen.st>
X-From: git-owner@vger.kernel.org Fri May 04 02:43:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hjltn-0007MP-Pt
	for gcvg-git@gmane.org; Fri, 04 May 2007 02:43:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767553AbXEDAnp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 3 May 2007 20:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767555AbXEDAnp
	(ORCPT <rfc822;git-outgoing>); Thu, 3 May 2007 20:43:45 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:65396 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767553AbXEDAnh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 May 2007 20:43:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070504004336.EINM13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 3 May 2007 20:43:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id uojc1W0021kojtg0000000; Thu, 03 May 2007 20:43:36 -0400
In-Reply-To: <463A71D7.5060506@larsen.st> (Bryan Larsen's message of "Thu, 03
	May 2007 19:35:51 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46125>

Bryan Larsen <bryan@larsen.st> writes:

> Maybe PERL_PATH should be renamed PERL_SHEBANG or something.  Because
> if you pass in something that doesn't work on a shebang line (longer
> than 32 characters, say), it just won't work.

I think I see what problem you are trying to solve better now.
Probably more relevant example on MacOS would be whitespace in
the pathname.

I think using the bare $(PERL_PATH) in perl/Makefile is a
reasonable solution.

Are they any other issues on MacOS?  For example, gitweb.cgi is
built by replacing the shebang with $(PERL_PATH); I presume that
you already are successfully working around the whitespace in
the pathname with your "env perl" on MacOS?
