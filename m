From: Thomas Riboulet <riboulet@gmail.com>
Subject: Re: git faq : draft and rfc
Date: Fri, 17 Feb 2006 00:52:36 +0100
Message-ID: <22e91bb0602161552k3f88b98fu4ef2a4c97c840ad7@mail.gmail.com>
References: <22e91bb0602151636r2e70e60cpa5038f4b6caccc9c@mail.gmail.com>
	 <20060216151826.GS31278@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-From: git-owner@vger.kernel.org Fri Feb 17 00:52:46 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F9svR-0006hI-9l
	for gcvg-git@gmane.org; Fri, 17 Feb 2006 00:52:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbWBPXwh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Feb 2006 18:52:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbWBPXwh
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Feb 2006 18:52:37 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:7720 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750756AbWBPXwh convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Feb 2006 18:52:37 -0500
Received: by zproxy.gmail.com with SMTP id m22so286645nzf
        for <git@vger.kernel.org>; Thu, 16 Feb 2006 15:52:36 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=W3rDGRsBEUQVQ493SPNgs7Y6JsCn5xUGhmCY6dBDB8A6uST+qfXEdo3KhIM2jV6zNqUwFuD7+zA7kAKcpWEjIKnAYu1nkV8k/fBzfpx1ONh+YzI0RbXsDYk8VMCwGElGVuK0lr+2VX6I6jjRDZWSepHK5FWGlP9YM73OBnrDQL0=
Received: by 10.36.65.9 with SMTP id n9mr1620148nza;
        Thu, 16 Feb 2006 15:52:36 -0800 (PST)
Received: by 10.36.177.3 with HTTP; Thu, 16 Feb 2006 15:52:36 -0800 (PST)
To: git@vger.kernel.org
In-Reply-To: <20060216151826.GS31278@pasky.or.cz>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16317>

On 2/16/06, Petr Baudis <pasky@suse.cz> wrote:
> Dear diary, on Thu, Feb 16, 2006 at 01:36:20AM CET, I got a letter
> where Thomas Riboulet <riboulet@gmail.com> said that...
> > . Git commit is dying telling me "fatal : empty ident <user@myhost>
> > not allowed", what's wrong ?
> > Make sure your Full Name is not empty in chsh or the 5th field of your
> > user line in /etc/passwd isn't empty. If you @myhost is empty make sure
> > your hostname is correctly set.
>
> Please also mention GIT_AUTHOR_NAME; chsh may be frequently unavailable.

ok

>
> > . What's the difference between fetch and pull ?
> > Fetch : download objects and a head from another repository.
> > Pull : pull and merge from another repository.
> > See man git-fetch and git-pull for more.
>
> This could do with a little more elaboration as well. Nice inspiration
> might be <Pine.LNX.4.64.0602140845080.3691@g5.osdl.org>.

ok, I'll as soon as I manage to get it :/

>
> > . Can I tell git to ignore files ?
> > Yes. Put the files path in the repository in the .git/info/exclude file.
>
> Or .gitignore in the tree itself. .git/info/exclude is only for your
> particular checkout while .gitignore is what matters for all and
> everyone's checkouts of the project.
>

ok, added

> > . What can I use to setup a public repository ?
> > A ssh server, an http server, or the git-daemon.
> > See the tutorial for more details.
>
> Well this is about how to make it available, not how to use it.
>
> The repository should be set up by cg-admin-setuprepo or git-init-db
> --shared and normally does not have a working tree attached. You can
> fetch from such a repository either over:
>
>         * the GIT protocol (you need to run git-daemon)
>         * SSH (you can set up a git-use-only account using git-shell)
>         * rsync (has important disadvantages but it is currently the
>           fastest way to do the initial checkout)
>         * or the HTTP protocol (any reasonable webhosting will do, but
>           you need to run git-update-server-info after each repository
>           update; if you used cg-admin-setuprepo to set it up, this
>           will be done automatically, otherwise you may enable it in
>           the post-update hook - see .git/hooks/post-update).
>
> You can push to such a repository over:
>
>         * SSH
>         * HTTP DAV (you will need to specially configure your HTTP
>           server for this)
>
> Obviously, you can also fetch/push from/to a repository locally if it
> is available in the local filesystem structure.
>

the initial aim of that question was simply to tell svn people (and
others) what can be used to setup a public repos.
isn't it a bit too much for a faq ? maybe add some things to the
present answer and put this question in the "general questions"
section (see below), and add more details in the "usage" section ?

> --
>                                 Petr "Pasky" Baudis
> Stuff: http://pasky.or.cz/
> Of the 3 great composers Mozart tells us what it's like to be human,
> Beethoven tells us what it's like to be Beethoven and Bach tells us
> what it's like to be the universe.  -- Douglas Adams
>

ok added (and pushed) the :
- taylor qa
- the git import bk qa
- GIT_AUTHOR_NAME

I'll separate the questions between the following sections :
- general questions (who, when, where, ...)
- usage : commands, errors ...

I'm planning on removing the text format faq and handle it as I handle
the html one  : through the docbook. ok ?

--
Thom/ange
