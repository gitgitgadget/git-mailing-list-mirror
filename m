From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] Teach name-rev to identify revisions containing a certain blob
Date: Sun, 18 Feb 2007 00:48:08 -0800
Message-ID: <7vejonj1h3.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0702171838510.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vmz3bj248.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Mike Coleman <tutufan@gmail.com>,
	junkio@cox.net
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Feb 18 09:48:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HIhiQ-0003j5-65
	for gcvg-git@gmane.org; Sun, 18 Feb 2007 09:48:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161172AbXBRIsL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Feb 2007 03:48:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161175AbXBRIsK
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Feb 2007 03:48:10 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:53273 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161172AbXBRIsK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Feb 2007 03:48:10 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070218084808.CBZJ1306.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Sun, 18 Feb 2007 03:48:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Qwo81W00H1kojtg0000000; Sun, 18 Feb 2007 03:48:09 -0500
In-Reply-To: <7vmz3bj248.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sun, 18 Feb 2007 00:34:15 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40064>

Junio C Hamano <junkio@cox.net> writes:

> [Footnote]
>
> *1* To find a revision that had a particular object at a known
> path, you should be able to do:
>
> 	git rev-list <starting refs> |
>       git diff-tree --stdin --raw -r -Z |
> 	grep -z that-object-name

Sheesh, please add "-- <path>" after "-Z".

>
> but an earlier commit abd4e222 needs to be further enhanced to
> add -Z option that means "output fields are not NUL terminated,
> output records are", which did not happen.
