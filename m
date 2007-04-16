From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Add --ignore-notfound option to exit with zero status when no files are removed.
Date: Mon, 16 Apr 2007 00:59:35 -0700
Message-ID: <7vps64vjfc.fsf@assigned-by-dhcp.cox.net>
References: <20070416000408.GA19107@midwinter.com>
	<7v4pnh18hr.fsf@assigned-by-dhcp.cox.net>
	<4622C0AC.8090904@midwinter.com>
	<7vps65yvc1.fsf@assigned-by-dhcp.cox.net>
	<20070416074648.GA18719@midwinter.com>
	<20070416075324.GA18961@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Apr 16 09:59:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdM7g-0001mF-Ei
	for gcvg-git@gmane.org; Mon, 16 Apr 2007 09:59:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964792AbXDPH7h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Apr 2007 03:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbXDPH7h
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Apr 2007 03:59:37 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:45736 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964792AbXDPH7g (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Apr 2007 03:59:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070416075937.TTUI1257.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Mon, 16 Apr 2007 03:59:37 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id njzb1W00J1kojtg0000000; Mon, 16 Apr 2007 03:59:36 -0400
In-Reply-To: <20070416075324.GA18961@midwinter.com> (Steven Grimm's message of
	"Mon, 16 Apr 2007 00:53:24 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44613>

Steven Grimm <koreth@midwinter.com> writes:

>  Documentation/git-rm.txt |    3 +++
>  builtin-rm.c             |   21 +++++++++++++++++----
>  t/t3600-rm.sh            |    4 ++++
>  3 files changed, 24 insertions(+), 4 deletions(-)

I find it easier to see what is going on with two independent
features separated out, especially with tests.  Much nicer.

> @@ -47,6 +47,9 @@ OPTIONS
>  	the paths only from the index, leaving working tree
>  	files.
>  
> +\--ignore-notfound::
> +	Exit with a zero status even if no files matched.
> +

ls-files has --error-unmatch so we may want to make the name
consistent by saying --ignore-unmatch?  I particularly do not
care about the minute naming issues _right_ _now_, but we might
regret it in the long run.

No need to resend unless you have an actual fix; I'll queue your
patch as is in 'pu', wait for a few days for comments on the
naming, and amend it as needed.

Thanks.
