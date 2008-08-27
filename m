From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [egit PATCH] avoiding output in the error log
Date: Wed, 27 Aug 2008 15:00:22 -0700
Message-ID: <20080827220022.GP26523@spearce.org>
References: <218798.11648.bm@omp221.mail.ukl.yahoo.com> <200808272228.07060.robin.rosenberg.lists@dewire.com> <20080827203343.GN26523@spearce.org> <200808272350.56819.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: robert_no.spam_m@yahoo.fr, git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 00:01:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYT52-0004ch-Ph
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 00:01:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754038AbYH0WAY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 18:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755949AbYH0WAY
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 18:00:24 -0400
Received: from george.spearce.org ([209.20.77.23]:60054 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755908AbYH0WAX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 18:00:23 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 8F22A38375; Wed, 27 Aug 2008 22:00:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <200808272350.56819.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93963>

Robin Rosenberg <robin.rosenberg.lists@dewire.com> wrote:
> > > 
> > > Shawn, you removed the test from the code in 4a230ea1. Perhaps you could care to
> > > comment on this patch to restore the test, though slightly different.
> > > 
> > > 		if (r.isAccessible())
> > > 			r.setSessionProperty(GITFOLDERDIRTYSTATEPROPERTY, null);
> 
> Good. So then the question is whether we should use isAccessible() or exists()? Normally
> this makes no difference, but for a Project (at least) there is a difference. I project that exits
> is not accessible when closed. 

It _has_ to be isAccessible().  You cannot get or set a session
property on a closed project.

-- 
Shawn.
