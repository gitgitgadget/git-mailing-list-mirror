From: Junio C Hamano <junkio@cox.net>
Subject: Re: Marking abandoned branches
Date: Wed, 13 Sep 2006 11:40:10 -0700
Message-ID: <7vmz93a9v9.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910609130817r39bbf8a8x2e05461816d9d2a1@mail.gmail.com>
	<20060913152451.GH23891@pasky.or.cz>
	<Pine.LNX.4.63.0609131729500.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jon Smirl <jonsmirl@gmail.com>,
	Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Sep 13 20:41:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GNZek-0001yO-Qs
	for gcvg-git@gmane.org; Wed, 13 Sep 2006 20:40:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750761AbWIMSkO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Sep 2006 14:40:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751092AbWIMSkO
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Sep 2006 14:40:14 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:53692 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750844AbWIMSkM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Sep 2006 14:40:12 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060913184011.UHBS13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Wed, 13 Sep 2006 14:40:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Mug01V00V1kojtg0000000
	Wed, 13 Sep 2006 14:40:01 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0609131729500.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 13 Sep 2006 17:31:41 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26929>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> Dear diary, on Wed, Sep 13, 2006 at 05:17:59PM CEST, I got a letter
>> where Jon Smirl <jonsmirl@gmail.com> said that...
>> > Abandoned branches are common in CVS since it is not distributed.
>> > People start working on something in the main repo and then decide it
>> > was a bad idea. In the git world these branches usually don't end up
>> > in the main repo.
>> 
>> Can't you just toss the branch away in that case? :-)
>> 
>> You could also stash the ref to refs/heads-abandoned/ instead of
>> refs/heads/ if you want to keep the junk around for some reason. Of
>> course you don't get the nice marker with explanation of why is this
>> abandoned and who decided that, but you can just use an empty commit for
>> the same purpose.
>
> ... or a tag (remember, you can stash a tag into refs/abandoned/, instead 
> of a commit) with the further benefit that you really cannot commit on top 
> of that.

Using tag has an added benefit that you now have a place to say
why you dropped it.  So what we would need to support this is an
agreed-upon name under $GIT_DIR/refs/ that is omitted from
display by convention across Porcelains (the core side should
not ignore them because even when you are abandoning them, you
do not want to lose them),
