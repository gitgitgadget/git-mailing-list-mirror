From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] Move remote parsing into a library file out of builtin-push.
Date: Thu, 10 May 2007 01:21:16 -0700
Message-ID: <7virb1ks1v.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705092203130.18541@iabervon.org>
	<7vhcqlma1l.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0705100328260.18541@iabervon.org>
	<7vmz0dktdf.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0705100355560.18541@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Thu May 10 10:21:25 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hm3tr-0006hz-2N
	for gcvg-git@gmane.org; Thu, 10 May 2007 10:21:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266AbXEJIVT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 May 2007 04:21:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755675AbXEJIVT
	(ORCPT <rfc822;git-outgoing>); Thu, 10 May 2007 04:21:19 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:49243 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755266AbXEJIVR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 May 2007 04:21:17 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070510082117.OOZC13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 10 May 2007 04:21:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xLMG1W00E1kojtg0000000; Thu, 10 May 2007 04:21:17 -0400
In-Reply-To: <Pine.LNX.4.64.0705100355560.18541@iabervon.org> (Daniel
	Barkalow's message of "Thu, 10 May 2007 04:04:10 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46845>

Daniel Barkalow <barkalow@iabervon.org> writes:

>> And I think it does today.
>
> Hmm, and I guess URIs on the command line work the same way. How about 
> requiring a '/' somewhere in a repository argument in order to treat it as 
> a repository instead of a remote name? Then "../next-door-neighbour" would 
> work, "./gitcvs.git" would work (in the odd case where you actually have a 
> bare repository sitting in your working directory), but we'd avoid the 
> current default of pushing to a bare repository in "./origin/" if nothing 
> at all is configured.

When I wrote the message you are responding to, I thought this
was a regression from the current behaviour, which (IIRC--it's
getting late and I am tired to double check) essentially says if
the token is a name of the directory, the target repository is a
local one, but "we'd avoid..." part seems to suggest that you
actually did this deliberately as a fix to some problem in the
current behaviour.  I am not however sure what it exactly is.
Could you care to elaborate the part after "we'd avoid..." to
clarify what the problem is, please?
