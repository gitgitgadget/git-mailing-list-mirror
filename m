From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cloning speed comparison, round II
Date: Sat, 12 Nov 2005 20:46:46 +0100
Message-ID: <20051112194646.GE30496@pasky.or.cz>
References: <20051112155302.GD30496@pasky.or.cz> <Pine.LNX.4.64.0511121134170.3263@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 12 20:48:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eb1Ku-0005KJ-3S
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 20:46:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932482AbVKLTqt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 12 Nov 2005 14:46:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbVKLTqt
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Nov 2005 14:46:49 -0500
Received: from w241.dkm.cz ([62.24.88.241]:47837 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932482AbVKLTqt (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 12 Nov 2005 14:46:49 -0500
Received: (qmail 7840 invoked by uid 2001); 12 Nov 2005 20:46:46 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511121134170.3263@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11700>

Dear diary, on Sat, Nov 12, 2005 at 08:40:11PM CET, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> 
> 
> On Sat, 12 Nov 2005, Petr Baudis wrote:
> >
> >              rsync   git+ssh(*)   git(**)   http
> > 
> > git.git      0m45s   0m34s        5m30s     4m01s (++)
> > 
> > cogito.git   2m09s   1m54s (+)    4m30s     15m11s (only single run)
> > 
> > 
> > (*) git+ssh was to master.kernel.org, which was under significant load
> >     from some seemingly runaway gzip process, so that slowed things
> >     down.
> > 
> > (**) The unpacking was slooooooooow yet the load was quite low. This
> >      should be investigated, the native git fetching is much slower
> >      than even HTTP.

(BTW, it's obviously not much slower than HTTP - I wrote that after the
first git run, but I screwed up myself at that one.)

> So I think the difference between your git+ssh and git tests are purely 
> due to the fact that master.kernel.org sees a lot less load (both in CPU 
> and in networking) than the public sites, and the time differences have 
> nothing to do with the protocol per se.

Well, at the time of fetching, master.kernel.org with git+ssh had load
about ~3.5 and some wild gzip was eating most of the CPU there. So if
the git protocol still manages to be TEN times slower while rsync goes
full speed from that machine, I would say that this means the git server
requires way too much CPU.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
