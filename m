From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] git-filter-branch.sh: Allow running in bare
	repositories
Date: Wed, 23 Jul 2008 01:36:52 +0200
Message-ID: <20080722233652.GT10151@machine.or.cz>
References: <20080722223710.29084.61373.stgit@localhost> <alpine.DEB.1.00.0807230025050.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jul 23 01:38:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLRQw-0004ik-8B
	for gcvg-git-2@gmane.org; Wed, 23 Jul 2008 01:38:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759521AbYGVXg4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 19:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759510AbYGVXg4
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 19:36:56 -0400
Received: from w241.dkm.cz ([62.24.88.241]:44320 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758083AbYGVXgz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 19:36:55 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id E96F4393B282; Wed, 23 Jul 2008 01:36:52 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807230025050.8986@racer>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89567>

  Hi,

On Wed, Jul 23, 2008 at 12:27:07AM +0100, Johannes Schindelin wrote:
> On Wed, 23 Jul 2008, Petr Baudis wrote:
> 
> > This also fixes suspicious shell boolean expression during a check
> > for dirty working tree.
> 
> If you are talking about X && Y || Z, it is well established (and should 
> not be suspicious to a shell hacker like the creator of Cogito) that Z is 
> executed if either X fails, or X succeeds and Y fails.

  um, oops. I actually never got to know these by heart since I learnt
to expliciply group the expressions early on. I guess my only excuse is
that I've stumbled at 0bdf93cbf earlier and understood it the _wrong_
way around since I'm getting really sleepy. ;-)

  I still think my change improves the code readibility so it could be
kept, but I'm fairly neutral on this.

> > +test_expect_success 'rewrite bare repository identically' '
> > +	(git config core.bare true && cd .git && git-filter-branch branch)
> > +'
> > +git config core.bare false
> 
> Any reason why this is done outside the test?

  If the test fails in the middle, not resetting this might negatively
affect the rest of the testsuite.

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
