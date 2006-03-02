From: Junio C Hamano <junkio@cox.net>
Subject: Re: git push issue
Date: Thu, 02 Mar 2006 01:58:43 -0800
Message-ID: <7v4q2h6ucs.fsf@assigned-by-dhcp.cox.net>
References: <6d6a94c50603020147l450d1cdfp1bc1747dc79189ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 02 10:59:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEkaI-0003DC-D1
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 10:58:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932295AbWCBJ6q (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 04:58:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932395AbWCBJ6q
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 04:58:46 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:23540 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S932295AbWCBJ6p (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Mar 2006 04:58:45 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060302095509.KQDK17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 2 Mar 2006 04:55:09 -0500
To: Aubrey <aubreylee@gmail.com>
In-Reply-To: <6d6a94c50603020147l450d1cdfp1bc1747dc79189ce@mail.gmail.com>
	(aubreylee@gmail.com's message of "Thu, 2 Mar 2006 17:47:36 +0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17061>

Aubrey <aubreylee@gmail.com> writes:

> aubrey@linux:~/public_html/u-boot.git> git push
> 10.99.22.20:/home/aubrey/public_html/my-git.git master

> error: src refspec master does not match any.
> error: dst refspec master does not match any existing ref on the
> remote and does not start with refs/.

The error message tells you that

 (1) directory you are in (u-boot.git) does not have a ref that
     matches "master".  Do you have the "master" branch?

 (2) remote repository at 10.99.22.20:/home/.../my-git.git does
     not have a ref that matches "master".

The problem on your end must be fixed first.  Then once you have
the master branch in u-boot.git directory (I presume
~/public_html/u-boot.git/.git/refs/heads/master would be the
file you would need to see), then the problem on the other end
needs to be dealt with.

If you are creating a branch over there afresh, you need to
spell it out, like this:

	$ git push 10.99..:.../my-git.git master:refs/heads/master

After you have done that once (hence creating
/home/aubrey/public_html/my-git.git/.git/refs/heads/master file
over there), you can do the command line I quoted at the
beginning of this message.
