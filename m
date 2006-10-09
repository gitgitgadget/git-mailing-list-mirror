From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] merge: loosen overcautious "working file will be lost" check.
Date: Mon, 09 Oct 2006 15:47:36 -0700
Message-ID: <7vy7rp9kdz.fsf@assigned-by-dhcp.cox.net>
References: <7v8xjqdoq1.fsf_-_@assigned-by-dhcp.cox.net>
	<20061009172053.48882.qmail@web31804.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 10 00:47:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GX3uP-0003gj-UX
	for gcvg-git@gmane.org; Tue, 10 Oct 2006 00:47:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751909AbWJIWri (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Oct 2006 18:47:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751910AbWJIWri
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Oct 2006 18:47:38 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:40834 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751909AbWJIWrh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Oct 2006 18:47:37 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20061009224736.OAQO12581.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Mon, 9 Oct 2006 18:47:36 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id YNnf1V00L1kojtg0000000
	Mon, 09 Oct 2006 18:47:39 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20061009172053.48882.qmail@web31804.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Mon, 9 Oct 2006 10:20:52 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28581>

Luben Tuikov <ltuikov@yahoo.com> writes:

> I think this is a good thing.
>
> How about this case I've noticed in my trees:
>
> After branching out, a file is deleted, only to add
> a different file with the same file name.
>
> Then any time I pull in from the trunk to merge,
> merge fails with git-diff-files showing all 0's and the
> file name in question.  Picture:
>
>   Branch B       +-----------------M1---->
>                 /                 /
>                C2 <-- git-add A  /
>               /                 /
>              C1 <-- git-rm A   /
>             /                 /
> Trunk -----+-----------------+---->

Sorry I do not understand the picture; where is the common
ancestor?  If it is the left plus sign on the Trunk line, and
you are talking about what happens when making the merge M1,
then before C1 A did not exist (so Trunk tip which is the right
plus sign on the Trunk line would not either), and the other
head (tip of branch B you are pulling the trunk into) would have
one already (from C2), so I would imagine it would be "one side
adds while the other did not touch" (net effect since branch B
forked from trunk is an addition of A, while Trunk did not do
anything with respect to path A), so I do not see where any
conflict can come from.  Puzzled.
