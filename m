From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] log: make --abbrev-commit's ellipsis configurable
Date: Fri, 13 Feb 2009 14:47:36 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902131445390.10279@pacific.mpi-cbg.de>
References: <1234529920-9694-1-git-send-email-trast@student.ethz.ch> <alpine.DEB.1.00.0902131418230.10279@pacific.mpi-cbg.de> <200902131437.49293.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	=?ISO-8859-15?Q?Adeodato_Sim=F3?= <dato@net.com.org.es>,
	Junio C Hamano <gitster@pobox.com>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Fri Feb 13 14:48:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXyOu-0005f2-E2
	for gcvg-git-2@gmane.org; Fri, 13 Feb 2009 14:48:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754429AbZBMNqu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Feb 2009 08:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753911AbZBMNqt
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Feb 2009 08:46:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:45900 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753399AbZBMNqt (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Feb 2009 08:46:49 -0500
Received: (qmail invoked by alias); 13 Feb 2009 13:46:46 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp017) with SMTP; 13 Feb 2009 14:46:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/O4DJO3ajO6FGQmexSjXGH7Hs35rYa8S4vHQFqky
	RLW9cIWiMiMc1s
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <200902131437.49293.trast@student.ethz.ch>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109748>

Hi,

On Fri, 13 Feb 2009, Thomas Rast wrote:

> Johannes Schindelin wrote:
> > On Fri, 13 Feb 2009, Thomas Rast wrote:
> [...]
> > >  log-tree.c               |   19 ++++++++++++++-----
> > >  log-tree.h               |    3 +++
> > 
> > I am slightly worried that you overshoot here, as log-tree.c has plumbing 
> > users, too, no?
> > 
> > How about making this an option, and passing it in rev_opts instead?  This 
> > option could then be defaulted to in git-log, when the user said 
> > --abbrev-commit.
> 
> But the 'git_config(git_log_config, NULL);' that sets the new variable
> to false is only called from cmd_{log,show,whatchanged,reflog}.  I
> should have indicated this in the commit messaged, sorry.
> 
> The real problem with stuffing it in rev_opts (actually rev_info :-)
> is that it seems inconsistent to not change the 'Merge: blah' line's
> format.  But that is generated in pretty.c, in add_merge_info via
> pp_header from pretty_print_commit, which has a bunch of users in
> various 'builtin-*.c'.
> 
> So do I sacrifice symmetry (abbrev_commit is indeed stored in
> rev_info), or touch the other ~7 users of pretty_print_commit too?

Thanks, I understand much better now.

Hmm... I cannot really make my mind up what I prefer.  But you have 
implemented one of the two options, so...

Ciao,
Dscho
