From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [ANNOUNCEMENT] /Arch/ embraces `git'
Date: Wed, 20 Apr 2005 23:31:15 +0200
Message-ID: <20050420213114.GF19112@pasky.ji.cz>
References: <200504201000.DAA04988@emf.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gnu-arch-users@gnu.org, gnu-arch-dev@lists.seyza.com,
	git@vger.kernel.org, talli@museatech.net, torvalds@osdi.org
X-From: git-owner@vger.kernel.org Wed Apr 20 23:27:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOMiq-0000Fl-67
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 23:27:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261819AbVDTVbT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 17:31:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261820AbVDTVbT
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 17:31:19 -0400
Received: from w241.dkm.cz ([62.24.88.241]:35806 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261819AbVDTVbQ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Apr 2005 17:31:16 -0400
Received: (qmail 5043 invoked by uid 2001); 20 Apr 2005 21:31:15 -0000
To: Tom Lord <lord@emf.net>
Content-Disposition: inline
In-Reply-To: <200504201000.DAA04988@emf.net>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Apr 20, 2005 at 12:00:36PM CEST, I got a letter
where Tom Lord <lord@emf.net> told me that...
> >From the /Arch/ perspective: `git' technology will form the
> basis of a new archive/revlib/cache format and the basis
> of new network transports.

I think one thing git's objects database is not very well suited for are
network transports. You want to have something smart doing the
transports, comparing trees so that it can do some delta compression;
that could probably reduce the amount of data needed to be sent
significantly.

> >From the `git' perspective, /Arch/ will replace the lame "directory
> cache" component of `git' with a proper revision control system.

I'm not sure if you fully grasped the git's philosophy yet. The
"directory cache" component is not by itself any revision control system
- it is merely a staging area for any revision system on top of it (IOW:
subordinate, not competitor).

> I started here:
> 
>    http://www.seyza.com/=clients/linus/tree/index.html
> 
> and for those interested in `git'-theory, a good place to start is
> 
>    http://www.seyza.com/=clients/linus/tree/src/liblob/index.html

These pages are surely very nice, unfortunately I have to enjoy them
only from the "HTML source" view. The HTML seems completely broken,
containing unterminated comments like "<!-- BEGIN  the main body>". :-(

You didn't go into surely interesting details regarding what will you be
fixing regarding ancestry graphs.

Also, I have some concerns about your naming scheme. First, why do you
include the size in the filename? Second, with ..../..../ you are
_seriously_ worse off than with ../. The first will put 1/256 of project
files to each directory, where with the second you will have
1/4294967296 of project files per directory. I think the point of
directory is that it is a container grouping certain files in a certain
way; in the objects database it is done purely for performance (and
compatibility, to a degree) reasons, but your way it will have worse
performance characteristics at least until the project accumulates
4294967296 files in the database.

Kind regards,

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
