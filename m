From: Junio C Hamano <junkio@cox.net>
Subject: Re: Unresolved issues #2
Date: Thu, 04 May 2006 02:14:47 -0700
Message-ID: <7vwtd240e0.fsf@assigned-by-dhcp.cox.net>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
	<7v4q065hq0.fsf@assigned-by-dhcp.cox.net> <e3ce4j$chl$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 04 11:14:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FbZv9-0000wg-MG
	for gcvg-git@gmane.org; Thu, 04 May 2006 11:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWEDJOt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 4 May 2006 05:14:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751454AbWEDJOt
	(ORCPT <rfc822;git-outgoing>); Thu, 4 May 2006 05:14:49 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:47068 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751451AbWEDJOs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 May 2006 05:14:48 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060504091448.BREZ9215.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 4 May 2006 05:14:48 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e3ce4j$chl$1@sea.gmane.org> (Jakub Narebski's message of "Thu,
	04 May 2006 10:32:22 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19560>

Jakub Narebski <jnareb@gmail.com> writes:

>>   I am beginning to think using "graft" to cauterize history
>>   for this, while it technically would work, would not be so
>>   helpful to users, so the design needs to be worked out again.
>
> Perhaps use comment for marking graft as cauterizing history?

?

> There was also talk about proposed git-splithist, which would move some of
> the history to other (historical, archive) repository.

I stayed out from that discussion, but my impression was that
you could essentially do the same thing as what Linus did when
he started the recent kernel history since v2.6.12-rc2 without
any tool support.

The older kernel history from BKCVS was resurrected later by
independent parties and Linus's history can be grafted onto it,
but if you have an existing history stored in git, you could do:
(1) take a snapshot of the tip of your development with "git
tar-tree HEAD"; (2) extract it into an empty repository and
start a new history; (3) build on top of the truncated history;
and (4) graft that onto the history that stopped at (1), which
you tentatively abandoned, as needed.



	
