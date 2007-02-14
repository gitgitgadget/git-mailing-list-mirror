From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-unbundle - unbundle objects and references for disconnected transfer.
Date: Wed, 14 Feb 2007 16:03:00 -0500
Message-ID: <20070214210300.GF28290@spearce.org>
References: <11714622292110-git-send-email-mdl123@verizon.net> <11714622292295-git-send-email-mdl123@verizon.net> <11714622293142-git-send-email-mdl123@verizon.net> <20070214194537.GD28290@spearce.org> <45D377A8.1080404@verizon.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Mark Levedahl <mdl123@verizon.net>
X-From: git-owner@vger.kernel.org Wed Feb 14 22:07:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHRHT-0001lS-Es
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 22:03:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932461AbXBNVDH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 16:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932589AbXBNVDH
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 16:03:07 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42668 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932461AbXBNVDF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 16:03:05 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HHRHC-0006wx-0O; Wed, 14 Feb 2007 16:02:54 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D857D20FBAE; Wed, 14 Feb 2007 16:03:00 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <45D377A8.1080404@verizon.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39745>

Mark Levedahl <mdl123@verizon.net> wrote:
> Many of my uses of this result in 10-20 objects being transferred, so 
> I'm not sure keeping each pack is a real benefit. In particular, one use 
> is for daily updates between two sites via email where we tend to have a 
> lot of extra objects in the packs as we assume that not every bundle 
> actually gets applied, while the number of real new objects tends to be 
> small. On the other hand, given the manual nature of this operation, we 
> could always just follow up with repack -a -d, possibly guarded by a git 
> count. Thoughts?

I don't really have an opinion here, as I'm fortunate enough that
I can use an SSH or an anonymous git connection between all of my
repositories, and thus don't really have a need for bundle/unbundle.

Its just one of those operations which I thought would not happen
often, and when it did, probably would be big.  In which case keeping
the packfile would make the unbundle run faster, as you don't need
to create a huge mess of loose objects.

-- 
Shawn.
