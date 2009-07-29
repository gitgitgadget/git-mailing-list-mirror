From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCHv3 1/8] Introduce commit notes
Date: Wed, 29 Jul 2009 18:40:41 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907291839350.7626@intel-tinevez-2-302>
References: <1248834326-31488-1-git-send-email-johan@herland.net>  <1248834326-31488-2-git-send-email-johan@herland.net> <81b0412b0907290152w27c1b5b5l9efbd6980d4f904e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-1634672080-1248885642=:7626"
Cc: Johan Herland <johan@herland.net>, gitster@pobox.com,
	git@vger.kernel.org, trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 29 18:41:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWCDA-0007GM-Fy
	for gcvg-git-2@gmane.org; Wed, 29 Jul 2009 18:41:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755810AbZG2Qko (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Jul 2009 12:40:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755657AbZG2Qko
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Jul 2009 12:40:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:50833 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755672AbZG2Qko (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Jul 2009 12:40:44 -0400
Received: (qmail invoked by alias); 29 Jul 2009 16:40:43 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp070) with SMTP; 29 Jul 2009 18:40:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18kGrkAJpUktvcyRpHq5qtMyzXPP5S8jVq1XIXrs/
	yw+hxgvgBNKdgQ
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <81b0412b0907290152w27c1b5b5l9efbd6980d4f904e@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.55
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124369>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1634672080-1248885642=:7626
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Wed, 29 Jul 2009, Alex Riesen wrote:

> On Wed, Jul 29, 2009 at 04:25, Johan Herland<johan@herland.net> wrote:
> > +void get_commit_notes(const struct commit *commit, struct strbuf *sb,
> > +               const char *output_encoding)
> > +{
> > +       static const char *utf8 = "utf-8";
> 
> Using an array
> 
>   const char utf8[] = "utf-8";
> 
> costs you less BSS (no separate storage for the pointer).

Good to know!

> > @@ -963,5 +964,9 @@ void pretty_print_commit(enum cmit_fmt fmt, const struct commit *commit,
> > +
> > +       if (fmt != CMIT_FMT_ONELINE)
> > +               get_commit_notes(commit, sb, encoding);
> > +
> 
> Someday we will need a way to switch off the display of notes
> without resolving to oneline format.
> Is there a notes specifier for the printf-like log message formatting
> (--pretty=format: or --format) planned, BTW?

That would probably be something like "GIT_NOTES_REF=nyanyanya git log"?

Ciao,
Dscho

--8323329-1634672080-1248885642=:7626--
