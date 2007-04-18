From: Steve =?ISO-8859-1?Q?Fr=E9cinaux?= <nudrema@gmail.com>
Subject: Re: Things that surprise naive users
Date: Wed, 18 Apr 2007 23:16:10 +0200
Message-ID: <1176930970.7733.9.camel@mejai>
References: <Pine.LNX.4.64.0704181503080.27922@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Apr 18 23:16:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HeHVh-0002iH-Jf
	for gcvg-git@gmane.org; Wed, 18 Apr 2007 23:16:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992739AbXDRVQO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Apr 2007 17:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992744AbXDRVQO
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Apr 2007 17:16:14 -0400
Received: from serv108.segi.ulg.ac.be ([139.165.32.111]:36002 "EHLO
	serv108.segi.ulg.ac.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S2992739AbXDRVQN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Apr 2007 17:16:13 -0400
Received: (qmail 7571 invoked by uid 510); 18 Apr 2007 23:16:11 +0200
Received: from 82.212.191.161 by serv108.segi.ulg.ac.be (envelope-from <nudrema@gmail.com>, uid 501) with qmail-scanner-1.25 
 (clamdscan: 0.90.1/3110.  
 Clear:RC:1(82.212.191.161):. 
 Processed in 0.147675 secs); 18 Apr 2007 21:16:11 -0000
Received: from unknown (HELO [192.168.1.103]) (s020908@[82.212.191.161])
          (envelope-sender <nudrema@gmail.com>)
          by serv108.segi.ulg.ac.be (qmail-ldap-1.03) with SMTP
          for <barkalow@iabervon.org>; 18 Apr 2007 23:16:11 +0200
In-Reply-To: <Pine.LNX.4.64.0704181503080.27922@iabervon.org>
X-Mailer: Evolution 2.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44950>

On Wed, 2007-04-18 at 16:55 -0400, Daniel Barkalow wrote:

> 1. If your organization has a bunch of different projects, and there's 
>    some central location holding the upstream that people regularly pull 
>    from, there's no way to abbreviate this parent directory. (Equivalent 
>    of CVSROOT environment variable)
> 
>    I.e., we've got file-server:/var/git/<project>.git at my work, with 
>    dozens of projects, and you have to give the whole thing to git clone 
>    each time. 

export GITROOT=file-server:/var/git
git-clone $GITROOT/project.git

git doesn't enforce that but you can still do it with some shell karma.

BTW as far as I know no other scm than CVS provides this kind of thing,
and it's more often seen as a defect than an advantage. For instance, a
novice which had to checkout a CVS project from sourceforge and another
from cvs.gnome.org and another from... wasn't helped at all. SVN has it
much simpler (understandable) by just providing a URL for checkouts.

>    It'd be nice to have a global config option such that, if 
>    the argument to git-clone doesn't have any /, it prepends the standard 
>    default. (Also an environment variable for the same purpose on a shell
>    session scope.)

But this is also a good idea ;-)

> 2. There's no easy way to tell that you've made commits that you haven't 
>    pushed upstream. In fact, it's impossible to tell when disconnected 
>    whether you've pushed everything. This needs some command to report it,
>    and also for push to update the fetch sides of remote heads it updates.

I surprised myself doing so:
  git-push $remote
  git-fetch $remote
given that the remote in question pushes master, and pulls into $remote.
Maybe such a thing (in the idea) should be done implicitely.
