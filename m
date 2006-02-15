From: Petr Baudis <pasky@suse.cz>
Subject: Re: Shared repositories and umask
Date: Wed, 15 Feb 2006 14:05:38 +0100
Message-ID: <20060215130538.GO31278@pasky.or.cz>
References: <mj+md-20060215.120104.14337.atrey@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 15 14:05:19 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9MLI-0007hc-Iq
	for gcvg-git@gmane.org; Wed, 15 Feb 2006 14:05:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422783AbWBONEs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 15 Feb 2006 08:04:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422784AbWBONEs
	(ORCPT <rfc822;git-outgoing>); Wed, 15 Feb 2006 08:04:48 -0500
Received: from w241.dkm.cz ([62.24.88.241]:47303 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1422783AbWBONEs (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 15 Feb 2006 08:04:48 -0500
Received: (qmail 15200 invoked by uid 2001); 15 Feb 2006 14:05:38 +0100
To: Martin Mares <mj@ucw.cz>
Content-Disposition: inline
In-Reply-To: <mj+md-20060215.120104.14337.atrey@ucw.cz>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16240>

  Hi,

Dear diary, on Wed, Feb 15, 2006 at 01:19:07PM CET, I got a letter
where Martin Mares <mj@ucw.cz> said that...
> I'm playing with a shared repository and I am still unable to get the
> file and directory permissions kept correctly, that is writeable to
> a group.
> 
> Setting the `core.sharedrepository' flag helps a bit, but not completely:
> the object files and directories are group-writeable, but for example new
> head refs aren't.

  actually, this is not necessary, since when pushing to shared
repositories, the new ref is created in the directory as a lockfile and
then moved over the original ref - this makes the ref updating safe and
raceless, while also making it enough to have the refs directory
group-writable.

  Therefore, it shouldn't be actually necessary to meddle with umask
anymore. The documentation is obsolete; I'll remove the relevant bits
from Cogito docs.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
Of the 3 great composers Mozart tells us what it's like to be human,
Beethoven tells us what it's like to be Beethoven and Bach tells us
what it's like to be the universe.  -- Douglas Adams
