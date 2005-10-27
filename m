From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Avoid using dc in git-count-objects
Date: Thu, 27 Oct 2005 11:00:37 -0700
Message-ID: <7vmzku3kmy.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0510260120260.28994@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vd5ltcf05.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0510261031400.7424@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051026083658.GE30889@pasky.or.cz>
	<pan.2005.10.27.08.49.59.849081@smurf.noris.de>
	<Pine.LNX.4.64.0510270801560.4664@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 27 20:03:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVC3O-0004yk-2z
	for gcvg-git@gmane.org; Thu, 27 Oct 2005 20:00:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751388AbVJ0SAj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 14:00:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbVJ0SAj
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 14:00:39 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:22484 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751388AbVJ0SAi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 14:00:38 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051027180015.QTDV4169.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 27 Oct 2005 14:00:15 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0510270801560.4664@g5.osdl.org> (Linus Torvalds's
	message of "Thu, 27 Oct 2005 08:12:19 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10721>

Linus Torvalds <torvalds@osdl.org> writes:

> Oh - there's another similarity between $(..) and $((..)). They're both 
> POSIX 1003.2 standard features, so any "modern" shell should support them. 
> Although in practice I don't know if that means anything else than ksh 
> (where both syntaxes came from, actually).

OK, you prodded me enough to come to 21st century ;-).

I was hoping that doing .git/objects/ traversal and disk block
accounting ourselves maybe in C or Perl would be enough for that
particular program, but I would not object if the community
concensus is we would run on only POSIX shells anymore.

I still resist saying that we run only on Bash, though.  I
suspect we already have some bashism on the periphery, but
eradicating them has been lower priority for me.
