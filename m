From: Konstantin Khomoutov <flatworm@users.sourceforge.net>
Subject: Re: Git on intranet
Date: Fri, 26 Jul 2013 18:51:26 +0400
Message-ID: <20130726185126.45567727c50d81e9320683a1@domain007.com>
References: <51F27B59.8020608@gmail.com>
	<51F285E8.5040802@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Muhammad Bashir Al-Noimi <mbnoimi@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 26 16:51:40 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2jMl-0000R9-Dw
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jul 2013 16:51:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759181Ab3GZOvb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 10:51:31 -0400
Received: from mailhub.007spb.ru ([84.204.203.130]:60048 "EHLO
	mailhub.007spb.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758989Ab3GZOva (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 10:51:30 -0400
Received: from programmer.Domain007.com (programmer.domain007.com [192.168.2.100])
	by mailhub.007spb.ru (8.14.3/8.14.3/Debian-5+lenny1) with SMTP id r6QEpQmZ012965;
	Fri, 26 Jul 2013 18:51:27 +0400
In-Reply-To: <51F285E8.5040802@gmail.com>
X-Mailer: Sylpheed 3.3.0 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231186>

On Fri, 26 Jul 2013 16:21:28 +0200
Muhammad Bashir Al-Noimi <mbnoimi@gmail.com> wrote:

> > I want to use Git over the local network in our company because the 
> > internet connection isn't stable so I wonder how can I use git with 
> > pull request (similar to Github)?

Depends on what feature set you imply when you refer to "pull request".
The problem with the terminology here is that the term "pull request"
might refer both to a social act and to a formal technical action
supported by a particular software (Git-hosting or otherwise).  I mean,
it's perfectly OK for one developer to push a branch in a repository and
then ask another developer (directly, by mail or otherwise) to pull the
changes from that branch, integrating them into some other branch.
I think, for intranet this should cover 99% of use cases.
The github software platform allows to formalize this process by
providing web interface knobs to do pull requests -- this is useful
exactly because it stipulates contributions to a project by *random
people.*  Conversely, the people working on your projects in your
intranet are usually not random, and are usually well connected by
corporate e-mail, chat, phone and other means.

> > As I read about Gitorious.org I found it most candidate but I'm not 
> > sure is it supports this feature or maybe there is better open
> > source solutions!
> >
> Best search result I got is: http://stackoverflow.com/a/2593330 the
> user says that both *Gitolite* <http://sitaramc.github.com/gitolite/>
> and *Gitorious* <http://gitorious.com/local_install/> are very hard
> to configure!!! What do you suggest?

As to gitolite, for me personally installing it was a matter of running
`apt-get install gitolite` on one of my Debian machines.  But
administering it might require some getting used to as it uses a
special administrative Git repository to manage public SSH keys for your
Git developers and configuration of repositories.  You will also need
to possess at least some level of knowledge about what a Git repository
is, after all.  But in any case, gitolite only manages repos and users,
it has no web UI and no format support for github-style pull requests.

Coming back to F/OSS turn-key Git-hosting solutions, GitLab [1]
supports github-style pull requests since some version.  It's written
in Ruby so I, personally, would not touch it to avoid administrative
nightmares when the next upgrade comes but YMMV.
Gitorious also seems to support "merge requests" [3] which are actually
the same thing, I fancy.  Again, Ruby.
Gitblit and Girocco seem not to support such a feature yet (but the
former appears to have it in the works [2]).

1. http://gitlab.org/
2. http://code.google.com/p/gitblit/issues/detail?id=215
3. http://gitorious.wordpress.com/2009/07/15/new-merge-request-functionality/
4. http://repo.or.cz/w/girocco.git
