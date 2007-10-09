From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Trying to use git-filter-branch to compress history by removing
 large, obsolete binary files
Date: Tue, 9 Oct 2007 11:37:26 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710091133580.4174@racer.site>
References: <51419b2c0710071500x318ee734n9db6ca9e6daa3196@mail.gmail.com>
 <Pine.LNX.4.64.0710080018270.4174@racer.site>
 <51419b2c0710071624v79dc02d2g35a265add50dd46d@mail.gmail.com>
 <Pine.LNX.4.64.0710080028301.4174@racer.site>
 <51419b2c0710071638p6dcc0c7cm2a813c22758e6f32@mail.gmail.com>
 <Pine.LNX.4.64.0710080129480.4174@racer.site> <20071008010033.GA25654@fieldses.org>
 <Pine.LNX.4.64.0710080204140.4174@racer.site> <4709CCB2.4000202@viscovery.net>
 <20071008143650.GC2902@fieldses.org> <20071008163701.GA5868@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Elijah Newren <newren@gmail.com>,
	Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 09 12:38:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IfCTi-0004FR-01
	for gcvg-git-2@gmane.org; Tue, 09 Oct 2007 12:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbXJIKiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Oct 2007 06:38:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751788AbXJIKiH
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Oct 2007 06:38:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:40998 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751589AbXJIKiG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Oct 2007 06:38:06 -0400
Received: (qmail invoked by alias); 09 Oct 2007 10:38:02 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp058) with SMTP; 09 Oct 2007 12:38:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18MCwgw8SgML7G4VC6mvkuJk1D3QWXQxtFBSm0jah
	wB65vVozfEoTu8
X-X-Sender: gene099@racer.site
In-Reply-To: <20071008163701.GA5868@thunk.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60381>

Hi,

On Mon, 8 Oct 2007, Theodore Tso wrote:

> On Mon, Oct 08, 2007 at 10:36:50AM -0400, J. Bruce Fields wrote:
> > Having it by default leave these backups around, even when everything
> > succeeds, makes for unnecessary cleanup work in the normal case, and is
> > inconsistent with the behavior of other git commands that destroy or
> > rewrite history.
> 
> I think what makes git-filter-branch different is that you can change a 
> large amount of history with git-filter-branch, including large numbers 
> of tags, etc.  The reflog is quite sufficient to recover from a screwed 
> up "git commit --amend".
>
> [...]
>
> But I don't think the reflog is going to be sufficient given the kinds 
> of changes that git-filter-branch can potentially do to your repository.

FWIW after reading Bruce's reasoning, I tend towards having no "backups" 
by default (I say "backups", since they are _only_ written when the 
respective branch has changed).

And I do not think that the config variable is a good approach; if you 
want backups or not is a per-case decision.  So your proposal would only 
result in even more confusion.

My preference ATM is to write nothing per default, but only when 
--original <namespace> was given.

Ciao,
Dscho
