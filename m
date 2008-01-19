From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] http-push: fix webdav lock leak.
Date: Sat, 19 Jan 2008 23:38:12 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801192336350.5731@racer.site>
References: <1200022189-2400-1-git-send-email-mlevedahl@gmail.com> <1200022189-2400-2-git-send-email-mlevedahl@gmail.com> <7v1w8o4ws0.fsf@gitster.siamese.dyndns.org> <30e4a070801111252s4e17b9c4m62adeb9032963e66@mail.gmail.com> <7v63xzzszp.fsf@gitster.siamese.dyndns.org>
 <478855B5.9070600@gmail.com> <7vbq7ry405.fsf@gitster.siamese.dyndns.org> <47885B2C.8020809@gmail.com> <7v7iify2wm.fsf@gitster.siamese.dyndns.org> <4788BFA8.2030508@gmail.com> <7vwsqeubj8.fsf@gitster.siamese.dyndns.org> <47891658.3090604@gmail.com>
 <7vbq7qssd7.fsf@gitster.siamese.dyndns.org> <47893E1A.5020702@gmail.com> <7v4pdislrf.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801132224540.8333@wbgn129.biozentrum.uni-wuerzburg.de> <7vir1xmazm.fsf@gitster.siamese.dyndns.org>
 <7v63xrh3mw.fsf_-_@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0801181638500.5731@racer.site> <47921595.1080100@gbarbier.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463811741-2142400660-1200785893=:5731"
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?ISO-8859-15?Q?Gr=E9goire_Barbier?= <gb@gbarbier.org>
X-From: git-owner@vger.kernel.org Sun Jan 20 00:39:05 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JGNHE-0003Hn-Qz
	for gcvg-git-2@gmane.org; Sun, 20 Jan 2008 00:39:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751677AbYASXiZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jan 2008 18:38:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753450AbYASXiZ
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jan 2008 18:38:25 -0500
Received: from mail.gmx.net ([213.165.64.20]:37961 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751665AbYASXiY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jan 2008 18:38:24 -0500
Received: (qmail invoked by alias); 19 Jan 2008 23:38:22 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp058) with SMTP; 20 Jan 2008 00:38:22 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18gLPo3JXUgOLfX5lyzT0RTok87o2TaE5mypzqDVx
	RUDZUth4DLdhkt
X-X-Sender: gene099@racer.site
In-Reply-To: <47921595.1080100@gbarbier.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71144>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463811741-2142400660-1200785893=:5731
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

Hi,

On Sat, 19 Jan 2008, Grégoire Barbier wrote:

> Johannes Schindelin a écrit :
>
> >  After playing around for a while, all of a sudden, I got a
> >  segmentation fault:
> > 
> >  Waiting for
> > 
> > http://dscho@127.0.0.1/test.git/objects/56/5e84516c1c6dca168be1715b45aeae70b24d13_36e8d912-4841-455a-bbd9-69e54d00db99
> > Segmentation fault (core dumped)
> > 
> >  Unfortunately, this is with _and_ without this patch.

Looking at it again in more depth, it seems that this failure is indeed 
independent of your patch.

But I would still feel better if the fixes were kept minimal for now 
(codepath-wise, not only code-wise).

Ciao,
Dscho
---1463811741-2142400660-1200785893=:5731--
