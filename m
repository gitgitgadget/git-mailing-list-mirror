From: Petr Baudis <pasky@suse.cz>
Subject: Re: git binary directory?
Date: Mon, 7 Nov 2005 10:45:55 +0100
Message-ID: <20051107094555.GS1431@pasky.or.cz>
References: <Pine.LNX.4.64.0511051247330.3316@g5.osdl.org> <7voe4y5w3v.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511052013550.3316@g5.osdl.org> <7vy84249re.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511060816390.3316@g5.osdl.org> <7v7jbly1lh.fsf@assigned-by-dhcp.cox.net> <20051106221952.GP1431@pasky.or.cz> <7virv5wc86.fsf@assigned-by-dhcp.cox.net> <20051107004346.GR1431@pasky.or.cz> <Pine.LNX.4.64.0511061653380.3316@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Nov 07 10:47:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EZ3Zp-0000J9-L3
	for gcvg-git@gmane.org; Mon, 07 Nov 2005 10:46:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932465AbVKGJp7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 7 Nov 2005 04:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932471AbVKGJp7
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Nov 2005 04:45:59 -0500
Received: from w241.dkm.cz ([62.24.88.241]:32943 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932465AbVKGJp7 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 Nov 2005 04:45:59 -0500
Received: (qmail 13687 invoked by uid 2001); 7 Nov 2005 10:45:55 +0100
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0511061653380.3316@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11259>

Dear diary, on Mon, Nov 07, 2005 at 01:54:55AM CET, I got a letter
where Linus Torvalds <torvalds@osdl.org> told me that...
> On Mon, 7 Nov 2005, Petr Baudis wrote:
> > 
> > I want to avoid extra fork()s and exec()s. They seem to routinely matter
> > in orders of magnitude of speed in tight loops.
> 
> Yes. The more I think about it, the less I like the separate binary 
> directory after all. The "git cmd" format is great for high-level 
> commands, but we've always done "git-diff-tree" and "git-rev-list" etc 
> without the "git cmd" indirection.
> 
> The downsides of a separate binary directory appear to be bigger than the 
> upside..

Well, _one_ fork per user invocation (subsequent invocations wouldn't
need it, I already "cache" this kind of stuff in the environment) of a
Cogito command (to get the path to the gitdir) is not such a big deal,
I think.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
