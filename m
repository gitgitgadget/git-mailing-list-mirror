From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 1/9] Fix git patch header processing in git-apply.
Date: Mon, 29 Aug 2005 18:09:53 -0700
Message-ID: <7vacj06xi6.fsf@assigned-by-dhcp.cox.net>
References: <11252426672473-git-send-email-robfitz@273k.net>
	<7vslwtein3.fsf@assigned-by-dhcp.cox.net>
	<20050829235823.GA19351@localhost>
	<Pine.LNX.4.58.0508291744400.3243@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robert Fitzsimons <robfitz@273k.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 30 03:10:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9udS-0002sg-CZ
	for gcvg-git@gmane.org; Tue, 30 Aug 2005 03:09:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751441AbVH3BJz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 21:09:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751442AbVH3BJz
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 21:09:55 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:50635 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751441AbVH3BJz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2005 21:09:55 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050830010953.ELYY8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 29 Aug 2005 21:09:53 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0508291744400.3243@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 29 Aug 2005 17:47:00 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7935>

Linus Torvalds <torvalds@osdl.org> writes:

> Hmm. Anything that depends on "--ignore-applied" is fundamentally broken
> as an import tool. There's no way something like that can be valid, since
> it inhently means that somebody is trying to apply a patch that simple
> isn't applicable.
>
> Don't do this.

I suspect that it is exported data that is broken, if
this --ignore-applied flag is needed for importing something
somebody exported.

I, however, am not 100% convinced --ignore-applied is too
dangerous to be useful in any conceivable use cases, at least
not yet.  For example, you might be cherry-picking a change from
a foreign branch with 'git-diff-tree -p other~45 | git apply',
where the current branch may have already aquired part of the
changes that foreign branch contains since 45 generations ago.
