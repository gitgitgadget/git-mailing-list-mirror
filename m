From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Merge-Recursive Improvements
Date: Wed, 13 Feb 2008 00:05:41 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802130003370.3870@racer.site>
References: <A21B3CA8-6240-434F-87A9-C6F76DA15265@gmail.com> <alpine.LFD.1.00.0802121544370.2920@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Voltage Spike <voltspike@gmail.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 13 01:06:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JP58u-00037F-St
	for gcvg-git-2@gmane.org; Wed, 13 Feb 2008 01:06:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757146AbYBMAFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 19:05:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756840AbYBMAFi
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 19:05:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:40271 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752432AbYBMAFg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 19:05:36 -0500
Received: (qmail invoked by alias); 13 Feb 2008 00:05:34 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp026) with SMTP; 13 Feb 2008 01:05:34 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+CGENSBWuCwBhqoi95mGMwVa5BM9j4sc6nK9lLn2
	/3cDtgJ7He+9Lf
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LFD.1.00.0802121544370.2920@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73716>

Hi,

On Tue, 12 Feb 2008, Linus Torvalds wrote:

> On Tue, 12 Feb 2008, Voltage Spike wrote:
> > 
> > First, git is overly zealous at merging differences and two functions 
> > added at the same point in a file become intertwined during the merge. 
> > A trivial example of this behavior:
> 
> Hmm. Have you tested what happens if you use XDL_MERGE_EAGER instead of 
> XDL_MERGE_ZEALOUS in the "level" argument to xdl_merge() in 
> merge-recursive.c?
> 
> (No, I didn't test it myself, but it may get you the behaviour you want, 
> and we could make it a config option for people who want a less 
> aggressive merge)

Actually, I have this in my ever-growing TODO:

XDL_MERGE_ZEALOUS_ALNUM: require an alnum in the common code; otherwise do 
not de-conflict it.

In other words, if there is a hunk consisting of conflicting lines, which 
are identical, but have no letter and no number in it, then keep them as 
conflicts.

But I never got around to try it.

Ciao,
Dscho
