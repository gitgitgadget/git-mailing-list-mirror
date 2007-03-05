From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] revision walker: Fix --boundary when limited
Date: Mon, 5 Mar 2007 20:00:36 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0703051957090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <8aa486160703050202y5ee159d2i42a2859a00b41679@mail.gmail.com>
 <7vlkicynwm.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.63.0703051951340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1148973799-288284106-1173121236=:22628"
Cc: =?utf-8?Q?Santi_B=C3=A9jar?= <sbejar@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 05 20:00:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOIQM-0007Iq-Ja
	for gcvg-git@gmane.org; Mon, 05 Mar 2007 20:00:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbXCETAi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 5 Mar 2007 14:00:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932247AbXCETAi
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Mar 2007 14:00:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:51079 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932226AbXCETAi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Mar 2007 14:00:38 -0500
Received: (qmail invoked by alias); 05 Mar 2007 19:00:36 -0000
X-Provags-ID: V01U2FsdGVkX1+pKxxZw/Wp4+Df75Yd9M85E9hkZ7vI2TgX8VnSCT
	IKfIoA+NIFubxR
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.63.0703051951340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41473>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1148973799-288284106-1173121236=:22628
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 5 Mar 2007, Johannes Schindelin wrote:

> 	On Mon, 5 Mar 2007, Junio C Hamano wrote:
> 
> 	> "Santi Béjar" <sbejar@gmail.com> writes:
> 	> 
> 	> > the --topo-order does not play well with --boundary and 
> 	> > --max-count.
> 	> >
> 	> > $ git-rev-list --boundary --max-count=50 5ced0 | wc -l
> 	> > 56
> 	> > $ git-rev-list --topo-order --boundary --max-count=50 5ced0 \
> 	> >   | wc -l
> 	> > 8846
> 	> >
> 	> > (5ced0 is git.git's master). I think it should be 56 for both. 

Side note: with the patch I am replying to, the latter command returns 51. 
This is correct, since the only boundary commit it shows (1db8b60b) has 
(all) the other 5 commits as ancestors.

The behaviour of both is correct: in the former case, there is not enough 
information to tell that one of the 6 boundary commits reaches all the 
others.

Ciao,
Dscho

---1148973799-288284106-1173121236=:22628--
