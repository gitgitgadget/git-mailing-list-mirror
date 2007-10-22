From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-cherry-pick: improve description of -x.
Date: Mon, 22 Oct 2007 01:14:53 -0400
Message-ID: <20071022051453.GM14735@spearce.org>
References: <20071019174134.GD9906@ins.uni-bonn.de> <20071019211152.GN3917@planck.djpig.de> <20071020031917.GR14735@spearce.org> <20071021093618.GC12794@ins.uni-bonn.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 22 07:15:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IjpdD-0002Gq-7A
	for gcvg-git-2@gmane.org; Mon, 22 Oct 2007 07:15:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753617AbXJVFPB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Oct 2007 01:15:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753819AbXJVFPA
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Oct 2007 01:15:00 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:45584 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751188AbXJVFO7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Oct 2007 01:14:59 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ijpct-00073l-Vr; Mon, 22 Oct 2007 01:14:56 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1553B20FBAE; Mon, 22 Oct 2007 01:14:53 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071021093618.GC12794@ins.uni-bonn.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61933>

Ralf Wildenhues <Ralf.Wildenhues@gmx.de> wrote:
> * Shawn O. Pearce wrote on Sat, Oct 20, 2007 at 05:19:17AM CEST:
> > Frank Lichtenheld <frank@lichtenheld.de> wrote:
> > > On Fri, Oct 19, 2007 at 07:41:34PM +0200, Ralf Wildenhues wrote:
> > > > 
> > > > Is that by design (because there were conflicts) or an omission?
> > > > In case of the former, maybe the description of -x should mention this.
> > > 
> > > git commit currently doesn't know that you commit a cherry-pick. The -c
> > > only says to use the commit message of the original commit. So this is
> > > currently by design.
> > 
> > Ralf, can you submit an updated version of this patch that describes
> > the current behavior better, given the "by design" remark above
> > from Frank?
> 
> Here it goes.  Still makes me wonder whether that is the ideal mode of
> operation or not.

Thanks.

I think you are right that the current behavior of -x *not*
including the prior commit SHA-1 in the case of a conflict is wrong.
The problem however is that git-commit.sh doesn't get the data
necessary to preseve the original author name/email/date/tz unless
you use the "-c $id" option.  There's some work here to store the
necessary information into a file that git-commit.sh could pickup,
and then making sure stale versions of those files get cleaned up
properly, etc.

At least the current behavior is now documented.  Maybe someone
will be bothered enough by it to try and submit a patch that changes
the behavior.
 
-- 
Shawn.
