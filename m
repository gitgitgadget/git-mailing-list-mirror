From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-grep: --and to combine patterns with and instead of or
Date: Thu, 29 Jun 2006 15:44:34 -0700
Message-ID: <7vejx7oa3x.fsf@assigned-by-dhcp.cox.net>
References: <E1FuWh7-0008Ry-HX@moooo.ath.cx>
	<20060625184757.f8273820.tihirvon@gmail.com>
	<E1FuX8l-0001H5-2z@moooo.ath.cx>
	<Pine.LNX.4.63.0606260108510.29667@wbgn013.biozentrum.uni-wuerzburg.de>
	<E1FueYh-0004XE-Fg@moooo.ath.cx>
	<20060629222009.GA9310@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Matthias Lederhofer <matled@gmx.net>
X-From: git-owner@vger.kernel.org Fri Jun 30 00:44:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fw5FY-0003di-Mp
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 00:44:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933068AbWF2Woh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Jun 2006 18:44:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933069AbWF2Woh
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Jun 2006 18:44:37 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:50141 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S932779AbWF2Wof (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Jun 2006 18:44:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060629224435.PCFW27967.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 29 Jun 2006 18:44:35 -0400
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20060629222009.GA9310@cip.informatik.uni-erlangen.de> (Thomas
	Glanzmann's message of "Fri, 30 Jun 2006 00:20:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22924>

Thomas Glanzmann <sithglan@stud.uni-erlangen.de> writes:

> Hello,
>
>> *AND* more than one pattern. (something I miss in normal grep)
>
> so do I.

So do I.

I am wondering if we would rather want to do something like
expression `find` command let's you build.  In other words:

	git grep --extended-expression '(' 'foo' -o 'bar' ')' -a 'frotz'

might be what we would eventually want.  And I have this nagging
suspicion that if we allow to say something like this

	git grep --and -e a -e b

right now, it would make it more cumbersome (read: backward
compatibility wart) to support both styles later.

I could be talked into

	git grep -e a -a -e b

but that would already be building that expression engine, so...
