From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [RFC GSoC 2009: git-submodule for multiple, active developers
 on  active trees]
Date: Wed, 1 Apr 2009 02:58:31 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904010247170.10279@pacific.mpi-cbg.de>
References: <526944450903251314o622711b5u3665bac90398d6be@mail.gmail.com>  <20090330153245.GD23521@spearce.org>  <526944450903310830q5f56fe82xb64ae8dc3c954ffb@mail.gmail.com>  <alpine.DEB.1.00.0903311749160.7052@intel-tinevez-2-302> 
 <526944450903311532u24eb74fby1f558c1bef5c653a@mail.gmail.com>  <alpine.DEB.1.00.0904010058490.6616@intel-tinevez-2-302> <526944450903311649q358d43edkf07e2e5058a9e527@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>, git@vger.kernel.org
To: P Baker <me@retrodict.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 02:58:57 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LoomE-0006hg-PA
	for gcvg-git-2@gmane.org; Wed, 01 Apr 2009 02:57:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753882AbZDAA42 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2009 20:56:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753325AbZDAA41
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Mar 2009 20:56:27 -0400
Received: from mail.gmx.net ([213.165.64.20]:47141 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752734AbZDAA40 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2009 20:56:26 -0400
Received: (qmail invoked by alias); 01 Apr 2009 00:56:17 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp029) with SMTP; 01 Apr 2009 02:56:17 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19F1AB9BNhFwFoRdG6dybDnzAF5Izv4uew3ZgdkJu
	IS94rhxz0II4g/
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <526944450903311649q358d43edkf07e2e5058a9e527@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.53
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115335>

Hi,

On Tue, 31 Mar 2009, P Baker wrote:

> I'll paraphrase to see if I understand your points:
> 
> *Moving objects from submodule .git directories into the base .git/
> directory would protect the submodules and is a good idea.

No, I did not say that.

I said that moving submodules' working directory need to protected when 
renaming/deleting submodules.

Even worse, I think that moving the .git/ directory into the 
superproject's .git/ would be at least quite a bit awkward in the nested 
case.

> *Moving to a .git/ file from .gitmodules should be taken off of the
> goal list (I went back and read this thread:
> http://thread.gmane.org/gmane.comp.version-control.git/78605; seemed
> to clear things up).

Can't follow links here, as I am reading this offline, so cannot comment.

> *git submodule recurse would be a good option (not as a default), if
> the remaining issues are resolved.

Definitely.

> *It would be a good idea for git submodule to work with foreign VCS,
> through Daniel's patches.

But that would not only apply to submodules, but rather all repositories, 
to the point that "git submodule" does not need any change.

> I appreciate the guidance, it's helping me to see that some of this work 
> has already been done, it needs to be finished and pushed into a public 
> release. As an intense user of submodules, what does it do poorly/not do 
> for your needs?

One gripe I have, but which should be rather easy to fix: "git checkout -- 
submodule/" does not update the index, last time I checked.  (It correctly 
does not touch the submodule's working directory.)

Another one: The most common mistake with submodules is to commit and push 
the superproject, after having committed (but not pushed) in the 
submodule.  Not sure how that could be helped.

Further, often it would come in rather handy to be able to say something 
like "git diff $REVISION_AS_COMMITTED_IN_THE_SUPERPROJECT" from within 
the submodule...

git submodule summary should output to the pager by default.

Oh, and it would not hurt performance on Windows at all if git-submodule 
would be finally made a builtin.

Ciao,
Dscho
