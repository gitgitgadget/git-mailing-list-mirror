From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Document what the stage numbers in the :$n:path syntax mean.
Date: Mon, 20 Aug 2007 02:13:30 -0400
Message-ID: <20070820061330.GB27913@spearce.org>
References: <7v1we5bvbw.fsf@assigned-by-dhcp.cox.net> <20070814231422.GA10662@pe.Belkin> <7vps1paceh.fsf@assigned-by-dhcp.cox.net> <46C90C46.1030000@midwinter.com> <20070820055221.GA22993@coredump.intra.peff.net> <20070820060522.GA27913@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Grimm <koreth@midwinter.com>,
	Junio C Hamano <gitster@pobox.com>,
	Chris Shoemaker <c.shoemaker@cox.net>, git@vger.kernel.org,
	Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Aug 20 08:13:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IN0WH-0006m9-R2
	for gcvg-git@gmane.org; Mon, 20 Aug 2007 08:13:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbXHTGNl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Aug 2007 02:13:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751080AbXHTGNl
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Aug 2007 02:13:41 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:40001 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750948AbXHTGNk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Aug 2007 02:13:40 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IN0W4-0007e3-1y; Mon, 20 Aug 2007 02:13:32 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id ED86E20FBAE; Mon, 20 Aug 2007 02:13:30 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070820060522.GA27913@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56174>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Jeff King <peff@peff.net> wrote:
> > On Mon, Aug 20, 2007 at 11:36:38AM +0800, Steven Grimm wrote:
> > 
> > > The git-rev-parse manpage talks about the :$n:path notation (buried deep in
> > > a list of other syntax) but it just says $n is a "stage number" -- someone
> > > who is not familiar with the internals of git's merge implementation is
> > > never going to be able to figure out that "1", "2", and "3" mean what Junio
> > > said.
> > 
> > I often forget which number corresponds to which source. I seem to
> > recall somebody proposing :ours:$path a while ago, but I couldn't find
> > any reference in the archive, so perhaps I just dreamed it.
> > 
> > Am I the only one who messes this up? If not, patch is below.
> 
> Maybe.  ;-)
> 
> I've memorized it long long ago.  But my coworkers haven't and always
> get it wrong, and look at me funny when I tell them "trust me, your
> data is in stage 2 and theirs is in stage 3...  because that's the
> convention all of the tools you are using follows".

Actually, what's wrong with the following:

	git show HEAD:foo.c
	git show MERGE_HEAD:foo.c

?

That gives you yours (HEAD) and theirs (MERGE_HEAD).  And it doesn't
abuse sha1_file.c.  Granted it only works during a true merge and
doesn't work during a rebase, but remember I just pointed out life
is backwards anyway during a rebase, so uh, yea...

-- 
Shawn.
