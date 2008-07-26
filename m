From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 7/7] builtin-merge: avoid non-strategy git-merge commands
 in error message
Date: Sat, 26 Jul 2008 17:38:55 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807261737260.26810@eeepc-johanness>
References: <cover.1217037178.git.vmiklos@frugalware.org> <f311372167c02868ccf5aa4dc03c97b7f956d855.1217037178.git.vmiklos@frugalware.org> <1217073292-27945-1-git-send-email-vmiklos@frugalware.org> <4f2b03391e3f85cf2224f97a2a7765d08707bd73.1217037178.git.vmiklos@frugalware.org>
 <68749731fe8de8b2a9ffc53963291aeab9256b82.1217037178.git.vmiklos@frugalware.org> <99c90877657be0ed439a9918f500d6ad132550a2.1217037178.git.vmiklos@frugalware.org> <13f39dd6752a34beeb6ecccb51dbc7546ef87182.1217037178.git.vmiklos@frugalware.org>
 <fc448aa651ad9e8e9d1cf5556a665b5bd6074628.1217037178.git.vmiklos@frugalware.org> <65a569c389352c5d0500b8c44c28e5572352e6ba.1217037178.git.vmiklos@frugalware.org> <alpine.DEB.1.00.0807261701520.26810@eeepc-johanness>
 <20080726152502.GL32057@genesis.frugalware.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Sat Jul 26 17:38:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KMlrA-00038b-Pc
	for gcvg-git-2@gmane.org; Sat, 26 Jul 2008 17:38:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752406AbYGZPhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Jul 2008 11:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752065AbYGZPhx
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Jul 2008 11:37:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:36153 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751846AbYGZPhw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Jul 2008 11:37:52 -0400
Received: (qmail invoked by alias); 26 Jul 2008 15:37:50 -0000
Received: from 88-107-142-10.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.142.10]
  by mail.gmx.net (mp053) with SMTP; 26 Jul 2008 17:37:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+Z7Hp5hRWZ0Dv+mkFVboWbHlkPTtriko0RA3xl1q
	lOTV3SFDntWFES
X-X-Sender: user@eeepc-johanness
In-Reply-To: <20080726152502.GL32057@genesis.frugalware.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90245>

Hi,

On Sat, 26 Jul 2008, Miklos Vajna wrote:

> On Sat, Jul 26, 2008 at 05:08:11PM +0200, Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > > +		memset(&not_strategies, 0, sizeof(struct cmdnames));
> > > +		for (i = 0; i < main_cmds.cnt; i++) {
> > 
> > Looking through all the discovered git commands?  Cute...  But does 
> > that not exclude the commands that are in PATH, starting with 
> > git-merge-, even if they are custom strategies?
> 
> main_cmds contains only commands in /usr/libexec/git-core, while I guess 
> custom strategies are elsewhere in PATH, which commands are in 
> other_cmds, not in main_cmds.

Thanks.

> -				if (!strcmp(main_cmds.names[i]->name, all_strategy[j].name))
> +				if (!strncmp(ent->name, all_strategy[j].name, ent->len))

Oops... that is not what I meant.  You'd have to check if 
!all_strategy[j].name[ent->len], too...

Ciao,
Dscho
