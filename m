From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] bisect: test merge base if good rev is not an ancestor
 of bad rev
Date: Fri, 11 Jul 2008 00:38:10 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0807110035180.3279@eeepc-johanness>
References: <20080710054152.b051989c.chriscool@tuxfamily.org> <200807102126.37567.chriscool@tuxfamily.org> <7vd4llpkxq.fsf@gitster.siamese.dyndns.org> <200807110036.17504.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="658432-1708213059-1215729492=:3279"
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Jeff King <peff@peff.net>, git@vger.kernel.org
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 00:39:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KH4ms-0001fx-UY
	for gcvg-git-2@gmane.org; Fri, 11 Jul 2008 00:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198AbYGJWhx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Jul 2008 18:37:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753165AbYGJWhx
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Jul 2008 18:37:53 -0400
Received: from mail.gmx.net ([213.165.64.20]:50005 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751801AbYGJWhx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Jul 2008 18:37:53 -0400
Received: (qmail invoked by alias); 10 Jul 2008 22:37:51 -0000
Received: from 88-107-253-132.dynamic.dsl.as9105.com (EHLO eeepc-johanness.st-andrews.ac.uk) [88.107.253.132]
  by mail.gmx.net (mp038) with SMTP; 11 Jul 2008 00:37:51 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/MGao9arPMZSNWnW04+BcQ8JecGWmZHBBZuTrOSc
	66HMCQFB89WVSk
X-X-Sender: user@eeepc-johanness
In-Reply-To: <200807110036.17504.chriscool@tuxfamily.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.67
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88021>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--658432-1708213059-1215729492=:3279
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT

Hi,

On Fri, 11 Jul 2008, Christian Couder wrote:

> Le jeudi 10 juillet 2008, Junio C Hamano a écrit :
>
> >  - "Test this merge-base before going forward, please" will add 
> >    typically only one round of check (if you have more merge bases 
> >    between good and bad, you need to test all of them are good to be 
> >    sure), so it is not "slower nor more complex".
> 
> By "slower" I meant that it would need more rounds of check on average. 
> By "more complex" I meant that more code is needed.
> 
> And I think you are right, all the merge bases need to be tested so I 
> will send a patch on top of the patch discussed here.

Good luck.  This will open the scenario where people use a proper ancestor 
as "good" revision.  In this case, you test that.  If it is "bad" you 
report that it is the _first_ one.

You are opening a can of worms here, and I doubt that this is a good idea.

git-bisect as-is has very precise, and _simple_ semantics, and users 
should really know what they are doing (i.e. not marking something as 
"good" which is on a branch containing a fix).

Trying to be too clever here might just make the whole tool rather 
useless.

Ciao,
Dscho

--658432-1708213059-1215729492=:3279--
