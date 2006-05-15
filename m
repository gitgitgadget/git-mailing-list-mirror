From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: how to display file history?
Date: Mon, 15 May 2006 10:29:20 -0600
Message-ID: <m164k76ylb.fsf@ebiederm.dsl.xmission.com>
References: <CFF307C98FEABE47A452B27C06B85BB670F4FD@hdsmsx411.amr.corp.intel.com>
	<7v64k7wzzf.fsf@assigned-by-dhcp.cox.net>
	<m1ejyv7077.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0605150900510.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	"Brown, Len" <len.brown@intel.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 15 18:30:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fffxc-0001lF-Ut
	for gcvg-git@gmane.org; Mon, 15 May 2006 18:30:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932427AbWEOQaQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 15 May 2006 12:30:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932432AbWEOQaQ
	(ORCPT <rfc822;git-outgoing>); Mon, 15 May 2006 12:30:16 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:2015 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932427AbWEOQaO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 May 2006 12:30:14 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Debian-3) with ESMTP id k4FGTL8T009431;
	Mon, 15 May 2006 10:29:21 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.4/8.13.4/Submit) id k4FGTK7D009430;
	Mon, 15 May 2006 10:29:20 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0605150900510.3866@g5.osdl.org> (Linus
 Torvalds's message of "Mon, 15 May 2006 09:15:00 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20065>

Linus Torvalds <torvalds@osdl.org> writes:

> On Mon, 15 May 2006, Eric W. Biederman wrote:
>> 
>> So that it has a chance of being remembered, and eventually fixed
>> the man pages of git-whatchanged and git-log only sort of tell you
>> that this is even possible.
>
> I don't think this is a man-page issue. I think this is a very basic 
> tutorial issue. 
>
> People still don't seem to realize how flexible (and powerful) the git 
> revision specifications are. It's not just limiting by path, all of these 
> work on _all_ of the "history tools" (whether they be gitk, qgit, "git 
> log", "git whatchanged" or your own home-cooked stuff):
>
>  - "revision based limiting"
>
> 	"a..b", but also "a ^b ^c ^d" or "a --not b c d" for the more 
> 	complex case where you're interested in one (or more) commit, but 
> 	not anything that flows from any of a number of other commits.
>
> 	"--all".
>
>  - "commit date based limiting"
>
> 	"--since=2.weeks.ago" "--since=aug.5th"
>
>  - "limit by number of hits"
>
> 	"-15"
>
>  - "limit by type or state"
>
> 	"--no-merges" and "--unpacked"
>
> And finally
>
>  - "limit by pathname"
>
> and you can combine all of these.
>
> So
>
> 	gitk --all --since=1.month -15 -- t/
>
> will show at most fifteen commits from _any_ branch that changed the 
> test subdirectory in the last month.
>
> And yeah, maybe that isn't a very interesting query, but it's easy to 
> explain and understand, so it's worth explaining early.
>
> And it should be equally obvious to everybody that if it works for "gitk", 
> that means that it works for "qgit", "git log" and "git whatchanged" too, 
> ie this is a very core concept, and not just some tacked-on thing for one 
> special tool.

Sure.  If it gets included in a tutorial is great, but existing
users aren't likely to read through a tutorial if they think they
know what is going on.

Having it documented in the man pages (i.e. the reference
documentation) which is where people look to check up on the fine
points of a command is more likely to matter.  Plus it doesn't
take any creativity to write a man page you just need to describe
what is, which makes man-pages easier to write than documentation
where you aren't certain of who your audience is.

Since it isn't specific to one command we probably need to document
the query limiting in a single file like the diff options are
and then just included it in all of the different man pages.

But regardless of where we put it, it needs to be documented someplace
besides in the email so you don't need to read the code to see that
the option is there. 

Eric
