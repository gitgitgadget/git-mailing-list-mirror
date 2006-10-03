From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-rebase: Add a -v option to show a diffstat of the changes upstream at the start of a rebase.
Date: Tue, 03 Oct 2006 15:35:09 -0700
Message-ID: <7v4pulm3j6.fsf@assigned-by-dhcp.cox.net>
References: <45228FEB.10602@codeweavers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 04 00:35:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GUsr7-00008A-Sg
	for gcvg-git@gmane.org; Wed, 04 Oct 2006 00:35:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030568AbWJCWfN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Oct 2006 18:35:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030625AbWJCWfM
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Oct 2006 18:35:12 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:57503 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1030568AbWJCWfK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Oct 2006 18:35:10 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061003223509.LGW6077.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Tue, 3 Oct 2006 18:35:09 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Vyb31V00U1kojtg0000000
	Tue, 03 Oct 2006 18:35:03 -0400
To: Robert Shearman <rob@codeweavers.com>
In-Reply-To: <45228FEB.10602@codeweavers.com> (Robert Shearman's message of
	"Tue, 03 Oct 2006 17:29:31 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28309>

Robert Shearman <rob@codeweavers.com> writes:

> Signed-off-by: Robert Shearman <rob@codeweavers.com>
> @@ -121,6 +121,9 @@ OPTIONS
>  	is used instead (`git-merge-recursive` when merging a single
>  	head, `git-merge-octopus` otherwise).  This implies --merge.
>  
> +-v, \--verbose::
> +	Display a diffstat of what changed upstream since the last rebase.
> +
>  include::merge-strategies.txt[]
>  
>  NOTES

I initially was a bit surprised that you did not show diff
between onto and our HEAD (i.e. show the damages contained in
the topic you are rebasing that will be inflicted on upstream),
but I think your way of showing the upstream changes makes more
sense.  From the workflow point of view, this is for people who
rebase instead of pull, and when pulling we show what the
upstream did while we were looking the other way, so this
naturally matches that behaviour for rebase.  I would say it is
a good thinking.
