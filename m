From: ross@lug.udel.edu
Subject: Re: SHA1 hash safety
Date: Sat, 16 Apr 2005 11:49:51 -0400
Message-ID: <20050416154951.GB13373@jose.lug.udel.edu>
References: <Pine.LNX.4.62.0504160519330.21837@qynat.qvtvafvgr.pbz> <20050416123155.GA19908@elte.hu> <Pine.LNX.4.62.0504160542190.21837@qynat.qvtvafvgr.pbz> <4261132A.3090907@khandalf.com> <Pine.LNX.4.61.0504161040310.29343@cag.csail.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: omb@bluewin.ch, David Lang <david.lang@digitalinsight.com>,
	Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 17:46:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMpUv-0006GW-SN
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 17:46:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262689AbVDPPtz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 11:49:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262690AbVDPPtz
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 11:49:55 -0400
Received: from jose.lug.udel.edu ([128.175.60.112]:62868 "HELO
	mail.lug.udel.edu") by vger.kernel.org with SMTP id S262689AbVDPPtv
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 11:49:51 -0400
Received: (qmail 13755 invoked by uid 1009); 16 Apr 2005 15:49:51 -0000
To: "C. Scott Ananian" <cscott@cscott.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.61.0504161040310.29343@cag.csail.mit.edu>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, Apr 16, 2005 at 10:58:15AM -0400, C. Scott Ananian wrote:
> Even given the known weaknesses in MD5, it would take much more than a 
> million documents to find MD5 collisions.  I can only conclude that the 
> hash was being used incorrectly; most likely truncated (my wild-ass guess 
> would be to 32 bits; a collision is likely with > 50% probability in a 
> million document store for a hash of less than 40 bits).

I've also seen non thread-safe GUID generation, using MD5m hit collisions:
but of course that was due to the fact that the code had thread safety
issues, not because anyone actually ever hit a MD5 collision...

Of course there are constructed cases of MD5 collision, but those are
pretty disinteresting.  Give me two files that have useful content and
the same hash, and then I'll be impressed.

Linus has already weighed in that he doesn't give a crap.  All the
crypto-babble about collision whitepapers is uninteresting without a
repo that has real collisions.  git is far too cool as is - prove I
should be concerned.

-- 
Ross Vandegrift
ross@lug.udel.edu

"The good Christian should beware of mathematicians, and all those who
make empty prophecies. The danger already exists that the mathematicians
have made a covenant with the devil to darken the spirit and to confine
man in the bonds of Hell."
	--St. Augustine, De Genesi ad Litteram, Book II, xviii, 37
