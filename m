From: Junio C Hamano <junkio@cox.net>
Subject: Re: local git push bug wrt GIT_OBJECT_DIRECTORY
Date: Fri, 06 Jan 2006 14:36:58 -0800
Message-ID: <7vbqypt245.fsf@assigned-by-dhcp.cox.net>
References: <1135922900.2103.37.camel@della.draisey.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 06 23:38:14 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ev0Df-0007b1-HG
	for gcvg-git@gmane.org; Fri, 06 Jan 2006 23:38:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752573AbWAFWhL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Jan 2006 17:37:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752569AbWAFWhK
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Jan 2006 17:37:10 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:131 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1752573AbWAFWhF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 6 Jan 2006 17:37:05 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060106223549.SBYY20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 6 Jan 2006 17:35:49 -0500
To: Matt Draisey <matt@draisey.ca>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14219>

Matt Draisey <matt@draisey.ca> writes:

> Using git-send-pack to push to a local repository will propagate the
> environment variable GIT_OBJECT_DIRECTORY to git-receive-pack.
> git-receive-pack correctly ignores GIT_DIR (as opposed to what the
> documentation says) but, unfortunately, honours GIT_OBJECT_DIRECTORY.

Thanks for noticing.

True; receive-pack does not "ignore", but is explicitly told to
use the other repository by invoking send-pack.  

> It's not clear to me whether the correct behaviour is for git-send-pack
> to clean up its environment before it execs or for git-receive-pack to
> ignore most GIT variables.

Probably GIT_OBJECT_DIRECTORY should not be propagated;
GIT_ALTERNATE_OBJECT_DIRECTORIES neither.
