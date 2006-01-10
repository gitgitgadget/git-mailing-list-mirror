From: Junio C Hamano <junkio@cox.net>
Subject: Re: git pull on Linux/ACPI release tree
Date: Mon, 09 Jan 2006 19:04:34 -0800
Message-ID: <7v4q4cbx6l.fsf@assigned-by-dhcp.cox.net>
References: <20060109225143.60520.qmail@web31807.mail.mud.yahoo.com>
	<Pine.LNX.4.64.0601091845160.5588@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 10 04:04:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ew9oM-0000JR-Vm
	for gcvg-git@gmane.org; Tue, 10 Jan 2006 04:04:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750956AbWAJDEg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 9 Jan 2006 22:04:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750958AbWAJDEg
	(ORCPT <rfc822;git-outgoing>); Mon, 9 Jan 2006 22:04:36 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:23767 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750954AbWAJDEg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2006 22:04:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060110030439.SNWV25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 9 Jan 2006 22:04:39 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0601091845160.5588@g5.osdl.org> (Linus Torvalds's
	message of "Mon, 9 Jan 2006 18:50:14 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14402>

Linus Torvalds <torvalds@osdl.org> writes:

> Now, obviously, for various reasons we want to avoid having those kinds of 
> linkages as much as possible. We like to have develpment of different 
> subsystems as independent as possible, not because it makes for a "more 
> readable history", but because it makes it a lot easier to debug - if we 
> have three independent features/development trees, they can be debugged 
> independently too, while any linkages inevitably also mean that any bugs 
> end up being interlinked..
>
> 		Linus

Yes.  If subproject B uses new features from A (either upstream
or sibling subproject), pulling A into B is inevitable.

On the other hand, if such merges becomes too frequent, it may
be a sign that A's feature set and interface is still changing
too rapidly for downstream use, but developers A and B are not
communicating well and B has not noticed that B might be better
off taking a break, addressing other non-overlapping areas while
giving a bit of time for A to settle things down.

An SCM is just _one_ of the ways for developers to communicate,
it will never be a replacement for developer communication.
