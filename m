From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Cleaning the .git directory with gc
Date: Wed, 23 Apr 2008 20:57:44 -0400
Message-ID: <20080424005744.GR29771@spearce.org>
References: <20080423231359.GA30913@fox> <f9d2a5e10804231709v1d7e426fwf68b3d316a15081a@mail.gmail.com> <e1dab3980804231732x29d6d73cudd0568a910642639@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Russ Dill <russ.dill@gmail.com>,
	Haakon Riiser <haakon.riiser@fys.uio.no>, git@vger.kernel.org
To: David Tweed <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 24 02:58:38 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JopnJ-0000nr-Nu
	for gcvg-git-2@gmane.org; Thu, 24 Apr 2008 02:58:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753396AbYDXA5t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 20:57:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753409AbYDXA5t
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 20:57:49 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:58029 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753396AbYDXA5s (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 20:57:48 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JopmJ-0002gp-01; Wed, 23 Apr 2008 20:57:35 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 37C4B20FBAE; Wed, 23 Apr 2008 20:57:44 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <e1dab3980804231732x29d6d73cudd0568a910642639@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80277>

David Tweed <david.tweed@gmail.com> wrote:
> On Thu, Apr 24, 2008 at 1:09 AM, Russ Dill <russ.dill@gmail.com> wrote:
> > On Wed, Apr 23, 2008 at 4:13 PM, Haakon Riiser <haakon.riiser@fys.uio.no> wrote:
> >  > I've recently started using git, and while experimenting with
> >  >  git commit --amend, I noticed that git gc does not do what I
> >  >  expected.  Example:
> >
> >  Thats a lot of work without first reading the man page:
> >
> >        --prune
> [snip]
> 
> There's a relatively recent change in this area. Git keeps stuff
> that's apparently unattached for a period of, by default, 2 weeks
> (determined by gc.pruneexpire variable) after which a git gc will
> remove it. The reasoning is that even with the careful design of the
> git updating strategy there are rare times when with a concurrent
> other git process there are files in the repo that look unattached but
> will become attached as the other process completes.

Although that's certainly true, the original poster was asking about
`git commit --amend`.  In such a case the reflog for HEAD and the
current branch are going to anchor the old commit for the reflog
expire period, which is 90 days.  Way longer than the 2 week aging
of loose objects.

-- 
Shawn.
