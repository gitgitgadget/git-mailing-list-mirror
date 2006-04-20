From: Junio C Hamano <junkio@cox.net>
Subject: Re: Branch metainformation
Date: Thu, 20 Apr 2006 03:18:21 -0700
Message-ID: <7vwtdkzh1u.fsf@assigned-by-dhcp.cox.net>
References: <e27dqv$u6f$1@sea.gmane.org>
	<Pine.LNX.4.63.0604201131240.9099@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 20 12:18:31 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FWWF1-0006SN-9M
	for gcvg-git@gmane.org; Thu, 20 Apr 2006 12:18:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750836AbWDTKSY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 20 Apr 2006 06:18:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWDTKSY
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Apr 2006 06:18:24 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:59634 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750836AbWDTKSX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Apr 2006 06:18:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060420101822.EAUM20694.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 20 Apr 2006 06:18:22 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18963>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> However, this all depends on my (rejected) patch to move the remotes 
> information into the config file.

You seem to keep saying rejected, but IIRC you did not finish it
IOW the patch was not ready to be merged.  I do not recall, for
example, reading the part that touches git-parse-remote or
git-fetch to read from the config, but it was a long time ago
and my recollection is vague.

While we are talking about per branch property, some issues
raised on the list (and #git) recently would be helped by a
convention (and perhaps some core side support) for per-branch
property.  Here is a short list.

 + When I am on branch X, I would want "git pull" to pull
   (i.e. fetch and merge) from repository Y, not always "origin".

 + When I am on branch X, I would want "git push" to push to
   repository Y (we do not even use "origin" as the default for
   push).

 + This branch is not to be rebased (you could do this using
   custom pre-rebase hook but having a standard "branch property"
   would make it easy for such a hook to decide.

 - Do not merge and base your work on this branch -- this is
   "view only" and unstable (e.g. "pu" in git.git).

If we were to do a remote to config reorganization (for that we
need a migration plan and a period that we support both), the
per-branch configuration should be designed to support at least
the commonly asked ones.
