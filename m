From: Junio C Hamano <junkio@cox.net>
Subject: Re: Teach the "git" command to handle some commands internally
Date: Sun, 26 Feb 2006 15:46:27 -0800
Message-ID: <7vy7zx65v0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602261225500.22647@g5.osdl.org>
	<7vbqwt7m3t.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602261518110.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Andreas Ericsson <exon@op5.se>,
	Alex Riesen <raa.lkml@gmail.com>,
	Michal Ostrowski <mostrows@watson.ibm.com>
X-From: git-owner@vger.kernel.org Mon Feb 27 00:46:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FDVb1-0003Y4-FB
	for gcvg-git@gmane.org; Mon, 27 Feb 2006 00:46:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWBZXqc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 26 Feb 2006 18:46:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWBZXqc
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Feb 2006 18:46:32 -0500
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:11749 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751427AbWBZXqc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Feb 2006 18:46:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060226234300.JVCG17437.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 26 Feb 2006 18:43:00 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602261518110.22647@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 26 Feb 2006 15:22:42 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16807>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sun, 26 Feb 2006, Junio C Hamano wrote:
>> 
>> > There's one other change: the search order for external programs is 
>> > modified slightly, so that the first entry remains GIT_EXEC_DIR, but the 
>> > second entry is the same directory as the git wrapper itself was executed 
>> > out of - if we can figure it out from argv[0], of course.
>> 
>> I am not sure about this part, though.
>
> Well, what it means is that _if_ you install all your "git" binaries in 
> some directory that is not in your patch and is not GIT_EXEC_DIR, they 
> will still magically work, assuming you don't do something strange.

I understood that part.  I was wondering if this change defeats
what Michal (you sensibly CC'ed your message to) wanted to do
earlier, going great length trying to avoid mucking with PATH
and "where-ever git itself is found" in the last round.  After
reviewing the change in 77cb17 commit, I realize my worry was
unfounded.
