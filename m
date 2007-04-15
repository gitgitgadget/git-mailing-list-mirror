From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/3] Add basic infrastructure to assign attributes to paths
Date: Sat, 14 Apr 2007 17:59:42 -0700
Message-ID: <7vejmm78qp.fsf@assigned-by-dhcp.cox.net>
References: <7vr6qod4wh.fsf@assigned-by-dhcp.cox.net>
	<200704131033.15751.andyparkins@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>,
	Johannes Sixt <J.Sixt@eudaptics.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 15 02:59:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hct5o-0003YK-95
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 02:59:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751878AbXDOA7o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 Apr 2007 20:59:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751892AbXDOA7o
	(ORCPT <rfc822;git-outgoing>); Sat, 14 Apr 2007 20:59:44 -0400
Received: from fed1rmmtao103.cox.net ([68.230.241.43]:42652 "EHLO
	fed1rmmtao103.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751878AbXDOA7n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Apr 2007 20:59:43 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070415005943.XBUU1226.fed1rmmtao103.cox.net@fed1rmimpo01.cox.net>;
          Sat, 14 Apr 2007 20:59:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id nCzi1W00P1kojtg0000000; Sat, 14 Apr 2007 20:59:42 -0400
In-Reply-To: <200704131033.15751.andyparkins@gmail.com> (Andy Parkins's
	message of "Fri, 13 Apr 2007 10:33:12 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44476>

Andy Parkins <andyparkins@gmail.com> writes:

>> parent directories.  Lines in $GIT_DIR/info/attributes file are
>> used as the lowest precedence default rules.
>
> Shouldn't this be the highest precedence?  This would be important for 
> those cases where I (as a fringe developer) disagree with an attribute 
> that's been assigned in-tree.  I don't want to force my will on every 
> other developer, but would want my repository to work how I like it.  

Johannes Sixt <J.Sixt@eudaptics.com> writes:
>> This makes paths with 'nodiff' attribute not to produce
>> "textual" diffs from 'git-diff' family.
>
> If saying "nodiff" can be made equivalent to "!diff", then I'd strongly
> prefer an attribute "diff" over "nodiff". I'm a strong disbeliever in
> double negation.

Both of these are good points.

The only reason I initially made it 'nodiff' was to have a pair
of examples to demonstrate positive and negative setting of
attributes, and I agree it makes more sense to say 'diff' in
positive.

I reshuffled the code to make $GIT_DIR/info/attributes the
highest precedence, and unsetting 'diff' attribute to disable
diff; the result is in 'next'.

I'll follow this message up with a few more patches in the
series.
