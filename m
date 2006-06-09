From: Junio C Hamano <junkio@cox.net>
Subject: Re: Git-daemon messing up permissions for gitweb
Date: Fri, 09 Jun 2006 14:06:22 -0700
Message-ID: <7virnam435.fsf@assigned-by-dhcp.cox.net>
References: <5A14AF34CFF8AD44A44891F7C9FF410507957896@usahm236.amer.corp.eds.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Linus Torvalds" <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 09 23:06:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FooBX-0001YH-Fg
	for gcvg-git@gmane.org; Fri, 09 Jun 2006 23:06:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030328AbWFIVGY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Jun 2006 17:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965300AbWFIVGY
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jun 2006 17:06:24 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:30178 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S965296AbWFIVGY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jun 2006 17:06:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060609210623.OEXG554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 9 Jun 2006 17:06:23 -0400
To: "Post, Mark K" <mark.post@eds.com>
In-Reply-To: <5A14AF34CFF8AD44A44891F7C9FF410507957896@usahm236.amer.corp.eds.com>
	(Mark K. Post's message of "Fri, 9 Jun 2006 16:52:22 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21561>

"Post, Mark K" <mark.post@eds.com> writes:

> Since umask isn't an environment variable, per se, I'm not sure how this
> will change anything.

I do not configure my sshd, so you may need a bit more reading
on it yourself; $HOME/.ssh/environment does not seem to be it,
as you said.

> One other thing I noticed is that init-db.c spells core.sharedRepository
> with a capital R, but setup.c spells it "core.sharedrepository" with no
> upper case letters.  Would this make any difference to anything I'm
> seeing? 

The distinction should not matter since the code downcases
(git_config_set_multivar() in config.c) it, but to avoid future
confusion we might want to downcase the one in init-db.c
