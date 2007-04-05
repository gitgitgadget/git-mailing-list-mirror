From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Makefile: Add '+' to QUIET_SUBDIR0 to fix parallel make.
Date: Wed, 04 Apr 2007 22:39:11 -0700
Message-ID: <7vabxnwfb4.fsf@assigned-by-dhcp.cox.net>
References: <20070404204233.GA14252@ferdyx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Fernando J. Pereda" <ferdy@gentoo.org>
X-From: git-owner@vger.kernel.org Thu Apr 05 07:39:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZKgn-0001vj-H7
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 07:39:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161205AbXDEFjO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 01:39:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161213AbXDEFjO
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 01:39:14 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:58296 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161205AbXDEFjN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 01:39:13 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070405053912.EMM25613.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 5 Apr 2007 01:39:12 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id jHfB1W00b1kojtg0000000; Thu, 05 Apr 2007 01:39:12 -0400
In-Reply-To: <20070404204233.GA14252@ferdyx.org> (Fernando J. Pereda's message
	of "Wed, 4 Apr 2007 22:42:33 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43797>

"Fernando J. Pereda" <ferdy@gentoo.org> writes:

> Signed-off-by: Fernando J. Pereda <ferdy@gentoo.org>
> ---
>
>   I don't know if this breaks non-gnu make, and don't have an easy way
>   to test it right now. So someone should do that before it is applied.

I had an impression that our makefile is quite dependent on GNU
make already.  Do people build git without gmake?

>   This is needed for GNU make to let sub-makes connect to the jobserver
>   when multiple jobs are specified (-j option to make). It was not
>   needed before 74f2b2a8d006a49e1be7e30731c2f7365d2741d1 because of how
>   GNU make works.

Thanks.  The info page does not talk about -j but '+' apparently
is needed for jobserver.

       As a special feature, using the variable `MAKE' in the commands of a
    rule alters the effects of the `-t' (`--touch'), `-n' (`--just-print'),
    or `-q' (`--question') option.  Using the `MAKE' variable has the same
    effect as using a `+' character at the beginning of the command line.
    *Note Instead of Executing the Commands: Instead of Execution.  This
    special feature is only enabled if the `MAKE' variable appears directly
    in the command script: it does not apply if the `MAKE' variable is
    referenced through expansion of another variable.  In the latter case
    you must use the `+' token to get these special effects.
