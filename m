From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Fix type-punning issues
Date: Tue, 12 May 2009 10:13:50 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0905121012430.27348@pacific.mpi-cbg.de>
References: <1242091058-25197-1-git-send-email-dpmcgee@gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="8323328-1039355777-1242116030=:27348"
Cc: git@vger.kernel.org
To: Dan McGee <dpmcgee@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 12 10:13:53 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M3n7Z-0007Wt-1S
	for gcvg-git-2@gmane.org; Tue, 12 May 2009 10:13:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756050AbZELINp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2009 04:13:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754740AbZELINo
	(ORCPT <rfc822;git-outgoing>); Tue, 12 May 2009 04:13:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:38379 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753257AbZELINn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2009 04:13:43 -0400
Received: (qmail invoked by alias); 12 May 2009 08:13:43 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp059) with SMTP; 12 May 2009 10:13:43 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/oitAPQkjoivwu7DBBePlYX6MrCVegvRFWxxqqys
	7c36QzRUoubGFf
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <1242091058-25197-1-git-send-email-dpmcgee@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/118881>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1039355777-1242116030=:27348
Content-Type: TEXT/PLAIN; charset=utf-8
Content-Transfer-Encoding: 8BIT

Hi,

On Mon, 11 May 2009, Dan McGee wrote:

> In these two places we are casting part of our unsigned char sha1 array 
> into an unsigned int, which violates GCCs strict-aliasing rules (and 
> probably other compilers). In addition, we had two hashing functions 
> defined in object.c. Keep the one function that is "correct" and adopt 
> the other ones to fit.
> 
> decorate.c: In function ‘hash_obj’:
> decorate.c:11: warning: dereferencing type-punned pointer will break
> strict-aliasing rules

FWIW we have the same issue in msysGit, having installed GCC 4.4.0 
recently, but I did not dare to send my "fix".  Yours is much nicer.

Thanks,
Dscho
--8323328-1039355777-1242116030=:27348--
