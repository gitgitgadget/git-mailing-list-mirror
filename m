From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-ls-new-files & make patch, pull, etc.
Date: Tue, 06 Sep 2005 14:08:09 -0700
Message-ID: <7virxdj45i.fsf@assigned-by-dhcp.cox.net>
References: <430A84D1.2050206@linuxmachines.com>
	<7v1x4lz118.fsf@assigned-by-dhcp.cox.net>
	<431DFF30.7010009@linuxmachines.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 06 23:09:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ECkfu-0002cp-NX
	for gcvg-git@gmane.org; Tue, 06 Sep 2005 23:08:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750946AbVIFVIM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Sep 2005 17:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750948AbVIFVIM
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Sep 2005 17:08:12 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:41440 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S1750944AbVIFVIL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Sep 2005 17:08:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050906210809.UJLI9510.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 6 Sep 2005 17:08:09 -0400
To: Jeff Carr <jcarr@linuxmachines.com>
In-Reply-To: <431DFF30.7010009@linuxmachines.com> (Jeff Carr's message of
	"Tue, 06 Sep 2005 13:42:24 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8147>

Jeff Carr <jcarr@linuxmachines.com> writes:

> ... If I remember
> correctly, there was some threads at the beginning of git about how
> datestamps were not accurate so there was no point in setting them(?) Or
> maybe I mis-understood.

The point of those thread was that clocks on machines tend to be
not so accurate and we should not take the timestamps *too*
seriously.  We do record the time as accurately as the clock is
maintained on the machine the commit is made, provided if the
user does not override it with the GIT_COMMIT_DATE environment
variable with a bogus value.

The way you use it to show changes made in a certain timeperiod
is a good example that the information is useful.  The argument
against relying on timestamp too much in that thread you are
remembering was that it should not be used to see which commit
came before which other commit when there is no parent-child
ancestry between them.  It is still a useful hint, and we do use
it as such, but as the recent merge-base fixes show it is just a
hint and relying on it too much tends to screw things up.
