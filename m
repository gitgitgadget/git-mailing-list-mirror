From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] Move remote parsing into a library file out of builtin-push.
Date: Thu, 10 May 2007 01:35:18 -0700
Message-ID: <7v7irhkreh.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705092203130.18541@iabervon.org>
	<7vhcqlma1l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0705100328260.18541@iabervon.org>
	<7vmz0dktdf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0705100355560.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu May 10 10:35:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm47S-0000hN-5h
	for gcvg-git@gmane.org; Thu, 10 May 2007 10:35:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757277AbXEJIfU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 04:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757135AbXEJIfU
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 04:35:20 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:41837 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756129AbXEJIfT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 04:35:19 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070510083518.YNVB24310.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Thu, 10 May 2007 04:35:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xLbJ1W0051kojtg0000000; Thu, 10 May 2007 04:35:18 -0400
In-Reply-To: <Pine.LNX.4.64.0705100355560.18541@iabervon.org> (Daniel
	Barkalow's message of "Thu, 10 May 2007 04:04:10 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46848>

Daniel Barkalow <barkalow@iabervon.org> writes:

> ..., "./gitcvs.git" would work (in the odd case where you actually have a 
> bare repository sitting in your working directory), ...

This is a bit of tangent, because it does not change the issue
we are discussing, and I suspect you already know this.

But to avoid future confusion by people on the list who read
this in the archive...

	"foo.git" does _NOT_ mean the directory is a bare
	repository.  It is perfectly normal to have "foo.git/"
	that has a working tree whose repository data lives in
	"foo.git/.git".

I _think_ (meaning, I haven't polled the userbase) requiring '/'
may not break people's existing setup too badly, while it _is_ a
regression in the sense that we suddenly start disallowing
something we allowed for a long time, perhaps without no
apparent good reason.

I hope you'll correct me about "without no apparent good reason"
part, which was what I was asking in my previous message.  With
a good rationale, it is much easier to sell a change that is a
regression in the strictest sense but is unlikely to hurt people
in practice.
