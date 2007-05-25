From: Junio C Hamano <junkio@cox.net>
Subject: Re: Pulling from refs/remotes/ ?
Date: Thu, 24 May 2007 18:19:15 -0700
Message-ID: <7v7iqxvgx8.fsf@assigned-by-dhcp.cox.net>
References: <f35d9n$21e$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Fri May 25 03:19:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrOSc-00037U-PB
	for gcvg-git@gmane.org; Fri, 25 May 2007 03:19:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbXEYBTR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 21:19:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750741AbXEYBTR
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 21:19:17 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:65288 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709AbXEYBTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 21:19:16 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070525011914.REOI12190.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 24 May 2007 21:19:14 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3DKF1X00V1kojtg0000000; Thu, 24 May 2007 21:19:16 -0400
In-Reply-To: <f35d9n$21e$1@sea.gmane.org> (Han-Wen Nienhuys's message of "Thu,
	24 May 2007 22:12:45 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48323>

Han-Wen Nienhuys <hanwen@xs4all.nl> writes:

> why can't I pull from a remote?  I can do 
>
>   git log REMOTE-BRANCH
>   git diff BRANCH REMOTE-BRANCH
>
> etc. But pulling yields
>
>  [hanwen@haring foobar]$ git pull . origin/nonrandr-setup
>  error: no such remote ref refs/heads/origin/nonrandr-setup
>  Fetch failure: .
>
> also, "Fetch failure: .", what is that supposed to mean?

You are treating your local repository as if it is a remote
repository somewhere else, namely, '.' (current repository).

Notice "git log" and "git diff" are LOCAL operations?  "git
pull" is "git fetch" which is a remote operation (i.e. it
interacts with a remote repository) followed by "git merge"
which is a local operation to merge in what was fetched or what
you already have locally.

I think you would want:

	git merge REMOTE-BRANCH

e.g. "git merge origin/nonrandr-setup".
