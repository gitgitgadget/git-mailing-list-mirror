From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add compat/setenv.c, use in git.c.
Date: Sun, 04 Dec 2005 14:24:22 -0800
Message-ID: <7vy830ec15.fsf@assigned-by-dhcp.cox.net>
References: <28409.1133564908@lotus.CS.Berkeley.EDU>
	<43935A9E.2060602@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jason Riedy <ejr@EECS.Berkeley.EDU>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 04 23:25:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ej2HW-0004o0-7Q
	for gcvg-git@gmane.org; Sun, 04 Dec 2005 23:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932362AbVLDWY1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Dec 2005 17:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVLDWY1
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Dec 2005 17:24:27 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:43990 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932362AbVLDWY0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Dec 2005 17:24:26 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051204222349.VUJO15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 4 Dec 2005 17:23:49 -0500
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <43935A9E.2060602@zytor.com> (H. Peter Anvin's message of "Sun,
	04 Dec 2005 13:07:42 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13193>

"H. Peter Anvin" <hpa@zytor.com> writes:

> Wouldn't this be a good case for using alloca()?

Perhaps, but considering that (1) this function is not something
frequently called anyway, and (2) the proposed change would make
it the first alloca() user, and (3) this is compatibility
replacement function, I'd rather choose to keep it "old, known
to work at more places" malloc/free pair, and not having to
worry about it.

But now you quote the patch, sizeof(char) looks funny.  Isn't it
always 1 by definition?
