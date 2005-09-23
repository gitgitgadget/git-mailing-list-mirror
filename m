From: Junio C Hamano <junkio@cox.net>
Subject: Re: [ANNOUNCE] GIT 0.99.7b
Date: Fri, 23 Sep 2005 14:45:43 -0700
Message-ID: <7v4q8ba260.fsf@assigned-by-dhcp.cox.net>
References: <7voe6ki9x7.fsf@assigned-by-dhcp.cox.net>
	<dh0uur$h4g$1@sea.gmane.org> <7v8xxnbjhl.fsf@assigned-by-dhcp.cox.net>
	<20050923205242.GY27375@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: walt <wa1ter@myrealbox.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 23 23:46:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIvMb-0005Gj-Ii
	for gcvg-git@gmane.org; Fri, 23 Sep 2005 23:45:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbVIWVpq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Sep 2005 17:45:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932072AbVIWVpq
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Sep 2005 17:45:46 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:4045 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932071AbVIWVpq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2005 17:45:46 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050923214544.XAWE1974.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Sep 2005 17:45:44 -0400
To: Joel Becker <Joel.Becker@oracle.com>
In-Reply-To: <20050923205242.GY27375@ca-server1.us.oracle.com> (Joel Becker's
	message of "Fri, 23 Sep 2005 13:52:42 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9206>

Joel Becker <Joel.Becker@oracle.com> writes:

> On Fri, Sep 23, 2005 at 01:46:14PM -0700, Junio C Hamano wrote:
>> If you pulled from "master" branch, then --version would still
>> say 0.99.7; I agree it is confusing.  On the other hand, I do
>> not think we would want to increment the version string with
>> every little changes, so...
>
> 	Every little change, no.  But ANNOUNCEd releases should be
> considered 'major' from this point of view.  I don't think a little
> extra version number incrementing is too big a deal.

Yes, 'maint' has the GIT_VERSION bumped in the Makefile
(0.99.7a, 0.99.7b) and that is propagated to 'git --version'.

What I was having trouble was what to do with the stuff we put
in the 'master' between 0.99.7 and 0.99.8.  'maint' was *forked*
from 0.99.7, not just tagging some midpoint in 'master' line for
obvious reasons, so the 'git --version' on the 'master' side
does not have much to do with what happens on the 'maint' side.

We could say, immediately after 0.99.7 is released, bump the
GIT_VERSION in the 'master' branch to 0.99.8-pre or something
like that.

We need to pick something that sorts after '0.99.7a', '0.99.7b',
etc. and before '0.99.8'.  Somebody needs to come up with what
is appropriate for version number ordering scheme employed by
binary packaged distributions.  I know 0.99.8-pre does not sort
before 0.99.8 on Debian.  Probably '0.99.7zzz'?
