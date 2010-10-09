From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Best single user practice
Date: Sat, 09 Oct 2010 15:49:25 -0700 (PDT)
Message-ID: <m31v7zf0e0.fsf@localhost.localdomain>
References: <loom.20101009T233356-82@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Maaartin <grajcar1@seznam.cz>
X-From: git-owner@vger.kernel.org Sun Oct 10 00:49:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4iEQ-0003zx-0h
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 00:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756398Ab0JIWt2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Oct 2010 18:49:28 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:61151 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755655Ab0JIWt1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Oct 2010 18:49:27 -0400
Received: by fxm14 with SMTP id 14so1067023fxm.19
        for <git@vger.kernel.org>; Sat, 09 Oct 2010 15:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:received
         :x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        bh=eIFjj7r2v59IiSqgGF3WgJwYjqdQHUO4NhtK8Mu4cPw=;
        b=KYeduVsk3TinxM06Usug8OVc9Dl1TAATRqq+CYfUYanoSdh1VYioiwgmAFtw7Yb4y3
         jRkMo6G397EWCl2HQm1AAo7lPDMdWJl7yV0Rsf3IlmoEA55CtyMY4pgjtZQJkf26Qzb2
         iP4a+0tkeC6sXAYIARx+5LPl+REaUw6PBUZL0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=x-authentication-warning:to:cc:subject:references:from:date
         :in-reply-to:message-id:lines:user-agent:mime-version:content-type;
        b=BMJDn4JBe21I6tA3Vtke8XY364nR4P+fLjLkWD/SE/nXMLPugkmPckfz6K/OQLHbyc
         hd1W6/kHV6t+mgUa7X72k5PT96cSedxckyGOi42aPtr++VaBP0liVdyqJBCzS5E6qzul
         nu0KacRWRAuvRZ2XaWfdwUHDv+4If+WzF1u8E=
Received: by 10.223.85.197 with SMTP id p5mr801628fal.86.1286664566342;
        Sat, 09 Oct 2010 15:49:26 -0700 (PDT)
Received: from localhost.localdomain (abvg64.neoplus.adsl.tpnet.pl [83.8.204.64])
        by mx.google.com with ESMTPS id p2sm2343236fak.46.2010.10.09.15.49.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 09 Oct 2010 15:49:25 -0700 (PDT)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by localhost.localdomain (8.13.4/8.13.4) with ESMTP id o99MmtIj019821;
	Sun, 10 Oct 2010 00:49:06 +0200
Received: (from jnareb@localhost)
	by localhost.localdomain (8.13.4/8.13.4/Submit) id o99MmdcD019814;
	Sun, 10 Oct 2010 00:48:39 +0200
X-Authentication-Warning: localhost.localdomain: jnareb set sender to jnareb@gmail.com using -f
In-Reply-To: <loom.20101009T233356-82@post.gmane.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158637>

Maaartin <grajcar1@seznam.cz> writes:

> I've started using git maybe one month ago, and I'd like to use it for many 
> things including some one-man projects, browser settings backups, and such 
> things. So I always do a local git init, ssh to my server and create a repo 
> there. I copy the .git/config from a working project, and change the remote 
> URL. It all works, but it's not perfect.
> 
> - Is it not possible to create a remote repository from my own computer without 
> ssh?

No, it isn't.  "git push --create" / remote "git init" is one of
requested features for quite some time, but it isn't yet implemented.

IIRC the problem is that without being able to log in to remote
machine there are situations when yoy can't resolve problems without
it.


You can always use "ssh <user>@<machine> git init <directory>" (though
it is not a solution in your case, at least not as given, because "git
init <directory>" is quite new invention).

> - There's only version 1.5.4.3 on the server and I don't want to update it 
> unless strongly recommended so. Should I?

Well, with 1.5.4.3 you can't use "smart" HTTP protocol, but git is
deliberately interoperable between different versions of client and
server software.
 
> - Because of the low version, I can't use "git init --bare" on the server. So I 
> create an usual depository and change the configuration to bare=true. Is it OK 
> (I really don't mind the repo being placed in DIR/.git instead of DIR itself.)?

This should be O.K.  And you can always rename DIR/.git ro DIR.git...

> 
> - The very first time I need to do "git push origin master", later "git push" 
> suffices. I wonder why.

It is because default git behavior is to push matching branches,
i.e. all branches having the same name in both ends (you can change it
using `push.default` config option, see git-config and git-push
manpages).

This is the default behavior, because it allows you to easily control
which branches you want to have visible in remote repository.

[...]
> - Sometimes, I use "git push --force", how do I clean up the resulting garbage 
> on the server?

"git gc" on server.

> 
> - How can I ensure that everything important gets pushed to the server? Maybe 
> by using "git push --mirror"? Obviously and logically, .git/config doesn't get 
> pushed, but maybe I miss something more important, too?

You can always change `push.default`, or you can provide push refspecs
which pushes all branches, like remote.origin.push =
+refs/heads/*:refs/heads/*

Note that the opissite side of the coin is ensuing that nothing that
doesn't have to be pushed didn't get to be pushed.

HTH (Hope That Helps)
-- 
Jakub Narebski
Poland
ShadeHawk on #git
