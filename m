From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add --diff-filter= documentation paragraph
Date: Thu, 09 Feb 2006 11:53:45 -0800
Message-ID: <7vr76c9uly.fsf@assigned-by-dhcp.cox.net>
References: <E1F7DSt-0001q8-PV@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 09 20:54:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7HrX-0003qX-Ro
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 20:53:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750749AbWBITxw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 14:53:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWBITxw
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 14:53:52 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:54724 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750745AbWBITxw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 14:53:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060209195358.CJTP25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 14:53:58 -0500
To: Jon Loeliger <jdl@jdl.com>
In-Reply-To: <E1F7DSt-0001q8-PV@jdl.com> (Jon Loeliger's message of "Thu, 09
	Feb 2006 09:12:11 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15820>

Jon Loeliger <jdl@jdl.com> writes:

> Signed-off-by: Jon Loeliger <jdl@jdl.com>
>
> ----
>
> So, I don't know what the "*" selection flag does.
> It is called "AON" in the source.  Anyone?

That's All-or-None.

After applying the other filters if there is anything left, then
spit out everything (including the ones that did not pass the
other filters).  Otherwise do not output anything.

In other words,

	-M --pretty --diff-filter='R'

shows log for a commit that contains a rename, and diff for only
renamed paths.  On the other hand,

	-M --pretty --diff-filter='R*'

shows the same log and diff for all paths the commit touches,
not just the renamed ones.
