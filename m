From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-commit: allow From: line to be entered in commit message
Date: Fri, 13 Jan 2006 12:33:48 -0800
Message-ID: <7virsn50lv.fsf@assigned-by-dhcp.cox.net>
References: <20060112093700.1d3d25db.seanlkml@sympatico.ca>
	<20060112190031.GH14196@ca-server1.us.oracle.com>
	<7vhd89mc0y.fsf@assigned-by-dhcp.cox.net>
	<20060113065855.GJ14196@ca-server1.us.oracle.com>
	<7vpsmwbo9s.fsf@assigned-by-dhcp.cox.net>
	<20060113191231.GM14196@ca-server1.us.oracle.com>
	<7vhd877w9m.fsf@assigned-by-dhcp.cox.net>
	<20060113200124.GO14196@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 13 21:34:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ExVcQ-00046u-Ml
	for gcvg-git@gmane.org; Fri, 13 Jan 2006 21:33:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422931AbWAMUdv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 13 Jan 2006 15:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422932AbWAMUdv
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jan 2006 15:33:51 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:12502 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1422931AbWAMUdu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jan 2006 15:33:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060113203255.FACM15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 13 Jan 2006 15:32:55 -0500
To: Joel Becker <Joel.Becker@oracle.com>
In-Reply-To: <20060113200124.GO14196@ca-server1.us.oracle.com> (Joel Becker's
	message of "Fri, 13 Jan 2006 12:01:24 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14646>

Joel Becker <Joel.Becker@oracle.com> writes:

> On Fri, Jan 13, 2006 at 11:39:17AM -0800, Junio C Hamano wrote:
>> That's what I do.  Although I use git-am not git-applymbox, both
>> of them are designed to work that way.
>
> 	While I can see that git-am and git-applymbox have different
> options for the same basic task, I can't quite see why one would be
> preferred to the other.  What does git-am do that git-applymbox does
> not?

Sorry about the confusion.  This is turning into a FAQ and it is
all _my_ fault [*1*].

Some historical background.

 - "applymbox" was there first.  It was renamed from a tool
   'dotest' Linus had used since BK days, with somewhat
   unextensible command line syntax.

 - "am" was invented later, to majorly redo what applymbox does
   with extensible command line syntax.  It is supposed to do
   everything applymbox does, but the only thing it does not
   support is to be command-line compatible.

The primary reason why I kept applymbox maintained is because
many "How to hack kernel with git" documents floating around
talk about applymbox, and it still is used by Linus to apply
patches with his trained fingers.  Worse yet, it could be that
applymbox is used as a building block in larger private scripts
used by kernel developers, and its removal would force them to
update their scripts to use "am" instead.  I do not want to see
the kernel people spending their time on adjusting their private
tools for git changes unnecessarily; their time is better spent
on improving the kernel.

So in short, I tend to recommend "am" to new people, but
"applymbox" is still usable.


[Footnote]

*1* I do not mind keeping applymbox maintained, but at the same
time I know I would feel it stupid to carry two tools that do
almost the same thing if it were somebody else's project, and
every time this issue comes up I feel the urge to say "in 3
months, git-applymbox will be removed, please get used to
git-am", which so far I ended up resisting.
