From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Publishing Question: First time Pushing to nonexsiting directory
Date: Mon, 19 Feb 2007 15:03:32 -0500
Message-ID: <20070219200332.GA27565@spearce.org>
References: <20070219073526.GA26531@cip.informatik.uni-erlangen.de> <20070219081010.GC30030@spearce.org> <20070219194423.GJ786@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT <git@vger.kernel.org>
To: Thomas Glanzmann <thomas@glanzmann.de>
X-From: git-owner@vger.kernel.org Mon Feb 19 21:04:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJEjt-0006YJ-5C
	for gcvg-git@gmane.org; Mon, 19 Feb 2007 21:03:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932561AbXBSUDk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 15:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932515AbXBSUDi
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 15:03:38 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:50558 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932529AbXBSUDh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 15:03:37 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HJEjP-00080o-JB; Mon, 19 Feb 2007 15:03:27 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 070B420FBAE; Mon, 19 Feb 2007 15:03:32 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20070219194423.GJ786@cip.informatik.uni-erlangen.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40141>

Thomas Glanzmann <thomas@glanzmann.de> wrote:
>         (thinkpad) [~/work/astro] git pull
>         * refs/remotes/origin/master: storing branch 'master' of 131.188.30.59:/home/cip/adm/sithglan/work/repositories/private/astro

Good, the tracking branch was automatically created.

>         commit: 7a04a7e
>         Warning: No merge candidate found because value of config option
>                 "branch.master.merge" does not match any remote branch fetched.

Check your .git/config.  There is no configuration describing what
to do when `git pull` is invoked on your master branch.  You may want
to add something like the following to your .git/config:

	[branch "master"]
		remote = origin
		merge = refs/heads/master

This just says that by default, `git pull` will merge the master
branch of remote origin when you are on branch master.

> Maybe it is related to the fact that git version 1.4.4.4 is running on
> faui00u (131.188.30.59).

Nope.  It has to do with the fact that you are running 1.5.0 on your
thinkpad and are missing the branch.master.merge entry noted above.

-- 
Shawn.
