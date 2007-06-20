From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svn strangeness with tags and Squirrelmail repo
Date: Wed, 20 Jun 2007 00:24:46 -0700
Message-ID: <20070620072446.GC25010@muzzle>
References: <46a038f90706192205y71a77f5al5ca199b3ac382d71@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 20 09:24:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I0uYf-0002c7-Cg
	for gcvg-git@gmane.org; Wed, 20 Jun 2007 09:24:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758051AbXFTHYv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Jun 2007 03:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757753AbXFTHYv
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jun 2007 03:24:51 -0400
Received: from hand.yhbt.net ([66.150.188.102]:38175 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755927AbXFTHYu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jun 2007 03:24:50 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id DB8178D4027;
	Wed, 20 Jun 2007 00:24:46 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Wed, 20 Jun 2007 00:24:46 -0700
Content-Disposition: inline
In-Reply-To: <46a038f90706192205y71a77f5al5ca199b3ac382d71@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50544>

Martin Langhoff <martin.langhoff@gmail.com> wrote:
> First -- kudos to Eric Wong and company: git-svn can deal with the odd
> errors and invalid chunks of XML or UTF-8 that SVN spits at me every
> once in a while. And it "just works" in 99% of the situation. Great
> stuff.

You're welcome.  At the same time I'm not reallu sure what you mean by
"odd errors and invalid chunks of XML or UTF-8 that SVN spits at me"
unless it's some joke about SVN I'm not getting :)

> Now... on to my 1% where it doesn't "just work"... I am trying to get
> a working svn to git gateway for Squirrelmail, and getting in trouble
> with the tags setting...
> 
>  git --version
>  git version 1.5.2.2.238.g7cbf2f2
> 
> For starters - it "just works" if I run
>  git svn init  -T trunk -t tags -b branches \
>   http://squirrelmail.svn.sourceforge.net/svnroot/squirrelmail
> git svn fetch
> 
> However, every tree (for tags, branches and trunk) is prefixed with
> "squirrelmail" and commits to the toplevel "plugins" directory get in
> the way. Also, I want the branches and tags to appear in more natural
> places, so after init, and before fetch, I change .git/config to say:
> 
>   [svn-remote "svn"]
>        url = http://squirrelmail.svn.sourceforge.net/svnroot/squirrelmail
>        fetch = trunk/squirrelmail:refs/heads/svn/trunk
>        branches = branches/*/squirrelmail:refs/heads/svn/*
>        tags = tags/*/squirrelmail:refs/tags/svn/*

git-svn expects 'refs/remotes/' in the local ref name.  Otherwise,
the left-hand side is correct.

> and when I do that -- trunk and branches do what I want, but tags
> aren't imported anymore. :-/

Now its odd to me that trunks and branches even works with those ref
names.

-- 
Eric Wong
