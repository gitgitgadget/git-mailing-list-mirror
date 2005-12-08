From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Clean up file descriptors when calling hooks.
Date: Wed, 07 Dec 2005 19:29:47 -0800
Message-ID: <7vr78omfkk.fsf@assigned-by-dhcp.cox.net>
References: <20051208032428.8591.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Thu Dec 08 04:30:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EkCTj-0003vO-VG
	for gcvg-git@gmane.org; Thu, 08 Dec 2005 04:29:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030447AbVLHD3u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Dec 2005 22:29:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030449AbVLHD3u
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Dec 2005 22:29:50 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:40409 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1030447AbVLHD3t (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 Dec 2005 22:29:49 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051208032902.SCNU6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 7 Dec 2005 22:29:02 -0500
To: git@vger.kernel.org
In-Reply-To: <20051208032428.8591.qmail@science.horizon.com>
	(linux@horizon.com's message of "7 Dec 2005 22:24:28 -0500")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13356>

linux@horizon.com writes:

> E.g. imagine if I ran gcc -c file.c, and it assigned file.c to fd 0,
> file.h to fd1, and file.o to fd 2.   Then wants to print a warning
> message... right into the middle of the binary.  (Oversimplified
> example, because gcc is actually several separate programs, but
> hopefully you get the idea.)
>
> It's just safer to leave those fds open to a null device.

Overdangerous example.  Do people realize hooks run without any
locking?
