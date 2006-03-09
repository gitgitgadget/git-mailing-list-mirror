From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-ls-files --unmerged implies --stages: ?
Date: Thu, 09 Mar 2006 10:50:46 -0800
Message-ID: <7vslpr4fll.fsf@assigned-by-dhcp.cox.net>
References: <pan.2006.03.09.15.19.03.286472@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 09 19:51:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FHQDs-0002hR-7O
	for gcvg-git@gmane.org; Thu, 09 Mar 2006 19:50:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751327AbWCISut (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Mar 2006 13:50:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751328AbWCISut
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Mar 2006 13:50:49 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:663 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751327AbWCISut (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Mar 2006 13:50:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060309184651.BWZR20050.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Mar 2006 13:46:51 -0500
To: Matthias Urlichs <smurf@smurf.noris.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17434>

Matthias Urlichs <smurf@smurf.noris.de> writes:

> I wonder why git-ls-files --unmerged implies --stages. One nice use case
> for this command is to edit all the conflicting files after a failed
> merge, i.e.
>
> $ vi $(git-ls-files --unmerged)
>
> except I need a pipe to throw out all the cruft in there.

I typically use git diff --name-only for this (yes I probably
need to uniq them out), but you can certainly talk me into
introducing --unmerged --name-only.  If nobody objects, even
making --unmerged independent from --stages might be a sensible
thing to do -- if we do so you would need --unmerged --stages to
get the current behaviour.
