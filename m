From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Android needs repo, Chrome needs gclient. Neither work. What
 does  that say about git?
Date: Tue, 24 Nov 2009 15:45:42 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911241441520.14365@iabervon.org>
References: <2d707e8c-2561-470c-beba-c81e16ac441c@k17g2000yqh.googlegroups.com>  <65e170e70911200251q2ec5ec87rc37577dddfd3317d@mail.gmail.com>  <alpine.DEB.1.00.0911201229080.4985@pacific.mpi-cbg.de>  <65e170e70911222011l776a6aean7bd75f072a806616@mail.gmail.com>
  <20091123135817.GB2532@thunk.org> <65e170e70911231948l3b032dbeu7c99b65ce3ec97ff@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: tytso@mit.edu, git@vger.kernel.org,
	chromium-discuss@googlegroups.com
To: Adrian May <adrian.alexander.may@gmail.com>
X-From: git-owner@vger.kernel.org Tue Nov 24 21:45:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ND2Gj-000655-6i
	for gcvg-git-2@lo.gmane.org; Tue, 24 Nov 2009 21:45:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932827AbZKXUpi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Nov 2009 15:45:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932746AbZKXUph
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Nov 2009 15:45:37 -0500
Received: from iabervon.org ([66.92.72.58]:44360 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932732AbZKXUph (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Nov 2009 15:45:37 -0500
Received: (qmail 31732 invoked by uid 1000); 24 Nov 2009 20:45:42 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 24 Nov 2009 20:45:42 -0000
In-Reply-To: <65e170e70911231948l3b032dbeu7c99b65ce3ec97ff@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133592>

On Tue, 24 Nov 2009, Adrian May wrote:

> > If you don't have bolt-on scripts, and you move that into the the core
> > SCM, then you force *all* projects to use whatever workflow was
> > decided as being the One True Way of doing things as seen by the SCM
> > designer.  So the question is whether the SCM *should* regiment all
> > projects into following the SCM's designers idea of the One True
> > Workflow.
> 
> Of course I'd want the workflow configurable by whoever controls the
> main repository. I couldn't possibly suggest that all git projects
> need the same workflow. The number of developers can vary by five
> orders of magnitude - that calls for different workflow models.
> 
> > Git's approach is to say that it will be fairly flexible about
> > dictating workflow --- who pushs to whom; whether there is a single
> > "star" repository topology, or something that is more flexible, etc.
> > You seem to hate this flexibility, because it makes life harder until
> > you set up these bolt-on scripts.  But that's what many of us like
> > about git; that it doesn't force us (the project lead) into a single
> > way of doing things.
> 
> Leaving aside topology, I suppose we can agree that the subject
> divides into two aspects: offering the developer some optional tools,
> and asserting control over what gets commited to the official repo.
> Perhaps we can also agree that the former belongs under the control of
> the developer and the latter should be in the PM's hands. You seem to
> have opinions about which of these two aspects is more or less
> important, and to what extent git suffices, but I don't. I assume that
> the project manager has his own opinions about both aspects and I'm
> observing two big projects that independantly have augmented git's
> features with their own scripts. Their docs talk about both aspects,
> especially repo's, but they are entirely implemented in
> developer-overridable scripts. So any repo functions to do with the
> second aspect are either features that git needs to grow, or bits of
> the git manual that the repo designer didn't read. I'd kinda like to
> know which.

Repo (and gclient, which claims to be for SVN) seems to be mostly about 
the fact that nothing really handles submodules (independant projects that 
are also parts of larger projects) well. This is a known flaw with git, 
but it's unclear as to whether repo does better. It's probably best to let 
them work out a set of semantics which a real-world, full-scale project is 
happy with, and consider adopting it for native submodules when there's 
real-world positive experience behind it.

The other main thing I see repo doing is interfacing with gerrit, where 
your pushes get redirected, and there are a million review branches you 
can find on a web site, and where the server for a push is different from 
the best server for a mainline fetch. Some of this is probably worth 
having natively, but there's still the case of wanting to fetch a review 
branch based on understanding stuff about gerrit. This is similar to 
wanting to get a SVN revision out of bugzilla; you really want a tool 
that's particular to the integration of the systems you're using, not 
stuff built into your version control system. That said, if the submodule 
stuff were taken care of, Google could provide a git-review program, and 
do everything within the "git ..." wrapper instead of as an outer script.

	-Daniel
*This .sig left intentionally blank*
