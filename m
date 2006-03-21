From: Junio C Hamano <junkio@cox.net>
Subject: Re: Bad merging with stgit or git
Date: Tue, 21 Mar 2006 15:02:19 -0800
Message-ID: <7vfylbcsg4.fsf@assigned-by-dhcp.cox.net>
References: <1142969653.4749.109.camel@praia>
	<20060321193924.GD14579@fieldses.org>
	<1142972313.4749.123.camel@praia>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 22 00:02:44 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FLps9-00004q-FT
	for gcvg-git@gmane.org; Wed, 22 Mar 2006 00:02:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWCUXCX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Mar 2006 18:02:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWCUXCX
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Mar 2006 18:02:23 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:16016 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S964882AbWCUXCW (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Mar 2006 18:02:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060321230018.XBHP20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 21 Mar 2006 18:00:18 -0500
To: Mauro Carvalho Chehab <mchehab@infradead.org>
In-Reply-To: <1142972313.4749.123.camel@praia> (Mauro Carvalho Chehab's
	message of "Tue, 21 Mar 2006 17:18:33 -0300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17793>

Mauro Carvalho Chehab <mchehab@infradead.org> writes:

>From what I'm understanding now, I should do, when a conflict is
> detected:
>
> nano <files>
> git-update-index <files>
> git commit
>
> Previously (at git 1.1.4), I was doing:
> nano <files>
> git commit <files>
>
> git 1.2.4 don't allow this bad commit syntax anymore.

It is not a bad syntax, and it instead would say "you might have
meant to say -i paths...", and if you follow that suggestion to
say:

	$ git commit -i this-and-that-file-I-resolved-by-hand

you would commit the cleanly auto-resolved paths _and_ the
result of your hand merge result.  That is the same traditional
behaviour you are used to and is very convenient if you only had
a few paths to be hand resolved.

So I suspect there might be something else going on.
