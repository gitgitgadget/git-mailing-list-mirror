From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: warning: no common commits - slow pull
Date: Thu, 28 Feb 2008 03:50:38 -0500
Message-ID: <20080228085038.GS8410@spearce.org>
References: <200802102007.38838.lenb@kernel.org> <20080211035501.GB26205@mit.edu> <200802151643.30232.lenb@kernel.org> <200802261438.17014.lenb@kernel.org> <7vir0byoc2.fsf@gitster.siamese.dyndns.org> <7voda2yksf.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802271411280.19665@iabervon.org> <7vskzeruit.fsf@gitster.siamese.dyndns.org> <alpine.LNX.1.00.0802271605540.19665@iabervon.org> <20080228004313.GQ8410@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Len Brown <lenb@kernel.org>, Theodore Tso <tytso@mit.edu>,
	git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu Feb 28 09:51:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JUeUb-00024i-J2
	for gcvg-git-2@gmane.org; Thu, 28 Feb 2008 09:51:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753336AbYB1IvP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Feb 2008 03:51:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751592AbYB1IvP
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Feb 2008 03:51:15 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:34356 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752431AbYB1IvP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Feb 2008 03:51:15 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JUeTN-0001cO-NH; Thu, 28 Feb 2008 03:50:37 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 6707420FBAE; Thu, 28 Feb 2008 03:50:38 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20080228004313.GQ8410@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75370>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Daniel Barkalow <barkalow@iabervon.org> wrote:
> > On Wed, 27 Feb 2008, Junio C Hamano wrote:
> > > 
> > > I think we can teach the upload-pack side to be more helpful and
> > > with a protocol extension to send tag objects that are pointing
> > > at commits that will be included in the result, or something
> > > like that, though.  But that is outside the scope of 1.5.5; it
> > > would be a moderate to large protocol surgery, and I suspect it
> > > might even have to affect pack-objects.
> > 
> > Using a single connection, either by just telling the remote that you want 
> > to autofollow tags, and it should therefore include any tags that point to 
> > any objects it includes,
> 
> I agree its outside of 1.5.5, as we'd all like to see 1.5.5 happen
> soon, but it could be 1.5.6 material, especially if someone starts
> working on it sooner rather than later.
> 
> Its actually probably not that difficult to implement.

OK, so I posted a fairly short series tonight (4 patches) that
handles some of the common cases in a fairly small amount of
code churn.  It might just be 1.5.5-ish.

Doing anything better is going to require a new protocol extension,
which is already 1.5.6 material.  In the mean time maybe Junio's
earlier patch to try and drop the ref_map when we do open the new
connection is the way to deal with the round-robin DNS issues.

-- 
Shawn.
