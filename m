From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] builtin-blame.c: Use utf8_strwidth for author's names
Date: Sun, 1 Feb 2009 23:34:21 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0902012333060.3586@pacific.mpi-cbg.de>
References: <1233308489-2656-1-git-send-email-geofft@mit.edu> <1233308489-2656-2-git-send-email-geofft@mit.edu> <alpine.DEB.1.00.0901301811180.3586@pacific.mpi-cbg.de> <alpine.DEB.2.00.0901301710130.1984@vinegar-pot.mit.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Geoffrey Thomas <geofft@MIT.EDU>
X-From: git-owner@vger.kernel.org Sun Feb 01 23:35:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTkuO-0006Lk-Jt
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 23:35:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753141AbZBAWdy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Feb 2009 17:33:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753104AbZBAWdy
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Feb 2009 17:33:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:56212 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752410AbZBAWdx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Feb 2009 17:33:53 -0500
Received: (qmail invoked by alias); 01 Feb 2009 22:33:51 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp031) with SMTP; 01 Feb 2009 23:33:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19ccpwvuiJc4hWpbe/peWTay03SP+4mdRcjLY/ZHx
	m7quuOVE/g8fLA
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <alpine.DEB.2.00.0901301710130.1984@vinegar-pot.mit.edu>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.63
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108015>

Hi,

On Fri, 30 Jan 2009, Geoffrey Thomas wrote:

> Currently, however, printf("%*.*s", width, width, author) is simply 
> wrong, because printf only cares about bytes, not screen columns. Do you 
> think I should fall back on the old behavior if i18n.commitencoding is 
> set, or if at least one of the author names isn't parseable as UTF-8, or 
> something? Or should I be doing this with iconv and assuming all commits 
> are encoded in the current encoding specified via $LANG or $LC_whatever?

I do not know what encoding the author is at that point, but if you cannot 
be sure that it is UTF-8, using utf8_strwidth() is just as wrong as the 
current code, IMHO.

Ciao,
Dscho
