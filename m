From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git submodules
Date: Mon, 28 Jul 2008 23:04:49 -0700
Message-ID: <20080729060449.GG11947@spearce.org>
References: <20080728162003.GA4584@artemis.madism.org> <320075ff0807281323l51bb6478j30e3e4c490974a70@mail.gmail.com> <20080728205545.GB10409@artemis.madism.org> <20080728205923.GC10409@artemis.madism.org> <32541b130807281440v64f3cb9ci50cf6d16be4f2f82@mail.gmail.com> <b3889dff0807282251t7096a8c9wf477cf4495749d34@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	Nigel Magnay <nigel.magnay@gmail.com>,
	Git ML <git@vger.kernel.org>
To: Benjamin Collins <aggieben@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 29 08:05:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNiLO-0006gJ-Su
	for gcvg-git-2@gmane.org; Tue, 29 Jul 2008 08:05:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbYG2GEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2008 02:04:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750952AbYG2GEv
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Jul 2008 02:04:51 -0400
Received: from george.spearce.org ([209.20.77.23]:56107 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbYG2GEu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2008 02:04:50 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id B00CF383A5; Tue, 29 Jul 2008 06:04:49 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <b3889dff0807282251t7096a8c9wf477cf4495749d34@mail.gmail.com>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90586>

Benjamin Collins <aggieben@gmail.com> wrote:
> On Mon, Jul 28, 2008 at 4:40 PM, Avery Pennarun <apenwarr@gmail.com> wrote:
> >
> > > One irritating problem with submodules, is
> > > that when someone else commited, and that you git submodule update,
> > > you're on a detached head. Absolutely horrible.
> >
> > I think that roughly everyone agrees with the above statement by now.
> > It would also be trivial to fix it, if only we knew what "fix" means.
> > So far, I haven't seen any good suggestions for what branch name to
> > use automatically in a submodule, and believe me, I've been looking
> > for one :)
> 
> I disagree with this completely. I think the detached head is
> actually fantastic [...]

Ditto with Benjamin.  Detached head is a fantastic idea.

> [...] because it tells you all the right things:
> a) the branch your submodule is on is ultimately irrelevant
> b) it reminds you that this is not your project.  It's part of your
> project managed in a special way by Git, but your project is in ..
> c) if you want to do work in this part of your project that comes from
> somewhere else, you need to be thoughtful about how you manage its
> branches.
> 
> I try to keep all my submodules on (no branch) as much as possible.
> In a way, I feel like that kind of relieves me of the chore of keeping
> mapping superproject branches to submodule branches in my head.

At my former day-job we wrote our own "git submodule" in our
build system before gitlink was available in the core, let alone
git-submodule was a Porcelain command.

Many developers who were new to Git found having a sea of 11 Git
repositories+working directories in a single build area difficult to
manage.  They quickly found the detached HEAD feature in a submodule
to be a really handy way to know if they made changes there or not.

Most of our developers also modified __git_ps1() in their bash
completion to use `git name-rev HEAD` to try and pick up a remote
branch name when on a detached HEAD.  This slowed down their bash
prompts a little bit, but they found that "origin/foo" hint very
valuable to let them know they should start a new branch before
making changes.

So I'm just echoing what Benjamin said above, only we did it
independently, and came to the same conclusion.

-- 
Shawn.
