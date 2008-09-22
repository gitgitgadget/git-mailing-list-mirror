From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <ukleinek@strlen.de>
Subject: Re: [TopGit PATCH] prev/next/tsort: commands to explore
	dependencies
Date: Mon, 22 Sep 2008 22:10:25 +0200
Message-ID: <20080922201025.GB792@strlen.de>
References: <1221818101-14333-1-git-send-email-bert.wesarg@googlemail.com> <20080922153614.GO10360@machine.or.cz> <36ca99e90809221032x3003c1f7q8ef09cb92a0473ad@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Bert Wesarg <bert.wesarg@googlemail.com>, g@strlen.de
X-From: git-owner@vger.kernel.org Mon Sep 22 22:11:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Khrl0-00048O-5I
	for gcvg-git-2@gmane.org; Mon, 22 Sep 2008 22:11:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751334AbYIVUK2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Sep 2008 16:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751313AbYIVUK2
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Sep 2008 16:10:28 -0400
Received: from Chamillionaire.breakpoint.cc ([85.10.199.196]:35335 "EHLO
	Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751271AbYIVUK2 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Sep 2008 16:10:28 -0400
Received: id: ukleinek by Chamillionaire.breakpoint.cc authenticated by ukleinek with local
	(easymta 1.00 BETA 1)
	id 1Khrjl-0000O4-W0; Mon, 22 Sep 2008 22:10:26 +0200
Content-Disposition: inline
In-Reply-To: <36ca99e90809221032x3003c1f7q8ef09cb92a0473ad@mail.gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96509>

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
> 
> >
> >> III) tg tsort [PATTERN]
> >>      outputs a topological order of all patches starting with PATTERN
> >
> > ...and tg summary (overally, to have a tree view of branches).
> Maybe something like the graph output from git rev-log --graph?
> 
> >> +                                     printf "%s\t%q\n" "${dep_rev}" "${dep}" >&3
> >> +                                     printf "%s\t%s\n" "${topic_rev}" "${dep_rev}"
> >
> > %q?
> 
> "and %q causes printf to output the corresponding argument in  a
> format that can be reused as shell input."
With /bin/sh == dash this doesn't work.  I havn't looked where and how
this is used, but rev-parse has an --sq option that results in the
output being shell quoted.  Maybe this can help?

Best regards
Uwe
