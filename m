From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] fix git-repack for use with GIT_TRACE
Date: Mon, 10 Jul 2006 17:11:28 -0700
Message-ID: <7vy7v16lvz.fsf@assigned-by-dhcp.cox.net>
References: <E1Fzta3-00066Z-8B@moooo.ath.cx>
	<7vwtalbqeo.fsf@assigned-by-dhcp.cox.net>
	<E1FzvZG-0002C1-UN@moooo.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 02:11:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G05qh-000705-Cz
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 02:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751275AbWGKALa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 20:11:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751320AbWGKALa
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 20:11:30 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:64455 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1751275AbWGKAL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 20:11:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060711001128.TJPQ19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 10 Jul 2006 20:11:28 -0400
To: Matthias Lederhofer <matled@gmx.net>
In-Reply-To: <E1FzvZG-0002C1-UN@moooo.ath.cx> (Matthias Lederhofer's message
	of "Mon, 10 Jul 2006 15:12:54 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23671>

Matthias Lederhofer <matled@gmx.net> writes:

> Ok, this patch should fix this.  Instead of "echo abort" another more
> meaningful message could be used.

"git-rev-list died with exit code $?" perhaps.

> I checked the other scripts which
> redirect stderr and they should be fine.  In the tests I found
> t/t1200-tutorial.sh:38 
> t/t1300-repo-config.sh:276
> t/t5500-fetch-pack.sh:66
> redirecting stderr, which probably fail which GIT_TRACE.

Probably t/test-lib.sh should unset GIT_TRACE then like it does
for other environment variables.
