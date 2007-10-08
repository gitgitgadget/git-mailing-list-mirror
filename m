From: Jan Wielemaker <wielemak@science.uva.nl>
Subject: Re: [PATCH] git-shell and git-cvsserver
Date: Mon, 8 Oct 2007 16:22:33 +0200
Organization: HCS, University of Amsterdam
Message-ID: <200710081622.33222.wielemak@science.uva.nl>
References: <200710051453.47622.wielemak@science.uva.nl> <Pine.LNX.4.64.0710080534270.4174@racer.site>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Oct 08 16:28:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ietb1-0008ND-CX
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 16:28:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbXJHO21 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 10:28:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751426AbXJHO20
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 10:28:26 -0400
Received: from imap.science.uva.nl ([146.50.4.51]:40968 "EHLO
	imap.science.uva.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751138AbXJHO2Z (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 10:28:25 -0400
Received: from gollem.science.uva.nl [146.50.26.20]
          by imap.science.uva.nl with ESMTP (sendmail 8.13.8/config 11.38).
          id l98ESN5p013936; Mon, 8 Oct 2007 16:28:23 +0200
X-Organisation: Faculty of Science, University of Amsterdam, The Netherlands
X-URL: http://www.science.uva.nl/
User-Agent: KMail/1.9.5
In-Reply-To: <Pine.LNX.4.64.0710080534270.4174@racer.site>
Content-Disposition: inline
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60324>

Dscho,

On Monday 08 October 2007 06:51, Johannes Schindelin wrote:
> On Fri, 5 Oct 2007, Jan Wielemaker wrote:
> > Hi,
> >
> > I know, I shouldn't be using git-cvsserver :-( Anyway, I patched
> > git-shell to start git-cvsserver if it is started interactively and the
> > one and only line given to it is "cvs server".
> >
> > The patch to shell.c is below. The trick with the EXEC_PATH is needed
> > because git-cvsserver doesn't appear to be working if you do not include
> > the git bindir in $PATH. I think that should be fixed in git-cvsserver
> > and otherwise we should at least make the value come from the prefix
> > make variable.  With this patch I was able to use both Unix and Windows
> > cvs clients using git-shell as login shell.
> >
> > Note that you must provide ~/.gitconfig with user and email in the
> > restricted environment.
> >
> > 	Enjoy --- Jan
>
> I think this is a valuable contribution.  That's why I comment...

Great :-)

> Please put a useful commit message (less like an email, more like
> something you want to read in git-log) at the beginning of the email, then
> a line containing _just_ "---", and after that some comments that are not
> meant to be stored in the history, like (I know this does not belong
> to...)
>
> After that, there should be a diffstat, and then the patch.
>
> The easiest to have this layout is to do a proper commit in git, use "git
> format-patch" to produce the patch, and then insert what you want to say
> in addition to the commit message between the "---" marker and the
> diffstat.

I buy that.  I'm still trying to get used to all the features ...

> I strongly disagree (as you yourself, probably) with the notion that this
> does not belong into git-shell.
>
> > +#define EXEC_PATH "/usr/local/bin"
>
> This is definitely wrong.  Use git_exec_path() instead.

I stated in my comments I was not happy about that. Before I start
submitting a new patch that may or may not be accepted, I'd like to have
some things clear. I manage an Open Source project for a long time (the
term not even invented in 1985 :-) Users come up with problems and
report on this. Most often with just a statement they don't like it,
sometimes with a detailed description of what is wrong and how to fix
it, sometimes with patches.

Generally, patches are not really how I like them, precisely the kind
of things that are wrong with my patch.  Style issues, fixed A where
I consider the patch must be in B after a conflict between A and B
was detected, missing opportunities for code reuse, etc.

I try to talk frequent contributors into making things as `ready-to-use'
as possible. For incidental contributors I generally don't care. I just
rewrite the patch. Its less work for me than trying to explain all
details (as you kindly did and I agree to most of it, even learn some
new things) and it is too much work for someone who wishes an incidental
patch in the main distribution.

I don't want to become a GIT comitter, and I don't want to learn all of
its internals. Just a happy user for the SWI-Prolog project and an
internal project with some CVS addicts.

	Cheers --- Jan
