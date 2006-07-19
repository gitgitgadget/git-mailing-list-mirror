From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] tar-tree: add the "tar.applyUmask" config option
Date: Wed, 19 Jul 2006 15:33:48 -0700
Message-ID: <7vd5c1jkc3.fsf@assigned-by-dhcp.cox.net>
References: <20060719214025.GA10997@1wt.eu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 20 00:34:05 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G3KcC-0003ub-A4
	for gcvg-git@gmane.org; Thu, 20 Jul 2006 00:34:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932548AbWGSWdu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Jul 2006 18:33:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932553AbWGSWdu
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Jul 2006 18:33:50 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:49630 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932548AbWGSWdt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Jul 2006 18:33:49 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060719223348.ZVIW2704.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Jul 2006 18:33:48 -0400
To: Willy Tarreau <w@1wt.eu>
In-Reply-To: <20060719214025.GA10997@1wt.eu> (Willy Tarreau's message of "Wed,
	19 Jul 2006 23:40:25 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24009>

Willy Tarreau <w@1wt.eu> writes:

> While I agreed with Linus that the very permissive file modes set in tar
> archives were not particularly a problem for kernel users, I'm finding
> that for some other projects it sometimes becomes really annoying, to
> the point that I finally considered using a plain tar instead. This is a
> shame because tar-tree is really fast an powerful, and I like its ability
> to enforce permissions when those of the local dir might be wrong for
> various reasons.

I do not have problem with an option to allow a non-default
behaviour in this area.  Maybe we might want to be able to set
the mask in the configuration file as well, perhaps like...

	tar.umask = user ;# use from the current process'
        tar.umask = 0    ;# same as default
        tar.umask = 002  ;# group friendly
