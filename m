From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC GSoC 2009: git-submodule for multiple, active developers
 on  active trees]
Date: Wed, 1 Apr 2009 18:10:41 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904011806330.13502@intel-tinevez-2-302>
References: <526944450903251314o622711b5u3665bac90398d6be@mail.gmail.com>  <20090330153245.GD23521@spearce.org>  <526944450903310830q5f56fe82xb64ae8dc3c954ffb@mail.gmail.com>  <alpine.DEB.1.00.0903311749160.7052@intel-tinevez-2-302> 
 <526944450903311532u24eb74fby1f558c1bef5c653a@mail.gmail.com>  <alpine.DEB.1.00.0904010058490.6616@intel-tinevez-2-302>  <526944450903311649q358d43edkf07e2e5058a9e527@mail.gmail.com>  <alpine.DEB.1.00.0904010247170.10279@pacific.mpi-cbg.de>
 <526944450903311947w2f398c71n95a4a7aa47ecdb7f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: P Baker <me@retrodict.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 18:13:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lp33o-0003vv-IM
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 18:13:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763991AbZDAQKs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Apr 2009 12:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763711AbZDAQKr
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Apr 2009 12:10:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:55205 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1761604AbZDAQKq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Apr 2009 12:10:46 -0400
Received: (qmail invoked by alias); 01 Apr 2009 16:10:42 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp056) with SMTP; 01 Apr 2009 18:10:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/N89pRSdvNgzFrr4thdVBDt4kLgO/FsefXfn3BQP
	kdf1icu9wlvCTp
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <526944450903311947w2f398c71n95a4a7aa47ecdb7f@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115396>

Hi,

On Tue, 31 Mar 2009, P Baker wrote:

> >  > *Moving objects from submodule .git directories into the base .git/ 
> >  > directory would protect the submodules and is a good idea.
> >
> > No, I did not say that.
> >
> >  Even worse, I think that moving the .git/ directory into the 
> >  superproject's .git/ would be at least quite a bit awkward in the 
> >  nested case.
> >
> 
> Tthe initial prompt for the proposal was: "Rewrite git-submodule,
> placing the repository for each referenced submodules in the
> superproject's $GIT_DIR/modules...This resolves issues related to
> switching between versions of the superproject..." The prompt, and
> past experience with git, helped me to form my proposal which it seems
> would fix numerous problems with git submodule, with the implied cost
> of some awkwardness/complexity. Am I misunderstanding the prompt? Or
> do you think this could be accomplished more elegantly?

Well, I think the focus here is wrong.  The focus should be on the working 
directory as hinted here:

> >  I said that moving submodules' working directory need to protected 
> >  when renaming/deleting submodules.
> 
> I'm sorry, I still don't understand. Where would this occur? What is 
> being protected? What is the submodules' working directory? I'm still 
> learning the intricacies of git, so I'd appreciate any pointers you can 
> give.

If your superproject deletes a submodule, what should happen with the 
working directory?

And what should happen if the submodule is _moved_?  (Which is not as 
easily detected as with renamed files or directories.)

> >  Further, often it would come in rather handy to be able to say 
> >  something like "git diff $REVISION_AS_COMMITTED_IN_THE_SUPERPROJECT" 
> >  from within the submodule...
> >
> 
> That sounds complex, and would break expectations. This would only
> work if git in the submodule working directory knows its a submodule.

... or can detect easily that it is a submodule.

> Is there a way to reference it's super project?

No.

> >  Oh, and it would not hurt performance on Windows at all if 
> >  git-submodule would be finally made a builtin.
> 
> You mean rewriting git-submodule.sh in C? What other impacts might that 
> have?

Junio would hate it, I am sure.

Ciao,
Dscho
