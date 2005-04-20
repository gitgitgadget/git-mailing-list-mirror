From: "C. Scott Ananian" <cscott@cscott.net>
Subject: Re: [PATCH] write-tree performance problems
Date: Wed, 20 Apr 2005 11:52:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0504201147280.2630@cag.csail.mit.edu>
References: <200504191250.10286.mason@suse.com> <200504192049.21947.mason@suse.com>
 <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org> <200504201122.35448.mason@suse.com>
 <Pine.LNX.4.61.0504201128550.2630@cag.csail.mit.edu>
 <Pine.LNX.4.58.0504200840240.6467@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 17:49:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOHQt-0004Sj-6Z
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 17:48:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261701AbVDTPwV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 11:52:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261700AbVDTPwV
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 11:52:21 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:42896 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S261701AbVDTPwR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 11:52:17 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DOHUt-0000Z5-00; Wed, 20 Apr 2005 11:52:15 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504200840240.6467@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 20 Apr 2005, Linus Torvalds wrote:

>> I was considering using a chunked representation for *all* files (not just
>> blobs), which would avoid the original 'trees must reference other trees
>> or they become too large' issue -- and maybe the performance issue you're
>> referring to, as well?
> No. The most common index file operation is reading, and that's the one
> that has to be _fast_. And it is - it's a single "mmap" and some parsing.

OK, sure.  But how 'bout chunking trees?  Are you grown happy with the new 
trees-reference-other-trees paradigm, or is there a deep longing in your 
heart for the simplicity of 'trees-reference-blobs-period'?  I'm fairly
certain that chunking could get you the space-savings you need without 
multi-level trees, if the simplicity of that is still appealing.

Not necessarily for rev.1 of the chunking code, but I'm curious as to 
whether it's still of interest at all.  I don't know exactly how far
ingrained multilevel trees have become since they were adopted.
  --scott

Japan explosion BLUEBIRD Honduras jihad D5 SLBM Diplomat overthrow 
JMTIDE CABOUNCE AMTHUG ESODIC Kennedy AVBRANDY CLOWER mail drop PHOENIX
                          ( http://cscott.net/ )
