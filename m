From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 2/4] Hash tags by commit SHA1 in git-describe.
Date: Sun, 14 Jan 2007 18:19:37 -0500
Message-ID: <20070114231937.GF10888@spearce.org>
References: <8e29bab8b4b9f53cbdc85e6e783bf3b5d3787f0f.1168727248.git.spearce@spearce.org> <20070113222816.GB18011@spearce.org> <Pine.LNX.4.63.0701141358440.22628@wbgn013.biozentrum.uni-wuerzburg.de> <7vr6txh278.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:01:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6Vhn-0006S8-Ef
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:33:11 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V8Q-0003eK-MA
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:56:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751715AbXANXTn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 18:19:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751717AbXANXTn
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 18:19:43 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:56736 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751715AbXANXTm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 18:19:42 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H6EdN-0002GK-B0; Sun, 14 Jan 2007 18:19:29 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 88ADF20FBAE; Sun, 14 Jan 2007 18:19:37 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vr6txh278.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36813>

Junio C Hamano <junkio@cox.net> wrote:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
> > On Sat, 13 Jan 2007, Shawn O. Pearce wrote:
> >
> >> If a project has a very large number of tags then git-describe
> >> will spend a good part of its time looping over the tags testing
> >> them one at a time to determine if it matches a given commit.
> >
> > Why not just use object_refs? This also obviates the need for your patch 
> > 3/4, since you no longer have buckets to search binarily. Plus, it uses a 
> > hash map, which already turned out to beat (in terms of performance) the 
> > hell out of bucketed lists in git history.
> 
> Very good point.

OK. I didn't realize we had a better system already implemented.
Thanks for pointing it out.

I'll work up a patch to replace the crude hash/list arrangement
with something based on object_refs instead.

-- 
Shawn.
