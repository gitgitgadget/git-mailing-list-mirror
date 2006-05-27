From: Junio C Hamano <junkio@cox.net>
Subject: Re: ~/.git/config ?
Date: Sat, 27 May 2006 02:11:23 -0700
Message-ID: <7vejyfhlxg.fsf@assigned-by-dhcp.cox.net>
References: <20060526152837.GQ23852@progsoc.uts.edu.au>
	<20060526193325.d2a530a4.tihirvon@gmail.com>
	<20060526163829.GB10488@pasky.or.cz> <1148697382.5599.1.camel@dv>
	<20060527025750.GM11941@pasky.or.cz>
	<Pine.LNX.4.64.0605262007230.5623@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 27 11:11:52 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fjupj-0007Bm-Tn
	for gcvg-git@gmane.org; Sat, 27 May 2006 11:11:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751449AbWE0JLk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 May 2006 05:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWE0JLk
	(ORCPT <rfc822;git-outgoing>); Sat, 27 May 2006 05:11:40 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:39398 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751449AbWE0JLk (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 May 2006 05:11:40 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060527091139.RXJI11027.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 27 May 2006 05:11:39 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605262007230.5623@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 26 May 2006 20:20:14 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20839>

Linus Torvalds <torvalds@osdl.org> writes:

> On Sat, 27 May 2006, Petr Baudis wrote:
>> 
>> ~/.gitrc might get useful for actually doing what ~/.cvsrc or ~/.cgrc
>> does, that is providing default options for git commands. ~/.gitconfig
>> would just give you per-user defaults for the repository config file.
>
> I don't think the two are necessarily any different.

Me neither.  Default options to fall back on if repository
configuration does not specify them and when environments do not
override them -- that's exactly "per-user defaults", nothing else.

Earlier I suggested ~/.git-config, but anything other than
~/.git/config is OK.  ~/.gitrc is fine.  And the order suggested
by Anand sounded fine.

 - use environment (if the value is obtained, stop here)
 - use .git/config (if the value is obtained, stop here)
 - use ~/.git-config (if the value is obtained, stop here)
 - do whatever the program does by default.

>  (a) we might as well use the same syntax. There's no point in having 
>      different syntax for the files, even if they end up having slightly 
>      different usage.

Absolutely.

>  (b) a "user-wide" config file would tend to have different things in it 
>      than a per-repository one, but some of the things it would have in it 
>      are the things that we currently put in the per-repository one. 
>      Notably exactly the "user.name" and "user.email" values.

Yes.  Also "preference" kind of things as opposed to "per
project policy" such as apply.whitespace.
