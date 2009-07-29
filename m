From: Jody McIntyre <scjody@sun.com>
Subject: Re: 'git pull' fails with 'not uptodate' message despite 'git	reset
 --hard'
Date: Wed, 29 Jul 2009 18:54:32 -0400
Message-ID: <20090729225432.GG22281@clouds>
References: <20090728230842.GE22281@clouds>
 <32541b130907281719y57862c25w524f5bbf1df11c40@mail.gmail.com>
 <20090729203637.GF22281@clouds>
 <32541b130907291344u3c2b7df8ld848a79ec38197a6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Avery Pennarun <apenwarr@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 30 00:54:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWI2p-0005ME-Dz
	for gcvg-git-2@gmane.org; Thu, 30 Jul 2009 00:54:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753338AbZG2Wyh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 18:54:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753321AbZG2Wyh
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 18:54:37 -0400
Received: from sca-es-mail-2.Sun.COM ([192.18.43.133]:55613 "EHLO
	sca-es-mail-2.sun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753147AbZG2Wyg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 18:54:36 -0400
Received: from fe-sfbay-10.sun.com ([192.18.43.129])
	by sca-es-mail-2.sun.com (8.13.7+Sun/8.12.9) with ESMTP id n6TMsaA7007424
	for <git@vger.kernel.org>; Wed, 29 Jul 2009 15:54:36 -0700 (PDT)
Content-disposition: inline
Received: from conversion-daemon.fe-sfbay-10.sun.com by fe-sfbay-10.sun.com
 (Sun Java(tm) System Messaging Server 7u2-7.02 64bit (built Apr 16 2009))
 id <0KNK00300FAWT200@fe-sfbay-10.sun.com> for git@vger.kernel.org; Wed,
 29 Jul 2009 15:54:36 -0700 (PDT)
Received: from shinkansen.modernduck.com ([unknown] [24.37.153.200])
 by fe-sfbay-10.sun.com
 (Sun Java(tm) System Messaging Server 7u2-7.02 64bit (built Apr 16 2009))
 with ESMTPSA id <0KNK00M3XFMWMB40@fe-sfbay-10.sun.com>; Wed,
 29 Jul 2009 15:54:34 -0700 (PDT)
Received: by shinkansen.modernduck.com (sSMTP sendmail emulation); Wed,
 29 Jul 2009 18:54:32 -0400
In-reply-to: <32541b130907291344u3c2b7df8ld848a79ec38197a6@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124404>

On Wed, Jul 29, 2009 at 08:44:32PM +0000, Avery Pennarun wrote:

> You can always try the thermonuclear option:
> 
>    mv .git/index .git/index.bak
>    git reset HEAD    # note, don't use --hard here
>    git status   # should show only files you have *really* changed
> 
> Of course, if this fixes it than it's *definitely* a bug somewhere.

That still doesn't fix the problem.  I guess the index is not to blame.

$ mv .git/index .git/index.bak
$ git reset HEAD
$ git status
# On branch master
# Your branch is behind 'origin/master' by 484 commits, and can be fast-forwarded.
#
nothing to commit (working directory clean)
$ git pull origin tags/v2.6.31-rc4
From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
 * tag               v2.6.31-rc4 -> FETCH_HEAD
Updating 6847e15..4be3bd7
error: Entry 'CREDITS' not uptodate. Cannot merge.

Incidentally:

$ diff .git/index.bak .git/index
Binary files .git/index.bak and .git/index differ

I don't know what .git/index contains so I don't know if that's surprising or
not.

Cheers,
Jody

> 
> Good luck.
> 
> Avery
