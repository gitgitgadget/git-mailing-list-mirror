From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] core-tutorial: git-merge uses -m for commit messages
Date: Mon, 05 Feb 2007 10:07:38 -0800
Message-ID: <7vejp4mqad.fsf@assigned-by-dhcp.cox.net>
References: <20070205113439.GA27077@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Mon Feb 05 19:07:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HE8Fj-0001N5-G8
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 19:07:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752088AbXBESHk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Feb 2007 13:07:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbXBESHk
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Feb 2007 13:07:40 -0500
Received: from fed1rmmtai14.cox.net ([68.230.241.45]:54288 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752088AbXBESHj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Feb 2007 13:07:39 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070205180738.IWVN4586.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Mon, 5 Feb 2007 13:07:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Ku7e1W0011kojtg0000000; Mon, 05 Feb 2007 13:07:38 -0500
In-Reply-To: <20070205113439.GA27077@moooo.ath.cx> (Matthias Lederhofer's
	message of "Mon, 5 Feb 2007 12:34:39 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38764>

Matthias Lederhofer <matled@gmx.net> writes:

> Signed-off-by: Matthias Lederhofer <matled@gmx.net>
> ---
>  Documentation/core-tutorial.txt |   12 ++++++------
>  1 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/Documentation/core-tutorial.txt b/Documentation/core-tutorial.txt
> index 9c28bea..6f30e0a 100644
> --- a/Documentation/core-tutorial.txt
> +++ b/Documentation/core-tutorial.txt
> @@ -894,11 +894,11 @@ script called `git merge`, which wants to know which branches you want
>  to resolve and what the merge is all about:
>  
>  ------------
> -$ git merge "Merge work in mybranch" HEAD mybranch
> +$ git merge -m "Merge work in mybranch" HEAD mybranch
>  ------------

Unfortunately it needs more than that.

The funny command argument order in the original example was the
command line format that has been in use internally for a long
time:  merge <msg> HEAD <other commit>.

The human-accessible form that uses -m in front of <msg> does
not need the second argument that always must match the current
commit (it always must match so there is no point saying it).

The original examples work perfectly Ok, and you broke it -- if
you are doing '-m' you need to remove HEAD (and master in later
ones) from the command line.
