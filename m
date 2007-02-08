From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git rescue mission
Date: Thu, 8 Feb 2007 18:50:06 -0500
Message-ID: <20070208235006.GC1556@spearce.org>
References: <17866.27739.701406.722074@lisa.zopyra.com> <Pine.LNX.4.64.0702080858430.8424@woody.linux-foundation.org> <17867.40122.51865.575762@lisa.zopyra.com> <Pine.LNX.4.64.0702081408140.8424@woody.linux-foundation.org> <17867.45437.922483.805945@lisa.zopyra.com> <20070208233324.GA1556@spearce.org> <17867.46325.433406.974582@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org, Jakub Narebski <jnareb@gmail.com>
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Fri Feb 09 00:50:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFJ1r-0003eP-Or
	for gcvg-git@gmane.org; Fri, 09 Feb 2007 00:50:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422709AbXBHXuM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 8 Feb 2007 18:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422729AbXBHXuM
	(ORCPT <rfc822;git-outgoing>); Thu, 8 Feb 2007 18:50:12 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40365 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422709AbXBHXuK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Feb 2007 18:50:10 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HFJ1a-0000pV-GD; Thu, 08 Feb 2007 18:49:58 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6BDDC20FBAE; Thu,  8 Feb 2007 18:50:06 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <17867.46325.433406.974582@lisa.zopyra.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39131>

Bill Lear <rael@zopyra.com> wrote:
> So, I assume I need to tell our developers that once we have installed
> the new git, they will need to set aside their old repos and just
> clone again from our company repo?

Right.  Otherwise they need to do the config changes by hand in their
existing repository, which may be annoying/tedious/painful/difficult,
depending on your knowledge level with git.

You can actually use the old developer repositories with the newer
Git without doing anything specific to upgrade them.  Its just that
1.5.0 sets up the initial config of the repository differently,
and that's exactly the change in functionality you are looking for.

They can save their old topic branches (if they are important)
by doing something like:

	mv proj old_proj
	git clone git://server/proj proj
	cd proj
	git fetch ../old_proj topicA:topicA [topicB:topicB ...]

at which point ../old_proj can be tossed.

-- 
Shawn.
