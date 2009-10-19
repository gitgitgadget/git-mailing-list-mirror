From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: denying branch creation in a shared repository
Date: Mon, 19 Oct 2009 14:00:17 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0910191353080.4985@pacific.mpi-cbg.de>
References: <ee22b09e0910190132u20931fb4i6a98fb87582a9e56@mail.gmail.com>  <alpine.DEB.1.00.0910191155310.4985@pacific.mpi-cbg.de> <26ae428a0910190308t3233debdjfc0c8beedb9c0ac6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Mohit Aron <mohit.aron@gmail.com>, git@vger.kernel.org
To: Howard Miller <howard@e-learndesign.co.uk>
X-From: git-owner@vger.kernel.org Mon Oct 19 13:57:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mzqrr-0004L1-Nu
	for gcvg-git-2@lo.gmane.org; Mon, 19 Oct 2009 13:57:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755153AbZJSL51 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Oct 2009 07:57:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754774AbZJSL5Z
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Oct 2009 07:57:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:51565 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755088AbZJSL5X (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Oct 2009 07:57:23 -0400
Received: (qmail invoked by alias); 19 Oct 2009 11:57:26 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp050) with SMTP; 19 Oct 2009 13:57:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18llXtNvY4leepiExZV2WahSqkFCTOpoKml2xKjzR
	voJzpPEmYpO/pj
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <26ae428a0910190308t3233debdjfc0c8beedb9c0ac6@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/130692>

Hi,

first, if you want to be taken seriously, you might want to avoid to 
top-post.

Second, do diligent research (e.g. on the 'mob' user).

On Mon, 19 Oct 2009, Howard Miller wrote:

> I'm quite interested in this too but I can't see what that patch does at 
> all. I'm unsure what the 'mob' account is but a search suggests it's 
> something to do with anonymous access, which doesn't seem to make any 
> sense.

If this trivial script (_not_ a patch! This should be obvious at first 
sight) does not make any sense to you, I fear you will not be able to use 
hooks to do what you want to do.

> Can you explain?

Yes.

The 'mob' user (who is password-less) can push to the 'mob' branch _iff_ 
that exists.  IOW a user of repo.or.cz can decide to let random people to 
push commits by creating the 'mob' branch and adding the 'mob' user to the 
pushers.

The first part of the hook (as you can see from the pretty helpful error 
messages it outputs) is about denying to push to anything but the mob 
branch.

The second part is much more interesting in the context of this thread 
(and I would expect anyone capable of reading shell scripts to see that 
readily), because it denies the 'mob' user to _create_ the 'mob' branch.  
See line 16ff.

So the point is: the update hook gets a "$2" = 0000... in case a branch is 
about to be created, and the hook can prevent that by exiting with a 
non-zero exit code.

Hth,
Dscho
