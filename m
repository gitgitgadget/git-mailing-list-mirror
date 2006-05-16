From: Junio C Hamano <junkio@cox.net>
Subject: Re: Fix silly typo in new builtin grep
Date: Mon, 15 May 2006 20:18:11 -0700
Message-ID: <7vu07qfyj0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0605151743360.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 16 05:19:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ffq5P-00086x-Gh
	for gcvg-git@gmane.org; Tue, 16 May 2006 05:19:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWEPDSr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 23:18:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbWEPDSr
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 23:18:47 -0400
Received: from fed1rmmtai16.cox.net ([68.230.241.43]:13296 "EHLO
	fed1rmmtai16.cox.net") by vger.kernel.org with ESMTP
	id S1751089AbWEPDSr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 23:18:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060516031813.MNCA27919.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 15 May 2006 23:18:13 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605151743360.3866@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 15 May 2006 17:54:01 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20095>

Linus Torvalds <torvalds@osdl.org> writes:

> The "-F" flag apparently got mis-translated due to some over-eager 
> copy-paste work into a duplicate "-H" when using the external grep.

Thanks.  I've pushed it out to "master", along with some other
stuff.

> Me likee the new built-in grep. The ability to say
>
> 	git grep __make_request v2.6.13 -- '*.c'
>
> to grep for it in a specific version is well worth the fact that it 
> obviously ends up being slower than grepping in the currently checked-out 
> tree. It's doing a hell of a lot more, but despite that it's not at all 
> that slow.
>
> (In fact, I would say that doing the above command in just 4 seconds is 
> damn impressive - it's a large code-base, and v2.6.13 is several months, 
> and over 20 _thousand_ revisions ago).

That is a BS praise and you know it ;-).  You do not have delta
chains that are 20k long, so grepping from the tree 10 revs ago
and from the tree 20k revs ago would not make a difference.

It _would_ be impressive to CVS folks, but even there each path
would not have 20k revisions.  The kernel patches tend to touch
3 paths per patch on average, so 60k changes over 18k files
distributed unevenly -- my guess (I could count but haven't) is
probably 200 revisions at most for most frequently touched file.
