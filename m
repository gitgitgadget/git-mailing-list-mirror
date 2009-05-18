From: Heiko Voigt <hvoigt@hvoigt.net>
Subject: Re: [PATCH v2] Extend sample pre-commit hook to check for non
	ascii filenames
Date: Mon, 18 May 2009 11:37:10 +0200
Message-ID: <20090518093655.GA910@heiko-voigts-macbook.local>
References: <419AD153-53B4-4DAB-AF72-4127C17B1CA0@gmail.com> <m3r5yukv6g.fsf@localhost.localdomain> <20090512214250.GA22974@macbook.lan> <200905122356.00659.jnareb@gmail.com> <20090514175850.GA26267@macbook.lan> <46a038f90905150352q76157227q24c6b8c0befa4108@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Dmitry Potapov <dpotapov@gmail.com>,
	Esko Luontola <esko.luontola@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 18 11:37:44 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M5zHx-0004Oe-Br
	for gcvg-git-2@gmane.org; Mon, 18 May 2009 11:37:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757288AbZERJhQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 May 2009 05:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757699AbZERJhP
	(ORCPT <rfc822;git-outgoing>); Mon, 18 May 2009 05:37:15 -0400
Received: from darksea.de ([83.133.111.250]:37994 "HELO darksea.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756596AbZERJhM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 May 2009 05:37:12 -0400
Received: (qmail 21121 invoked from network); 18 May 2009 11:37:04 +0200
Received: from unknown (HELO localhost) (127.0.0.1)
  by localhost with SMTP; 18 May 2009 11:37:04 +0200
Content-Disposition: inline
In-Reply-To: <46a038f90905150352q76157227q24c6b8c0befa4108@mail.gmail.com>
User-Agent: Mutt/1.5.19 (2009-01-05)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119433>

On Fri, May 15, 2009 at 12:52:41PM +0200, Martin Langhoff wrote:
> On Thu, May 14, 2009 at 7:59 PM, Heiko Voigt <hvoigt@hvoigt.net> wrote:
> > At the moment non-ascii encodings of filenames are not portably converted
> > between different filesystems by git. This will most likely change in the
> > future but to allow repositories to be portable among different file/operating
> > systems this check is enabled by default.
> 
> Nice!
> 
>  - It'd be a good idea to add to the mix a check for filenames that
> are equivalent in case-insensitive FSs.

I agree, but that will be an extension in another patch. BTW, if anyone
has a good idea how to efficiently do that kind of check in a hook I'd
cook up a patch on top of this.

>  - Should all of this be a general "portablefilenames" setting?

Well, if you can specify what general portable filenames would have as
properties.

Questions like:

 * What is the portable maximum path length?
 * How long may a filename be (DOS 8.3 ?)
 * Are windows keywords (PRN, ...) allowed?
 * ...

So I think this should be on a per property basis providing sensible
defaults to support the most standard case.

cheers Heiko
