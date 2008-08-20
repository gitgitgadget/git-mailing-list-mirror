From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git-aware Issue Tracking?
Date: Wed, 20 Aug 2008 09:44:09 -0700
Message-ID: <20080820164409.GH3483@spearce.org>
References: <1219005852-21496-1-git-send-email-marek.zawirski@gmail.com> <20080819175931.GH20947@spearce.org> <200808192121.30372.robin.rosenberg.lists@dewire.com> <48AB84A2.7010905@gmail.com> <20080820141326.GA3483@spearce.org> <20080820152305.GJ10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marek Zawirski <marek.zawirski@gmail.com>,
	Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Wed Aug 20 18:45:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVqo8-0005qH-Mi
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 18:45:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751697AbYHTQoM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 12:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751508AbYHTQoM
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 12:44:12 -0400
Received: from george.spearce.org ([209.20.77.23]:47075 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751474AbYHTQoL (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 12:44:11 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id EB6AB38375; Wed, 20 Aug 2008 16:44:09 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080820152305.GJ10544@machine.or.cz>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92994>

Petr Baudis <pasky@suse.cz> wrote:
> On Wed, Aug 20, 2008 at 07:13:26AM -0700, Shawn O. Pearce wrote:
> > I've thought about starting a code.google.com project just to use
> > the issue tracking system there.
> 
> I have been thinking about issue tracking for some of my projects too,
> but I'm wondering, does anyone have a comprehensive picture of the state
> of the Git-supporting issue tracking tools, especially those that keep
> the tracked issues in a Git repository as well?
> 
> 	http://git.or.cz/gitwiki/InterfacesFrontendsAndTools#head-73b23f376ebd0222d1e4b08f09158172aa34c24f
> 
> has three, but two of them are in Ruby, which is rather discouraging.
> But Cil (in Perl) is already "self-hosting", so it might be well usable?

Cil is interesting.  I'm concerned about keeping the state in tree
with the repository though in a distributed development team.

If I mark the status of an issue in a branch that isn't ready
for mainline how do I share that status update with everyone else?
I have to put it into a branch somewhere, no big deal.  repo.or.cz is
pretty good at publishing things.

But do that now for 5 developers working on 10 or 20 different
branches at once.  We'll have status updates all over the place
and Marek's desire to see what we are each working on (to reduce
wasted effort and perhaps help each other out more) still isn't met.

This is the number one reason a DIT (distributed issue tracker)
isn't available.  Nobody has solved the hard technical problem of
making it easy to distribute the state changes, yet still provide
a reasonably current global view of the issue status.

Perhaps running Cil in its own egit-cil.git repository would get
us what we neeed.  I looked at the code and its pretty clean,
but I didn't see how merges of the .cil database work.

-- 
Shawn.
