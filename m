From: "C. Scott Ananian" <cscott@cscott.net>
Subject: Re: Val Henson's critique of hash-based content storage systems
Date: Fri, 29 Apr 2005 16:17:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0504291608410.32145@cag.csail.mit.edu>
References: <200504291952.MAA27541@emf.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org, robj@unrealities.com
X-From: git-owner@vger.kernel.org Fri Apr 29 22:21:20 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DRbzD-0006ah-Tq
	for gcvg-git@gmane.org; Fri, 29 Apr 2005 22:21:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262957AbVD2UVw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Apr 2005 16:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262919AbVD2UUh
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Apr 2005 16:20:37 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:59571 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S262944AbVD2URu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2005 16:17:50 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DRbvf-0007y1-00; Fri, 29 Apr 2005 16:17:39 -0400
To: Tom Lord <lord@emf.net>
In-Reply-To: <200504291952.MAA27541@emf.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 29 Apr 2005, Tom Lord wrote:

> I would expect someone to have on hand a small number of blobs that are
> different but have different hashes and, eventually, to drop said files
> into a blob-based infrastructure to wreak havoc.

This is just ridiculous.  The number of known collisions in SHA1 is 
*exactly zero* at this point in time --- not guaranteed to stay that way, 
of course, but generating collisions is likely to remain relatively 
expensive for some time.  The collisions are highly structured; they are 
not just arbitrary blobs.  If, after doing your 2^69 work or so to 
generate a real honest-to-goodness SHA-1 collision, you think an 
attacker would "DROP THEM IN A REPOSITORY TO CREATE HAVOC"?  You'd have to 
break into the repository, etc, and then you'd find that *NOTHING 
REFERENCED THEM* and so *ABSOLUTELY NOTHING WOULD HAPPEN*.

It's far more likely that SHA1 collisions will be used to generate forged 
X509 certificates, for a number of highly technical reasons.

Git's highly constrained and derided 'brittle' file formats also serve
to protect against the collision attacks against SHA-1 which are beginning 
to look possible.

> So: a way to locally mark a given checksum as "controversial" seems
> prudent, to me (hence, support for such in my blob-db code/spec).

Arguably that's what *upgrades* to the spec might be for -- git has a 
solid philosophy of not creating 'features' unless it is sure that they 
are needed/will be used, and I think this is always the wise route in 
software development.  Of much specification comes no code.

And, if you actually create a 'flexible' blob-db spec with 'room for 
expansion' -- congratulations, you've just made yourself more vulnerable 
to collision attacks.
  --scott

terrorist MI5 SKILLET hack AMLASH security KMPLEBE KUFIRE SCRANTON 
D5 SLBM LINCOLN KUDESK SMOTH Kojarena Moscow HTAUTOMAT WSBURNT Chechnya
                          ( http://cscott.net/ )
