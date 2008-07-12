From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [JGIT PATCH 1/1] jgit: create a tag command
Date: Sat, 12 Jul 2008 03:01:04 +0000
Message-ID: <20080712030104.GB15838@spearce.org>
References: <200807070041.35873.robin.rosenberg.lists@dewire.com> <200807070116.39892.robin.rosenberg.lists@dewire.com> <e2b179460807100831g5d62a0a8nc7e7bf2715f0b9f1@mail.gmail.com> <20080711020507.GD31862@spearce.org> <e2b179460807110145n4182978awd3aa3f97c3caac95@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	Marek Zawirski <marek.zawirski@gmail.com>, git@vger.kernel.org
To: Mike Ralphson <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jul 12 05:03:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KHVO1-0008CE-Va
	for gcvg-git-2@gmane.org; Sat, 12 Jul 2008 05:03:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751698AbYGLDBH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2008 23:01:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbYGLDBG
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Jul 2008 23:01:06 -0400
Received: from george.spearce.org ([209.20.77.23]:60663 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750938AbYGLDBF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2008 23:01:05 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 3311F38268; Sat, 12 Jul 2008 03:01:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <e2b179460807110145n4182978awd3aa3f97c3caac95@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88216>

Mike Ralphson <mike.ralphson@gmail.com> wrote:
> 2008/7/11 Shawn O. Pearce <spearce@spearce.org>:
> > Mike Ralphson <mike.ralphson@gmail.com> wrote:
> >>
> >> Loving the make_jgit stuff.
> >
> > So making jgit a single stand-alone, portable shell script for
> > command line usage was a good idea?  ;-)
> 
> It certainly seems so to me. It's a nice quick way of seeing what's
> implemented (I was toying with adding a jgit help command which would
> reflect over the TextBuiltins).

Yea, sadly our builtins don't register themselves into a table so its
a bit difficult to enumerate them at this time.  But it probably would
not be a difficult thing to change at all, and since we don't have a
lot of them yet it wouldn't be that much work to do the conversion.
 
> I'm not sure which if any platforms would eventually be better off
> with a commandline jgit than trying to port c-git though.

Not all platforms can compile c git, e.g. they are missing a
c compiler, but have a JRE handy.  Odd, I know, but sometimes
that's how it goes.  Or maybe you have a JRE handy, and want to
just download the single stand-alone jgit jar to get some sort of a
basic git implementation available, so you can clone and build the
real thing direct from Junio's sources.

Or maybe you are using a transport (Amazon S3) that C Git just
doesn't support.  :-)

> > I think we are at the point where we need to either write a
> > #@!*(!@(! command line option parser, import one, or stop writing
> > command line programs.  I would certainly appreciate any opinion
> > you might have on the matter.
> 
> a) is a distraction, c) is a backwards step, so maybe b) wins.

I don't disagree, I thought the very same thing myself.
 
> I don't know what the state of the art of Java option parsers is but
> there is a port of GNU getopt [1] which might drop in quite easily.

So I looked at GNU getopt and its at least smaller than Apache
Commons, and doesn't have this damned-if-you-do, damned-if-you-do
version selection choice they offer their end-users.  But it really
makes building something like an automatic --help difficult if not
impossible, and certainly makes handling numeric vs. ObjectId vs.
String vs. File arguments annoying.

I'd almost rather just do a).  It wouldn't take long to get something
small rolled out and working.  We don't need to support every goddamn
weird syntax that C git supports for backward compatability reasons.

> PS apologies for the patch format, I'm stuck with Outlook or gmail,
> and a recalcitrant firewall for the moment.

Some people are terrified of that system of tubes.  I feel for you.
Day-job is that way.  :-(
 
> [1] http://www.urbanophile.com/arenn/hacking/download.html

-- 
Shawn.
