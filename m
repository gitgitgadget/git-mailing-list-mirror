From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2 v2] Add strbuf_vaddf(), use it in strbuf_addf(), and
 add   strbuf_initf()
Date: Thu, 6 Mar 2008 17:59:20 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803061755080.3941@racer.site>
References: <1204138503-6126-1-git-send-email-johannes.sixt@telecom.at>  <alpine.LSU.1.00.0802281159550.22527@racer.site>  <200803052221.12495.johannes.sixt@telecom.at>  <alpine.LSU.1.00.0803052317350.15786@racer.site>  <7vir00lski.fsf@gitster.siamese.dyndns.org>
  <alpine.LSU.1.00.0803052327570.15786@racer.site>  <alpine.LSU.1.00.0803060212170.15786@racer.site>  <20080306063331.GA7325@glandium.org>  <3f4fd2640803060103i7fce7578ka40b5b4cc23a577f@mail.gmail.com>  <alpine.LSU.1.00.0803061153400.15786@racer.site>
 <3f4fd2640803060353w70651522w4b3896b8106b01c0@mail.gmail.com> <alpine.LSU.1.00.0803061319590.15786@racer.site> <alpine.LSU.1.00.0803061727120.3941@racer.site> <47D01E0D.1090801@viscovery.net> <47D02019.4000500@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Reece Dunn <msclrhd@googlemail.com>, Mike Hommey <mh@glandium.org>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Mar 06 18:00:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXJRq-0007OL-Dk
	for gcvg-git-2@gmane.org; Thu, 06 Mar 2008 18:00:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933728AbYCFQ7V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 11:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933566AbYCFQ7U
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 11:59:20 -0500
Received: from mail.gmx.net ([213.165.64.20]:45711 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933061AbYCFQ7T (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 11:59:19 -0500
Received: (qmail invoked by alias); 06 Mar 2008 16:59:17 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp057) with SMTP; 06 Mar 2008 17:59:17 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+diOAFyP+d0M5q9lcB6QcGCIRGkwT1m1P15TBtGH
	s7GEnUBEBvBzEn
X-X-Sender: gene099@racer.site
In-Reply-To: <47D02019.4000500@viscovery.net>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76401>

Hi,

On Thu, 6 Mar 2008, Johannes Sixt wrote:

> Johannes Sixt schrieb:
> > You did not cater for PRIuMAX, which is %llu except on Windows, where 
> > it is %I64u. We can make it %llu on Windows only if we can ensure that 
> > none of its uses ends up in a regular *printf function!
> 
> Oh, well, PRIuMAX is *only* used in regular *printf and in die() calls. 
> That's fine, too.

Hey, no problem.  I used my earlier analysis to find the _minimal_ set of 
formats needed to get Git running without that vsnprintf().

The idea is, of course, to enhance vaddf() as needed (if at all).

Note: I did not even bother trying to convert any vsnprintf() users except 
for strbuf_addf() to that interface: it should be relatively easy, but 
there are quite a few sites (even using strbuf, but not addf() because 
only a va_list is available), so it is left as an exercise to the reader 
;-)

Ciao,
Dscho

