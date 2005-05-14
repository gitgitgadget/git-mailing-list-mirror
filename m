From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Resurrect diff-tree-helper -R
Date: Sat, 14 May 2005 17:03:56 +0200
Message-ID: <20050514150356.GK3905@pasky.ji.cz>
References: <7v7jij3htp.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504301805300.2296@ppc970.osdl.org> <20050513224529.GF32232@pasky.ji.cz> <7vhdh691gs.fsf@assigned-by-dhcp.cox.net> <20050513233354.GK32232@pasky.ji.cz> <7vmzqy7k47.fsf@assigned-by-dhcp.cox.net> <7voebe63zs.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 14 17:04:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWyBP-0002mT-Jz
	for gcvg-git@gmane.org; Sat, 14 May 2005 17:04:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262778AbVENPEB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 11:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262779AbVENPEB
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 11:04:01 -0400
Received: from w241.dkm.cz ([62.24.88.241]:2458 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262778AbVENPD5 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2005 11:03:57 -0400
Received: (qmail 9993 invoked by uid 2001); 14 May 2005 15:03:56 -0000
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7voebe63zs.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, May 14, 2005 at 02:33:11AM CEST, I got a letter
where Junio C Hamano <junkio@cox.net> told me that...
> Another possibility.  How about generating the following _only_
> when mode changes (including create and delete), even for human
> consumption?  There will be _no_ such line when mode or type
> does not change.
> 
> # mode: 100644 100755 path/to/a/file/that/changed/mode
> # mode: 100644 120000 path/to/a/file/that/changed/to/symlink
> # mode: 100644 100644 path/to/a/file/with/no/mode/change
> # mode: . 100644 path/to/a/new/file
> # mode: 100644 . path/to/a/deleted/file
> 
> This is not "something like this", but a proposal for the exact
> output format specification (I am going to code immediately).
> Each token above is separated with exactly one ' ' (ASCII 0x20)
> each, and such a line comes immediately before the patch for the
> file.  Showing both mode bits is to prepare for the case you
> would want to apply the patch in reverse.
> 
> This is for machine consumption and there is no need to force
> them to parse out -> and (), so I dropped them.  And mode or
> type change happens so rarely, it would be OK for human
> consumption if we show these garbage (from human point of view)
> only when things change.  Can you parse this, or do you always
> want to have them even if nothing changes?
> 
> Let's see how this would look like to humans.

For humans I'd say "Mode change" instead of "mode" would be better, and
for machines I still think "@" would be better than "#". "#" can occur
quite naturally in some code snippets or whatever pasted to the commit
message, which is extremely unlikely for "@". What are the advantages
of "#"?

I like the rest. That's basically what I've imagined, and without the
arrows it's even better. :-)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
