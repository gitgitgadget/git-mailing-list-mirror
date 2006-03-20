From: Junio C Hamano <junkio@cox.net>
Subject: Re: efficient cloning
Date: Mon, 20 Mar 2006 13:39:41 -0800
Message-ID: <7vk6aokd7m.fsf@assigned-by-dhcp.cox.net>
References: <m3r74ykue7.fsf@lugabout.cloos.reno.nv.us>
	<7vu09um3ae.fsf@assigned-by-dhcp.cox.net>
	<m3wteqj6qx.fsf@lugabout.cloos.reno.nv.us>
	<7vbqw1nakz.fsf@assigned-by-dhcp.cox.net>
	<7vu09tjy38.fsf@assigned-by-dhcp.cox.net>
	<20060320151833.GN18185@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 20 22:39:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLS6O-00023y-Tu
	for gcvg-git@gmane.org; Mon, 20 Mar 2006 22:39:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbWCTVjp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Mar 2006 16:39:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbWCTVjp
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Mar 2006 16:39:45 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:62632 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S964981AbWCTVjo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Mar 2006 16:39:44 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060320213542.ZNZD17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 20 Mar 2006 16:35:42 -0500
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060320151833.GN18185@pasky.or.cz> (Petr Baudis's message of
	"Mon, 20 Mar 2006 16:18:33 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17767>

Petr Baudis <pasky@suse.cz> writes:

> I think this sucks the way it is, because you still have only a single
> namespace for remotes (still quite a huge improvement to the current git
> situation), but you can have many upstreams.

Come on, give me a break.

You are commenting on the initial 'git-clone' and specifically
on one of its optional feature.  What multiple upstreams?

The whole point of what git-clone does on top of making a
straight clone of the remote is to give you a reasonable
starting point.  The traditional "master" -> "origin" mapping is
good for cloning a typical single-head repository.  If your
upsteram has more branches, --use-separate-remote would help you
to start your branch namespace uncluttered.

If you want to go fancier after the initial clone to
"cg-add-branch" more upstreams, you can implement a customized
editor, even a graphical one if you want, that inspects
$GIT_DIR/[branches,remotes} _and_ $GIT_DIR/{heads,remotes},
shows the current status, and lets you edit the contents of a
$GIT_DIR/remotes/foobar _while_ making matching changes to what
are under $GIT_DIR/{heads,remotes}.
