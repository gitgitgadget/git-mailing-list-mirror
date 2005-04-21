From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Add "git push"
Date: Thu, 21 Apr 2005 22:41:25 +0200
Message-ID: <20050421204125.GI7443@pasky.ji.cz>
References: <20050421124333.AB2CE7F887@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 21 22:37:43 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOiQ0-0000gx-Rs
	for gcvg-git@gmane.org; Thu, 21 Apr 2005 22:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261869AbVDUUl3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Apr 2005 16:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261868AbVDUUl3
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Apr 2005 16:41:29 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45959 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261869AbVDUUl0 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 21 Apr 2005 16:41:26 -0400
Received: (qmail 20290 invoked by uid 2001); 21 Apr 2005 20:41:25 -0000
To: Matthias Urlichs <smurf@smurf.noris.de>
Content-Disposition: inline
In-Reply-To: <20050421124333.AB2CE7F887@smurf.noris.de>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Thu, Apr 21, 2005 at 02:43:33PM CEST, I got a letter
where Matthias Urlichs <smurf@smurf.noris.de> told me that...
> This patch adds the ability to "git push", as the obvious converse of
> "git pull".

While lack of locking is a problem for git-pasky too, for this git push
it is a downright disaster waiting to happen. It might be also a good
idea to check for remote 'blocked' file, which must exist and contain
only a "pushtree" line. This is so that no (sensible) real working tree
is attached to it, which would be a disaster for it too.

You probably don't want to allow pushing if your local tree is blocked.
And you want to allow pushing only when HEAD is your ancestor. (Helper
tool wanted for this - we need this in git merge badly too.)

BTW, it contains some unrelated and seemingly irrelevant tracking stuff.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
