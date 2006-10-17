From: Shawn Pearce <spearce@spearce.org>
Subject: Re: VCS comparison table
Date: Tue, 17 Oct 2006 01:20:19 -0400
Message-ID: <20061017052019.GB21210@spearce.org>
References: <9e4733910610140807p633f5660q49dd2d2111c9f5fe@mail.gmail.com> <egr3ud$nqm$1@sea.gmane.org> <45340713.6000707@utoronto.ca> <200610170119.09066.jnareb@gmail.com> <45346290.6050300@utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, bazaar-ng@lists.canonical.com,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 17 07:20:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZhNP-0007TR-Ey
	for gcvg-git@gmane.org; Tue, 17 Oct 2006 07:20:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423106AbWJQFU2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 01:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423110AbWJQFU2
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 01:20:28 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:18925 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1423106AbWJQFU1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 01:20:27 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GZhNG-0006RT-05; Tue, 17 Oct 2006 01:20:22 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1C3AA20E42A; Tue, 17 Oct 2006 01:20:20 -0400 (EDT)
To: Aaron Bentley <aaron.bentley@utoronto.ca>
Content-Disposition: inline
In-Reply-To: <45346290.6050300@utoronto.ca>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29022>

Aaron Bentley <aaron.bentley@utoronto.ca> wrote:
> Jakub Narebski wrote:
> > One cannot have universally valid revision numbers (even
> > only per branch) in distributed development. Subversion can do that only
> > because it is centralized SCM. Global numbering and distributed nature
> > doesn't mix... hence contents based sha1 as commit identifiers.
> 
> Sure.  Our UI approach is that unique identifiers can usefully be
> abstracted away with a combination of URL + number, in the vast majority
> of cases.

But this only works when the URL is public.  In Git I can just lookup
the unique SHA1 for a revision in my private repository and toss it
into an email with a quick copy and paste.  With Bazaar it sounds
like I'd have to do that relative to some known public repository,
which just sounds like more work to me.

But I don't want to see this otherwise interesting thread devolve into
a "we do X better!" match so I'm not going to say anything further here.
 
> > I wonder if any SCM other than git has easy way to "rebase" a branch,
> > i.e. cut branch at branching point, and transplant it to the tip
> > of other branch. For example you work on 'xx/topic' topic branch,
> > and want to have changes in those branch but applied to current work,
> > not to the version some time ago when you have started working on
> > said feature.
> 
> If I understand correctly, in Bazaar, you'd just merge the current work
> into 'xx/topic'.

Git has two approaches:

 - merge: The two independent lines of development are merged
   together under a new single graph node.  This is a merge commit
   and has two parent pointers, one for each independent line of
   development which was combined into one.  Up to 16 independent
   lines can be merged at once, though 12 is the record.

 - rebase: The commits from one line of development are replayed
   onto a totally different line of development.  This is often
   used to reapply your changes onto the upstream branch after the
   upstream has changed but before you send your changes upstream.
   It can often generate more readable commit history.

I believe what you are talking about in Bazaar is the former (merge)
while what Jakub was talking about was the latter (rebase).
 
> > What your comparison matrick lacks for example is if given SCM
> > saves information about branching point and merges, so you can
> > get where two branches diverged, and when one branch was merged into
> > another.
> 
> I'm not sure what you mean about divergence.  For example, Bazaar
> records the complete ancestry of each branch, and determining the point
> of divergence is as simple as finding the last common ancestor.  But are
> you considering only the initial divergence?  Or if the branches merge
> and then diverge again, would you consider that the point of divergence?

I'm believe you nailed what Jakub was talking about on the head.
And yes, I noticed its in your matrix but its not very clear.
I think that some additional explanation there may help other
readers.
 
-- 
Shawn.
