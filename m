From: Paul Mackerras <paulus@samba.org>
Subject: Re: Regarding gitk
Date: Sat, 14 May 2005 17:47:31 +1000
Message-ID: <17029.44307.356844.438027@cargo.ozlabs.ibm.com>
References: <20050513051923.GA15116@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 09:48:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWrNR-0004hc-MP
	for gcvg-git@gmane.org; Sat, 14 May 2005 09:48:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbVENHr5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 03:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262704AbVENHr5
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 03:47:57 -0400
Received: from ozlabs.org ([203.10.76.45]:17296 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262702AbVENHrl (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2005 03:47:41 -0400
Received: by ozlabs.org (Postfix, from userid 1003)
	id EAC8967B34; Sat, 14 May 2005 17:47:38 +1000 (EST)
To: Tejun Heo <htejun@gmail.com>
In-Reply-To: <20050513051923.GA15116@htj.dyndns.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi Tejun,

>  First of all, thanks a lot for gitk.  I was working on something using
> graphviz/pygtk to do about the same thing for a couple of weeks (and got
> pretty far with it) but ditched it as gitk seemed much better.  I really
> love how gitk shows the commit graph. :-)

Yes, I was pleased with how it turned out.

>  As I don't wanna ditch any more of my time, it would be great if you
> let me know what you're currently working on, so that I can coordinate
> with you.  Here are the things I have on mind.
> 
> * integrate two-way diff view w/ diff map into gitk from mgdiff.

I guess mgdiff and dirdiff do very similar things, although dirdiff
can display the diffs between up to 5 trees (limited mainly by the
number of easily distinguishable colors between red and green).  Doing
3-way diffs is useful for most merges (diffing the output vs. the
inputs) and for diffing two arbitrary commits (diffing the two vs. the
nearest common ancestor).

I recently changed dirdiff to be able to diff git commits with each
other or the working directory, and I was intending to add a way to
invoke that from gitk.

> * show the current cache and working files at the head of graph

Interesting idea.  I had mostly been thinking of gitk in terms of the
way I use it, which is to help me follow what others are doing rather
than looking at what I have done.

> * demand-load commits as the user scrolls down the graph

It would be nice to at least be a bit asynchronous, so that the graph
is drawn as the commits are read, rather than having to wait for all
the commits are read before anything is drawn.  I need to hack
git-rev-tree, I guess.

>  I wrote a commit viewing utility (gitkdiff) modified from mgdiff two
> weeks ago so I'm quite familiar with mgdiff source, and implemented
> demand-loading of commits in my own project in python, but writing a
> separate c utility with the same algorithm wouldn't take that much time.

Does that algorithm let you say "commits reachable from A but not from
B" like git-rev-tree does?

Regards,
Paul.
