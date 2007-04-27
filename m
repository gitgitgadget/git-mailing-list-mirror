From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] [PATCH] git-mirror - exactly mirror another repository
Date: Fri, 27 Apr 2007 06:38:12 +0200
Message-ID: <20070427043812.GX4489@pasky.or.cz>
References: <20070427021505.1740.58136.stgit@rover> <4631642B.2010501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 27 06:38:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HhIDq-0007A2-4D
	for gcvg-git@gmane.org; Fri, 27 Apr 2007 06:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755287AbXD0EiP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 Apr 2007 00:38:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755294AbXD0EiP
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Apr 2007 00:38:15 -0400
Received: from w241.dkm.cz ([62.24.88.241]:53100 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755287AbXD0EiO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Apr 2007 00:38:14 -0400
Received: (qmail 10171 invoked by uid 2001); 27 Apr 2007 06:38:12 +0200
Content-Disposition: inline
In-Reply-To: <4631642B.2010501@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45686>

On Fri, Apr 27, 2007 at 04:47:07AM CEST, A Large Angry SCM wrote:
> It would be nice if this had an option to not mirror HEAD and another 
> option to map the refs from (/ref/[^/])/(.*) to /ref/\1/${repo_path}/\2.

When I try to guess why you want this, I think this is just saying "it
would be nice if this was part of git-fetch and if git-fetch actually
did this automagically by default". Because when you clone a given
repository with all its branches, you are naturally interested not only
in the snapshot of the branch set at the point of the clone but more
likely just want "anytime whatever branches are over there". So when
fetching a * refspec it's natural to look for new branches and fetch
them too; and if you do that, it should be pretty easy to also (probably
optionally) remove stale branches.

But heck, maybe with all the nifty fetch--tools git-fetch is already
doing it. But there seems to be basically zero documentation, the code
is not that easy to follow and it's too late for me to be decyphering it
now... 

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
