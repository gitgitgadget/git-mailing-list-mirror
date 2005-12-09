From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] use "git init-db" in tests
Date: Fri, 09 Dec 2005 12:46:51 -0800
Message-ID: <7vmzja2e2s.fsf@assigned-by-dhcp.cox.net>
References: <20051208202555.GA3046@steel.home>
	<7vu0dje2oi.fsf@assigned-by-dhcp.cox.net>
	<20051208210251.GB19423@steel.home>
	<7v7jafcmev.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0512082336i674932bapd631d559e80cad79@mail.gmail.com>
	<7vlkyu7l05.fsf@assigned-by-dhcp.cox.net>
	<81b0412b0512090259l5f06f6d6n5416e271af36d6a1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 09 21:48:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ekp8s-0007iB-E0
	for gcvg-git@gmane.org; Fri, 09 Dec 2005 21:46:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932338AbVLIUqz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Dec 2005 15:46:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932428AbVLIUqz
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Dec 2005 15:46:55 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:62083 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932338AbVLIUqy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Dec 2005 15:46:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051209204601.BBEM20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 9 Dec 2005 15:46:01 -0500
To: Alex Riesen <raa.lkml@gmail.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13435>

Alex Riesen <raa.lkml@gmail.com> writes:

> In my case it was the freshly build directory where a chmod 0666 * was
> done. This directory wont rebuild (the dates are correct), and the
> tests run, as if nothing happened.

I see.  I appreciate your honesty ;-), it is a pilot error
alright, but surely it would be nicer if we catch it.

Although your proposed change makes it harder to implement
my desire to be able to run tests with installed binaries than
it already is, I'd take the patch for now.  It would catch this
particular pilot error.

I however would think adding a dependency in t/Makefile to
make sure the top level is built before starting to run test a
overkill (I think I've seen some projects to do that), so I'd
not go there.
