From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git's is_inside_git_dir too strict?
Date: Wed, 7 Mar 2007 10:53:07 -0500
Message-ID: <20070307155307.GC27596@spearce.org>
References: <fcaeb9bf0703060741l7cbfd0f3ue443730176606db6@mail.gmail.com> <Pine.LNX.4.63.0703062232570.22628@wbgn013.biozentrum.uni-wuerzburg.de> <fcaeb9bf0703070417n5d3fb168jc7efd4642ad38c92@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 07 16:53:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOyS5-00089Y-5I
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 16:53:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751941AbXCGPxN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Mar 2007 10:53:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751980AbXCGPxN
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Mar 2007 10:53:13 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:40857 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbXCGPxL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Mar 2007 10:53:11 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HOyRr-0003pM-7p; Wed, 07 Mar 2007 10:53:03 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 379A420FBAE; Wed,  7 Mar 2007 10:53:07 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <fcaeb9bf0703070417n5d3fb168jc7efd4642ad38c92@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41669>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> wrote:
> On 3/7/07, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> >Well, there is a real problem with "This operation must be run in a work
> >tree". What operation is that? We tried to make it hard to overwrite
> >things in $GIT_DIR by running Git operations meant for the working tree,
> >and it seems like you are running one of them.
> 
> From this command:
> 
> git --git-dir=/home/pclouds/blog/data.git ls-files --others --modified
> 2007-03-07T18_52_41.txt
> 
> It was run in /home/pclouds/blog/data, which is the working directory
> of data.git.

Why not just symlink it?

	cd /home/pclouds/blog/data
	ln -s ../data.git .git

But really, why is your Git repository for the working directory
outside of the working directory?  Why not just move data.git to
data/.git ?

-- 
Shawn.
