From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: kernel.org now has gitweb installed
Date: Thu, 28 Apr 2005 22:47:46 +0100
Message-ID: <1114724866.2734.27.camel@localhost.localdomain>
References: <42703E79.8050808@zytor.com>
	 <1114673723.12012.324.camel@baythorne.infradead.org>
	 <20050428081005.GG8612@pasky.ji.cz>
	 <1114676955.12012.346.camel@baythorne.infradead.org>
	 <1114680199.12012.363.camel@baythorne.infradead.org>
	 <Pine.LNX.4.58.0504281149330.18901@ppc970.osdl.org>
	 <1114723214.2734.9.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0504281432490.18901@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Petr Baudis <pasky@ucw.cz>, "H. Peter Anvin" <hpa@zytor.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 28 23:44:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRGni-0006QC-J0
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 23:44:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262271AbVD1Vtd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Apr 2005 17:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262267AbVD1VtY
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Apr 2005 17:49:24 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:31114 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262266AbVD1VtS (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Apr 2005 17:49:18 -0400
Received: from baythorne.infradead.org ([81.187.226.107] helo=[192.168.129.125])
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DRGsi-0006Z0-Fm; Thu, 28 Apr 2005 22:49:12 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504281432490.18901@ppc970.osdl.org>
X-Mailer: Evolution 2.2.2 (2.2.2-1) 
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, 2005-04-28 at 14:40 -0700, Linus Torvalds wrote:
> Wrong. The date _does_ have meaning. It shows which of the parents was 
> more recent, which indirectly is a hint about which side had more activity 
> going on. 
> 
> In other words, it _is_ meanginful. Maybe it's a _statistical_ meaning 
> ("that side is probably the active one, because it has the last commit"), 
> but it's a meaning.

It's not entirely clear what 'active' is supposed to be useful for in
this instance. You could just as well count the commits between the
merge and the common ancestor, if you want to see which side was most
_active_ -- but that isn't helpful for deciding the order in which
'cg-log' should show commits.

What you really want there is 'local' vs. 'remote', because people want
to see the order in which changesets arrived in the _local_ repository
-- if the last thing you did was pull from me, people want all my
changesets to be at the top; regardless of who last committed to their
tree before the merge -- i.e. regardless of whether I did a last-minute
commit before you pulled, or whether you'd done another commit to your
tree immediately before pulling.

As you rightly point out, the local/remote information isn't really
available in an easy form -- certainly not from the ordering of the
parents in a merge commit. But let's not fool ourselves that we can
piece it together from the date either.

OK, the date _is_ meaningful in a way, but only in the same way that the
author's name and IRC address information is meaningful. Of course we
didn't include it for _nothing_, but it's outside the scope of git
itself; it isn't part of the useful information which git should care
about.

-- 
dwmw2

