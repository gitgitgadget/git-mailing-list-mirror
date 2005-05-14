From: Petr Baudis <pasky@ucw.cz>
Subject: Re: speeding up cg-log -u
Date: Sat, 14 May 2005 16:40:57 +0200
Message-ID: <20050514144057.GH3905@pasky.ji.cz>
References: <20050514061914.GB14353@tumblerings.org> <7vu0l62l27.fsf@assigned-by-dhcp.cox.net> <20050514061914.GB14353@tumblerings.org> <20050514103937.GA3905@pasky.ji.cz> <7vk6m212g7.fsf@assigned-by-dhcp.cox.net> <20050514142325.GC14353@tumblerings.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	torvalds@osdl.org
X-From: git-owner@vger.kernel.org Sat May 14 16:41:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWxpD-0000fs-2Q
	for gcvg-git@gmane.org; Sat, 14 May 2005 16:41:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262774AbVENOlD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 10:41:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262775AbVENOlC
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 10:41:02 -0400
Received: from w241.dkm.cz ([62.24.88.241]:40857 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262774AbVENOk6 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 May 2005 10:40:58 -0400
Received: (qmail 6049 invoked by uid 2001); 14 May 2005 14:40:57 -0000
To: Zack Brown <zbrown@tumblerings.org>
Content-Disposition: inline
In-Reply-To: <20050514142325.GC14353@tumblerings.org>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sat, May 14, 2005 at 04:23:25PM CEST, I got a letter
where Zack Brown <zbrown@tumblerings.org> told me that...
> On Sat, May 14, 2005 at 04:17:44AM -0700, Junio C Hamano wrote:
> > Not wanting to keep the whole object because of their size is
> > understandable since the users of "struct object" derivatives
> > rarely if ever seem to free them once they get hold of them.
> > And not wanting to think ahead about what is worth keeping (like
> > names for tree entries back then, or commit author names) is
> > also understandable, but it still is frustrating.
> 
> So if this design is changed to suit -u, would a further redesign be needed
> to support an option to filter on keywords in the body of the changelog
> entry? Perhaps this will result in a net slowdown for the usual case of just
> grabbing all log entries.

I admit not looking at this code for a rather long time, but what about
just telling the commit parser what stuff are you interested in and it
would leave the rest of the structure fields NULL? That would mean only
slight memory usage increase and basically no time increase.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
