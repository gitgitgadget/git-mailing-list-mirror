From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Census] So who uses git?
Date: Tue, 31 Jan 2006 18:31:58 -0800
Message-ID: <7v64nzollt.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	<Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	<46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	<1138446030.9919.112.camel@evo.keithp.com>
	<7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
	<1138529385.9919.185.camel@evo.keithp.com>
	<43DCA495.9040301@gorzow.mm.pl> <20060130225107.GA3857@limbo.home>
	<Pine.LNX.4.64.0601311314030.7301@g5.osdl.org>
	<20060131220148.GA19411@steel.home> <20060201013901.GA16832@mail.com>
	<Pine.LNX.4.64.0601311747360.7301@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 03:32:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F47nS-0008WP-TE
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 03:32:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWBACcB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 21:32:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964895AbWBACcB
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 21:32:01 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:62974 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S964891AbWBACcA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 21:32:00 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060201023101.GQJI3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 31 Jan 2006 21:31:01 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601311747360.7301@g5.osdl.org> (Linus Torvalds's
	message of "Tue, 31 Jan 2006 18:04:31 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15379>

Linus Torvalds <torvalds@osdl.org> writes:

> They're fast, because they are purely in the cache (well, git-update-index 
> obviously isn't, but the new op wouldn't be any _slower_ than the old 
> one).
>
> Looks simple enough. The big thing to remember is to clear that 
> "implicitly up-to-date" flag whenever we make changes (ie we'd probably 
> make "add_cache_entry()" always clear it, possibly with a flag to add it 
> as "pre-verified" which would set it).
>
> Comments? Junio, what do you think?

Somehow this reminds me of a "feature" we added quite a long
time ago to support "update-index without working tree".

I think this should work fine as a mechanism, but I am a bit
worried about the convenience and safety aspect.  It _might_
make sense to do what RCS does; check out read-only copy by
default and set the "assume unchanged" flag, to prevent people
from accidentally modifying the working tree copy without
telling the index about it.
