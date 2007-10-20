From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Proposed git mv behavioral change
Date: Sat, 20 Oct 2007 02:36:28 -0400
Message-ID: <20071020063628.GV14735@spearce.org>
References: <20071019015419.GV14735@spearce.org> <A2C1BF08-4CC8-4F98-9CA8-B81B2FBFE9E4@mit.edu> <20071019031959.GE14735@spearce.org> <20071019032407.GA10622@coredump.intra.peff.net> <7E3647F4-E61C-4FBE-9AA7-81CDBE324308@MIT.EDU> <20071019033500.GB10697@coredump.intra.peff.net> <93BF5798-F1C3-48EE-8233-A0F111BF8138@MIT.EDU> <20071019034704.GB11095@coredump.intra.peff.net> <1192859748.13347.146.camel@g4mdd.entnet> <20071020062400.GA30388@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ari Entlich <lmage11@twcny.rr.com>,
	Michael Witten <mfwitten@MIT.EDU>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 20 08:36:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ij7x4-0006oL-71
	for gcvg-git-2@gmane.org; Sat, 20 Oct 2007 08:36:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760414AbXJTGgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Oct 2007 02:36:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758741AbXJTGgh
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Oct 2007 02:36:37 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:47414 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758341AbXJTGgh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Oct 2007 02:36:37 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Ij7wj-0005re-Al; Sat, 20 Oct 2007 02:36:29 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A037B20FBAE; Sat, 20 Oct 2007 02:36:28 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20071020062400.GA30388@coredump.intra.peff.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61796>

Jeff King <peff@peff.net> wrote:
> No, I meant more that the state you have staged will never have actually
> existed in your working tree, so you could not possibly have tested it.
> However, it may be that the changes you are trying to avoid staging are
> trivial, and you're willing to accept that. And git shouldn't stand in
> your way.
> 
> And it sounds like you don't necessarily want to make a _commit_ out of
> this, you just want to keep working and not have git-mv munge your
> staged state.

Yea, I want the same thing.  :-)

And not because I commit things that weren't tested.  Its because
I do mini code reviews for small hunks at a time.  I stage things
I have looked at, and keep things I'm still unsure about unstaged.
But before I commit I make sure my `git diff` output is empty,
so I know that any tests I do now will match what I have when I
run git-commit.

So lets say I make a change in my Makefile that changes the name
of a source file to be more descriptive of that file's contents.
I've reviewed the Makefile change *and* done the file rename,
but I'm still not done reviewing the stuff in the file.  (Yea,
maybe that should be two different commits, but maybe not, lets
not get into that as it depends very much on context.)

Today I move the file, then unstage the hunks I'm not sure about,
then go back and restage them.  Annoying.  It really disrupts
my workflow.

The killer feature in Git for me is the index.  That sucker saves
me on a daily basis as it lets me organize "this i'm happy with,
this i'm not" while I'm in the middle of making a single new commit.
Today git-mv robs me of it.
 
-- 
Shawn.
