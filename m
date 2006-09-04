From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/5] autoconf: Preliminary check for working mmap
Date: Mon, 04 Sep 2006 16:36:50 -0700
Message-ID: <7vy7szjjal.fsf@assigned-by-dhcp.cox.net>
References: <200609050054.24279.jnareb@gmail.com>
	<200609050056.52590.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Tue Sep 05 01:36:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GKNzT-0006pH-B3
	for gcvg-git@gmane.org; Tue, 05 Sep 2006 01:36:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965039AbWIDXg1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Sep 2006 19:36:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965041AbWIDXg1
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Sep 2006 19:36:27 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:14542 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S965039AbWIDXgZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Sep 2006 19:36:25 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060904233625.HRSU6711.fed1rmmtao04.cox.net@fed1rmimpo01.cox.net>;
          Mon, 4 Sep 2006 19:36:25 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JPcK1V00A1kojtg0000000
	Mon, 04 Sep 2006 19:36:19 -0400
To: git@vger.kernel.org
In-Reply-To: <200609050056.52590.jnareb@gmail.com> (Jakub Narebski's message
	of "Tue, 5 Sep 2006 00:56:52 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26454>

Jakub Narebski <jnareb@gmail.com> writes:

> This patch sent earlier in other patch series and dropped,
> as git uses private mapping, not private fixed. I think
> that this check is better than no check at all...

I think the next major change that is needed fairly soon is to
be able to mmap parts of a large pack file (even with 32-bit
offset).  I haven't loooked into it deeply enough but it may or
may not turn out to be beneficial if we map at fixed location so
the requirements of "working mmap()" might change.  I'd be
happier if you held onto this part of the patch before that
happens.
