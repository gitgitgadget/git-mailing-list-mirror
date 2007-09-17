From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 4/9] Introduce entry point for launching add--interactive.
Date: Tue, 18 Sep 2007 00:27:54 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709180027100.28586@racer.site>
References: <11890382183913-git-send-email-krh@redhat.com> 
 <11890382242333-git-send-email-krh@redhat.com>  <11890382243290-git-send-email-krh@redhat.com>
  <11890382253220-git-send-email-krh@redhat.com>  <Pine.LNX.4.64.0709061729270.28586@racer.site>
 <1190070792.10112.15.camel@hinata.boston.redhat.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323584-459764579-1190071674=:28586"
Cc: git@vger.kernel.org
To: Kristian =?ISO-8859-1?Q?H=F8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Tue Sep 18 01:28:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IXQ1G-0001r4-QT
	for gcvg-git-2@gmane.org; Tue, 18 Sep 2007 01:28:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754590AbXIQX2n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Sep 2007 19:28:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754803AbXIQX2n
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Sep 2007 19:28:43 -0400
Received: from mail.gmx.net ([213.165.64.20]:32931 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754454AbXIQX2l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Sep 2007 19:28:41 -0400
Received: (qmail invoked by alias); 17 Sep 2007 23:28:40 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp051) with SMTP; 18 Sep 2007 01:28:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18Yvykepy8YB6WWJL++Uz7Lv8x9FgGHKxZUVMeBn7
	l22h4VSkJRzQnx
X-X-Sender: gene099@racer.site
In-Reply-To: <1190070792.10112.15.camel@hinata.boston.redhat.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58498>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323584-459764579-1190071674=:28586
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 17 Sep 2007, Kristian H?gsberg wrote:

> On Thu, 2007-09-06 at 17:31 +0100, Johannes Schindelin wrote:
> > 
> > On Wed, 5 Sep 2007, Kristian Høgsberg wrote:
> > 
> > > diff --git a/builtin-add.c b/builtin-add.c
> > > index 3dd4ded..e79e8f7 100644
> > > --- a/builtin-add.c
> > > +++ b/builtin-add.c
> > > @@ -153,6 +154,13 @@ static int git_add_config(const char *var, const char *value)
> > >  	return git_default_config(var, value);
> > >  }
> > >  
> > > +int interactive_add(void)
> > > +{
> > > +	const char *argv[2] = { "add--interactive", NULL };
> > > +
> > > +	return run_command_v_opt(argv, RUN_GIT_CMD);
> > > +}
> > 
> > I'd rather have this in builtin-commit.c, since it is quite funny if 
> > builtin-add.c has code to fork() and exec() itself (eventually, that 
> > is) ;-)
> 
> Huh... it ends up in the same binary, and interactive_add() sounds like 
> it should live in builtin-add.c rather than builtin-commit.c.  Either 
> way, I don't care too much, but can we fix it up later?

Well, you are probably right on the former, and therefore we do not have 
to do the latter.

Thanks,
Dscho

--8323584-459764579-1190071674=:28586--
