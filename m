From: Junio C Hamano <junkio@cox.net>
Subject: Re: ***DONTUSE*** Re: [PATCH] Use a hashtable for objects instead of a sorted list
Date: Sun, 12 Feb 2006 10:34:08 -0800
Message-ID: <7v8xsgbf4v.fsf@assigned-by-dhcp.cox.net>
References: <87slqpg11q.fsf@wine.dyndns.org>
	<Pine.LNX.4.63.0602120254260.10235@wbgn013.biozentrum.uni-wuerzburg.de>
	<7virrli9am.fsf@assigned-by-dhcp.cox.net>
	<87accwlt8k.fsf@mid.deneb.enyo.de>
	<7vlkwgdbk6.fsf_-_@assigned-by-dhcp.cox.net>
	<7virrkbsgp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0602121822060.21959@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 12 19:34:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8M34-0005S9-8V
	for gcvg-git@gmane.org; Sun, 12 Feb 2006 19:34:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750850AbWBLSeM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Feb 2006 13:34:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbWBLSeL
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Feb 2006 13:34:11 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:41888 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750809AbWBLSeK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Feb 2006 13:34:10 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060212183241.TVXS6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 12 Feb 2006 13:32:41 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0602121822060.21959@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sun, 12 Feb 2006 18:26:50 +0100
	(CET)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16009>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Could it be the shallow thing?

No, I do not think so.  In the current "master", "next", "pu"
picture, "pu" merges js/obj with the "8856cc69" commit and then
shallow and bind comes later.  That merged version is what I am
testing, and also its second parent, which is "master" plus
hashtable.  In either case, shallow and bind are not part of the
picture.

> Again, sorry for the inconvenience, Junio.

That is not your fault, and I did not mean to sound I am unhappy
about *you*.  I am indeed unhappy because I did not see anything
obviously or subtly wrong with your patch after I moved call to
hashtable_index() in find_object().

But I think Linus nailed it.  I'll see if I can understand his
explanation.
