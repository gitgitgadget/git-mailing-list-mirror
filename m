From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-add: allow path limiting with -u
Date: Sun, 13 May 2007 18:29:31 -0700
Message-ID: <7virawp4zo.fsf@assigned-by-dhcp.cox.net>
References: <20070512064159.GA7471@coredump.intra.peff.net>
	<200705131235.25281.jnareb@gmail.com>
	<20070514004224.GB6689@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	cworth@cworth.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon May 14 03:29:40 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HnPNY-0008HS-JW
	for gcvg-git@gmane.org; Mon, 14 May 2007 03:29:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758124AbXENB3d (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 May 2007 21:29:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758435AbXENB3c
	(ORCPT <rfc822;git-outgoing>); Sun, 13 May 2007 21:29:32 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:63027 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758124AbXENB3c (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 May 2007 21:29:32 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070514012930.YBMJ13903.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 13 May 2007 21:29:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ypVX1W00E1kojtg0000000; Sun, 13 May 2007 21:29:31 -0400
In-Reply-To: <20070514004224.GB6689@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 13 May 2007 20:42:24 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47214>

Jeff King <peff@peff.net> writes:

> On Sun, May 13, 2007 at 12:35:24PM +0200, Jakub Narebski wrote:
>
>> The fact that "add --interactive does not take any parameters" is
>> separate issue (which, accidentally, was adressed in the same patch).
>
> I don't generally use add --interactive, but I imagine that
> path-limiting would also make sense there. I think it would be a bit
> harder to implement (and test!), since there are many calls to commands
> which would need the limits. So I will leave that unless somebody really
> cares about it.

I do not use -i myself that much, but due to its "interactive"
nature, I would imagine that limiting path upfront is actually
counter-productive.  During the interactive refining process you
might notice that you wanted to handle some other paths you
excluded from the command line, but you won't be able to access
them if you limit upfront.  In other words, command line limiter
would only interfere with what the interactive user would really
want to do.
