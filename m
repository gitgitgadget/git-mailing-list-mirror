From: "Bernhard R. Link" <brlink@debian.org>
Subject: Re: [PATCH 4/4] Makefile: Don't pass $(ALL_CFLAGS) to the linker
Date: Sun, 27 Jun 2010 11:44:34 +0200
Message-ID: <20100627094433.GA21771@pcpool00.mathematik.uni-freiburg.de>
References: <4C226520.5080009@ramsay1.demon.co.uk> <20100623210820.GA24242@burratino> <4C264019.6030408@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Jun 27 12:26:14 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OSp41-0003Yi-H3
	for gcvg-git-2@lo.gmane.org; Sun, 27 Jun 2010 12:26:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754681Ab0F0K0I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jun 2010 06:26:08 -0400
Received: from pcpool00.mathematik.uni-freiburg.de ([132.230.30.150]:35623
	"EHLO pcpool00.mathematik.uni-freiburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753193Ab0F0K0F (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 Jun 2010 06:26:05 -0400
X-Greylist: delayed 2487 seconds by postgrey-1.27 at vger.kernel.org; Sun, 27 Jun 2010 06:26:05 EDT
Received: from pcpool09.mathematik.uni-freiburg.de ([132.230.30.159])
	by pcpool00.mathematik.uni-freiburg.de with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1OSoPi-0001Ft-5C; Sun, 27 Jun 2010 11:44:34 +0200
Received: from brl by pcpool09.mathematik.uni-freiburg.de with local (Exim 4.69)
	(envelope-from <brl@pcpool00.mathematik.uni-freiburg.de>)
	id 1OSoPi-0005ik-30; Sun, 27 Jun 2010 11:44:34 +0200
Content-Disposition: inline
In-Reply-To: <4C264019.6030408@ramsay1.demon.co.uk>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149791>

* Ramsay Jones <ramsay@ramsay1.demon.co.uk> [100626 20:02]:
> Really? I thought that the general scheme was something like:
>
>     - LDFLAGS is for options which only affects the operation of
>       the linker (e.g. -L).
>     - CPPFLAGS is for options which only affects the operation of
>       the C pre-processor (e.g. -I, -D, -U)
>     - CFLAGS is for options which only affects the operation of
>       the compiler proper.

I think the problem are options like -g or -m64 and the like which
you also want to give to the linker on some systems, so it is quite
common and I'd say recommended to have the compiling stage get
CPPFLAGS and CFLAGS and the linking stage getting CFLAGS and LDFLAGS
(and link using the compiler, otherwise you might miss libraries anyway).
I do not know if automake started with this, or if it is older.

> Also, the last time I was forced to use automake (yuck), I noticed that
> it passed CPPFLAGS to the linker; I consider this to be a bug in
> automake. :-P

Huh? Never heared of that bug, it must be more than 15 years ago. Are
you sure it was not CFLAGS it passed to the linker?

	Bernhard R. Link

No need to CC me, I'm subscribed...
