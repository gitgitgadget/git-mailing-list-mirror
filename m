From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 0/2] RUNTIME_PREFIX enhancements
Date: Wed, 18 Feb 2009 22:11:48 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902182208070.10279@pacific.mpi-cbg.de>
References: <cover.1234969572u.git.johannes.schindelin@gmx.de> <499C63C2.3050405@kdbg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com,
	Steffen Prohaska <prohaska@zib.de>
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Feb 18 22:12:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LZtiM-0005pd-3a
	for gcvg-git-2@gmane.org; Wed, 18 Feb 2009 22:12:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061AbZBRVKt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Feb 2009 16:10:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752020AbZBRVKt
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Feb 2009 16:10:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:60843 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751712AbZBRVKt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Feb 2009 16:10:49 -0500
Received: (qmail invoked by alias); 18 Feb 2009 21:10:46 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp009) with SMTP; 18 Feb 2009 22:10:46 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+/zskxrRm/2gVYbmgTNnZMwFXlhsGDckVl6dAhT1
	7Y9GX5nufhNgiJ
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <499C63C2.3050405@kdbg.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.62
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110576>

Hi,

On Wed, 18 Feb 2009, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> > When I ran "make" in msysGit's /git/, I was greeted by a pretty unfriendly
> > message about a RUNTIME_PREFIX that could not be determined.
> 
> ;)
> 
> I have a patch in my private tree that removes the warning.

I briefly considered this.  But my patch actually does something different 
than hiding an error condition.  It copes with the very peculiar situation 
we have on Windows.

I still would like to see the warning if something goes wrong -- _outside_ 
/git/.

> This only silences the warning, but there is no guarantee that the 
> resulting git suite works because your msysgit developer may not have 
> installed stuff in C:\msysgit\libexec\git-core, yet.

The good thing: it still works.  Why?  Because Git actually does _not_ 
search the Git binaries in libexec/git-core.  It adds that directory to 
PATH and lets the PATH lookup handle the searching.  So it kind of works, 
but in a different manner than you think it works.

But that cannot be helped.

Ciao,
Dscho
