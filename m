From: Junio C Hamano <junkio@cox.net>
Subject: Re: git refuses to switch to older branches
Date: Sat, 19 Aug 2006 18:34:22 -0700
Message-ID: <7vy7tkyyu9.fsf@assigned-by-dhcp.cox.net>
References: <20060819202558.GE30022@admingilde.org>
	<ec80sl$i25$2@sea.gmane.org> <7v3bbs1h8c.fsf@assigned-by-dhcp.cox.net>
	<ec84gg$p2l$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 20 03:34:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GEcCt-0003ya-Gw
	for gcvg-git@gmane.org; Sun, 20 Aug 2006 03:34:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751632AbWHTBeY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Aug 2006 21:34:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751633AbWHTBeY
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Aug 2006 21:34:24 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:3275 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751632AbWHTBeY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Aug 2006 21:34:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060820013423.MTEC18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 19 Aug 2006 21:34:23 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ec84gg$p2l$1@sea.gmane.org> (Jakub Narebski's message of "Sun,
	20 Aug 2006 00:48:56 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25744>

Jakub Narebski <jnareb@gmail.com> writes:

> ... I'm not sure if this is feature or bug that git-checkout
> with file specified (path limit specified?) doesn't need -f

This is definitely a feature we deliberately added long after
git-checkout was initially written, in reponse to specific
requests from users.  Back then the only way to revert to index
or HEAD was to "checkout-index -f -q -u -a" or "reset --hard"
and it was cumbersome to revert only a single path.

I have been wondering if we wanted to be able to say:

	git checkout HEAD gitweb/

to revert everything under named hierarchy, but we haven't heard
user requests for this.  This is way more dangerous than my
liking so personally I am happy that we do not have it.
