From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Add a new lstat implementation based on Win32 API, and
 make stat use that implementation too.
Date: Sun, 2 Sep 2007 18:44:59 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0709021843270.28586@racer.site>
References: <46DACD93.9000509@trolltech.com> <46DACE0D.5070501@trolltech.com>
 <3f4fd2640709020832x656fa78djf29117690318ea48@mail.gmail.com>
 <46DAE025.900@trolltech.com> <3f4fd2640709020933sa2bdec0g532500ea49c179b5@mail.gmail.com>
 <F0525923-6D9B-46AA-9678-8B1263C45FF7@silverinsanity.com>
 <3f4fd2640709020953k2f5367a0o64870da9d8e04f68@mail.gmail.com>
 <46DAED4F.2080407@trolltech.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Reece Dunn <msclrhd@googlemail.com>,
	Brian Gernhardt <benji@silverinsanity.com>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <johannes.sixt@telecom.at>
To: Marius Storm-Olsen <marius@trolltech.com>
X-From: git-owner@vger.kernel.org Sun Sep 02 19:45:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRtW6-0002oA-Br
	for gcvg-git@gmane.org; Sun, 02 Sep 2007 19:45:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753349AbXIBRpm (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Sep 2007 13:45:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752964AbXIBRpm
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Sep 2007 13:45:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:51999 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751765AbXIBRpl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Sep 2007 13:45:41 -0400
Received: (qmail invoked by alias); 02 Sep 2007 17:45:39 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp021) with SMTP; 02 Sep 2007 19:45:39 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19CCsYDvtNCin9yJpp524LRyVM6YSTN1OWz7zNCz6
	o7m9Hu+YNBX1I1
X-X-Sender: gene099@racer.site
In-Reply-To: <46DAED4F.2080407@trolltech.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57372>

Hi,

On Sun, 2 Sep 2007, Marius Storm-Olsen wrote:

> The conversion of the FileTime to unix time_t is far more heavy.

Really?  If so, we might consider storing FILETIME->dwHightDateTime and 
->dwLowDateTime in the index.

But I doubt it.  AFAICT _getting_ at the stat data is the expensive thing 
in Windows, not a 64-bit addition, subtraction and division.

Ciao,
Dscho
