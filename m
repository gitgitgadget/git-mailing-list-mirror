From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/2] gitview: Use new-style classes
Date: Sat, 02 Jun 2007 02:38:39 -0700
Message-ID: <7vsl9awva8.fsf@assigned-by-dhcp.cox.net>
References: <f623da83269ba030fabc64777cdb1071e5ab00bf.1180500418.git.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Ellerman <michael@ellerman.id.au>, <git@vger.kernel.org>
To: <aneesh.kumar@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jun 02 11:38:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuQ4P-0006e2-0D
	for gcvg-git@gmane.org; Sat, 02 Jun 2007 11:38:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751570AbXFBJil (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 2 Jun 2007 05:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752166AbXFBJil
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jun 2007 05:38:41 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:41354 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbXFBJik (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jun 2007 05:38:40 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070602093841.RUXV1540.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sat, 2 Jun 2007 05:38:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 6Zef1X0051kojtg0000000; Sat, 02 Jun 2007 05:38:39 -0400
In-Reply-To: <f623da83269ba030fabc64777cdb1071e5ab00bf.1180500418.git.michael@ellerman.id.au>
	(Michael Ellerman's message of "Wed, 30 May 2007 14:47:08 +1000
	(EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48918>

Michael Ellerman <michael@ellerman.id.au> writes:

> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Aneesh, this one is in your bailiwick.

Michael, it would have been nicer to have a real log message,
not just the Subject line, in your message.  The Subject line
says what the patch does in what subarea of the git.git tree,
which is very appropriate, but that can be seen from the diff
even if you did not say so.  The log message (before your
Signed-off-by line) is where you describe _why_ you would think
it is a good change.  "What" and "how" are usually evident in
well written code without much explanation, but "why" is often
more useful when reviewing the patch, and reading and studying
the history of the code.

I would have written something like:

	This changes the Commit class to use new-style class,
	which has been available since Python 2.2 (Dec 2001).
	This is a necessary step in order to use __slots__
	declaration so that we can reduce the memory footprint
	with my next patch.

I have no strong preference on this change myself.  "Classes
that derive from type" are relatively recent invention but I
would personally feel that Python 2.2 is ancient enough that
using it would not pose any practical portability issues, but
what would I know...

The __slots__ patch depends on this, and that one has a
measurable memory footprint improvement, so I would say we
should take it.
