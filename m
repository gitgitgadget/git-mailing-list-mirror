From: Junio C Hamano <junkio@cox.net>
Subject: Re: importing cvs logical modules
Date: Wed, 24 May 2006 22:01:14 -0700
Message-ID: <7vslmyzoit.fsf@assigned-by-dhcp.cox.net>
References: <93c3eada0605242148u4656bc31p96d84a16703f0fe0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 25 07:01:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fj7yJ-0000Uc-Rz
	for gcvg-git@gmane.org; Thu, 25 May 2006 07:01:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbWEYFBQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 May 2006 01:01:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965038AbWEYFBQ
	(ORCPT <rfc822;git-outgoing>); Thu, 25 May 2006 01:01:16 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:17611 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S965037AbWEYFBQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 May 2006 01:01:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060525050115.UXPN19317.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 25 May 2006 01:01:15 -0400
To: geoff@austrics.com.au
In-Reply-To: <93c3eada0605242148u4656bc31p96d84a16703f0fe0@mail.gmail.com>
	(Geoff Russell's message of "Thu, 25 May 2006 14:18:25 +0930")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20726>

"Geoff Russell" <geoffrey.russell@gmail.com> writes:

> I'd like to make 1 git repository Progs with xxxx and yyyy as child trees.
>
>           Progs/.git
>           Progs/xxxx
>           Progs/yyyy
>
> Does this sound useful to anyone else, or is it already possible?

I would do it like this:

           Progs/.git
           Progs/xxxx/.git
           Progs/yyyy/.git

I do not know what you have in Progs/ hierarchy -- if it is just
scaffolding to house subdirectories and nothing else you may not
even need Progs/.git repository.

This is a very useful and handy structure, and you do not need
any tool support once you have these as separate repositories.
If you want a single distribution point, you can push from these
separate repositories into separate branches of a single
distribution point repository [*1*].

One potential disadvantage is that you would not get revision
linkage between these "modules", but not having tight linkage is
the point of modular structure, so depending on your workflow it
probably may not matter.


[Footnote]

*1* In fact, my git working area has the "master", "next" or
"pu" branch checked out in /path/to/work/area/git (and the
repository is in /path/to/work/area/git/.git directory), and I
check out the "todo" branch in /path/to/work/area/git/Meta
directory, with /path/to/work/area/git/Meta/.git directory as
its repository.
