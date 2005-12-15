From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] We do not like "HEAD" as a new branch name
Date: Thu, 15 Dec 2005 11:34:31 -0800
Message-ID: <7vacf2p320.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0512151244230.22400@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 15 20:39:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Emys9-0003xW-4u
	for gcvg-git@gmane.org; Thu, 15 Dec 2005 20:34:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750919AbVLOTed (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 14:34:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbVLOTed
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 14:34:33 -0500
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:63976 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1750919AbVLOTed (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 14:34:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051215193307.QRVO17838.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 15 Dec 2005 14:33:07 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13708>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> +		/* do not allow "HEAD" as ref name */
> +		if (ch == 'H' && (!strcmp(cp, "EAD") ||
> +					!strncmp(cp, "EAD/", 4)))

Why forbid HEAD in the middle, like "refs/heads/HEAD/frotz"?
Confusion avoidance?

We might want to forbid anything that matches /^.*_?HEAD$/ to catch
ORIG_HEAD for example, though.
