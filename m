From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Only use GIT_CONFIG in "git config", not other
 programs
Date: Tue, 15 Jul 2008 17:46:50 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0807151733430.19665@iabervon.org>
References: <alpine.LNX.1.00.0806300328380.19665@iabervon.org> <bd6139dc0807151056q61a9379l84761fe021d4541c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: sverre@rabbelier.nl
X-From: git-owner@vger.kernel.org Tue Jul 15 23:48:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KIsNE-000251-P2
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 23:47:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753927AbYGOVqx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 17:46:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753222AbYGOVqx
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 17:46:53 -0400
Received: from iabervon.org ([66.92.72.58]:57338 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752580AbYGOVqw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 17:46:52 -0400
Received: (qmail 17324 invoked by uid 1000); 15 Jul 2008 21:46:50 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 15 Jul 2008 21:46:50 -0000
In-Reply-To: <bd6139dc0807151056q61a9379l84761fe021d4541c@mail.gmail.com>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88598>

On Tue, 15 Jul 2008, Sverre Rabbelier wrote:

> On Mon, Jun 30, 2008 at 9:37 AM, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > @@ -611,31 +613,28 @@ int git_config(config_fn_t fn, void *data)
> >  {
> >        int ret = 0;
> >        char *repo_config = NULL;
> > -       const char *home = NULL, *filename;
> > +       const char *home = NULL;
> >
> >        /* $GIT_CONFIG makes git read _only_ the given config file,
> >         * $GIT_CONFIG_LOCAL will make it process it in addition to the
> >         * global config file, the same way it would the per-repository
> >         * config file otherwise. */
> 
> I noticed today while looking at config.c (because of the 'git config
> oddity' thread) that this reference to GIT_CONFIG_LOCAL was not
> removed?

Actually, it looks like that whole comment is obsolete; only 
builtin-config.c cares about any of this stuff.

> On latest next:
> $ grep GIT_CONFIG_LOCAL *
> config.c:	 * $GIT_CONFIG_LOCAL will make it process it in addition to the
> git-svn:		my $file = $ENV{GIT_CONFIG} || $ENV{GIT_CONFIG_LOCAL} ||
> git-svn.perl:		my $file = $ENV{GIT_CONFIG} || $ENV{GIT_CONFIG_LOCAL} ||

I'm not sure if git-svn is doing the right thing here, either.

	-Daniel
*This .sig left intentionally blank*
