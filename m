From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Optimize prefixcmp()
Date: Sat, 29 Dec 2007 23:15:18 +0100 (CET)
Message-ID: <Pine.LNX.4.64.0712292307210.14355@wbgn129.biozentrum.uni-wuerzburg.de>
References: <e5bfff550712291001q5f246ceah6700b98308fb96f1@mail.gmail.com> 
 <Pine.LNX.4.64.0712292019450.14355@wbgn129.biozentrum.uni-wuerzburg.de>
 <e5bfff550712291239y5648b923y8d332d9c40a8c97b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Marco Costalba <mcostalba@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 29 23:15:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J8jy7-0004Bx-1K
	for gcvg-git-2@gmane.org; Sat, 29 Dec 2007 23:15:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752359AbXL2WPW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Dec 2007 17:15:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752209AbXL2WPW
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Dec 2007 17:15:22 -0500
Received: from mail.gmx.net ([213.165.64.20]:42484 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752079AbXL2WPV (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Dec 2007 17:15:21 -0500
Received: (qmail invoked by alias); 29 Dec 2007 22:15:19 -0000
Received: from wbgn128.biozentrum.uni-wuerzburg.de (EHLO wrzx67.rz.uni-wuerzburg.de) [132.187.25.128]
  by mail.gmx.net (mp056) with SMTP; 29 Dec 2007 23:15:19 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+3SsYDgji3DlV/EmsUFZRQurrnEzMLZWCwJSebKI
	Z4bgd7A1Lr5aHN
X-X-Sender: gene099@wbgn129.biozentrum.uni-wuerzburg.de
In-Reply-To: <e5bfff550712291239y5648b923y8d332d9c40a8c97b@mail.gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69333>

Hi,

On Sat, 29 Dec 2007, Marco Costalba wrote:

> What your patch does not seem to avoid is a segfault if prefix or str 
> are NULL pointers.

I am quite certain that it is not allowed to pass NULL pointers to strcmp, 
and even if it was, I maintain that it is bad style.

FWIW the test suite seems to agree with me, as it passes with my patch.

However, since you already seem to have a profiling setup ready, I would 
be interested in some numbers, i.e. if this patch is faster for you or 
slower, or shows no effect at all.

Ciao,
Dscho
