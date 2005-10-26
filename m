From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] GIT paths
Date: Tue, 25 Oct 2005 23:12:52 -0700
Message-ID: <7vmzkwajrv.fsf@assigned-by-dhcp.cox.net>
References: <7vhdb7qown.fsf@assigned-by-dhcp.cox.net>
	<435E259D.3040701@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 26 08:14:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EUeX3-0003Eg-CW
	for gcvg-git@gmane.org; Wed, 26 Oct 2005 08:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932553AbVJZGMy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 26 Oct 2005 02:12:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932554AbVJZGMy
	(ORCPT <rfc822;git-outgoing>); Wed, 26 Oct 2005 02:12:54 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:59628 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932553AbVJZGMy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Oct 2005 02:12:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051026061237.FVQP1668.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 26 Oct 2005 02:12:37 -0400
To: Andreas Ericsson <ae@op5.se>
In-Reply-To: <435E259D.3040701@op5.se> (Andreas Ericsson's message of "Tue, 25
	Oct 2005 14:31:25 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10648>

Andreas Ericsson <ae@op5.se> writes:

> About the literally named /~junio directory, it would be possible with 
> this syntax;
>
> 	git fetch host.xz:/~junio
>
> The userdir is (with my previous patch) only expanded if the path starts 
> with a tilde.

I do not necessarily consider that a feature; see next item.

> It must remove the leading slash for this syntax:
>
> 	ssh://host.xz/~junio/repo
>
> Otherwise it would be passed as /~junio/repo to the remote end and no 
> ~user interpolation would be done.

Not necessarily.  Having the remote end interpret "/~user" and
"~user" the same way might make things more consistent; in other
words, "http://host/~user" is not spelled "http://host~user".

> I'd say make it invoke the programs with the canonicalized path. As you 
> say, git-daemon has to verify that it's a proper git repo and in the 
> whitelist anyway so I think it would be silly to add extra complexity to 
> upload-pack and receive-pack.

Yeah, I tend to agree here.

>>  - Give --server-root=/path/to/root flag to programs...
>
> If we stick with canonicalized paths I suppose this can be dropped.

Sounds good.
