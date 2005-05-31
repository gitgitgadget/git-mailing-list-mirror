From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Make git-update-cache --force-remove regular
Date: Tue, 31 May 2005 12:52:17 -0700
Message-ID: <7vpsv7xjf2.fsf@assigned-by-dhcp.cox.net>
References: <20050531165243.GD7013@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: torvalds@osdl.org, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 31 21:51:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DdCkB-0001Ma-7z
	for gcvg-git@gmane.org; Tue, 31 May 2005 21:49:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVEaTwX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 15:52:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVEaTwX
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 15:52:23 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:59055 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S261357AbVEaTwT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 May 2005 15:52:19 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050531195218.WXUH26972.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 31 May 2005 15:52:18 -0400
To: Petr Baudis <pasky@ucw.cz>
In-Reply-To: <20050531165243.GD7013@pasky.ji.cz> (Petr Baudis's message of
 "Tue, 31 May 2005 18:52:43 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "PB" == Petr Baudis <pasky@ucw.cz> writes:

PB> Make the --force-remove flag behave same as --add, --remove and
PB> --replace. This means I can do

PB> 	git-update-cache --force-remove -- file1.c file2.c

PB> which is probably saner and also makes it easier to use in cg-rm.

I am ambivalent about this.  Although I like the semantic
clean-up your proposed change makes, at the same time: 

  $ git-update-cache --force-remove one --add two

used to remove "one" and add "two", which has to be now written
as two separate calls, which is a slight a performance hit of
having to read the 1.6MB cache twice.  Maybe it does not matter,
or the new usage's convenience outweighs it; I cannot tell
offhand.

