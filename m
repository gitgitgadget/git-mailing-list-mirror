From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC, PATCH] Usage message clean-up, take #2
Date: Sun, 11 Dec 2005 02:15:22 -0800
Message-ID: <7vu0dglz2d.fsf@assigned-by-dhcp.cox.net>
References: <20051211095549.GB4919@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 11 11:16:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElOF9-00007k-VY
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 11:15:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751317AbVLKKPY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Dec 2005 05:15:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbVLKKPY
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Dec 2005 05:15:24 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:50879 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751317AbVLKKPY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Dec 2005 05:15:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051211101447.HDST3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 11 Dec 2005 05:14:47 -0500
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20051211095549.GB4919@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Sun, 11 Dec 2005 10:55:49 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13496>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> The scripts will also set USAGE and possibly LONG_USAGE before they
> source git-sh-setup. If LONG_USAGE isn't set it defaults to USAGE.

Looks like a good start to allow us to mechanically generate
parts of the manpages in the future.

Last time I played around with various bourne derivative shells,
I was annoyed by that scripts sourced with '.'  behaved slightly
differently regarding positional arguments such as "$1", which
may be one thing to watch out for (sorry, I do not remember the
details right now, other than one case: ". ./foobra.sh arg1
arg2", and depending on the shell the value of $# and $1
foobra.sh sees was different.  I do not think this would matter
for our purpose because in our case ". script" form is never
used with extra parameters).
