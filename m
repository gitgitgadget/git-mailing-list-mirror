From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2] count-objects: add human-readable size option
Date: Thu, 14 Aug 2008 16:05:28 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0808141604190.24820@pacific.mpi-cbg.de.mpi-cbg.de>
References: <1218657910-22096-1-git-send-email-marcus@griep.us> <1218687684-11671-1-git-send-email-marcus@griep.us> <20080814043817.GC11232@spearce.org> <7vskt8f9x2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Marcus Griep <marcus@griep.us>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 14 16:02:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTdP9-00039x-4u
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 16:02:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753378AbYHNOAp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 10:00:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754112AbYHNOAp
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 10:00:45 -0400
Received: from mail.gmx.net ([213.165.64.20]:40456 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752968AbYHNOAo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 10:00:44 -0400
Received: (qmail invoked by alias); 14 Aug 2008 14:00:42 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp009) with SMTP; 14 Aug 2008 16:00:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+AD/cHceOAMx8nxjDg1mG7ibFMoNkCH/ZOWTPnDk
	Q9bPKtxox8028C
X-X-Sender: schindelin@pacific.mpi-cbg.de.mpi-cbg.de
In-Reply-To: <7vskt8f9x2.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.59
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92359>

Hi,

On Wed, 13 Aug 2008, Junio C Hamano wrote:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > Marcus Griep <marcus@griep.us> wrote:
> >> diff --git a/Documentation/git-count-objects.txt b/Documentation/git-count-objects.txt
> >> index 75a8da1..291bc5e 100644
> >> --- a/Documentation/git-count-objects.txt
> >> +++ b/Documentation/git-count-objects.txt
> >> +++ b/builtin-count-objects.c
> > ...
> >> +void human_readable_size(char *buf, int buf_size, double size /* in bytes */)
> >
> > Hmm.  This probably should be static.  Or if it really is meant
> > to be a utility for use elsewhere in Git, moved to someplace where
> > string handling is done.  Its not strbuf related, but maybe strbuf.c
> > is a better location for this sort of library function.
> 
> Yes, with customizable precision (so that the caller can control "1.6k" vs
> "1.62k"), and perhaps cutomizable unit (so that you can use this for
> "3.6kB" and "2.6Mbps"), this kind of thing is a good candidate to be a
> library function in strbuf.c.

Or, should it ever be merged into git.git, the strbuf_vaddf() routine I 
wrote.

Ciao,
Dscho
