From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git-unpack-objects < pack file in repository doesn't work!
Date: Mon, 6 Mar 2006 21:29:26 -0500
Message-ID: <20060307022926.GB29180@spearce.org>
References: <200603070213.02805.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Mar 07 03:29:34 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FGRx8-00087r-0y
	for gcvg-git@gmane.org; Tue, 07 Mar 2006 03:29:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617AbWCGC3a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Mar 2006 21:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752456AbWCGC3a
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Mar 2006 21:29:30 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:9390 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751391AbWCGC33 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Mar 2006 21:29:29 -0500
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FGRwr-0002A0-3P
	for git@vger.kernel.org; Mon, 06 Mar 2006 21:29:17 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 4EC1A20FBAC; Mon,  6 Mar 2006 21:29:26 -0500 (EST)
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <200603070213.02805.blaisorblade@yahoo.it>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17314>

Blaisorblade <blaisorblade@yahoo.it> wrote:
> It's not a bug, it's an undocumented feature. It should be documented as 
> "git-unpack-objects < $pack; rm $pack" is something one would deem correct at 
> first glance (luckily I just moved the pack away and did git-fsck-cache).
> 
> To write an object, git-unpack-objects ends in
> 
> unpack-objects.c:write_object -> sha1_file.c:write_sha1_file:
> 
>         /* Normally if we have it in the pack then we do not bother writing
>          * it out into .git/objects/??/?{38} file.
>          */
> 
> This indeed works, so the files aren't unpacked.

Funny, I just did the exact same thing today, scratched my head and
said ``what did I just do!?!?!'' as I had deleted the pack before
discovering that nothing was actually unpacked.  *sigh* At least
it was a clone of the real repository and thus didn't matter to me.

I totally didn't expect that behavior.  But I should have.  It makes
perfect sense.

-- 
Shawn.
