From: Miles Bader <miles@gnu.org>
Subject: Re: Git commit won't add an untracked file given on the command line
Date: Thu, 20 Nov 2008 14:06:56 +0900
Message-ID: <buowsez56kv.fsf@dhapc248.dev.necel.com>
References: <20081118211237.234d8035@crow>
	<200811182227.20076.fge@one2team.com> <20081118214730.005fc72d@crow>
	<alpine.DEB.1.00.0811190206170.30769@pacific.mpi-cbg.de>
	<87tza41pf4.fsf@catnip.gol.com>
	<alpine.DEB.1.00.0811190238360.30769@pacific.mpi-cbg.de>
	<buomyfwmldj.fsf@dhapc248.dev.necel.com>
	<alpine.DEB.1.00.0811191036340.30769@pacific.mpi-cbg.de>
Reply-To: Miles Bader <miles@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mark Burton <markb@ordern.com>,
	Francis Galiegue <fge@one2team.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Nov 20 06:08:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L31mL-0006gK-6h
	for gcvg-git-2@gmane.org; Thu, 20 Nov 2008 06:08:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751539AbYKTFHR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Nov 2008 00:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751473AbYKTFHQ
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Nov 2008 00:07:16 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.206]:46350 "EHLO
	tyo202.gate.nec.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751174AbYKTFHP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Nov 2008 00:07:15 -0500
Received: from relay11.aps.necel.com ([10.29.19.46])
	by tyo202.gate.nec.co.jp (8.13.8/8.13.4) with ESMTP id mAK56wx0016692;
	Thu, 20 Nov 2008 14:06:58 +0900 (JST)
Received: from relay31.aps.necel.com ([10.29.19.24] [10.29.19.24]) by relay11.aps.necel.com with ESMTP; Thu, 20 Nov 2008 14:06:57 +0900
Received: from dhapc248.dev.necel.com ([10.114.112.215] [10.114.112.215]) by relay31.aps.necel.com with ESMTP; Thu, 20 Nov 2008 14:06:57 +0900
Received: by dhapc248.dev.necel.com (Postfix, from userid 31295)
	id 432BC3E2; Thu, 20 Nov 2008 14:06:57 +0900 (JST)
System-Type: i686-pc-linux-gnu
Blat: Foop
In-Reply-To: <alpine.DEB.1.00.0811191036340.30769@pacific.mpi-cbg.de>
	(Johannes Schindelin's message of "Wed, 19 Nov 2008 10:41:44 +0100
	(CET)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101387>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
>> I use the staging area a lot, so I think I have a pretty clear idea of 
>> what it's "about", but I also often use "commit FILE" or "commit -a" for 
>> simple cases; even when splitting a change into multiple commits, it's 
>> often more convenient to do "commit FILE..." instead of "add FILE; 
>> commit".
>
> What I meant was this: the "commit <file>" paradigm is not what you should 
> do most of the time.  In order to work with the staging area efficiently, 
> you should make staging and committing two separate steps.
>
> So my point is this: stage first, verify, then commit.  That saves you a 
> lot of embarrassment.

You seem to be saying that you think that using staging area explicitly
is necessary or somehow "more efficient" for making good commits, but on
the face of it, that's simply not true.

I'm extremely careful about committing clean changes, and do a lot of
testing and pre-commit diffing.  For complex changes which need to be
split, the staging area is indeed a very useful tool, and I'm very glad
git has it -- but it's hardly necessary for _all_ commits, and my
experience is that in practice, many commits are indeed the simple sort
which for which it's superfluous.  My goal is not to "work with the
staging area efficiently", it's to "make good/clean/tested commits,
efficiently".

Obviously this depends on work style, and subject matter.  Sometimes one
_needs_ to make biggish changes and split them for commiting, and some
people like to use that work style even when it's not strictly
necessary.  Other times, changes are more obviously independent, and can
be done, tested, and commited in a serial fashion without any splitting.

Perhaps, given your work style or the type of work you, you use the
staging area 99% of the time.  For your case, maybe any git features
which bypass the staging area are simply unneeded complexity.  However,
my own experience suggests that this is not universally true.  I'd say I
use the staging area for maybe 50% of commits.

One of the nice thing about git is the way that it tries to cater to
multiple work styles, so it seems wrong to reject a useful feature
simply because you want to "encourage" people to use your preferred work
style, when that work style is not obviously better.  [Of course there
can be other good reasons to reject this feature -- maybe it's too
dangerous or mucks up the code.]

> I regularly encounter people who never call "git diff --cached" before 
> committing, and guess who introduces all kinds of debug statements and 
> other cruft into their commits?  Exactly.

[I'm not sure what the point of that was... for the record, no I'm not
one of "those people".  When I use the staging area, I use "git diff
--cached"; when I don't use the staging area, I "git diff" instead...]

-Miles

-- 
Bacchus, n. A convenient deity invented by the ancients as an excuse for
getting drunk.
