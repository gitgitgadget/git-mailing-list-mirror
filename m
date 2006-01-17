From: Petr Baudis <pasky@suse.cz>
Subject: Re: RFC: Subprojects
Date: Tue, 17 Jan 2006 15:09:37 +0100
Message-ID: <20060117140937.GI28365@pasky.or.cz>
References: <43C52B1F.8020706@hogyros.de> <Pine.LNX.4.64.0601141055210.13339@g5.osdl.org> <7vek3ah8f9.fsf@assigned-by-dhcp.cox.net> <200601161144.48245.Josef.Weidendorfer@gmx.de> <7vek37rj83.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0601170001130.25300@iabervon.org> <7vfynnfkc8.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 15:08:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EyrVg-0000dc-0U
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 15:08:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932500AbWAQOI3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 09:08:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932503AbWAQOI3
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 09:08:29 -0500
Received: from w241.dkm.cz ([62.24.88.241]:4834 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932500AbWAQOI2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Jan 2006 09:08:28 -0500
Received: (qmail 407 invoked by uid 2001); 17 Jan 2006 15:09:37 +0100
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfynnfkc8.fsf@assigned-by-dhcp.cox.net>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14794>

Dear diary, on Tue, Jan 17, 2006 at 07:18:47AM CET, I got a letter
where Junio C Hamano <junkio@cox.net> said that...
> Here again I am thinking aloud, remembering the earlier example
> of an embedded linux project that ships with linux-2.6 and
> gcc-4.0, along with its own README and Makefile at the toplevel
> and src/ for its own sources.  The tools at the tip of "pu"
> should be able to let you do the following:
> 
> 	$ git cat-file commit $such_toplevel_commit
> 	tree $tree
>         parent $parent
>         bind $primarysub /
>         bind $linuxsub linux-2.6/
>         bind $gccsub gcc-4.0/
> 	author A U Thor <author@example.com> 1137392543 -0800
> 	commmitter A U Thor <author@example.com> 1137392543 -0800
> 
>         An example.
> 
> where $tree is the object name of the whole tree (no "gitlink"
> object), $primarysub and $linuxsub are the object names of
> commit objects for the primary subproject (which sits at the
> rootlevel) and another subproject (which sits at linux-2.6/
> subdirectory).

I perhaps missed this in the thread, but is it really so useful to bind
the subprojects to specific commits? If you care about reproducing
specific configuration, all you have to do is tag and seek recursively -
and even having a separate tiny git branch tracking just a single file
listing the commit ids of subprojects seems more elegant to me than just
forcing the specific commit ids. In the general case, I think it most
usually goes "this project#branch, the latest commit you can get", so
I'm not really convinced that you are optimizing for the right case at
all.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
