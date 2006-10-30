X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Theodore Tso <tytso@mit.edu>
Subject: Re: VCS comparison table
Date: Sun, 29 Oct 2006 19:10:35 -0500
Message-ID: <20061030001035.GA15753@thunk.org>
References: <200610270202.k9R22Wxf004208@laptop13.inf.utfsm.cl> <4541D291.5020205@op5.se> <20061027144656.GA32451@fieldses.org> <m3mz7gheoe.fsf@iny.iki.fi> <ehvnal$tjg$1@sea.gmane.org> <m3fyd77gsn.fsf@iny.iki.fi> <ei2563$m1u$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Mon, 30 Oct 2006 00:10:50 +0000 (UTC)
Cc: git@vger.kernel.org, bazaar-ng@lists.canonical.com
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <ei2563$m1u$1@sea.gmane.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30475>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeKjl-0006Zp-VY for gcvg-git@gmane.org; Mon, 30 Oct
 2006 01:10:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030478AbWJ3AKm (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 29 Oct 2006
 19:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030476AbWJ3AKm
 (ORCPT <rfc822;git-outgoing>); Sun, 29 Oct 2006 19:10:42 -0500
Received: from thunk.org ([69.25.196.29]:650 "EHLO thunker.thunk.org") by
 vger.kernel.org with ESMTP id S1030477AbWJ3AKl (ORCPT
 <rfc822;git@vger.kernel.org>); Sun, 29 Oct 2006 19:10:41 -0500
Received: from root (helo=candygram.thunk.org) by thunker.thunk.org with
 local-esmtps  (tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1
 (Debian)) id 1GeKmk-00045y-1S; Sun, 29 Oct 2006 19:13:50 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
 (envelope-from <tytso@thunk.org>) id 1GeKjb-0007LM-Ry; Sun, 29 Oct 2006
 19:10:35 -0500
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Sun, Oct 29, 2006 at 01:01:07PM +0100, Jakub Narebski wrote:
> > You can give Bazaar for me, a bk user, and I can understand what to do
> > with the branches that are like bk clones. (The repository stuff is
> > later development and still optional.) Switching a CVS environment to
> > Bazaar one can be done so that most of the users can be just told to
> > use bzr checkout and they don't have to care about pushing.
> 
> That is of course because you are familiar with branch-centric distributed
> SCM, namely BitKeeper, when trying Bazaar-NG. IMHO branch-centric view
> is somewhat limiting; you can always use repository-centric SCM with
> one-live-branch-per-repository paradigm and emulate branch-centric SCM,
> which is not (or not always) the case for branch-centric SCM. Branch-centric
> and repo-centric SCM promote different workflows, namely parallel uncommited
> work on few development branches for branch-centric SCM, one-change
> per-commit multiple temporary and feature branches for repo-centric SCM.

I've got to disagree here.  Being a former bitkeeper user myself, I
find BZR-NG to be nothing like bk.  In particular, Bitkeeper is *not*
branch-centric the way that BZR is; in fact, bk is much closer to git
and bk both in terms of how it works and its terminology.  You can
have a non-linear set of history without using any "branches" in both
bk and mercurial, simply by creating two commits changing different
files in two different repositories (using the bk, git, and hg sense
of the word --- only bzr attaches a completely different definitoin to
term "repository"), and then pull them together.   

With bzr, the only way you can do the following is by explicitly
creating a separate branch and then merging the two branches together.
In bzr --- unlike bk, git, and hg --- when you are on a "branch" the
history must be completely linear.  The difference between bk, and git
and hg, is that bk enforces a restriction that there must be one
"head", or "tip" on a particular repository (in the bk, hg, and git
sense).  So if you start by cloning the repository A -> B, and then
make one or more commits in repository A, and then one or more commits
in repository B, when you pull from repository B to A, bk will enforce
the creation of a merge changeset on the resulting repository --- or
fail the merge.  (Actually, with BK there was the option to create
multiple tips using "lines of development", but it was never fully
developed or supported.)

With hg and git, you have the *option* of pulling the two lines of
commits together using a merge changeset *or* leaving the two "tips"
or "heads" unmerged.  But that's only a very minor difference between
bk and hg/git --- and if you are willing to always merge two heads
after pulling so that your git or hg repository only has one head/tip,
then conceptually the changeset history is just like bk.

In contrast, it's impossible to do this with bzr without leaving the
named branches around, so in this sense it's quite different form BK.

						- Ted

P.S.  I'm going to teaching a class entitled "Bzr, Hg, and Git, Oh
my!" at LISA conference in Washington, D.C.  It's only a half-day
tutorial intending to cover the basics of Distributed SCM systems, so
most folks on this list will probably know everything I'm planning on
discussing, but if you have some colleagues who need a gentle
introduction, please feel tell them to head on over to the LISA
conference website at www.usenix.org.
