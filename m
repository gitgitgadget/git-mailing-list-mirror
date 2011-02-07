From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [msysGit] Re: [PATCH v4 5/5] mingw_rmdir: set errno=ENOTEMPTY
	when appropriate
Date: Mon, 7 Feb 2011 22:18:44 +0100
Message-ID: <20110207211844.GH63976@book.hvoigt.net>
References: <20101214220604.GA4084@sandbox> <AANLkTiks1drfpu9eR6S7KQ9X2MgVy91QAfKs-SRF_voG@mail.gmail.com> <7vmxo6pxyi.fsf@alter.siamese.dyndns.org> <20110207204818.GA63976@book.hvoigt.net> <20110207205400.GF63976@book.hvoigt.net> <AANLkTin6A-HVKvM9_5ggMezpM--tt1qUwSXF+CEaXg7J@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Pat Thoyts <patthoyts@users.sourceforge.net>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 07 22:18:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PmYU0-0001lZ-Mj
	for gcvg-git-2@lo.gmane.org; Mon, 07 Feb 2011 22:18:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754801Ab1BGVSq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Feb 2011 16:18:46 -0500
Received: from darksea.de ([83.133.111.250]:49156 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753949Ab1BGVSq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Feb 2011 16:18:46 -0500
Received: (qmail 11903 invoked from network); 7 Feb 2011 22:18:44 +0100
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 7 Feb 2011 22:18:44 +0100
Content-Disposition: inline
In-Reply-To: <AANLkTin6A-HVKvM9_5ggMezpM--tt1qUwSXF+CEaXg7J@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166297>

On Mon, Feb 07, 2011 at 10:07:10PM +0100, Erik Faye-Lund wrote:
> On Mon, Feb 7, 2011 at 9:54 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > From: Johannes Schindelin <johannes.schindelin@gmx.de>
> >
> > On Windows, EACCES overrules ENOTEMPTY when calling rmdir(). But if the
> > directory is busy, we only want to retry deleting the directory if it
> > is empty, so test specifically for that case and set ENOTEMPTY rather
> > than EACCES.
> >
> 
> I'm sorry, I don't quite understand. rmdir on Windows/MinGW fails with
> errno=ENOTEMPTY if a directory isn't empty:

I think Johannes was referring to the case when a directory is busy.
E.g. a process is running that has its working directory inside that
directory. In that case ENOTEMPTY was not returned even though the
directory is not empty. Thats what I read from the patch.

Cheers Heiko
