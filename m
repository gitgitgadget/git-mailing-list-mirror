From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: correct git merge behavior or corner case?
Date: Tue, 21 Apr 2009 11:04:21 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904211103380.10279@pacific.mpi-cbg.de>
References: <4ac8254d0904191540j68246cd8qa36a034209d4c800@mail.gmail.com>  <alpine.DEB.1.00.0904201148150.6955@intel-tinevez-2-302> <41354.bFoQE3daRhY=.1240222235.squirrel@webmail.hotelhot.dk>  <20090421024433.GC14479@coredump.intra.peff.net>
 <7vskk2bt3x.fsf@gitster.siamese.dyndns.org>  <fabb9a1e0904210148w4c6b869l396122baef1c0ee3@mail.gmail.com>  <alpine.DEB.1.00.0904211055160.10279@pacific.mpi-cbg.de> <fabb9a1e0904210200j5f82e9ci440b99ab18016938@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Anders Melchiorsen <mail@cup.kalibalik.dk>,
	Tuncer Ayaz <tuncer.ayaz@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 21 11:04:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LwBtw-0005WH-QH
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 11:04:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754682AbZDUJCs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 05:02:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754137AbZDUJCs
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 05:02:48 -0400
Received: from mail.gmx.net ([213.165.64.20]:42414 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751083AbZDUJCr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 05:02:47 -0400
Received: (qmail invoked by alias); 21 Apr 2009 09:02:45 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp069) with SMTP; 21 Apr 2009 11:02:45 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/xfTtb2NrxFWnOmzXdybIhbKGTYxyMcR51USAJBp
	nnYZsQ2J0bWOTJ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <fabb9a1e0904210200j5f82e9ci440b99ab18016938@mail.gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117110>

Hi,

On Tue, 21 Apr 2009, Sverre Rabbelier wrote:

> On Tue, Apr 21, 2009 at 10:56, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > But they would be a good example why we do _not_ want rename detection
> > there.
> 
> Yes, I would agree that they are indeed a good example. The other day
> I moved a directory in a python project (containing several
> sub-directories and as such several empty __init__.py files), and it
> renamed them rather wrongly :P.
> 
> The diff looked something like:
> Renamed root/old/a/__init__.py to root/new/b/__init__.py
> Renamed root/old/b/__init__.py to root/new/c/__init__.py
> Renamed root/old/c/__init__.py to root/new/a/__init__.py
> 
> While of course, a better result would have been:
> Renamed root/old/a/__init__.py to root/new/a/__init__.py
> Renamed root/old/b/__init__.py to root/new/b/__init__.py
> Renamed root/old/c/__init__.py to root/new/c/__init__.py

Heh, at some point I had a patch in my tree (dunno if it still there) to 
use Levenshtein for rename detection, that should have helped...

Ciao,
Dscho
