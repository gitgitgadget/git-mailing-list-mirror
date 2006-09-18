From: Shawn Pearce <spearce@spearce.org>
Subject: Re: [PATCH] Contributed bash completion support for core Git tools.
Date: Mon, 18 Sep 2006 13:55:09 -0400
Message-ID: <20060918175509.GD31140@spearce.org>
References: <20060918004831.GA19851@spearce.org> <20060918083114.GQ20913@albany.tokkee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 18 19:56:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPNLD-0007yJ-Ls
	for gcvg-git@gmane.org; Mon, 18 Sep 2006 19:55:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751868AbWIRRzR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Sep 2006 13:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751869AbWIRRzR
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Sep 2006 13:55:17 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49618 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751868AbWIRRzP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Sep 2006 13:55:15 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GPNKj-0001qI-KE; Mon, 18 Sep 2006 13:55:05 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CD7ED20E48E; Mon, 18 Sep 2006 13:55:09 -0400 (EDT)
To: Sebastian Harl <sh@tokkee.org>
Content-Disposition: inline
In-Reply-To: <20060918083114.GQ20913@albany.tokkee.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27254>

Sebastian Harl <sh@tokkee.org> wrote:
> Hi,
> 
> > This is a set of bash completion routines for many of the
> > popular core Git tools.  I wrote these routines from scratch
> > after reading the git-compl and git-compl-lib routines available
> > from the gitcompletion package at http://gitweb.hawaga.org.uk/
> > and found those to be lacking in functionality for some commands.
> 
> Did you talk to Ben Clifford (the maintainer of these scripts) before?

No.  I found his scripts yesterday, played around with them for
about 15 minutes and found them to be missing some features.
In particular they don't actually list all branch names as they
only list only those contained directly in refs/heads.  This is
certainly very annoying when your topic branch policy uses "sp/",
"jh/", "lt/" as branch name prefixes.  It also won't work with Linus'
new packed ref format...

Ben's scripts also don't always complete tags at points where Git
accepts a tag, nor can they complete through a path with git diff
or git cat-file to yank a file out of another branch which doesn't
exist in the current working directory.  They also can't complete
branch names in a remote repository when you are fetching or pushing.

So I set out to write my own, finished it in less than an hour,
used it for 4 hours while doing some merging, and sent an email to
put the script into contrib.  :-)

> His scripts seem to be in pretty wide-spread use already, so it might
> make sense to join efforts and improve his scripts (and get them
> into git-core).

Agreed.  There may be a few things my script is lacking but I
think the one I sent yesterday is already more powerful than Ben's.
But I'd like to see it be smarter about completion context and do
even more.  But right now I'm happy as it can complete my topic
branch names and tag names.

I'd like to see core Git at least carry the completion for core Git.
I know Ben has support for StGit and Cogito as well; two packages
that my script doesn't support.  In my humble opnion the completion
scripts should migrate into the packages they support.  I don't
think its unreasonable to expect bash completion support to be part
of a popular package which is heavily dependent on the shell for
its user interface[*1*].

> > Consequently there may be some similarities but many differences.
> 
> Do you know of any (incompatible) differences?

None that I can think of.  I believe that my script will complete
anything Ben's does with the exception of a stray single character
option here or there.

You can't load both into your shell at the same time as bash will
only accept one completion function for any given command and both
packages use the same function names to implement the completion
logic.


[*1*] So long as there is someone to maintain it anyway.  :-)

-- 
Shawn.
