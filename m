From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] gitweb: start to generate PATH_INFO URLs
Date: Fri, 29 Sep 2006 15:30:47 -0700
Message-ID: <7v8xk2jofc.fsf@assigned-by-dhcp.cox.net>
References: <20060929221641.GC2871@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 30 00:30:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTQsd-0004vN-Sf
	for gcvg-git@gmane.org; Sat, 30 Sep 2006 00:30:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932098AbWI2Wat (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 18:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932109AbWI2Wat
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 18:30:49 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:38896 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932098AbWI2Was (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Sep 2006 18:30:48 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060929223047.HTVK2704.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Sep 2006 18:30:47 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id UNWj1V00B1kojtg0000000
	Fri, 29 Sep 2006 18:30:43 -0400
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060929221641.GC2871@admingilde.org> (Martin Waitz's message of
	"Sat, 30 Sep 2006 00:16:41 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28134>

Martin Waitz <tali@admingilde.org> writes:

> Instead of providing the project as a ?p= parameter it is simply appended
> to the base URI.
> All other parameters are appended to that, except for ?a=summary which
> is the default and can be omitted.

Supporting PATH_INFO in the sense that we do sensible things
when we get called with one is one thing, but generating such a
URL that uses PATH_INFO is a different thing.  I suspect not
everybody's webserver is configured to call us with PATH_INFO,
so this should be conditional.
