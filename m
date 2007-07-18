From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Proposal about --help options and man calls
Date: Wed, 18 Jul 2007 16:16:41 -0700
Message-ID: <7v644h715y.fsf@assigned-by-dhcp.cox.net>
References: <85y7hdwfds.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Thu Jul 19 01:17:00 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBIlN-0004h0-4r
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 01:16:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761739AbXGRXQo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 19:16:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760754AbXGRXQn
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 19:16:43 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:37909 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760389AbXGRXQn (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jul 2007 19:16:43 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070718231641.GMNB1393.fed1rmmtao106.cox.net@fed1rmimpo01.cox.net>;
          Wed, 18 Jul 2007 19:16:41 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RBGh1X00Z1kojtg0000000; Wed, 18 Jul 2007 19:16:42 -0400
In-Reply-To: <85y7hdwfds.fsf@lola.goethe.zz> (David Kastrup's message of "Wed,
	18 Jul 2007 23:50:23 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52907>

David Kastrup <dak@gnu.org> writes:

> Frequently, git somecommand --help will call the man command to
> display help pages.  I think that when it does so, it should pass the
> value of the GIT_PAGER variable copied into the PAGER variable: the
> paging happens on behalf of git here.

Hmph.  Is that to help people who uses GIT_PAGER but no PAGER,
or have both but set it differently (setting both and in the
same way does not make much sense).  But what it means is that
"git command --help" and "man git-command" would be paged
differently.  I highly doubt it is really desirable.

What's the reason to set GIT_PAGER and PAGER differently to
begin with?  Can people give examples of the reason why?

By the way, I would understand if there is a request to honor
GIT_LESS environment and if it exists export its value instead
of FRSX as LESS when we spawn the pager.  As some people do not
want S nor R for other programs but do want them for colored git
output that tends to consist of long lines.  This is a slightly
related topic, but different from the issue you raised in your
message.
