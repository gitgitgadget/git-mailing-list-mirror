From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Move refspec pattern matching to match_refs().
Date: Sat, 26 May 2007 01:20:49 -0700
Message-ID: <7vejl4m1we.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0705250111200.9778@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sat May 26 10:21:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrrWE-0004tZ-Qe
	for gcvg-git@gmane.org; Sat, 26 May 2007 10:20:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752689AbXEZIUv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 04:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752208AbXEZIUv
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 04:20:51 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:64359 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751315AbXEZIUv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 04:20:51 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070526082050.QZPO15717.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sat, 26 May 2007 04:20:50 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3kLp1X0061kojtg0000000; Sat, 26 May 2007 04:20:50 -0400
In-Reply-To: <Pine.LNX.4.64.0705250111200.9778@iabervon.org> (Daniel
	Barkalow's message of "Fri, 25 May 2007 01:20:56 -0400 (EDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48460>

Daniel Barkalow <barkalow@iabervon.org> writes:

> This means that send-pack and http-push will support pattern refspecs,
> so builtin-push.c doesn't have to expand them, and also git push can
> just turn --tags into "refs/tags/*", further simplifying
> builtin-push.c
>
> check_ref_format() gets a third "conditionally okay" result for
> something that's valid as a pattern but not as a particular ref.
>
> Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> ---
> On top of my "remote" series. Shouldn't change any significant behavior, 
> and simplifies a lot of logic. This version takes into account the 
> comments from the previous round (assuming that the ruling on coding style 
> is that:
>
> if (condition)
> 	/* Comment */
> 	statement;
>
> shouldn't have braces).
>
>  builtin-push.c |  133 +++++++++----------------------------------------------
>  refs.c         |   27 ++++++++---
>  remote.c       |   31 ++++++++++++-
>  send-pack.c    |    1 +
>  4 files changed, 70 insertions(+), 122 deletions(-)

Whee.  Removes lots more code than it adds.  Will queue.
