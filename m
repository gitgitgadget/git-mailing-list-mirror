From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: mingw, windows, crlf/lf, and git
Date: Mon, 12 Feb 2007 00:34:27 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702120028340.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <45CFA30C.6030202@verizon.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: Mark Levedahl <mlevedahl@verizon.net>
X-From: git-owner@vger.kernel.org Mon Feb 12 00:34:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGODI-0001vg-Un
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 00:34:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932821AbXBKXea (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 18:34:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932914AbXBKXe3
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 18:34:29 -0500
Received: from mail.gmx.net ([213.165.64.20]:56891 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932821AbXBKXe3 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 18:34:29 -0500
Received: (qmail invoked by alias); 11 Feb 2007 23:34:28 -0000
X-Provags-ID: V01U2FsdGVkX18siD5bs+IsjAlc2VMTWy94aJXnfVCoJVW1gqQyAx
	fZJA==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <45CFA30C.6030202@verizon.net>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39331>

Hi,

On Sun, 11 Feb 2007, Mark Levedahl wrote:

> The major competing solutions git seeks to supplant (cvs, cvsnt, svn, 
> hg) have capability to recognize "text" files and transparently replace 
> \r\n with \n on input, the reverse on output, and ignore all such 
> differences on diff operations.

Agree with transformations on input and output; disagree on diff.

The problem is that it really is a transformtion. Since most Windows tools 
(at least those used in portable software) handle \n without \r quite 
well, thank you, I'd tend towards the view point: do not mess with line 
endings pre-commit/post-checkout.

Even MacOSX uses \n now, instead of \r.

Of course, for those projects which _use_ CRLF: they can continue with it. 
Git has no problem with those line endings.

The only problem CVS tried to solve (badly) was to be able to checkout 
text files on DOS, Unix _and_ MacOS. In practice, though, this use case 
does not matter anymore IMHO.

Ciao,
Dscho
