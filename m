From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: bugfix: list regression
Date: Tue, 22 Aug 2006 02:19:29 -0700
Message-ID: <7vbqqdnn4u.fsf@assigned-by-dhcp.cox.net>
References: <20060822085540.1104.qmail@web31812.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 22 11:19:45 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFSQ2-0001sQ-Pr
	for gcvg-git@gmane.org; Tue, 22 Aug 2006 11:19:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750803AbWHVJTc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Aug 2006 05:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWHVJTc
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Aug 2006 05:19:32 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:23763 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1750803AbWHVJTa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Aug 2006 05:19:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060822091930.BMIP21457.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 22 Aug 2006 05:19:30 -0400
To: Luben Tuikov <ltuikov@yahoo.com>
In-Reply-To: <20060822085540.1104.qmail@web31812.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Tue, 22 Aug 2006 01:55:40 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25845>

Luben Tuikov <ltuikov@yahoo.com> writes:

> Fix regression introduced by
> commit 17d07443188909ef5f8b8c24043cb6d9fef51bca.
>
> 1. Commit 17d07443188909ef5f8b8c24043cb6d9fef51bca defines
> "a.list" twice in gitweb.css, once with bold and once with
> normal font-weight.

The normal one is limited to a.list that is inside table.tags
isn't it?  I had an impression that this was done on purpose.

> 2. "a.list" being "bold", makes a myriad of things shown by
> gitweb in bold font-weight, which is a regression from
> pre-17d07443188909ef5f8b8c24043cb6d9fef51bca behavior.

The only difference I see offhand is that Jakub's version shows
the tag text in normal weight in summary pane (tags section),
while yours show it in bold.  Also clickable object names in
many views are shown in bold in Jakub's version while yours do
not distinguish them from unclickable ones.

I tend to agree that bold looks too loud in tree view, but
showing tree and parent diffently from commit itself in commit
view may be a good thing.  I am not sure bold is a good choice,
though.  Usually people underline clickable links not type in
bold.

I do not case either way myself that much.  Could you battle
this out with the guilty party?
