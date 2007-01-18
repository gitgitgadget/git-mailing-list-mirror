From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH/POLL] git-format-patch: the default suffix is now .patch, not .txt
Date: Thu, 18 Jan 2007 10:42:57 -0500
Message-ID: <20070118154257.GC15428@spearce.org>
References: <87ps9d7j6t.fsf@morpheus.local> <7vejptsglj.fsf@assigned-by-dhcp.cox.net> <625fc13d0701171218i31585558wf89374eae9485341@mail.gmail.com> <7vsle9p8pg.fsf@assigned-by-dhcp.cox.net> <7vd55dp5a3.fsf_-_@assigned-by-dhcp.cox.net> <81b0412b0701172359y1ef4f936pcdcb2de53d6bd468@mail.gmail.com> <7v64b4ohcj.fsf@assigned-by-dhcp.cox.net> <81b0412b0701180135r505a75a5j172c70792d6569c0@mail.gmail.com> <625fc13d0701180352m151cceb3lf9c00b6cf0ae937b@mail.gmail.com> <81b0412b0701180540x15d20453s3dbc0c061fd06d50@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josh Boyer <jwboyer@gmail.com>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org, davidk@lysator.liu.se
X-From: git-owner@vger.kernel.org Thu Jan 18 16:43:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7ZPz-0006LO-F0
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 16:43:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752049AbXARPnG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Jan 2007 10:43:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932423AbXARPnG
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Jan 2007 10:43:06 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52935 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752055AbXARPnE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jan 2007 10:43:04 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H7ZPh-0002eF-S3; Thu, 18 Jan 2007 10:42:53 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5658B20FBAE; Thu, 18 Jan 2007 10:42:57 -0500 (EST)
To: Alex Riesen <raa.lkml@gmail.com>
Content-Disposition: inline
In-Reply-To: <81b0412b0701180540x15d20453s3dbc0c061fd06d50@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37113>

Alex Riesen <raa.lkml@gmail.com> wrote:
> The _real_ majority of the programmers desperately need a better
> VCS than CVS, SVN, Perforce, SourceSafe, ClearCase, etc.

Yes.  But...

Yesterday I had a conversation with the software configuration
management guy at my day-time-pays-the-bills organization.
They are seriously looking at Perforce and ClearCase, as these are
lightyears ahead of what we have already (PVCS Version Manager).
They also have 1-800-my-vendor telephone numbers which you can
call and scream at someone when the tool corrupts its internal
database[*1*], or when you cannot figure out what the "Checkout"
action in the context menu does[*2*].

However my fellow developers and I use Git.  We export our changes
out to PVCS Version Manager via an *ugly* Perl script that I would
never actually wish on anyone (which is one reason why its not
contributed as git-pvcsexport).  Configuration management guy won't
even look at Git's real strengths as it lacks the all-important
1-800-git-help[*3*] phone number.

Yesterday we spent 4 half-man-days (4 developers working together
all morning) trying to get a configuration of random files from
PVCS Version Manager which compiled.  In Git this would have been as
simple as merging the two topics that management wanted moved to the
next level of testing.  But since our organization doesn't actually
use Git and multiple topics affected the same files, well, yea, it
was a mess.  Unfortunately calling 1-800-my-vendor yields a "don't do
that" from our vendor and nothing more in support.  I'm very glad
we pay them for the privilege of having a 1-800-my-vendor phone
number in our rolodex.  Yesterday it cost us over $1600 in labor.

> Yes. For me and you. One of my coworkers knows nothing about patches,
> but wants (and perfectly able to) review my code. He has usable brains
> and is able to figure out what "+" and "-" is (he has, by now). He hasn't
> even realized that it was an automatically generated information, as
> I sent a patch to him first time, thought it was just a funny way to
> document changes (and was surprised when I told him a patch can be
> applied automatically, even if the original file is not exactly the same).
> But he is a typical windows-trained programmer.

I work with a few people who would rather copy and paste their
changed parts into an email, then color them with pretty colors
like red, green, blue, black, orange in Outlook (and all in the
same email too).  These then get sent to me for code review.

Prior to us using Git it may make some sense, as we did not have
a diff tool available.  Now that everyone is using Git and working
in isolated topic branches (and doing very well with that concept)
I still get these emails.  People seem to have an easy time grasping
the idea that Git is tracking their changes and when combined with
my git-pvcsexport (see above) it just Does The Right Thing(tm)
later on.  But they have a hard time grasping the idea that Git can
export these as a diff, or that they could just push their topic
branch to me so I can pop it open in gitk.  *sigh*


[*1*] This has happened to me with Perforce more than once.  Not a
      happy thought.  Never with Git.

[*2*] Yes, really, some of our version control users have difficulty
      grasping a concept like "checkout".  They *definately* have
      an issue with Git's "checkout -b" concept.

[*3*] Already taken.  Oddly enough by a company that could almost
      be considered to be a competiter to my day-time-pays-the-bills
      organization.
 
-- 
Shawn.
