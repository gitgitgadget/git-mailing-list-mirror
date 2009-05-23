From: Johan Herland <johan@herland.net>
Subject: Re: partial checkouts
Date: Sun, 24 May 2009 01:34:53 +0200
Message-ID: <200905240134.53387.johan@herland.net>
References: <200905231401.11651.chanika@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
To: Chani <chanika@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 24 01:38:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M80nm-0006u5-CR
	for gcvg-git-2@gmane.org; Sun, 24 May 2009 01:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752926AbZEWXe5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 May 2009 19:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752090AbZEWXe5
	(ORCPT <rfc822;git-outgoing>); Sat, 23 May 2009 19:34:57 -0400
Received: from mx.getmail.no ([84.208.15.66]:60901 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751326AbZEWXe4 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 23 May 2009 19:34:56 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KK400FO2EU6C4C0@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 24 May 2009 01:34:54 +0200 (MEST)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KK400J6HEU56SB0@get-mta-in02.get.basefarm.net> for
 git@vger.kernel.org; Sun, 24 May 2009 01:34:54 +0200 (MEST)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.5.23.232259
User-Agent: KMail/1.11.3 (Linux/2.6.29-ARCH; KDE/4.2.3; x86_64; ; )
In-reply-to: <200905231401.11651.chanika@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119805>

On Saturday 23 May 2009, Chani wrote:
> [...]
>
> right now all I've thought of is one ugly hack: have a server that checks
> out all the kde git repos, pulls daily, copies all the doc/ folders into
> a documentation folder, and offers that folder up on the interwebs so
> that update_xml can rsync from it or download a tgz of it or something.
> there appear to be lots of images in the documentation, so it's not a
> small download - 200mb and growing. it still hasn't finished downloading
> all the externals...

Do you need the doc/ folders from _all_ kde git repos, or just from those 
repos that you have currently checked out? In the latter case, you could 
solve this by adding symlinks to all the doc/ folders inside the 
documentation/ folder, and then make sure the software that traverse the 
documentation/ folder recognize and skips symlinks. Of course, this won't 
work if the translations project need _all_ doc/ folders accessible, but not 
all the kde git repos.

> I'm kinda wondering if there'd be a way to use git-filter-branch to make
> a repo that only tracks the doc/ folder for a module - but I've no idea
> whether it'd have to be recreated from scratch every time someone changes
> something in the real repo's doc/
>
> can anyone think of a less ugly solution?
> what are the chances of git supporting this kind of partial checkout
> someday?

Check out git-subtree. It can split out a subdirectory into its own repo, 
and re-integrate it back into the "parent" repo at a later date. git-subtree 
has been posted as a patch to this list a couple of times without much 
response, but it looks like an interesting alternative to submodules:
http://alumnit.ca/~apenwarr/log/?m=200904#30

If a lot of people find git-subtree useful, who knows, it might be included 
in a future git version.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
