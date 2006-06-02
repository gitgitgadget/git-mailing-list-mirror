From: Petr Baudis <pasky@ucw.cz>
Subject: Re: [PATCH] Ability to automaticaly push tags to remote repositories.
Date: Fri, 2 Jun 2006 22:58:36 +0200
Message-ID: <20060602205836.GG10488@pasky.or.cz>
References: <442BD562.3030207@people.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 02 22:58:26 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmGip-0001pq-Ln
	for gcvg-git@gmane.org; Fri, 02 Jun 2006 22:58:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030255AbWFBU6R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Jun 2006 16:58:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030232AbWFBU6Q
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jun 2006 16:58:16 -0400
Received: from w241.dkm.cz ([62.24.88.241]:22483 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1030255AbWFBU6O (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 2 Jun 2006 16:58:14 -0400
Received: (qmail 4334 invoked by uid 2001); 2 Jun 2006 22:58:36 +0200
To: Krzysiek Pawlik <krzysiek.pawlik@people.pl>
Content-Disposition: inline
In-Reply-To: <442BD562.3030207@people.pl>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21174>

Dear diary, on Thu, Mar 30, 2006 at 02:56:02PM CEST, I got a letter
where Krzysiek Pawlik <krzysiek.pawlik@people.pl> said that...
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> - From `cg-push --long-help`:
> 
> - -t TAG::
>         Tells cg-push to also push the given tag. Note that in the
>         future, cg-push should push tags automatically. Also note
>         that even if you pass `cg-push` the '-t' arguments, your
>         HEAD is still pushed as well in addition to the tags.
> 
> One of possible ways of doing it is in attached patch. Comments,
> suggestions?

Well, this works properly only when you ever push to a single
repository, which many people don't. Besides, if you have two branches,
push branch A but tag a commit only on branch B, you will now be pushing
an invalid tag since the other end won't have the branch B and thus the
tagged commit.

A better way would be to use git-ls-remote --tags to get the list of
remote tags and compare that with the list of local tags, then push
those tags that tag commits on the branch we are pushing and the other
end does not have them.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
A person is just about as big as the things that make them angry.
