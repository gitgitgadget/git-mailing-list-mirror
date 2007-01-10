From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Using GIT to store /etc (Or: How to make GIT store all file permission bits)
Date: Tue, 9 Jan 2007 21:30:31 -0500
Message-ID: <20070110023031.GC30765@spearce.org>
References: <787BE48C-1808-4A33-A368-5E8A3F00C787@mac.com> <8aa486160612100706y92bc722n93374e394fc58005@mail.gmail.com> <Pine.LNX.4.63.0701091735490.7747@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 10 03:30:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H4TEc-0004Vt-3r
	for gcvg-git@gmane.org; Wed, 10 Jan 2007 03:30:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbXAJCag (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 Jan 2007 21:30:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932671AbXAJCag
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jan 2007 21:30:36 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40089 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932669AbXAJCaf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jan 2007 21:30:35 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H4TEM-0006eb-6O; Tue, 09 Jan 2007 21:30:22 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id D7E4420FBAE; Tue,  9 Jan 2007 21:30:31 -0500 (EST)
To: David Lang <david.lang@digitalinsight.com>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0701091735490.7747@qynat.qvtvafvgr.pbz>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36473>

David Lang <david.lang@digitalinsight.com> wrote:
> I want to have a tripwire-like system checking the files to make sure that 
> they haven't changed unexpectedly. the program I'm looking at notices inode 
> as well as timestamp and content changed.
> 
> when you checkout a file from git will it re-write/overwrite a file that 
> hasn't changed or will it realize there is no change and leave it as-is?

If the stat data is current it will leave it as-is.  You can force
the index to refresh with `git update-index --refresh` or by running
git status.
 
> does this answer change if there is a trigger on checkout (to change 
> permissions or otherwise manipulate the file)?

Only if the trigger does something in addition, like force overwrite
files.  But we don't have a checkout trigger.  So there's no trigger.

-- 
Shawn.
