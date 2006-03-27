From: Junio C Hamano <junkio@cox.net>
Subject: Re: Following renames
Date: Sun, 26 Mar 2006 23:30:01 -0800
Message-ID: <7vodzsny4m.fsf@assigned-by-dhcp.cox.net>
References: <20060326014946.GB18185@pasky.or.cz>
	<Pine.LNX.4.64.0603251919170.15714@g5.osdl.org>
	<44264426.8010608@michonline.com> <20060326014946.GB18185@pasky.or.cz>
	<Pine.LNX.4.64.0603251919170.15714@g5.osdl.org>
	<20060326100717.GD18185@pasky.or.cz>
	<Pine.LNX.4.64.0603260829550.15714@g5.osdl.org>
	<20060326191445.GQ18185@pasky.or.cz>
	<Pine.LNX.4.64.0603261415390.15714@g5.osdl.org>
	<20060326223154.GU18185@pasky.or.cz>
	<7vodzsq12g.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603261509320.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 27 09:30:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FNmBB-0007wQ-92
	for gcvg-git@gmane.org; Mon, 27 Mar 2006 09:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750772AbWC0HaH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 27 Mar 2006 02:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750773AbWC0HaG
	(ORCPT <rfc822;git-outgoing>); Mon, 27 Mar 2006 02:30:06 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:20411 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750772AbWC0HaD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 27 Mar 2006 02:30:03 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060327073003.LPJL15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 27 Mar 2006 02:30:03 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18075>

Linus Torvalds <torvalds@osdl.org> writes:

> No. "--sparse" still removes the uninteresting parents of merges. It just 
> doesn't then make the linear history any denser.

Hmph, you are right.  add_parents_to_list() calls prune_fn
unconditionally while running limit_list().

Disabling that with yet another flag might be a possibility but
I suspect then it would not be much different from running
rev-list without path limiter and having the caller process the
result.
