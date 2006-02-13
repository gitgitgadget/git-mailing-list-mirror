From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-bisect problem
Date: Mon, 13 Feb 2006 02:08:03 -0800
Message-ID: <7vbqxb1sho.fsf@assigned-by-dhcp.cox.net>
References: <20060213002502.5c23122c.akpm@osdl.org>
	<7virrj1v44.fsf@assigned-by-dhcp.cox.net>
	<20060213013205.4ba47836.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 13 11:08:13 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8acs-0005Pv-8D
	for gcvg-git@gmane.org; Mon, 13 Feb 2006 11:08:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751704AbWBMKIG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Feb 2006 05:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbWBMKIG
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Feb 2006 05:08:06 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:7094 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1751704AbWBMKIE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Feb 2006 05:08:04 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060213100810.DVDV25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 13 Feb 2006 05:08:10 -0500
To: Andrew Morton <akpm@osdl.org>
In-Reply-To: <20060213013205.4ba47836.akpm@osdl.org> (Andrew Morton's message
	of "Mon, 13 Feb 2006 01:32:05 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16062>

Andrew Morton <akpm@osdl.org> writes:

>> As humans, we can tell that it is not very plausible that the
>>  EXTRAVERSION change caused whatever breakage you are chasing,
>>  but sorry, from your log, I think bisect is doing the right
>>  thing.
>
> I don't think humans are well-suited to using git.

I did not mean that ;-).  Git is not as smart as humans.

> My current theory is that I was bisecting Linus's tree all along.

Sorry, I did not realize that was _not_ what you were doing.
Your log started by saying 2.6.16-rc1 is good but 2.6.16-rc2 was
not, so I just assumed your bug was between those two.

If your suspect was merged between these two versions, then it
does not matter which branch you were _on_ when you started to
bisect.  

You mark points that are good and bad, and wander around in the
commit DAG, trying to narrow down the distance between known
good points and bad points while bisecting, and during that, you
are not really on _any_ branch.
