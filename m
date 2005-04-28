From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: kernel.org now has gitweb installed
Date: Thu, 28 Apr 2005 22:20:14 +0100
Message-ID: <1114723214.2734.9.camel@localhost.localdomain>
References: <42703E79.8050808@zytor.com>
	 <1114673723.12012.324.camel@baythorne.infradead.org>
	 <20050428081005.GG8612@pasky.ji.cz>
	 <1114676955.12012.346.camel@baythorne.infradead.org>
	 <1114680199.12012.363.camel@baythorne.infradead.org>
	 <Pine.LNX.4.58.0504281149330.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 23:17:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRGMr-0003MU-N0
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 23:16:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262172AbVD1VVs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 17:21:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262175AbVD1VVs
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 17:21:48 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:54921 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262172AbVD1VVp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 17:21:45 -0400
Received: from baythorne.infradead.org ([81.187.226.107] helo=[192.168.129.125])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DRGS4-0006QQ-DL; Thu, 28 Apr 2005 22:21:40 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504281149330.18901@ppc970.osdl.org>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-04-28 at 11:55 -0700, Linus Torvalds wrote:
> Anyway, the reason remote and local don't matter is that if somebody else
> merges with me, and I just pull the result without having any changes in 
> my tree, we just "fast-forward" to that other side, because otherwise you 
> can never "converge" on anything (people merging each others trees would 
> always create a new commit, for no good reason).
> 
> What does that mean? It means that my local tree now became the _remote_ 
> parent, even though it was always local to my tree.

Hmm, that's true; albeit unfortunate. 

Still, using the date isn't any better. It'll give results which are
about as random as just sorting by the sha1 of each parent.

Yes, the ordering of the parents in a merge is probably meaningless in
the general case, but so is the date.

The best we could probably do, from a theoretical standpoint, is to look
at the paths via each parent to a common ancestor, and look at how many
of the commits on each path were done by the same committer. Even that
isn't ideal, and it's probably fairly expensive -- but it's pointless to
pretend we can infer anything from _either_ the dates or the ordering of
the parents in a merge.

-- 
dwmw2

