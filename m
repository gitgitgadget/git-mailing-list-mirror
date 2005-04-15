From: David Woodhouse <dwmw2@infradead.org>
Subject: Re: Merge with git-pasky II.
Date: Fri, 15 Apr 2005 17:01:21 +0100
Message-ID: <1113580881.27227.73.camel@hades.cambridge.redhat.com>
References: <20050414002902.GU25711@pasky.ji.cz>
	 <20050413212546.GA17236@64m.dyndns.org>
	 <20050414004504.GW25711@pasky.ji.cz>
	 <Pine.LNX.4.58.0504132020550.7211@ppc970.osdl.org>
	 <7vfyxtsurd.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0504140051550.7211@ppc970.osdl.org>
	 <7v64ypsqev.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0504140201130.7211@ppc970.osdl.org>
	 <7vvf6pr4oq.fsf@assigned-by-dhcp.cox.net>
	 <20050414121624.GZ25711@pasky.ji.cz>
	 <7vll7lqlbg.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0504141133260.7211@ppc970.osdl.org>
	 <7v7jj5qgdz.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.58.0504141728590.7211@ppc970.osdl.org>
	 <1113559330.12012.292.camel@baythorne.infradead.org>
	 <Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, Petr Baudis <pasky@ucw.cz>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Apr 15 17:59:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMTCr-00017J-2y
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 17:58:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbVDOQBg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 12:01:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261843AbVDOQBe
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 12:01:34 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:63390 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261838AbVDOQB1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 12:01:27 -0400
Received: from nat-pool-stn.redhat.com ([62.200.124.98] helo=hades.cambridge.redhat.com)
	by pentafluge.infradead.org with esmtpsa (Exim 4.43 #1 (Red Hat Linux))
	id 1DMTFy-00073n-K6; Fri, 15 Apr 2005 17:01:23 +0100
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org>
X-Mailer: Evolution 2.0.4 (2.0.4-1.dwmw2.1) 
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 2005-04-15 at 08:32 -0700, Linus Torvalds wrote:
>  - you're doing the work at the wrong point. Doing it _well_ is quite 
>    expensive. So if you do it at commit time, you cannot _afford_ to do it 
>    well, and you'll always fall back to doing an ass-backwards job that 
>    doesn't really get you to the good state, and only gets you to a 
>    not-very-interesting easy 1% of the solution (ie full file renames).
> 
>  - you're doing the work at the wrong point for _another_ reason. You're 
>    freezing your (crappy) algorithm at tree creation time, and basically 
>    making it pointless to ever create something better later, because even 
>    if hardware and software improves, you've codified that "we have to
>    have crappy information".

OK, I'm inclined to agree. The only thing that prevents me from
capitulating entirely and resubscribing to the "Torvalds is always
right" school is the concern that it _is_ expensive, and that's why I
originally wanted to do it at commit time because then it's a one-off
cost rather than recurring every time we want to track the history of a
given piece of content. Also because we actually have the developer's
attention at commit time, and we can get _real_ answers from the user
about what she was doing, instead of having to guess.

But if it can be done cheaply enough at a later date even though we end
up repeating ourselves, and if it can be done _well_ enough that we
shouldn't have just asked the user in the first place, then yes, OK I
agree.

-- 
dwmw2

