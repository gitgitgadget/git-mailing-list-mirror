From: Petr Baudis <pasky@suse.cz>
Subject: Re: [BUG] gitweb on repo.or.cz shows buggy commitdiff
Date: Mon, 27 Aug 2007 02:48:38 +0200
Message-ID: <20070827004838.GO1219@pasky.or.cz>
References: <20070729094645.GU23229@nan92-1-81-57-214-146.fbx.proxad.net> <20070825202530.GB1219@pasky.or.cz> <200708270230.04537.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>, Yann Dirson <ydirson@altern.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 27 02:48:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPSmZ-0007b5-KW
	for gcvg-git@gmane.org; Mon, 27 Aug 2007 02:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbXH0Ask (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Aug 2007 20:48:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751307AbXH0Ask
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 20:48:40 -0400
Received: from w241.dkm.cz ([62.24.88.241]:60387 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751155AbXH0Asj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 20:48:39 -0400
Received: (qmail 31729 invoked by uid 2001); 27 Aug 2007 02:48:38 +0200
Content-Disposition: inline
In-Reply-To: <200708270230.04537.jnareb@gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56751>

On Mon, Aug 27, 2007 at 02:30:04AM CEST, Jakub Narebski wrote:
> 2. Alternate solution is to note that we have split patch only in the case
> of 'T' (type change) status, and for typechange we always split patch in
> two, so there are two patches corresponding to single raw diff-tree line.
> 
> So it would be enough to introduce $continued_patch variable, unset it
> after writing that patch is continued if it is true, set it to true if
> there was typechange, i.e. if status (one of status) is 'T'.
> 
> And we can get rid of buffering extended diff header and parsing it,
> I think. This would simplify git_patchset_body, making it easier to
> understand and maintain.
> 
> But this depends on my understanding on "git diff-tree --patch-with-raw"
> output, and that it would not change in the future WRT split patches.

I'd prefer this solution, though I think split patch could also happen
if you use -B (which I think is very good idea to use and it's a pity
that it isn't default - or is it?).

-- 
				Petr "Pasky" Baudis
Early to rise and early to bed makes a male healthy and wealthy and dead.
                -- James Thurber
