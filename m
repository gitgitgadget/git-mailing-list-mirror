From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] daemon: Support a --user-path option.
Date: Fri, 03 Feb 2006 12:52:46 -0800
Message-ID: <7vr76kcggx.fsf@assigned-by-dhcp.cox.net>
References: <20060203202330.1895.60474.stgit@metalzone.distorted.org.uk>
	<20060203202706.1895.70864.stgit@metalzone.distorted.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 03 21:53:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F57vI-0006Zh-7Z
	for gcvg-git@gmane.org; Fri, 03 Feb 2006 21:52:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWBCUwt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Feb 2006 15:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030232AbWBCUwt
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Feb 2006 15:52:49 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:19690 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1030193AbWBCUws (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Feb 2006 15:52:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060203205143.EMUQ15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 3 Feb 2006 15:51:43 -0500
To: Mark Wooding <mdw@distorted.org.uk>
In-Reply-To: <20060203202706.1895.70864.stgit@metalzone.distorted.org.uk>
	(Mark Wooding's message of "Fri, 03 Feb 2006 20:27:06 +0000")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15553>

Mark Wooding <mdw@distorted.org.uk> writes:

> If we're invoked with --user-path=FOO option, then a URL of the form
> git://~USER/PATH/... resolves to the path HOME/FOO/PATH/..., where HOME
> is USER's home directory.

I am probably slow as usual but I do not see how this is useful.

Wouldn't loosening the "request must be absolute if you use
--base-path" check in the area your first patch in the series
touches to also allow paths that start with a '~' be enough?
That way ~alice/foo would remain to be /home/alice/foo (with
/home/alice being alice's $HOME) and ~becky/bar would be
/home2/becky/bar (with /home2/becky being becky's $HOME).

I suppose you are doing something similar to ~/public_html, but
I think that is an independent feature.
