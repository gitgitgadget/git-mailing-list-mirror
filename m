From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Odd problem in repository
Date: Tue, 24 Apr 2007 13:48:28 -0400
Message-ID: <20070424174828.GC5942@spearce.org>
References: <462E3D32.60804@gmail.com> <20070424173048.GA5942@spearce.org> <462E4200.7080206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Clark Williams <clark.williams@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 24 19:48:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgP82-0001WX-0W
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 19:48:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422881AbXDXRsd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 13:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422843AbXDXRsd
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 13:48:33 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58361 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422881AbXDXRsc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 13:48:32 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HgP7a-0004Jw-Uv; Tue, 24 Apr 2007 13:48:11 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E5DC720FBAE; Tue, 24 Apr 2007 13:48:28 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <462E4200.7080206@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45480>

Clark Williams <clark.williams@gmail.com> wrote:
> But, I'm still confused. After you clone the central repository, with
> the new layout, why can't I 'mock checkout -f mock-0-6-branch'? Do I
> need to further qualify it, or create a local branch from it?

I don't know what the mock command does...  but if you meant:

	git checkout -f mock-0-6-branch

then you want to add the origin/ prefix to qualify it, as you want
the branch from the origin remote.  That should cause your head to
get detached however:

	git checkout -f origin/mock-0-6-branch

at which point you aren't on any branch at all.  So you might
want to make your own mock-0-6-branch starting at your origin's
current version:

	git checkout -f -b mock-0-6-branch origin/mock-0-6-branch

-- 
Shawn.
