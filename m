From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: ref name troubles, was Re: [PATCH v2] Introduce %<branch> as
	shortcut to the tracked branch
Date: Thu, 19 Mar 2009 17:40:29 -0700
Message-ID: <20090320004029.GX23521@spearce.org>
References: <200903181448.50706.agruen@suse.de> <20090318182603.GM8940@machine.or.cz> <alpine.DEB.1.00.0903182210310.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903182245280.10279@pacific.mpi-cbg.de> <7vr60ubgul.fsf@gitster.siamese.dyndns.org> <alpine.DEB.1.00.0903182343580.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200121330.10279@pacific.mpi-cbg.de> <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Petr Baudis <pasky@suse.cz>,
	Andreas Gruenbacher <agruen@suse.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 20 01:42:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkSoC-000258-TG
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 01:42:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755824AbZCTAkc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Mar 2009 20:40:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754455AbZCTAkc
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 20:40:32 -0400
Received: from george.spearce.org ([209.20.77.23]:55438 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753407AbZCTAkb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Mar 2009 20:40:31 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id E0C2638221; Fri, 20 Mar 2009 00:40:29 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0903200137230.10279@pacific.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113876>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Fri, 20 Mar 2009, Johannes Schindelin wrote:
> 
> > Just try this:
> > 
> > 	$ git checkout -b %helloworld
> 
> It gets worse.  Much worse.
> 
> Try this (triggered by a comment by Ilari on IRC):
> 
> 	$ git checkout -b '@{1}'
> 
> That _works_! WTH?

'@' is not reserved.  Neither is '{' or '}'.  Neither is
the combination.

Waaaaaay back when I added reflog query syntax I tried to use only
'@', people with branch names like 'foo@bar' made a point that they
didn't want to reserve it.  We stuck the {} in as a "highly unlikely
to conflict with a branch name" and others pointed out most shells
will do fun things with those, but we kept it to avoid ambiguous
meanings of "foo@noon" when foo@noon is already a branch.

Fast-forward more than 2 years, and the "@{...}" syntax is quite
widely used, perhaps more so than "@" in a branch name.  But its
still not reserved.

So yea, you can create a branch named "foo@{1}".

$ git branch foo@{1}
$ git branch
  cache-walk
  foo@{1}
  master
* mergebase-bug
  mw/blame
  rr/compareeditor
  transport-mirror
  worktree-api
  worktree-edit

Yay.

-- 
Shawn.
