From: Junio C Hamano <junkio@cox.net>
Subject: Re: git bisect enhancements?
Date: Wed, 30 Nov 2005 14:23:05 -0800
Message-ID: <7vmzjlojw6.fsf@assigned-by-dhcp.cox.net>
References: <7vu0dtokqp.fsf@assigned-by-dhcp.cox.net>
	<1133388429.30767.37.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 23:26:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhaM3-0004Ou-Tr
	for gcvg-git@gmane.org; Wed, 30 Nov 2005 23:23:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751023AbVK3WXI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 30 Nov 2005 17:23:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbVK3WXI
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Nov 2005 17:23:08 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:6584 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751023AbVK3WXG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2005 17:23:06 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051130222136.HUHP17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 30 Nov 2005 17:21:36 -0500
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <1133388429.30767.37.camel@cashmere.sps.mot.com> (Jon Loeliger's
	message of "Wed, 30 Nov 2005 16:07:09 -0600")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13023>

Jon Loeliger <jdl@freescale.com> writes:

> Sure.  But I'm proposing to alter the new bisection
> middle point.  I don't know its status yet.  I am
> just angling on hedging my bets of a "good midpoint"
> choice by finding something that is likely to be
> more stable than the proposed midpoint.

You could "git reset --hard <that-commit-N-up-or-down>",
compile, test and say "git bisect good" or "git bisect bad".

Even "N commits before" is not so easy.  "git reset --hard
bisect~2" would be 2 commits before what git-bisect suggested as
long as that chain in question is a single strand of pearls.  "N
commits after" is a bit harder, especially when a merge is
involved.  But you are right.  Bisect should be able to do what
you can visually do with gitk.
