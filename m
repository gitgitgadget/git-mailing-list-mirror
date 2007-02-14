From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] The "table-of-contents" in the update hook script should match the body
Date: Wed, 14 Feb 2007 08:53:53 -0800
Message-ID: <7vy7n0r87y.fsf@assigned-by-dhcp.cox.net>
References: <200702141120.32776.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Andy Parkins <andyparkins@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 14 17:53:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHNOI-0005tq-Od
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 17:53:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932382AbXBNQxz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 11:53:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932390AbXBNQxz
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 11:53:55 -0500
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:33788 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932382AbXBNQxy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 11:53:54 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214165353.FIUJ21177.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Wed, 14 Feb 2007 11:53:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id PUtt1W00v1kojtg0000000; Wed, 14 Feb 2007 11:53:54 -0500
In-Reply-To: <200702141120.32776.andyparkins@gmail.com> (Andy Parkins's
	message of "Wed, 14 Feb 2007 11:20:32 +0000")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39681>

Andy Parkins <andyparkins@gmail.com> writes:

> 44478d99ee0 introduced a filter using "git-rev-parse --not --all" to the
> log display to prevent the display of revisions already in the
> repository.  However, the table of contents generation didn't get that
> same update.
>
> This patch fixes that.  The table of contents before the log and the log
> now both display the same list of revisions.
>
> Signed-off-by: Andy Parkins <andyparkins@gmail.com>
> ---
> Apologies.  I should always wait a day before posting patches.

No worries.  I will always wait a day before applying yours ;-)

Just kidding.  It's not a big deal as this is purely a sample
script.

>  templates/hooks--update |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/templates/hooks--update b/templates/hooks--update
> index a7cf604..fd1f73d 100644
> --- a/templates/hooks--update
> +++ b/templates/hooks--update
> @@ -57,7 +57,7 @@ announcerecipients=$(git-repo-config hooks.announcelist)
>  allowunannotated=$(git-repo-config --bool hooks.allowunannotated)
>  
>  # --- Check types
> -newrev_type=$(git-cat-file -t "$newrev")
> +newrev_type=$(git-cat-file -t $newrev)
>  
>  case "$refname","$newrev_type" in
>  	refs/tags/*,commit)

I do not think this hunk is related...
