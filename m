From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v2] diff -c -p: do not die on submodules
Date: Thu, 30 Apr 2009 00:39:21 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904300037300.10279@pacific.mpi-cbg.de>
References: <gt7err$3m4$1@ger.gmane.org>  <7v4ow8my1u.fsf@gitster.siamese.dyndns.org>  <20090428211257.GA31191@pvv.org> <20090429084209.GA24064@localhost>  <7v8wljcmvk.fsf_-_@gitster.siamese.dyndns.org>  <7vy6tj8aur.fsf_-_@gitster.siamese.dyndns.org> 
 <81b0412b0904291450w3d292ed5i3b2ab5164c0ae0f4@mail.gmail.com>  <alpine.DEB.1.00.0904300011140.10279@pacific.mpi-cbg.de> <81b0412b0904291519m41035200n408b6ab409eed127@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-447920112-1241044762=:10279"
Cc: Junio C Hamano <gitster@pobox.com>,
	Clemens Buchacher <drizzd@aon.at>,
	Finn Arne Gangstad <finnag@pvv.org>,
	Tim Olsen <tim@brooklynpenguin.com>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 30 00:39:49 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LzIRR-0000y2-Db
	for gcvg-git-2@gmane.org; Thu, 30 Apr 2009 00:39:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932141AbZD2WjH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 29 Apr 2009 18:39:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762896AbZD2WjF
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Apr 2009 18:39:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:41379 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762887AbZD2WjD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Apr 2009 18:39:03 -0400
Received: (qmail invoked by alias); 29 Apr 2009 22:39:03 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp033) with SMTP; 30 Apr 2009 00:39:03 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19I0BJu0lNIMJO61+t8NyP/Oqtd91/lpsTONl4iCq
	p6UWr834CZ23Xi
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <81b0412b0904291519m41035200n408b6ab409eed127@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117970>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-447920112-1241044762=:10279
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 30 Apr 2009, Alex Riesen wrote:

> 2009/4/30 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
> > Hi,
> >
> > On Wed, 29 Apr 2009, Alex Riesen wrote:
> >
> >> 2009/4/29 Junio C Hamano <gitster@pobox.com>:
> >> > +
> >> > +       if (S_ISGITLINK(mode)) {
> >> > +               blob = xmalloc(100);
> >> > +               *size = snprintf(blob, 100,
> >> > +                                "Subproject commit %s\n", sha1_to_hex(sha1));
> >>
> >> snprintf returns a signed value. It also has a bad record of returning
> >> negative values for obscure reasons (on obscure platforms, admittedly).
> >>
> >> For this particular case,
> >>
> >>   strcpy(blob, "Subproject commit ");
> >>   strcat(blob, sha1_to_hex(sha1));
> >>   strcat(blob, "\n");
> >>   *size = strlen(blob); /* that's a constant */
> >>
> >> could be considered.
> >
> > Actually, we know _exactly_ the size of the thing.  It is 18+40+1.  But I
> > think that *size wants to have the size, not the length.  So add 1.
> >
> > In any case, I don't think that we have to jump through hoops here:
> > snprintf() is _most_ unlikely to return something negative here.  So I'd
> > say that readability trumps paranoia here.
> >
> 
> http://www.google.com/search?q=snprintf+negative+return+value
> 
> First link: http://bytes.com/groups/c/590845-snprintf-return-value
> 
> Look for "(Windows, mingw)"

No, I will not.

This is a _lousy_ time balance you propose: yourself saving a few minutes, 
everybody spending more time, trying to figure out what your point is, 
only so that you do not have to summarize in a concise manner why you 
thing that I am wrong.

I fully disagree with that, and refuse to obey your command,
Dscho

--8323328-447920112-1241044762=:10279--
