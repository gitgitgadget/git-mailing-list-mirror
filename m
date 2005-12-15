From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] We do not like "HEAD" as a new branch name
Date: Thu, 15 Dec 2005 15:38:19 -0800
Message-ID: <7v4q5alyms.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0512151244230.22400@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vacf2p320.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0512152339530.4962@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 16 00:38:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1En2g5-0006S5-6k
	for gcvg-git@gmane.org; Fri, 16 Dec 2005 00:38:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751208AbVLOXiW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 15 Dec 2005 18:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbVLOXiW
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Dec 2005 18:38:22 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:18129 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751208AbVLOXiV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Dec 2005 18:38:21 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051215233743.SLFL3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 15 Dec 2005 18:37:43 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13718>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Okay, I think this is what *I* would want to be illegal:
>
> HEAD,
> ORIG_HEAD,
> FETCH_HEAD
> MERGE_HEAD
>
> Others? Or should I really test for just *anything* ending in _HEAD 
> besides HEAD itself?

Just to futureproof ourselves, how about this?

	/^(?:.*/)?(?:[A-Z0-9]+_)?HEAD$/

The last path component being "HEAD" or capital-or-digit
followed by underscore followed by "HEAD".
