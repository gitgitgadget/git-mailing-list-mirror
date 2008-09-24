From: Petr Baudis <pasky@suse.cz>
Subject: Re: [TopGit PATCH] prev/next/tsort: commands to explore
	dependencies
Date: Wed, 24 Sep 2008 17:23:18 +0200
Message-ID: <20080924152318.GX10360@machine.or.cz>
References: <1221818101-14333-1-git-send-email-bert.wesarg@googlemail.com> <20080922153614.GO10360@machine.or.cz> <36ca99e90809221032x3003c1f7q8ef09cb92a0473ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>
X-From: git-owner@vger.kernel.org Wed Sep 24 17:24:35 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KiWEC-000640-9Z
	for gcvg-git-2@gmane.org; Wed, 24 Sep 2008 17:24:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751564AbYIXPXY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Sep 2008 11:23:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751528AbYIXPXY
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Sep 2008 11:23:24 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51867 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750988AbYIXPXX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Sep 2008 11:23:23 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id D34F43939B43; Wed, 24 Sep 2008 17:23:18 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <36ca99e90809221032x3003c1f7q8ef09cb92a0473ad@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96649>

On Mon, Sep 22, 2008 at 07:32:50PM +0200, Bert Wesarg wrote:
> On Mon, Sep 22, 2008 at 17:36, Petr Baudis <pasky@suse.cz> wrote:
> >  Hi,
> >
> > On Fri, Sep 19, 2008 at 11:55:00AM +0200, Bert Wesarg wrote:
> >> I hacked 3 commands to explore the dependencies of TopGit patches:
> >
> >  thanks, the idea of all three commands is good,
> >
> >>   I) tg prev [NAME]
> >>      outputs the dependencies of NAME
> >>
> >>  II) tg next [NAME]
> >>      outputs patches that depends on NAME
> >
> >  but I think it would be cleaner to add this functionality to
> > tg info...
> Right, but 'tg next' is shorter than any 'tg info --next'.

So, an alias? ;-) I wouldn't really like to clutter the UI with many
trivial commands for getting various sort of info. And I mean, ideally
you could just see all this in default 'tg info' output (or for
computationally expensive operations, maybe 'tg info -l'?).

> >
> >> III) tg tsort [PATTERN]
> >>      outputs a topological order of all patches starting with PATTERN
> >
> > ...and tg summary (overally, to have a tree view of branches).
> Maybe something like the graph output from git rev-log --graph?

That would be excellent.

> >> +                                     printf "%s\t%q\n" "${dep_rev}" "${dep}" >&3
> >> +                                     printf "%s\t%s\n" "${topic_rev}" "${dep_rev}"
> >
> > %q?
> 
> "and %q causes printf to output the corresponding argument in  a
> format that can be reused as shell input."
> 
> I thought that this would be needed.

Interesting, I didn't find that in my documentation. But as said later,
this quoting is probably unnecessary.

-- 
				Petr "Pasky" Baudis
People who take cold baths never have rheumatism,
but they have cold baths.
