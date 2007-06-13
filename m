From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Interpret :/<pattern> as a regular expression
Date: Tue, 12 Jun 2007 18:21:51 -0700
Message-ID: <7v1wggir80.fsf@assigned-by-dhcp.pobox.com>
References: <Pine.LNX.4.64.0706130148080.4059@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jun 13 03:21:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyHYX-0003zi-Rl
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 03:21:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbXFMBVw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 21:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751146AbXFMBVw
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 21:21:52 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:50353 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750909AbXFMBVw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Jun 2007 21:21:52 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070613012152.RQXK6565.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Tue, 12 Jun 2007 21:21:52 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id ApMr1X00C1kojtg0000000; Tue, 12 Jun 2007 21:21:51 -0400
In-Reply-To: <Pine.LNX.4.64.0706130148080.4059@racer.site> (Johannes
	Schindelin's message of "Wed, 13 Jun 2007 01:50:22 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50011>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Earlier, Git interpreted the pattern as a strict prefix, which made
> the operator unsuited in many cases.
>
> Now, the pattern is interpreted as a regular expression (which does not 
> change the behaviour too much, since few onelines contain special regex 
> characters), so that you can say
>
> 	git diff :/.*^Signed-off-by:.Zack.Brown
>
> to see the diff against the most recent reachable commit which was
> signed off by Zack, whose Kernel Cousin I miss very much.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>

While this perhaps is an improvement and people who are not
interested in paying the price have a choice of not using this
silly syntax, I am moderately annoyed that the syntax does not
define "the most recent reachable" very well.  It is more like
"the first one we happened to pick by diffing from reachable
refs".  It would be more useful if it took "$commit:/$pattern"
form to limit the search among reachable ones from named commit.
