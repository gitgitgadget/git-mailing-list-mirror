From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] daemon: send stderr of service programs to the syslog
Date: Sat, 20 Jun 2009 21:25:10 +0200
Message-ID: <200906202125.10844.j6t@kdbg.org>
References: <200906142238.51725.j6t@kdbg.org> <7veitgkm0i.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jun 20 21:25:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MI6Bp-0002NN-Pr
	for gcvg-git-2@gmane.org; Sat, 20 Jun 2009 21:25:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbZFTTZN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 20 Jun 2009 15:25:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbZFTTZN
	(ORCPT <rfc822;git-outgoing>); Sat, 20 Jun 2009 15:25:13 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:52056 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751337AbZFTTZM (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 20 Jun 2009 15:25:12 -0400
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 53FBD10010;
	Sat, 20 Jun 2009 21:25:11 +0200 (CEST)
Received: from localhost (localhost [IPv6:::1])
	by dx.sixt.local (Postfix) with ESMTP id 57D36256EB;
	Sat, 20 Jun 2009 21:25:11 +0200 (CEST)
User-Agent: KMail/1.9.9
In-Reply-To: <7veitgkm0i.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121952>

On Freitag, 19. Juni 2009, Junio C Hamano wrote:
> Johannes Sixt <j6t@kdbg.org> writes:
> > diff --git a/daemon.c b/daemon.c
> > index d7ceca4..3e1a354 100644
> > --- a/daemon.c
> > +++ b/daemon.c
> > @@ -1,6 +1,7 @@
> >  #include "cache.h"
> >  #include "pkt-line.h"
> > -#include "exec_cmd.h"
> > +#include "run-command.h"
> > +#include "strbuf.h"
>
>     CC daemon.o
> cc1: warnings being treated as errors
> daemon.c: In function 'main':
> daemon.c:981: error: implicit declaration of function
> 'git_extract_argv0_path' make: *** [daemon.o] Error 1
>
> I'll add the include back in the meantime.

Oops, you are right! Thanks for noticing it. Silly me: I didn't have -Wall in 
my CFLAGS.

-- Hannes
