From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [WIP] Status update on merge-recursive in C
Date: Sun, 9 Jul 2006 16:41:28 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0607091634010.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.63.0607081840280.29667@wbgn013.biozentrum.uni-wuerzburg.de>
 <1152421230.2103.31.camel@dv>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 09 16:41:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FzaTV-0002lv-8B
	for gcvg-git@gmane.org; Sun, 09 Jul 2006 16:41:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbWGIOla (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 9 Jul 2006 10:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932470AbWGIOla
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Jul 2006 10:41:30 -0400
Received: from mail.gmx.de ([213.165.64.21]:6116 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932465AbWGIOla (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 9 Jul 2006 10:41:30 -0400
Received: (qmail invoked by alias); 09 Jul 2006 14:41:28 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp008) with SMTP; 09 Jul 2006 16:41:28 +0200
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Pavel Roskin <proski@gnu.org>
In-Reply-To: <1152421230.2103.31.camel@dv>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23554>

Hi,

On Sun, 9 Jul 2006, Pavel Roskin wrote:

> Hello, Dscho!
> 
> On Sat, 2006-07-08 at 18:42 +0200, Johannes Schindelin wrote:
> > This is just an update for people being interested. Alex and me were
> > busy with that project for a few days now. While it has progressed nicely,
> > there are quite a couple TODOs in merge-recursive.c, just search for "TODO".
> 
> That's great.  Just a few notes regarding the patch.
> 
> Why do you list "recur" twice in all_strategies in the git-merge.sh?
> The second "recur" should probably be "recursive".

This is just make really, really sure that recursive is not tested, but 
recur. I would be laughed at if I sent a patch for recur and tested in on 
recursive, claiming the patch was fine, right?

Besides, when recur is fixed (for the TODOs as well as for obscure test 
cases), there will be no change to git-merge.sh and git-rebase.sh, because 
recur will be the new recursive.

> Test for Python in the git-rebase.sh is probably wrong.  "recur" doesn't
> need Python - that's the whole point.  In fact, if I build git with
> NO_PYTHON, TEST fails in t3401-rebase-partial.sh

Again, I am not concerned about simple bugs as this right now. I want to 
fix the big things first. Biggest thing right now: reimplement the 
whee^H^H^H^Hread-tree with -i, -m, and no option.

> - variable declarations in the middle of the code (allowed by c99 but
> not by ANSI C) and incomplete function declarations (no "void").  It's
> not C++, let's stick to the C standards.

>From my experience with Java, I know that this declaration in the middle 
of the code can make debugging much easier. That is why they are still 
there. Like Junio said, once the thing is close to finished, we can fix 
these.

> I'm attaching a patch that fixes everything except variable
> declarations.

May I ask you a favour? Can you redo the patch in, say, two weeks? Thank 
you!

> It would be great to have a patch that actually removes the old
> "recursive" and makes the new strategy "recursive".  I understand it's
> the plan, right?

Yes, sir.

Ciao,
Dscho
