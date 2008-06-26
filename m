From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] cmd_reset: don't trash uncommitted changes unless told
 to
Date: Thu, 26 Jun 2008 13:07:40 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806261306060.9925@racer>
References: <20080624222105.GA24549@dervierte> <1214346098-24584-1-git-send-email-stevenrwalter@gmail.com> <7vwskea2ik.fsf@gitster.siamese.dyndns.org> <48620C1A.6000509@panasas.com> <alpine.DEB.1.00.0806251109380.9925@racer> <486220CE.3070103@viscovery.net>
 <alpine.DEB.1.00.0806251334060.9925@racer> <20080625135100.GF20361@mit.edu> <7v63rx2zwf.fsf@gitster.siamese.dyndns.org> <20080626115550.GA23058@atjola.homenet>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323329-471785229-1214482061=:9925"
Cc: Junio C Hamano <gitster@pobox.com>, Theodore Tso <tytso@mit.edu>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Boaz Harrosh <bharrosh@panasas.com>,
	Steven Walter <stevenrwalter@gmail.com>, git@vger.kernel.org,
	jeske@google.com
To: =?ISO-8859-15?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jun 26 14:11:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBqJj-0008Np-3j
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 14:11:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbYFZMJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 08:09:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751452AbYFZMJm
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 08:09:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:41612 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750931AbYFZMJl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 08:09:41 -0400
Received: (qmail invoked by alias); 26 Jun 2008 12:09:39 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp026) with SMTP; 26 Jun 2008 14:09:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1//MFdN/tD/WD42xJXHm7axkITRwim35DGuhutLic
	fBQEvelSoOXCok
X-X-Sender: gene099@racer
In-Reply-To: <20080626115550.GA23058@atjola.homenet>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86442>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-471785229-1214482061=:9925
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Thu, 26 Jun 2008, Björn Steinbrink wrote:

> On 2008.06.25 10:22:08 -0700, Junio C Hamano wrote:
> > Theodore Tso <tytso@mit.edu> writes:
> > 
> > > I used to argue for this, but gave up, because no one seemed to agree
> > > with me.  So now I just have the following in
> > > /home/tytso/bin/git-revert-file and I am very happy:
> > >
> > > #!/bin/sh
> > > #
> > > prefix=$(git rev-parse --show-prefix)
> > >
> > > for i in $*
> > > do
> > >         git show HEAD:$prefix$i > $i
> > > done
> > 
> > Isn't that this?
> > 
> >         #!/bin/sh
> >         exec git checkout HEAD -- "$@"
> 
> I thought so at first, too, but there's one difference. Ted's version
> doesn't affect the index, while yours does. Of course I cannot tell if
> Ted actually intended not to touch the index ;-)

While we are nit-picking: Ted's version does not respect autocrlf, while 
Junio's does.

Oh, and Junio's version works with spaces and other funny stuff in file 
names, while Ted's does not.

Oh, and error checking is correct in Junio's version.

I am sure there are more differences.

Ciao,
Dscho

--8323329-471785229-1214482061=:9925--
