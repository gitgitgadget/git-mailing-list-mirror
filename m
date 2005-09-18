From: Petr Baudis <pasky@suse.cz>
Subject: Re: first impressions to git
Date: Sun, 18 Sep 2005 16:54:34 +0200
Message-ID: <20050918145434.GA22391@pasky.or.cz>
References: <20050918111259.GA10882@schottelius.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Kay Sievers <kay.sievers@vrfy.org>,
	Christian Gierke <ch@gierke.de>
X-From: git-owner@vger.kernel.org Sun Sep 18 16:55:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EH0Z2-0008J6-BT
	for gcvg-git@gmane.org; Sun, 18 Sep 2005 16:54:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbVIROym (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Sep 2005 10:54:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbVIROym
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Sep 2005 10:54:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52199 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751108AbVIROyl (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 18 Sep 2005 10:54:41 -0400
Received: (qmail 11015 invoked by uid 2001); 18 Sep 2005 16:54:34 +0200
To: Nico -telmich- Schottelius <nico-linux-git@schottelius.org>
Content-Disposition: inline
In-Reply-To: <20050918111259.GA10882@schottelius.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8782>

Dear diary, on Sun, Sep 18, 2005 at 01:12:59PM CEST, I got a letter
where Nico -telmich- Schottelius <nico-linux-git@schottelius.org> told me that...
> Hello!

Hello,

> My first impressions are:
> 
> - many commands, reminds me of arch/tla

this is one of Cogito's considerations, I try to keep the number of
commands low. It's 26 non-admin commands now, which might raise a bit
yet, but hopefully not by much. And I was thinking about coupling stuff
like cg-branch-* to a single command.

> - I am not able to upload cinit, because
>    o adding directories with files and files I want to exclude is not easily
>      possible

Just fixed, cg-init should now DTRT.

>    o it's not clear to me, how I should publish (push)
>       - scp/rsync from outside
>       - git/cogito push

Push works fine for anything but the initial push - recursive scp or
rsync of the whole repository is probably the easiest solution. It would
be nice if git-send-pack would support the initial push.

>    o excluding *.o seems not to work, neither through .gitignore nor through
>      .git/info/exlude

It should now work during the initial commit.

> - How do I check integrity of files, is signed files somehow implemented?

This was discussed on IRC, it seems signed tags were the answer you
were looking for.

> I've written some notes down in
>    http://creme.schottelius.org/~nico/temp/cogito

Pretty much all of this solved now, I think.

>    http://creme.schottelius.org/~nico/temp/git-erfahrungen
> 
> Adding directories with git-script-add (or whatever) would be nice in the way
> it adds the contents of the directory recursively.

cg-add -r implemented now.

>    o cogito could in fact be a nice frontend, after removing the current bugs
>      and if it has nicer error messaeges, which tell me WHAT I did wrong and
>      HOW to do it right.

This was one thing I kept in mind when making Cogito as well, I tried to
make its error messages as helpful as possible. It would be great if you
could point out where _Cogito_'s error messages might be more helpful
(it's tougher with Git, but I'm sure they'll love to make their error
messages more helpful as well - one thing I _really_ don't want to get
into is filtering Git's error messages and rewriting them ;-).

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
If you want the holes in your knowledge showing up try teaching
someone.  -- Alan Cox
