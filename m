From: Junio C Hamano <junkio@cox.net>
Subject: Re: diffstat wierdness with 'git format-patch' output
Date: Mon, 13 Feb 2006 22:09:30 -0800
Message-ID: <7vveviv5d1.fsf@assigned-by-dhcp.cox.net>
References: <20060214055425.GA32261@kroah.com>
	<20060214055648.GA592@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 14 07:09:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F8tNl-0000Uo-0L
	for gcvg-git@gmane.org; Tue, 14 Feb 2006 07:09:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030423AbWBNGJe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 14 Feb 2006 01:09:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030477AbWBNGJe
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Feb 2006 01:09:34 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:19451 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1030423AbWBNGJd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2006 01:09:33 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060214060825.DVEW3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 14 Feb 2006 01:08:25 -0500
To: Greg KH <greg@kroah.com>
In-Reply-To: <20060214055648.GA592@kroah.com> (Greg KH's message of "Mon, 13
	Feb 2006 21:56:48 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16116>

Greg KH <greg@kroah.com> writes:

> Hm, in looking at it closer, it's probably the last two lines of the
> file, the signature that git format-patch adds to the message:
> 	-- 
> 	1.2.0

If that is the case, it's unfortunate that diffstat is broken
and is not properly counting lines to tell which lines are part
of the patch and which lines are not.

Have you tried "git apply --stat" instead?

> Any way to suppress these?

Sorry, there is no option to disable that, but the stuff is
GPLv2 so you can do whatever ;-).

The string "-- \n" is an established convention to mark the
beginning of the signature (or whatever inmaterial stuff that
follow the message contents), so changing the marker is
pointless -- if we want the option it should be to delete those
two lines altogether.

I personally find it useful to see the trend of version of tools
people use on the public mailing list, and that was the primary
reason it is there.

Have you tried "git apply --stat --summary" instead?
