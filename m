From: Petr Baudis <pasky@suse.cz>
Subject: Re: [QUESTION] about .git/info/grafts file
Date: Thu, 19 Jan 2006 18:30:07 +0100
Message-ID: <20060119173006.GE28365@pasky.or.cz>
References: <7v8xtdrqwg.fsf@assigned-by-dhcp.cox.net> <43CF739F.2030204@op5.se> <cda58cb80601190531q238a8f40r@mail.gmail.com> <43CF97AF.9060300@op5.se> <cda58cb80601170928r252a6e34y@mail.gmail.com> <cda58cb80601170932o6f955469y@mail.gmail.com> <7v8xtdrqwg.fsf@assigned-by-dhcp.cox.net> <cda58cb80601190251v5251c8bdh@mail.gmail.com> <20060119130940.GC28365@pasky.or.cz> <Pine.LNX.4.64.0601190842270.3240@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Franck <vagabon.xyz@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Jan 19 18:31:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EzdbN-0002ly-SA
	for gcvg-git@gmane.org; Thu, 19 Jan 2006 18:29:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030233AbWASR2u (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jan 2006 12:28:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751217AbWASR2u
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jan 2006 12:28:50 -0500
Received: from w241.dkm.cz ([62.24.88.241]:4277 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751207AbWASR2t (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jan 2006 12:28:49 -0500
Received: (qmail 11360 invoked by uid 2001); 19 Jan 2006 18:30:07 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <43CF97AF.9060300@op5.se> <Pine.LNX.4.64.0601190842270.3240@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14916>

Dear diary, on Thu, Jan 19, 2006 at 05:58:09PM CET, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> On Thu, 19 Jan 2006, Petr Baudis wrote:
> >
> > Dear diary, on Thu, Jan 19, 2006 at 11:51:22AM CET, I got a letter
> > where Franck <vagabon.xyz@gmail.com> said that...
> > > well, dealing with a repo that has more than 300,000 objects becomes a
> > > burden. A lots of git commands are slow, and cloning it take a while !
> > 
> > Were the objects packed? It would be interesting to have some data about
> > how GIT performs with that much objects...
> 
> The historical linux archive has a lot more than 300,000 objects. In fact, 
> even the _current_ kernel archive has almost 200,000 objects.

Eek. I was burnt by git-count-objects' misleading name. I guess

	git-rev-list --objects --all | wc -l

should give accurate results - 145941 for kernel repository back from
December. I will follow up later with a patch for git-count-objects.

>  - a full clone takes a long time. Git _could_ fairly easily have an 
>    extension to add a date specifier to clone too:
> 
> 	git clone --since=1.month.ago <source> <dst>
> 
>    and just leave any older stuff (you could always fetch it later), but 
>    we've just never done it. Maybe we should. It _should_ be pretty simple 
>    to do from a conceptual standpoint.

Yes. I receive wishes for this time by time and it is buried somewhere
deep in my TODO list. I'm not sure how happy the GIT tools will be about
invalid parent references.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
