From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH 01/14] msvc: Fix compilation errors in compat/win32/sys/poll.c
Date: Wed, 8 Dec 2010 20:42:06 +0100
Message-ID: <201012082042.06935.j6t@kdbg.org>
References: <4CFA8E64.6070402@ramsay1.demon.co.uk> <201012042222.23384.j6t@kdbg.org> <4CFECEBB.7060703@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, kusmabite@gmail.com,
	"GIT Mailing-list" <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Wed Dec 08 20:42:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQPud-0002C6-5g
	for gcvg-git-2@lo.gmane.org; Wed, 08 Dec 2010 20:42:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756444Ab0LHTmL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Dec 2010 14:42:11 -0500
Received: from bsmtp2.bon.at ([213.33.87.16]:26592 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1756438Ab0LHTmK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Dec 2010 14:42:10 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 22DCA2C4009;
	Wed,  8 Dec 2010 20:42:06 +0100 (CET)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 064E519F831;
	Wed,  8 Dec 2010 20:42:07 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <4CFECEBB.7060703@ramsay1.demon.co.uk>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163214>

On Mittwoch, 8. Dezember 2010, Ramsay Jones wrote:
> Johannes Sixt wrote:
> > On Samstag, 4. Dezember 2010, Ramsay Jones wrote:
> >> diff --git a/compat/win32/sys/poll.c b/compat/win32/sys/poll.c
> >> index 7e74ebe..708a6c9 100644
> >> --- a/compat/win32/sys/poll.c
> >> +++ b/compat/win32/sys/poll.c
> >> @@ -34,6 +34,9 @@
> >>
> >>  #if (defined _WIN32 || defined __WIN32__) && ! defined __CYGWIN__
> >>  # define WIN32_NATIVE
> >> +# if defined (_MSC_VER)
> >> +#  define _WIN32_WINNT 0x0502
> >> +# endif
> >>  # include <winsock2.h>
> >>  # include <windows.h>
> >>  # include <io.h>
> >
> > Don't you have to do the same in git-compat-util.h?
>
> No. compat/win32/sys/poll.c doesn't include git-compat-util.h (and I
> don't think it should),

I know and I agree.

> so adding it there would not solve the immediate 
> problem.

Didn't I say: "do the same..."? :-) So the question remains open. After all, 
by doing so, you would make sure that the rest of git sees the same API 
(struct definitions and #defined constants) as compat/win32/sys/poll.c, no?

-- Hannes
