From: Junio C Hamano <junkio@cox.net>
Subject: Re: gitweb: using quotemeta
Date: Thu, 28 Sep 2006 16:18:28 -0700
Message-ID: <7vodszshq3.fsf@assigned-by-dhcp.cox.net>
References: <20060928211600.97412.qmail@web31808.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Sep 29 01:19:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GT59x-0007Wm-Q2
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 01:19:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030386AbWI1XSw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Sep 2006 19:18:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030391AbWI1XSv
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Sep 2006 19:18:51 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:20639 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751027AbWI1XS3 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Sep 2006 19:18:29 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060928231828.KZPO12909.fed1rmmtao05.cox.net@fed1rmimpo02.cox.net>;
          Thu, 28 Sep 2006 19:18:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id TzJW1V01o1kojtg0000000
	Thu, 28 Sep 2006 19:18:31 -0400
To: ltuikov@yahoo.com
In-Reply-To: <20060928211600.97412.qmail@web31808.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Thu, 28 Sep 2006 14:15:59 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28065>

Luben Tuikov <ltuikov@yahoo.com> writes:

> Commit ab41dfbfd4f3f9fedac71550027e9813b11abe3d introduces
> the use of quotemeta to quote the $filename of the snapshot.
> The commit message explains:
>
>     Just in case filename contains end of line character.
>
> But quotemeta quotes any characters not matching /A-Za-z_0-9/.
> Which means that we get strings like this:
>     
>     linux\-2\.6\.git\-5c2d97cb31fb77981797fec46230ca005b865799\.tar\.gz
>
> Is this the desired behavior?  FWIW, the backslash character
> is not part of of the name, but ended up when the snapshot was written
> to the filesystem.

Ouch, that was a sloppy planning and coding, and sloppier
reviewing.  Sorry.

What is the right quoting there?  Just quoting double-quotes?
