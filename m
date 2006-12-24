From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: i18n.logToUTF8: convert commit log message to UTF-8
Date: Sun, 24 Dec 2006 15:18:47 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0612241505290.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Sun Dec 24 15:18:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GyUBg-00047N-Ua
	for gcvg-git@gmane.org; Sun, 24 Dec 2006 15:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751667AbWLXOSt (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Dec 2006 09:18:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751665AbWLXOSt
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Dec 2006 09:18:49 -0500
Received: from mail.gmx.net ([213.165.64.20]:39787 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751667AbWLXOSs (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Dec 2006 09:18:48 -0500
Received: (qmail invoked by alias); 24 Dec 2006 14:18:47 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp053) with SMTP; 24 Dec 2006 15:18:47 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: git@vger.kernel.org, junkio@cox.net
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35358>

Hi,

I don't like the convention to add the encoding after a trailing NUL. I'd 
rather have it as an "encoding blabl" header like the author and committer 
headers. I.e.

-- snip --
tree 519fba5ec35f25cbac7f46574f214fb5eb95d2c8
parent 41c7c86ccbcb846cacf48c5e283983fa797cf37b
author Johannes Schindelin <Johannes.Schindelin@gmx.de> 1166969650 +0100
committer Johannes Schindelin <Johannes.Schindelin@gmx.de> 1166969650 +0100
encoding latin1

    git-commit-tree: add encoding header if commitEncoding != utf-8
-- snap --

Our log routines all grok these commit objects.

And I would prefer commit-tree to fail if we explicitely ask for 
conversion to UTF-8, but NO_ICONV is set, or reencoding fails for other 
reasons.

Ciao,
Dscho
