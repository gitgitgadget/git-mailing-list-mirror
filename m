From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Fake linear history in a deterministic manner.
Date: Thu, 16 Feb 2006 14:29:57 -0800
Message-ID: <20060216222956.GA5818@Muzzle>
References: <46a038f90602121746v5adb448ej73cc2be6dd3745ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Paul Mackerras <paulus@samba.org>
X-From: git-owner@vger.kernel.org Thu Feb 16 23:30:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9rdS-0007uC-Mw
	for gcvg-git@gmane.org; Thu, 16 Feb 2006 23:30:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWBPWaA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 17:30:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbWBPW37
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 17:29:59 -0500
Received: from hand.yhbt.net ([66.150.188.102]:22168 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1750744AbWBPW37 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Feb 2006 17:29:59 -0500
Received: from mayonaise.dyndns.org (user-118bgak.cable.mindspring.com [66.133.193.84])
	by hand.yhbt.net (Postfix) with SMTP id 536202DC08D;
	Thu, 16 Feb 2006 14:29:57 -0800 (PST)
Received: by mayonaise.dyndns.org (sSMTP sendmail emulation); Thu, 16 Feb 2006 14:29:57 -0800
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90602121746v5adb448ej73cc2be6dd3745ce@mail.gmail.com>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16315>

Martin Langhoff <martin.langhoff@gmail.com> wrote:
> To emulate `cvs log somepath` I need to munge history to look linear.
> I am working on the theory that I will tell the cvs client about *one*
> linear history, and show merges from parallel histories as a merge
> commit, "flattened" so to speak, and with a commit message where I'll
> list the hash and first line of each commit that it involves.

I'd be interested in exporting from git to SVN with something like this.

> I thought briefly about delaying the decision until I see the merge,
> and pick the leftmost, or rightmost, if there is some bias in
> git-merge or cg-merge on putting whatever origin has on a particular
> side. It'd mean running backwards through history and that the very
> last merge can flip the decision entirely. Hmmm... any strategy I can
> come up with means that each new merge throws the dice again entirely.
> 
> Ideas?

I'd actually like to do this interactively in gitk.  Just browse history
visually and pick the path you want to choose each time there's a merge,
and then having it output the revisions to stdout or saved to a file
after you're done picking.  Ideally you'd be able to use saved output
interactively, as well.

-- 
Eric Wong
