From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to create and keep up to date a naked/bare repository?
Date: Thu, 26 Jan 2006 04:22:06 -0800
Message-ID: <7v64o7fac1.fsf@assigned-by-dhcp.cox.net>
References: <7v1wyvn9pc.fsf@assigned-by-dhcp.cox.net>
	<m37j8n9rat.fsf_-_@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 26 13:22:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F268p-0004hG-0d
	for gcvg-git@gmane.org; Thu, 26 Jan 2006 13:22:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbWAZMWK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jan 2006 07:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932302AbWAZMWJ
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jan 2006 07:22:09 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:19667 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932303AbWAZMWI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2006 07:22:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060126122048.NFTK6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 26 Jan 2006 07:20:48 -0500
To: Mathieu Chouquet-Stringer <ml2news@free.fr>
In-Reply-To: <m37j8n9rat.fsf_-_@localhost.localdomain> (Mathieu
	Chouquet-Stringer's message of "26 Jan 2006 12:12:10 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15163>

Mathieu Chouquet-Stringer <ml2news@free.fr> writes:

> I can do a: GIT_DIR=. git fetch and it works.

That is the right way of doing it.

> The second question is I'd think I would have to use git fetch instead of
> git pull as a pull is fetch + merge and merging wouldn't make much sense as
> I didn't check out any files. Does it make any sense?

Absolutely.  Bare repositories are either to be pushed into or
fetched into.

> The third thing (can't reproduce ATM as I just got a fresh new clone) is
> that git fetch was just fetching over and over the same objects...

It sounds like you are not telling fetch to update the refs you
track from outside.  Perhaps, this may help (untested):

	$ GIT_DIR=/pub/scm/git/git.git git fetch \
        	--update-head-ok $remote master:master
