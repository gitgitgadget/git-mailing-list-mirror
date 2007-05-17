From: Petr Baudis <pasky@suse.cz>
Subject: Re: Smart fetch via HTTP?
Date: Thu, 17 May 2007 14:40:06 +0200
Message-ID: <20070517124006.GO4489@pasky.or.cz>
References: <20070515201006.GD3653@efreet.light.src>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jan Hudec <bulb@ucw.cz>
X-From: git-owner@vger.kernel.org Thu May 17 14:40:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HofHE-00047P-4N
	for gcvg-git@gmane.org; Thu, 17 May 2007 14:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338AbXEQMkK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 08:40:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754382AbXEQMkK
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 08:40:10 -0400
Received: from w241.dkm.cz ([62.24.88.241]:47078 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754338AbXEQMkI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 08:40:08 -0400
Received: (qmail 5568 invoked by uid 2001); 17 May 2007 14:40:06 +0200
Content-Disposition: inline
In-Reply-To: <20070515201006.GD3653@efreet.light.src>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47515>

  Hi,

On Tue, May 15, 2007 at 10:10:06PM CEST, Jan Hudec wrote:
> Did anyone already think about fetching over HTTP working similarly to the
> That is rather than reading the raw content of the repository, there would be
> a CGI script (could be integrated to gitweb), that would negotiate what the
> client needs and then generate and send a single pack with it.

  frankly, I'm not that excited. I'm not disputing that this would be
useful, but I have my doubts on just how *much* useful it would be - I'm
not so sure the set of users affected is really all that large. So I'm
just cooling people down here. ;-))

> Mercurial and bzr both have this option. It would IMO have three benefits:
>  - Fast access for people behind paranoid firewalls, that only let http and
>    https (you can tunel anything through, but only to port 443) through.

  How many users really have this problem? I'm not so sure. There are
certainly some, but enough for this to be a viable argument?

>  - Can be run on shared machine. If you have web space on machine shared
>    by many people, you can set up your own gitweb, but cannot/are not allowed
>    to start your own network server for git native protocol.

  You need to have CGI-enabled hosting, set up the CGI script etc. -
overally, the setup is similarly complicated as git-daemon setup, so
it's not "zero-setup" solution anymore.

  Again, I'm not sure just how many people are in the situation that
they can run real CGI (not just PHP) but not git-daemon.

>  - Less things to set up. If you are setting up gitweb anyway, you'd not need
>    to set up additional thing for providing fetch access.

  Except, well, how do you "set it up"? You need to make sure
git-update-server-info is run, yes, but that shouldn't be a problem (I'm
not so sure if git does this for you automagically - Cogito would...).

  I think 95% of people don't set up gitweb.cgi either for their small
HTTP repositories. :-)

  Then again, it's not that it would be really technically complicated -
adding "give me a bundle" support to gitweb should be pretty easy.
However, this support has some "social" costs as well: no compatibility
with older git versions, support cost, confusion between dumb HTTP and
gitweb HTTP transports, more lack of motivation for improving dumb HTTP
transport...

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Ever try. Ever fail. No matter. // Try again. Fail again. Fail better.
		-- Samuel Beckett
