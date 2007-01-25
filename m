From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/2] Teach git-describe to display distances from tags.
Date: Thu, 25 Jan 2007 16:37:12 -0500
Message-ID: <20070125213712.GC13874@spearce.org>
References: <20070125173954.GA13276@spearce.org> <7vmz46ajcq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Jan 25 22:37:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HACHa-0005QB-5O
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 22:37:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030593AbXAYVhS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 16:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030594AbXAYVhS
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 16:37:18 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:50704 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030593AbXAYVhQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 16:37:16 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HACHN-0003qH-3z; Thu, 25 Jan 2007 16:37:09 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 840A020FBAE; Thu, 25 Jan 2007 16:37:12 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <7vmz46ajcq.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37761>

Junio C Hamano <junkio@cox.net> wrote:
>  - This is purely style, but we seem to prefer %d instead of %i
>    elsewhere in the code (three existing offenders are
>    builtin-describe.c, receive-pack.c and sha1_file which we may
>    want to clean up for consistency).

I'll send a cleanup patch then for these locations.
 
>  - How much damage are we talking about with this patch to
>    People's existing scripts?  I expect they all extract the
>    hash from last -g (because they cannot rely on particular
>    convention in tagnames), but I am also worried if people are
>    expecting everything that comes before the last -g is the
>    whole tag.

No way to know for sure.  I almost put this as an option
(e.g. "--include-distance") but didn't want everyone to need to
update their existing git-describe callers to obtain this new data.
I would hope that people split on last -g to get at or remove the
commit SHA-1, but they probably are also assiming te tag name is
everything to the left.  Including the distance would certainly
violate that.

-- 
Shawn.
