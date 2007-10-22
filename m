From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: how to deal with conflicts after "git stash apply"?
Date: Mon, 22 Oct 2007 00:26:09 -0400
Message-ID: <20071022042609.GK14735@spearce.org>
References: <20071021223206.GJ16291@srparish.net> <Pine.LNX.4.64.0710212338200.25221@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Scott Parish <sRp@srparish.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 06:26:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ijory-0002Me-Gn
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 06:26:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751047AbXJVE0O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 00:26:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751090AbXJVE0O
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 00:26:14 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44484 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbXJVE0N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 00:26:13 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ijorj-0002at-Uj; Mon, 22 Oct 2007 00:26:12 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8BD7620FBAE; Mon, 22 Oct 2007 00:26:09 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0710212338200.25221@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61930>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sun, 21 Oct 2007, Scott Parish wrote:
> 
> > How is the intended way to deal with "git stash apply" conflicts?
> > If i just edit the file and remove the conflict, "git diff" gives
> > some really messed up output. Documentation for other commands and
> > conflicts suggest "git commit" after cleaning up the conflict, or
> > "git add", but in the case of "stash apply" i'm not ready for a
> > commit yet, and "git add" keeps "git diff" from showing any output.
> 
> You are probably seeing combined diffs.
> 
> This show not only the differences of the working tree relative to HEAD, 
> but also of the changes stored in the stash.

The reason Scott is seeing a combined diff here is merge-recursive
left the different versions of the file in the higher order stages
of the index when it found conflicts during the apply.  You need
to use git-add to stage the resolved file and replace the higher
order stages with just the normal stage 0.

-- 
Shawn.
