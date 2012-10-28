From: Krzysztof Mazur <krzysiek@podlesie.net>
Subject: Re: Mistake in git-reset documentation
Date: Sun, 28 Oct 2012 15:13:27 +0100
Message-ID: <20121028141327.GB16686@shrek.podlesie.net>
References: <CABPGWqr7=Rq4qS7yP09t2vMBUJ98NFTSmHUUgMzUQ5=WVrjfqg@mail.gmail.com>
 <20121028083610.GA26374@shrek.podlesie.net>
 <20121028110715.GB11434@sigill.intra.peff.net>
 <m2zk36hg0q.fsf@igel.home>
 <20121028134635.GA25519@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Bojan =?iso-8859-2?Q?Petrovi=E6?= <bojan85@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Oct 28 15:13:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TSTcV-0002S6-Q2
	for gcvg-git-2@plane.gmane.org; Sun, 28 Oct 2012 15:13:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608Ab2J1ONb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Oct 2012 10:13:31 -0400
Received: from [93.179.225.50] ([93.179.225.50]:41320 "EHLO shrek.podlesie.net"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1750979Ab2J1ONa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Oct 2012 10:13:30 -0400
Received: by shrek.podlesie.net (Postfix, from userid 603)
	id AE0B859; Sun, 28 Oct 2012 15:13:27 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20121028134635.GA25519@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208547>

On Sun, Oct 28, 2012 at 09:46:35AM -0400, Jeff King wrote:
> On Sun, Oct 28, 2012 at 02:39:49PM +0100, Andreas Schwab wrote:
> 
> > Jeff King <peff@peff.net> writes:
> > 
> > > On Sun, Oct 28, 2012 at 09:36:10AM +0100, Krzysztof Mazur wrote:
> > >
> > >>  DESCRIPTION
> > >>  -----------
> > >> @@ -43,7 +43,7 @@ This means that `git reset -p` is the opposite of `git add -p`, i.e.
> > >>  you can use it to selectively reset hunks. See the ``Interactive Mode''
> > >>  section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
> > >>  
> > >> -'git reset' --<mode> [<commit>]::
> > >> +'git reset' [--<mode>] [<commit>]::
> > >>  	This form resets the current branch head to <commit> and
> > >>  	possibly updates the index (resetting it to the tree of <commit>) and
> > >>  	the working tree depending on <mode>, which
> > >
> > > Should we say something like "if --<mode> is omitted, defaults to
> > > "--mixed"?
> > 
> > Under --mixed it already says "This is the default action", though.
> 
> I know, but that is somewhat buried for somebody who is seeing that the
> "--<mode>" bit is optional and wondering what it means to omit it.
> 

The --mixed mode is also described as second mode, and saying that --mixed
is default earlier may save some time wasted on reading --soft
description.

There is also small inconsequence in what <mode> is, just "mixed" or
"--mixed".

Krzysiek

-- >8 --
Subject: [PATCH] doc: git-reset: make "<mode>" optional

The git-reset's "<mode>" is an optional argument, however it was
documented as required.

The "<mode>" is documented as one of: --soft, --mixed, --hard, --merge
or --keep, so "<mode>" should be used instead of "--<mode>".

Signed-off-by: Krzysztof Mazur <krzysiek@podlesie.net>
---
 Documentation/git-reset.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-reset.txt b/Documentation/git-reset.txt
index 117e374..978d8da 100644
--- a/Documentation/git-reset.txt
+++ b/Documentation/git-reset.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 [verse]
 'git reset' [-q] [<commit>] [--] <paths>...
 'git reset' (--patch | -p) [<commit>] [--] [<paths>...]
-'git reset' (--soft | --mixed | --hard | --merge | --keep) [-q] [<commit>]
+'git reset' [--soft | --mixed | --hard | --merge | --keep] [-q] [<commit>]
 
 DESCRIPTION
 -----------
@@ -43,11 +43,11 @@ This means that `git reset -p` is the opposite of `git add -p`, i.e.
 you can use it to selectively reset hunks. See the ``Interactive Mode''
 section of linkgit:git-add[1] to learn how to operate the `--patch` mode.
 
-'git reset' --<mode> [<commit>]::
+'git reset' [<mode>] [<commit>]::
 	This form resets the current branch head to <commit> and
 	possibly updates the index (resetting it to the tree of <commit>) and
-	the working tree depending on <mode>, which
-	must be one of the following:
+	the working tree depending on <mode>. If <mode> is omitted,
+	defaults to "--mixed". The <mode> must be one of the following:
 +
 --
 --soft::
-- 
1.8.0.47.g5b520ba
