From: Matt Porter <mporter@kernel.crashing.org>
Subject: Re: [PATCH] have commit-id dereference git tags
Date: Thu, 5 May 2005 14:14:44 -0700
Message-ID: <20050505141444.B10541@cox.net>
References: <20050505074823.GA9075@fatelectrons.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 05 23:11:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTnbn-0002FA-50
	for gcvg-git@gmane.org; Thu, 05 May 2005 23:10:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVEEVQr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 May 2005 17:16:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbVEEVQr
	(ORCPT <rfc822;git-outgoing>); Thu, 5 May 2005 17:16:47 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:20735 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S261446AbVEEVQp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 May 2005 17:16:45 -0400
Received: from liberty.homelinux.org ([68.2.41.86]) by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050505211640.MWPD19494.fed1rmmtao06.cox.net@liberty.homelinux.org>;
          Thu, 5 May 2005 17:16:40 -0400
Received: (from mmporter@localhost)
	by liberty.homelinux.org (8.9.3/8.9.3/Debian 8.9.3-21) id OAA12948;
	Thu, 5 May 2005 14:14:44 -0700
To: Alexander Beyn <malex-git@fatelectrons.org>
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20050505074823.GA9075@fatelectrons.org>; from malex-git@fatelectrons.org on Thu, May 05, 2005 at 12:48:23AM -0700
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, May 05, 2005 at 12:48:23AM -0700, Alexander Beyn wrote:
> With this patch, if commit-id is passed a git tag, it will check to see
> if the tag points to a commit. If it does, commit-id will return that
> commit's id.
> 
> I'm not sure if this is the proper place to handle git tags, but it does
> make things like "cg-diff -r v2.6.12-rc2:v2.6.12-rc3" work in the Linus
> kernel tree. I've not noticed any problems this introduces, but I didn't 
> do a thorough check.

I like this feature and it works on the Linus tree for me as well.
However, it fails on the cogito tree as follows:

mporter@beef:~/src/cogito$ cg-diff -r git-pasky-0.7:cogito-0.8
.git/objects/c8/3b95297c2a6336c2007548f909769e0862b509: No such file or directory
fatal: git-cat-file c83b95297c2a6336c2007548f909769e0862b509: bad file
Invalid id: c83b95297c2a6336c2007548f909769e0862b509
usage: git-cat-file [-t | tagname] <sha1>
usage: git-cat-file [-t | tagname] <sha1>
Invalid id:

I haven't looked any further at it yet though.

-Matt
