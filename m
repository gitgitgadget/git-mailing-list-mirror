From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFC: Subprojects
Date: Mon, 20 Feb 2006 23:57:14 -0800
Message-ID: <7v1wxx4011.fsf@assigned-by-dhcp.cox.net>
References: <43C52B1F.8020706@hogyros.de>
	<Pine.LNX.4.63.0601111740220.17966@wbgn013.biozentrum.uni-wuerzburg.de>
	<43C537C9.4090206@hogyros.de>
	<Pine.LNX.4.64.0601110928350.5073@g5.osdl.org>
	<7vacdzkww3.fsf@assigned-by-dhcp.cox.net>
	<20060220131659.GA8613@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 21 08:57:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FBSOf-0003z5-D7
	for gcvg-git@gmane.org; Tue, 21 Feb 2006 08:57:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWBUH5S (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 21 Feb 2006 02:57:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbWBUH5S
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Feb 2006 02:57:18 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:59313 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751173AbWBUH5R (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Feb 2006 02:57:17 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060221075542.TSIK6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 21 Feb 2006 02:55:42 -0500
To: Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de>
In-Reply-To: <20060220131659.GA8613@informatik.uni-freiburg.de> (Uwe
	Zeisberger's message of "Mon, 20 Feb 2006 14:16:59 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16524>

Uwe Zeisberger <zeisberg@informatik.uni-freiburg.de> writes:

> I'd prefer to have the objects needed to get the linux-2.6 tree in the
> object db of the containing project.  Then "url" is not needed, and you
> could directly use the commit as value for the link.

... which is actually closer to what bind commit approach gives
you.  The tree object in a commit of the containing project has
the full tree object at path linux-2.6/.  The "bind" lines in
the commit object are just notes that tell you where those
trees happen to came from.

> ...  Moreover the condition that the
> "containing" tree must not have an entry named linux-2.6 is handled
> implicitly with links.

I had an impression that two approaches were more or less
equivalent, especially the last round of bound commit approach.
It does not let anything to exist at the bound path in the
containing project either ("read-tree --prefix" rejects it).

> Please correct me if I'm wrong somewhere.  It's some time ago I read the
> patches and this thread.  This mail is the result of some thoughts in my
> vacation.

I have to admit that I haven't thought about the issues involved
for a long time, having no great need nor desire for subprojects
myself, and especially with more generally useful stuff like
performance enhancement for pack generation to occupy me.  I am
not sure I am much more qualified to comment than you are at
this point.

The bound commit lowlevel changes have been sitting in "pu" for
about a month by now, but nobody seems to be interested enough
to start prototyping Porcelain around it.  Neither the gitlink
approach.  After seeing not much interest on the list, I was
hoping that I could retire both WIPs.
