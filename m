From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Shallow clone: low level machinery.
Date: Tue, 31 Jan 2006 10:22:22 -0800
Message-ID: <7vzmlcz28x.fsf@assigned-by-dhcp.cox.net>
References: <7voe1uchet.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0601301220420.6424@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v8xsxa70o.fsf@assigned-by-dhcp.cox.net>
	<7vmzhc1wz6.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0601311449040.8033@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vd5i81e4e.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0601311904410.10944@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 31 19:24:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F409b-0002t5-5r
	for gcvg-git@gmane.org; Tue, 31 Jan 2006 19:22:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751323AbWAaSWZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 Jan 2006 13:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbWAaSWZ
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jan 2006 13:22:25 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:13052 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751324AbWAaSWY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2006 13:22:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060131182119.RSFI15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 31 Jan 2006 13:21:19 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0601311904410.10944@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Tue, 31 Jan 2006 19:06:28 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15331>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Worse, you cannot pull from older servers into shallow repos.

"have X" means different thing if you do not have matching
grafts information, so I suspect that is fundamentally
unsolvable.

I am not sure you can convince "git-rev-list ^A" to mean "not at
A but things before that is still interesting", especially when
you give many other heads to start traversing from, but if you
can, then you can do things at rev-list command line parameter
level without doing the "exchange and use the same grafts"
trickery.  That _might_ be easier to implement but I do not see
an obvious correctness guarantee in the approach.

Implementation bugs aside, it is obvious the things _would_ work 
correctly with "exchange and use the same grafts" approach.
