From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: Re: Tracking remote branches
Date: Mon, 14 Sep 2009 21:19:58 +0200
Message-ID: <20090914191957.GB64280@macbook.lan>
References: <a4c8a6d00909131737v35d7c63dsea669f47456f5acb@mail.gmail.com> <20090914050145.GA12985@vidovic> <a4c8a6d00909141130o628a069fu4c489b25f95f543d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nicolas Sebrecht <nicolas.s.dev@gmx.fr>, git@vger.kernel.org
To: Thiago Farina <tfransosi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 14 21:20:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MnH5q-0004yD-IC
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 21:20:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756802AbZINTT6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Sep 2009 15:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754810AbZINTT5
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Sep 2009 15:19:57 -0400
Received: from darksea.de ([83.133.111.250]:36764 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751043AbZINTT4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2009 15:19:56 -0400
Received: (qmail 7979 invoked from network); 14 Sep 2009 21:19:58 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 14 Sep 2009 21:19:58 +0200
Content-Disposition: inline
In-Reply-To: <a4c8a6d00909141130o628a069fu4c489b25f95f543d@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128493>

On Mon, Sep 14, 2009 at 03:30:10PM -0300, Thiago Farina wrote:
> On Mon, Sep 14, 2009 at 2:01 AM, Nicolas Sebrecht <nicolas.s.dev@gmx.=
fr> wrote:
> > The 13/09/09, Thiago Farina wrote:
> > $ git checkout -t origin/maint
> >
> >> OK, now I switched to maint branch. And then I did:
> >> $ git status
> >>
> >> # On branch maint
> >> # Changes to be committed
> >> # =A0 =A0(use "git reset HEAD <file>..." to unstage)
> >> #
> >> # =A0 =A0 =A0 =A0 =A0new file: =A0 =A0git-remote-curl
> >> # =A0 =A0 =A0 =A0 =A0new file: =A0 =A0git-replace
> >> #
> >>
> >> What happened here? What I have to do now?
>
> Why these files has this status? Is supposed to me to do something
> about that when this situation occurs?

I just checked and this is because you probably made a build on the
master branch which creates these files. They are untracked but ignored
through the .gitignore file in the master branch.

Now the situation is that the .gitignore on the current 'maint' branch
does not have these files ignored because they are quite new.

In this situation you can do a

  git clean -f

which gets rid of all untracked but not ignored files (all files that
git status shows as new) or

  make clean

while you are still on the master branch.

cheers Heiko
