From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Add --no-reuse-delta, --window,
 and --depth options to git-gc
Date: Tue, 08 May 2007 09:46:38 -0400 (EDT)
Message-ID: <alpine.LFD.0.99.0705080941350.24220@xanadu.home>
References: <E1HlFqU-0002ir-GK@candygram.thunk.org>
 <alpine.LFD.0.99.0705072305270.24220@xanadu.home>
 <20070508032122.GA10940@thunk.org> <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: Theodore Tso <tytso@mit.edu>, git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Tue May 08 15:46:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlQ1d-0004Xn-Si
	for gcvg-git@gmane.org; Tue, 08 May 2007 15:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967136AbXEHNql (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 09:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967498AbXEHNql
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 09:46:41 -0400
Received: from relais.videotron.ca ([24.201.245.36]:29667 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967136AbXEHNqk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2007 09:46:40 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JHQ00C7369Q1DC0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 08 May 2007 09:46:38 -0400 (EDT)
In-reply-to: <7vr6ps3oyk.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46578>

On Mon, 7 May 2007, Junio C Hamano wrote:

> Theodore Tso <tytso@mit.edu> writes:
> 
> > On Mon, May 07, 2007 at 11:13:58PM -0400, Nicolas Pitre wrote:
> >> ... 
> >> Especially if you're aware and interested in those options, you won't be 
> >> afraid of 'git repack -a -f -d --window=...".
> >> 
> >> In the context of "gc", having an option that reads "window" looks a bit 
> >> strange too.
> >
> > I suppose, but you either need to then know all of the other commands
> > which git-gc runs, and do them manually, skipping git-gc altogether,
> > or use git-gc, and end up rewriting the pack twice,...
> 
> If the user really wants to tweak the parameters that much and
> that often, I think what Nico says, plus your pack.depth/window
> configuration variables, make more sense.

Also, once you've run git-repack with -f and the window/depth params you 
want, those deltas will be reused as is by default afterwards even if 
you use git-gc.  So the big repack to tighten a large repo needs only to 
be done once.


Nicolas
