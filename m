From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] merge-recursive: leave unmerged entries in the index.
Date: Sun, 11 Dec 2005 01:42:38 -0800
Message-ID: <7v64pwnf5d.fsf@assigned-by-dhcp.cox.net>
References: <7vek4ktai1.fsf@assigned-by-dhcp.cox.net>
	<20051211092531.GA4919@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 11 10:44:08 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ElNjG-0000Um-O0
	for gcvg-git@gmane.org; Sun, 11 Dec 2005 10:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161087AbVLKJmk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Dec 2005 04:42:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161107AbVLKJmk
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Dec 2005 04:42:40 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:6087 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1161087AbVLKJmj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Dec 2005 04:42:39 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051211094242.PAYZ25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 11 Dec 2005 04:42:42 -0500
To: Fredrik Kuivinen <freku045@student.liu.se>
In-Reply-To: <20051211092531.GA4919@c165.ib.student.liu.se> (Fredrik
	Kuivinen's message of "Sun, 11 Dec 2005 10:25:31 +0100")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13494>

Fredrik Kuivinen <freku045@student.liu.se> writes:

> It might be cleaner to use
>
> runProgram(['git-update-index', '-z', '--index-info'],
>            input="0 " + ("0" * 40) + "\t" + path + "\0" + \
>                  "%o %s %d\t%s\0" % (oMode, oSHA1, 1, path) + \
>                  "%o %s %d\t%s\0" % (aMode, aSHA1, 2, path) + \
>                  "%o %s %d\t%s\0" % (bMode, bSHA1, 3, path))
>
> here instead. With this code we will get an exception if
> git-update-index exits with an error code. It is also consistent with
> the rest of the code.

Thanks.  I did not know how to feed the string through
runProgram (well, I did not look close enough).
