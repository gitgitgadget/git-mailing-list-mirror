From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: question concerning branches
Date: Thu, 20 Aug 2009 07:59:50 -0700 (PDT)
Message-ID: <m3y6pemsyl.fsf@localhost.localdomain>
References: <alpine.LFD.2.01.0908191441070.3158@localhost.localdomain>
	<4a8d4583@wupperonline.de> <4A8D53F3.3050500@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ingo Brueckl <ib@wupperonline.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Aug 20 17:00:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Me97Z-0002HP-PG
	for gcvg-git-2@lo.gmane.org; Thu, 20 Aug 2009 17:00:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754380AbZHTO7x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Aug 2009 10:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754319AbZHTO7x
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Aug 2009 10:59:53 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:28483 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754287AbZHTO7w (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Aug 2009 10:59:52 -0400
Received: by fg-out-1718.google.com with SMTP id e12so26183fga.17
        for <git@vger.kernel.org>; Thu, 20 Aug 2009 07:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=NMm/4sQKTr1X5Gt7WWhPC784jkALlANWpsE14BB+J8A=;
        b=GZz/BiqGKhkj2g27vqHkFYfK+vb6ACk9Duag9OcY8meh3TURe04qzSFyncAS2mt8dW
         to9a7RguF3Vc5nluza3Ls2CtTXHLtbIDFTAX01ruL6NgyToFGa2SREIk2QMWNw82akmD
         W281OWjLu1TR76uEUSwQtZMDQLNxQ0jBeN46c=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=UlE1gsK13tc+xyADVLObSp2hSduCvX9/fY9bYAim5RDsKfZ07pId/MkYWq8BV0LbMV
         eP+9nq55DYNG6W6Tv5FEQaI4J2FFrlE9S2RW9u1b4WtvkVy1rsximKnxgURONM0uf6q/
         59PRYsFh6cWDzbZ0gxNh2f0JqCjuRjyc+81kc=
Received: by 10.86.247.18 with SMTP id u18mr5134344fgh.43.1250780392608;
        Thu, 20 Aug 2009 07:59:52 -0700 (PDT)
Received: from localhost.localdomain (abvn197.neoplus.adsl.tpnet.pl [83.8.211.197])
        by mx.google.com with ESMTPS id d4sm379673fga.15.2009.08.20.07.59.49
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 20 Aug 2009 07:59:50 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id n7KExnMe030722;
	Thu, 20 Aug 2009 16:59:50 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id n7KExll1030719;
	Thu, 20 Aug 2009 16:59:47 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <4A8D53F3.3050500@viscovery.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126644>

Johannes Sixt <j.sixt@viscovery.net> writes:

> Ingo Brueckl schrieb:

> > In a branch, I learned, I have to commit or stash before I return to master
> > for push/pull to follow the project. If I forget, I'm screwed, because files
> > have changed due to the rewrite (in that branch), I won't get a warning until
> > my first commit (in that branch) and commits (in master) will conflict.

Errr... if having unknown files in status info when comitting doesn't
clue you in that you have spurious uncomitted changes, 

  # On branch master
  # Changes to be committed:
  #   (use "git reset HEAD <file>..." to unstage)
  #
  #       modified:   somefile

and neither commit diff summary

   n files changed, kk insertions(+), ll deletions(-)

doesn't clue you in, then you have more serous problems!


Second, you can use git-aware prompt to tell you if you have
uncomitted changes, so you will know when switching branches that you
have some changes that don't belong to branch you switch from.

> 
> You are obviously of a CVS or SVN mindset, where making a commit is such
> an important operation that you don't dare to make it until your work is
> *completed*.
> 
> With a git mindset, it won't happen that you "forget" whether you have
> anything uncommitted; you simply never have because committing half-baked
> stuff is the rule, not the exception. That is, before you get a cup of
> coffee, you commit; before you answer a phone call, you commit; before you
> turn your attention away, you commit. (That may be exaggerated, perhaps it
> even isn't, but you get the point.)
> 
> When you have completed your work, you go back to make your commit history
> look nice, comprehensible, and bisectable.

...with "git rebase --interactive" or patch management interface
(StGit, Guilt), or topic branch management interface (TopGit).

> 
> And only then comes the heavy operation: You publish your work for
> consumption by interested parties. This may be even only you yourself:
> "Consumption" would be to merge the work into your release branch. This is
> the right time to care about upstream again.

-- 
Jakub Narebski
Poland
ShadeHawk on #git
