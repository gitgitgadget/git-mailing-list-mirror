From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] update hook: redirect _both_ diagnostic lines to stderr upon tag failure
Date: Thu, 28 Dec 2006 14:14:51 -0800
Message-ID: <7v8xgrvfac.fsf@assigned-by-dhcp.cox.net>
References: <87tzzg6oyp.fsf@rho.meyering.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 28 23:14:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1H03Wa-0006W5-V4
	for gcvg-git@gmane.org; Thu, 28 Dec 2006 23:14:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965009AbWL1WOy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Dec 2006 17:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965011AbWL1WOy
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Dec 2006 17:14:54 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:57646 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965009AbWL1WOx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Dec 2006 17:14:53 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061228221452.QOEL9173.fed1rmmtao01.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Dec 2006 17:14:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 4NF61W0041kojtg0000000; Thu, 28 Dec 2006 17:15:06 -0500
To: Jim Meyering <jim@meyering.net>
In-Reply-To: <87tzzg6oyp.fsf@rho.meyering.net> (Jim Meyering's message of
	"Thu, 28 Dec 2006 16:05:02 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35563>

Jim Meyering <jim@meyering.net> writes:

> Otherwise, sending the diagnostic to stdout would provoke a protocol failure.

Very true; thanks for the patch.

However, I suspect that we'd want to prevent this by redirecting
on the caller side, so that the hook writers do not have to
worry about the issue.  I haven't looked at the code that runs
the hook for some time but we should be able to do that...
