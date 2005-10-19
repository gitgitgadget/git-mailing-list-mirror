From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem getting older version
Date: Wed, 19 Oct 2005 01:26:43 -0700
Message-ID: <7vach5ewu4.fsf@assigned-by-dhcp.cox.net>
References: <20051019080046.GI22986@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 10:27:54 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES9Hd-00008F-3a
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 10:26:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932443AbVJSI0q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 04:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932461AbVJSI0p
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 04:26:45 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:41432 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932443AbVJSI0p (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2005 04:26:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051019082631.GBNU4527.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 19 Oct 2005 04:26:31 -0400
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
In-Reply-To: <20051019080046.GI22986@schottelius.org>
	(nico-linux-git@schottelius.org's message of "Wed, 19 Oct 2005
	10:00:46 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10273>

Nico -telmich- Schottelius <nico-linux-git@schottelius.org> writes:

> The following situation:
>
> - The last commit was a merge, mhich broke some files
> - We want three files from the commit before

With only git-core tool, with the tip of the master branch,
would be:

    $ git pull somewhere ;# this caused the mismerge
    $ git checkout HEAD^ foo.c bar.c baz.c

This assumes that HEAD is a merge and HEAD^ (= HEAD^1) is the tip
of your branch before that merge (HEAD^2 would be what you
pulled from "somewhere").

The latest "git checkout", when given extra paths parameters,
does not switch branches.  Instead it pulls out named files from
the given version into your index, and checks them out. 

> Now I was told to do the following:

These 5 steps look correct; after that, you probably would want
to run git-update-index on those three paths.
