From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-name-rev: allow --name-only in combination with
 --stdin
Date: Fri, 1 Aug 2008 12:57:47 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808011256330.9611@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1217510434-94979-1-git-send-email-pdebie@ai.rug.nl> <7vtze5td00.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Pieter de Bie <pdebie@ai.rug.nl>,
	Git Mailinglist <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>, spearce@spearce.org
X-From: git-owner@vger.kernel.org Fri Aug 01 12:54:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOsHF-0003Wt-AT
	for gcvg-git-2@gmane.org; Fri, 01 Aug 2008 12:54:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753003AbYHAKx2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2008 06:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752985AbYHAKx2
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Aug 2008 06:53:28 -0400
Received: from mail.gmx.net ([213.165.64.20]:41649 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752945AbYHAKx2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2008 06:53:28 -0400
Received: (qmail invoked by alias); 01 Aug 2008 10:53:26 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp031) with SMTP; 01 Aug 2008 12:53:26 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18ifX55vVEirbqW4CwMURfYuqDSIYOdmkcBLUqxzz
	W2cvYn31Tn/MwQ
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <7vtze5td00.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91054>

Hi,

On Fri, 1 Aug 2008, Junio C Hamano wrote:

> Pieter de Bie <pdebie@ai.rug.nl> writes:
> 
> > Signed-off-by: Pieter de Bie <pdebie@ai.rug.nl>
> > ---
> >
> > 	Or was there a specific reason not to allow this?
> 
> I'll let Dscho answer that one.

... who let's Shawn answer that one.

> > diff --git a/builtin-name-rev.c b/builtin-name-rev.c
> > index 85612c4..0536af4 100644
> > --- a/builtin-name-rev.c
> > +++ b/builtin-name-rev.c
> > @@ -266,8 +266,14 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
> >  					if (!name)
> >  						continue;
> >  
> > -					fwrite(p_start, p - p_start + 1, 1, stdout);
> > -					printf(" (%s)", name);
> > +					if (data.name_only) {
> > +						fwrite(p_start, p - p_start + 1 - 40, 1, stdout);
> > +						printf(name);
> > +					}
> > +					else {
> > +						fwrite(p_start, p - p_start + 1, 1, stdout);
> > +						printf(" (%s)", name);
> > +					}
> >  					p_start = p + 1;
> >  				}
> >  			}
> 
> Is it just me to find that this part is getting indented too deeply to be
> readable?

No.

Ciao,
Dscho
