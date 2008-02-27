From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Using gpg and gitattributes together
Date: Wed, 27 Feb 2008 00:13:19 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0802270008550.22527@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 27 01:14:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JU9wK-000436-Ac
	for gcvg-git-2@gmane.org; Wed, 27 Feb 2008 01:14:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581AbYB0ANu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Feb 2008 19:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754077AbYB0ANu
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Feb 2008 19:13:50 -0500
Received: from mail.gmx.net ([213.165.64.20]:37411 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752899AbYB0ANu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Feb 2008 19:13:50 -0500
Received: (qmail invoked by alias); 27 Feb 2008 00:13:47 -0000
Received: from host86-138-198-40.range86-138.btcentralplus.com (EHLO racer.home) [86.138.198.40]
  by mail.gmx.net (mp022) with SMTP; 27 Feb 2008 01:13:47 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+fdr9Yloyf7p+xlY7iCRU1sYoeoHbWCYQugEOLBq
	J+RIAg/VbR2Iqm
X-X-Sender: gene099@racer.site
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75194>

Hi,

I just added my .netrc to a repository where I track some files that I 
would hate to lose.  However, since I mirror that repository to a machine 
where other people than me have root access, I thought that I encrypt the 
file with gpg.

To make this procedure more convenient for me, I decided not to encrypt 
with a private key, but with a passphrase, and to use gitattributes to do 
the encryption for me:

$ echo 'netrc filter=gpg' > .gitattributes
$ git config filter.gpg.clean 'gpg --cipher-algo AES256 -c'
$ git config filter.gpg.smudge 'gpg --decrypt'
$ git add netrc

It asks quite a few times for the passphrase (as expected), but I had to 
add the file twice (not expected).  However, since it worked now, I am 
happy.

Maybe somebody else will find this information useful.

Ciao,
Dscho
