From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] git-filter-branch: avoid collisions with variables in
	eval'ed commands
Date: Wed, 25 Mar 2009 22:58:48 +0100
Message-ID: <20090325215848.GV8940@machine.or.cz>
References: <1238015581-12801-1-git-send-email-newren@gmail.com> <20090325212403.GU8940@machine.or.cz> <51419b2c0903251433s75775206x556fc2d65a347d7d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de, gitster@pobox.com
To: Elijah Newren <newren@gmail.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 23:00:26 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lmb97-0005LD-Qb
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 23:00:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753667AbZCYV64 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 17:58:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753468AbZCYV6z
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 17:58:55 -0400
Received: from w241.dkm.cz ([62.24.88.241]:57911 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752920AbZCYV6y (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 17:58:54 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 361BC1E4C02E; Wed, 25 Mar 2009 22:58:48 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <51419b2c0903251433s75775206x556fc2d65a347d7d@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114682>

On Wed, Mar 25, 2009 at 03:33:31PM -0600, Elijah Newren wrote:
> Hi,
> 
> On Wed, Mar 25, 2009 at 3:24 PM, Petr Baudis <pasky@suse.cz> wrote:
> > On Wed, Mar 25, 2009 at 03:13:01PM -0600, newren@gmail.com wrote:
> >> From: Elijah Newren <newren@gmail.com>
> >>
> >> Avoid using simple variable names like 'i', since user commands are eval'ed
> >> and may clash with and overwrite our values.
> >>
> >> Signed-off-by: Elijah Newren <newren@gmail.com>
> >
> > Almost-acked-by: Petr Baudis <pasky@suse.cz>
> >
> > But:
> >
> >>-i=0
> >>+git_filter_branch_count=0
> >
> > Why branch_count? It counts commits, not branches, doesn't it?
> 
> Oh, I was just changing i->git_filter_branch_i, then thought as long
> as it was long I might as well use a word instead of "i".  Didn't
> think about the combined meaning.  How about
> "git_filter_branch_commit_count"?  Maybe a double underscore between
> the "namespace" and the "variable"?

Oh, I sort of thought it's "git-filter branch count", not
"git-filter-branch count". I'm dumbed down from all day spent in IKEA
I guess. :/

I'd personally just use $__git_i, $__git_commit or something, but YMMV.

-- 
				Petr "Pasky" Baudis
The average, healthy, well-adjusted adult gets up at seven-thirty
in the morning feeling just terrible. -- Jean Kerr
