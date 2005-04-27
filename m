From: Petr Baudis <pasky@ucw.cz>
Subject: Re: PATCH: Allow tree-id to return the ID of a tree object
Date: Thu, 28 Apr 2005 01:22:23 +0200
Message-ID: <20050427232223.GM22956@pasky.ji.cz>
References: <426FBBE7.1090806@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 28 01:17:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DQvmO-0001mc-NF
	for gcvg-git@gmane.org; Thu, 28 Apr 2005 01:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262094AbVD0XWg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Apr 2005 19:22:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262095AbVD0XWg
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Apr 2005 19:22:36 -0400
Received: from w241.dkm.cz ([62.24.88.241]:63404 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262094AbVD0XWZ (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Apr 2005 19:22:25 -0400
Received: (qmail 15440 invoked by uid 2001); 27 Apr 2005 23:22:23 -0000
To: Philip Pokorny <ppokorny@mindspring.com>
Content-Disposition: inline
In-Reply-To: <426FBBE7.1090806@mindspring.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Wed, Apr 27, 2005 at 06:20:55PM CEST, I got a letter
where Philip Pokorny <ppokorny@mindspring.com> told me that...
> While playing with cg-ls, I tried:
> 
> % cg-ls
> ... snip ...
> 100644  blob    bc607fd55f6ce4e56ce87766369b5d4d55ec79af        object.h
> 100755  blob    f35877a6aa5b68d2fb4a388dcfa9b3e64262604e        parent-id
> 040000  tree    bfb75011c32589b282dd9c86621dadb0f0bb3866        ppc
> 100644  blob    d922305ee0f5583bdfcb629f6d4061e11e0fa859        read-cache.c
> 100644  blob    1ad7ffc555b635fe57fa7834b12d71ff576be065        read-tree.c
> ... snip ...
> % cg-ls bfb75011c32589b282dd9c86621dadb0f0bb3866       <-- the ppc tree ID
> Invalid id: bfb75011c32589b282dd9c86621dadb0f0bb3866
> usage: cat-file [-t | tagname] <sha1>
> usage: cat-file [-t | tagname] <sha1>
> Invalid id:
> 
> 
> Shouldn't cg-ls give a listing of a sub-tree?  The cg-help says it takes
> a TREE-ID?
> 
> The problem seems to be that tree-id really only accepts a commit-id and
> returns the TREE-ID of that commit.
> 
> So I modified commit-id, tree-id and parent-id to make them more similar
> in coding style, force "short-id" names to be at least 4 lower case
> letters, and have tree-id accept short, unambiguous ID's and bare SHA1-ID's.
> 
> Patch attached.

Could you please functionally split and sign off your patch?

Also, I'd prefer not to have the sha1 completion logic duplicated; what
about just having commit-id take a parameter not to validate its id?
Actually, that's ugly too. I think the cleanest solution would be to
reintroduce the cg-Xnormid, now to only really do the _common_ stuff -
basically everything up to the typecheck (exclusively) in commit-id.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
