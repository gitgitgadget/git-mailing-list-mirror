From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 9/10] Remove cmd_usage() routine and re-organize the help/usage code.
Date: Thu, 03 Aug 2006 21:33:13 -0700
Message-ID: <7vslkdnmra.fsf@assigned-by-dhcp.cox.net>
References: <000101c6b72a$51601a80$c47eedc1@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Aug 04 06:33:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G8rN8-0005ho-Ru
	for gcvg-git@gmane.org; Fri, 04 Aug 2006 06:33:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030256AbWHDEdP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 00:33:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030257AbWHDEdP
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 00:33:15 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:48590 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1030256AbWHDEdP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 4 Aug 2006 00:33:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060804043314.FPBH1537.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 4 Aug 2006 00:33:14 -0400
To: "Ramsay Jones" <ramsay@ramsay1.demon.co.uk>
In-Reply-To: <000101c6b72a$51601a80$c47eedc1@ramsay1.demon.co.uk> (Ramsay
	Jones's message of "Thu, 3 Aug 2006 19:26:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24773>

"Ramsay Jones" <ramsay@ramsay1.demon.co.uk> writes:

> Speaking of consistency, I noticed some inconsistent command
> names in various usage strings. I attach a patch (p0011.txt)
> for your consideration.

Thanks, all look good.

> During one of my "grep-fests", I also noticed some calls to
> die(usage_string) rather than usage(usage_string). Calling die()
> rather than usage() means that a "fatal: " (rather than "usage: ")
> prefix is output prior the usage string, and the exit code
> is 128 (rather than 129).
>
> It looks like to choice of die() was deliberate, particularly in
> builtin-rm.c and hash-object.c since they call both die() and
> usage(). However, It's not clear to me why this choice was made.
> (Which is not to say there isn't a perfectly good reason for the
> choice; it's just that I don't see it.)

I think these were all sloppy coding.  The fix you did with
p0012 look good -- all of them are complaining that the command
line parsing found something unexpected, so I think usage() is
more appropriate.
