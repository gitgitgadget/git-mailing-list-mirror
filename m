From: Peter Baumann <waste.manager@gmx.de>
Subject: Re: [PATCH] Makefile: create an install-symlinks target
Date: Mon, 30 Jul 2007 00:26:04 +0200
Message-ID: <20070729222604.GB5753@xp.machine.xx>
References: <85lkcyvr4f.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 30 00:26:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IFHDI-0007bd-34
	for gcvg-git@gmane.org; Mon, 30 Jul 2007 00:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964833AbXG2W0I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 18:26:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964816AbXG2W0H
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 18:26:07 -0400
Received: from mail.gmx.net ([213.165.64.20]:39796 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1762848AbXG2W0G (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 18:26:06 -0400
Received: (qmail invoked by alias); 29 Jul 2007 22:26:04 -0000
Received: from mason.hofmann.stw.uni-erlangen.de (EHLO localhost) [131.188.24.36]
  by mail.gmx.net (mp054) with SMTP; 30 Jul 2007 00:26:04 +0200
X-Authenticated: #1252284
X-Provags-ID: V01U2FsdGVkX18cWAFLC1kcfKVawoyoOUl+CPOl7HYyBEd8QfqcNV
	/2siS6fOqPeLE1
Mail-Followup-To: David Kastrup <dak@gnu.org>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <85lkcyvr4f.fsf@lola.goethe.zz>
User-Agent: Mutt/1.5.16 (2007-06-11)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54142>

On Sun, Jul 29, 2007 at 11:26:08PM +0200, David Kastrup wrote:
> [commit text mostly pinched from INSTALL]
> 
> An alternative global installation method making it much easier to
> uninstall is to use a package-specific prefix like /opt/git, then
> create symlinks from /usr/local into that hierarchy.  Uninstalling can
> then be achieved by
> 
> 	# rm -rf /opt/git; find /usr/local -xtype l -delete
> 
> You can create a setup like that after having used one of the above
> install recipes with prefix=/opt/git by writing
> 
> 	# make prefix=/opt/git symlinkprefix=/usr/local install-symlinks
> 
> This works by copying the directory hierarchy of $prefix to
> $symlinkprefix (not copying or descending to any directories of the
> name git* matched case-insensitively), then linking all the rest.
> 
> Signed-off-by: David Kastrup <dak@gnu.org>

AFAIR I suggested this the last time this came up, but in case you
missed it:

Use (x)stow for this. It does exactly what you want. No need to hack the
Makefile.

-Peter
