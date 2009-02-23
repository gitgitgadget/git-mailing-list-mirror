From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [EGIT] [PATCH 1/2] Make sure to set core.bare to false when
	cloning
Date: Mon, 23 Feb 2009 08:07:19 -0800
Message-ID: <20090223160719.GJ22848@spearce.org>
References: <cover.1235228532.git.ferry.huberts@pelagic.nl> <80065b1339c7b235b19fa1f5a40a58dca335ae91.1235228532.git.ferry.huberts@pelagic.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: ferry.huberts@pelagic.nl
X-From: git-owner@vger.kernel.org Mon Feb 23 17:09:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LbdMS-0002Em-5z
	for gcvg-git-2@gmane.org; Mon, 23 Feb 2009 17:08:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbZBWQHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Feb 2009 11:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751411AbZBWQHV
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Feb 2009 11:07:21 -0500
Received: from george.spearce.org ([209.20.77.23]:41070 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbZBWQHU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Feb 2009 11:07:20 -0500
Received: by george.spearce.org (Postfix, from userid 1001)
	id 2E19F38210; Mon, 23 Feb 2009 16:07:19 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <80065b1339c7b235b19fa1f5a40a58dca335ae91.1235228532.git.ferry.huberts@pelagic.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111148>

ferry.huberts@pelagic.nl wrote:
> From: Ferry Huberts <ferry.huberts@pelagic.nl>
> 
> This is to make sure that the git plugin sets up a clone
> in the same fashion as the CLI git clone command.
> 
> Signed-off-by: Ferry Huberts <ferry.huberts@pelagic.nl>

Thanks.  "jgit clone" also needed this added.  I did that in
a small followup patch.

Really though we need to fix the abstraction of Repository so there's
a notion of a bare repository, and a repository+worktree.  And that
abstraction should then set the core.bare property accordingly
when creating a new repository (or new repository+worktree).
Unfortunately that hasn't happened yet...

> +		/* we're setting up for a clone with a checkout */
> +		local.getConfig().setBoolean("core", null, "bare", false);
> +		

-- 
Shawn.
