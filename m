From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH, resend] git-commit: colored status when color.ui is
 set
Date: Fri, 9 Jan 2009 11:56:08 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0901091155210.30769@pacific.mpi-cbg.de>
References: <200901081953.01418.markus.heidelberg@web.de> <7viqoo26rq.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: markus.heidelberg@web.de, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 09 11:56:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LLF2r-0004xy-Pa
	for gcvg-git-2@gmane.org; Fri, 09 Jan 2009 11:56:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859AbZAIKza (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Jan 2009 05:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751705AbZAIKza
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Jan 2009 05:55:30 -0500
Received: from mail.gmx.net ([213.165.64.20]:43266 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751366AbZAIKz3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Jan 2009 05:55:29 -0500
Received: (qmail invoked by alias); 09 Jan 2009 10:55:27 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp022) with SMTP; 09 Jan 2009 11:55:27 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX188wn9aytI82v9BoQE1uxwneV2coMW4VXBsPp8E/A
	+enxDbvDhCS6vK
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <7viqoo26rq.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.54
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105004>

Hi,

On Fri, 9 Jan 2009, Junio C Hamano wrote:

> Markus Heidelberg <markus.heidelberg@web.de> writes:
> 
> > When using "git commit" and there was nothing to commit (the editor
> > wasn't launched), the status output wasn't colored, even though color.ui
> > was set. Only when setting color.status it worked.
> >
> > Signed-off-by: Markus Heidelberg <markus.heidelberg@web.de>
> > ---
> >  builtin-commit.c |    3 +++
> >  1 files changed, 3 insertions(+), 0 deletions(-)
> >
> > diff --git a/builtin-commit.c b/builtin-commit.c
> > index e88b78f..2d90f74 100644
> > --- a/builtin-commit.c
> > +++ b/builtin-commit.c
> > @@ -945,6 +945,9 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
> >  
> >  	git_config(git_commit_config, NULL);
> >  
> > +	if (wt_status_use_color == -1)
> > +		wt_status_use_color = git_use_color_default;
> > +
> >  	argc = parse_and_validate_options(argc, argv, builtin_commit_usage, prefix);
> >  
> >  	index_file = prepare_index(argc, argv, prefix);
> 
> My first reaction was:
> 
> 	When the editor does get launched, what would the new code do with
> 	your patch?  Would we see bunch of escape codes in the editor now?
> 
> But we do disable color explicitly when we generate contents to feed the
> editor in that case since bc5d248 (builtin-commit: do not color status
> output shown in the message template, 2007-11-18), so that fear is
> unfounded.

I had the same reaction, so I would like to see this reasoning in the 
commit message.

Ciao,
Dscho
