From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-diff-tree rename detection bug
Date: Wed, 14 Sep 2005 14:55:21 -0700
Message-ID: <7vfys7fh6e.fsf@assigned-by-dhcp.cox.net>
References: <59a6e583050914094777c4fe96@mail.gmail.com>
	<7v3bo7jxdn.fsf@assigned-by-dhcp.cox.net>
	<59a6e5830509141208282166c8@mail.gmail.com>
	<7vmzmfh2y1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0509141352010.26803@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 14 23:57:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFfDx-0005Pg-Vx
	for gcvg-git@gmane.org; Wed, 14 Sep 2005 23:55:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964899AbVINVzX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Sep 2005 17:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964942AbVINVzX
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Sep 2005 17:55:23 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:24709 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S964899AbVINVzX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Sep 2005 17:55:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050914215523.QZNG24420.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 14 Sep 2005 17:55:23 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0509141352010.26803@g5.osdl.org> (Linus Torvalds's
	message of "Wed, 14 Sep 2005 13:53:34 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8570>

Linus Torvalds <torvalds@osdl.org> writes:

> Undoing that second one (068eac91ce04b9aca163acb1927c3878c45d1a07) fixes 
> the valgrind errors.

Thanks; reverted and applied your other patch and pushed them
out.

I think the filepairs are sometimes shared so to be able to free
them properly, we need to reference count.  Ugh.
