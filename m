From: "Nicolas Vilz 'niv'" <nicolas@vilz.de>
Subject: Re: [PATCH] contrib/git-svn: use refs/remotes/git-svn instead of 
     git-svn-HEAD
Date: Thu, 2 Mar 2006 22:17:03 +0100 (CET)
Message-ID: <62157.84.163.95.215.1141334223.squirrel@mail.geht-ab-wie-schnitzel.de>
References: <20060302055831.GA16600@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "git list" <git@vger.kernel.org>, "Junio C Hamano" <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 02 22:17:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEvAq-00048v-R0
	for gcvg-git@gmane.org; Thu, 02 Mar 2006 22:17:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932554AbWCBVRV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Mar 2006 16:17:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932547AbWCBVRV
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Mar 2006 16:17:21 -0500
Received: from geht-ab-wie-schnitzel.de ([217.69.165.145]:57871 "EHLO
	vsectoor.geht-ab-wie-schnitzel.de") by vger.kernel.org with ESMTP
	id S932554AbWCBVRU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Mar 2006 16:17:20 -0500
Received: from localhost (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id C36273F7A;
	Thu,  2 Mar 2006 22:17:10 +0100 (CET)
Received: from vsectoor.geht-ab-wie-schnitzel.de ([127.0.0.1])
	by localhost (vsectoor.geht-ab-wie-schnitzel.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 25870-10; Thu, 2 Mar 2006 22:17:05 +0100 (CET)
Received: from mail.geht-ab-wie-schnitzel.de (localhost [127.0.0.1])
	by vsectoor.geht-ab-wie-schnitzel.de (Postfix) with ESMTP id 68CF73EFB;
	Thu,  2 Mar 2006 22:17:02 +0100 (CET)
Received: from 84.163.95.215
        (SquirrelMail authenticated user niv@geht-ab-wie-schnitzel.de)
        by mail.geht-ab-wie-schnitzel.de with HTTP;
        Thu, 2 Mar 2006 22:17:03 +0100 (CET)
In-Reply-To: <20060302055831.GA16600@localdomain>
To: "Eric Wong" <normalperson@yhbt.net>
User-Agent: SquirrelMail/1.4.5
X-Priority: 3 (Normal)
Importance: Normal
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17107>

> After reading a lengthy discussion on the list, I've come to the
> conclusion that creating a 'remotes' directory in refs isn't
> such a bad idea.
>
> You can still branch from it by specifying remotes/git-svn (not
> needing the leading 'refs/'), and the documentation has been
> updated to reflect that.

i got stuck in that.

git-svn does the remotes/svn-git reference good, git pull hasn't
recognized it, yet. So i had to do a symlink from .git/refs/remotes to
.git/refs/heads/ to do the git pull...

then i got a bit stuck because of conflicts.... which i resolved (thank god).

the third thing is that the git-svn commit command does deletions of
certain files very often, when i commit some patches i pulled into my
private-talk-to-svn-branch. in on of the next commits the same files are
added again.. but i thought "o my god, i am screwed", when i saw the
scheduled deletions the first time... that is a bit confusing for the
users.

so in conclusion, i think, you should teach git pull to recognize
refs/remotes as heads to be pulled from (not to be pulled at)...

btw, i like the visualization of the remotes-refs in gitk.

Nicolas
