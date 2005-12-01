From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Move couple of ifdefs after "include config.mk"
Date: Thu, 01 Dec 2005 01:04:24 -0800
Message-ID: <7vmzjlkx2f.fsf@assigned-by-dhcp.cox.net>
References: <20051201012333.44bd81f2.tihirvon@gmail.com>
	<Pine.LNX.4.63.0512010144050.11941@wbgn013.biozentrum.uni-wuerzburg.de>
	<20051201033201.02b47071.tihirvon@gmail.com>
	<7vhd9tmw1g.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0512010906400.22709@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Timo Hirvonen <tihirvon@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 01 10:05:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhkN5-0000jL-7W
	for gcvg-git@gmane.org; Thu, 01 Dec 2005 10:04:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751605AbVLAJE1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 1 Dec 2005 04:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbVLAJE0
	(ORCPT <rfc822;git-outgoing>); Thu, 1 Dec 2005 04:04:26 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:26522 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751605AbVLAJE0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Dec 2005 04:04:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051201090343.KRMK6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 1 Dec 2005 04:03:43 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0512010906400.22709@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 1 Dec 2005 09:08:27 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13043>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> But it is only one line, heck only 20 bytes!

Hey, don't get so piped up.  Timo's patch has already been
merged (thanks, Timo).

But think about it a bit.

If you need an override, you have to write down and maintain
those YesPlease _somewhere_ yourself anyway, outside what I
ship.  Either "config.mak" or "Make" script.

If we have '-include' in the Makefile, we need to make a
decision if what we are adding to the Makefile should be
overridable by that config.mak every time, exactly because
whatever is included becomes part of the Makefile.  IOW, that
"only 20 bytes" adds work for the Makefile maintainer.

"Make" script method is a command line override to the "make"
program, which takes precedence and does not have that problem.
