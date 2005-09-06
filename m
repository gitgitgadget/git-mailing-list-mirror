From: Junio C Hamano <junkio@cox.net>
Subject: Re: Tool renames? was Re: First stab at glossary
Date: Tue, 06 Sep 2005 01:38:22 -0700
Message-ID: <7vwtlusi9t.fsf@assigned-by-dhcp.cox.net>
References: <200509050054.j850sC3D023778@laptop11.inf.utfsm.cl>
	<Pine.LNX.4.58.0509050738340.3504@evo.osdl.org>
	<46a038f90509051713389c62c8@mail.gmail.com>
	<Pine.LNX.4.58.0509060013520.4316@evo.osdl.org>
	<7vll2atz8a.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509060057491.4316@evo.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Langhoff <martin.langhoff@gmail.com>,
	Horst von Brand <vonbrand@inf.utfsm.cl>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Tim Ottinger <tottinge@progeny.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 06 10:40:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECYyL-0005ZP-IZ
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 10:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932447AbVIFIi1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 04:38:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbVIFIi1
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 04:38:27 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:57508 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932447AbVIFIi0 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2005 04:38:26 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050906083822.LPDI24420.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Sep 2005 04:38:22 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509060057491.4316@evo.osdl.org> (Linus Torvalds's
	message of "Tue, 6 Sep 2005 00:59:04 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8127>

Linus Torvalds <torvalds@osdl.org> writes:

> What's the upside?
>
> I can point to one downside: "git". That script right now is simple. If 
> you rewrite git-cvsimport-script from shell to perl, it looks the same to 
> git. 

What I've been working on was to:

 * have git-cvsimport.perl in the source

 * install it as $(bindir)/git-cvsimport

 * simplify 'git' (whose source is of course in 'git.sh') to
   only do: 

     cmd="$1"; shift; exec "git-$cmd" ${1+"$@"}

Naturally, the rewrite of git-cvsimport in shell or C would look
the same to git.

One potential downside (for people who consider this a downside)
is that you cannot easily run uninstalled, but you already
cannot run tools/git-applymbox and git-cherry-pick uninstalled
anyway, and I do not think it is such a big deal.
