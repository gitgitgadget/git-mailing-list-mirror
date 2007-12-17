From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: [PATCH] HP-UX does not have select.h
Date: Mon, 17 Dec 2007 23:22:59 +0100
Message-ID: <20071217232259.0b41a3bf@pc09.procura.nl>
References: <20071217192306.5da48540@pc09.procura.nl>
	<7v8x3t6nq1.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 17 23:25:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J4OOu-0006dX-OG
	for gcvg-git-2@gmane.org; Mon, 17 Dec 2007 23:25:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933333AbXLQWZB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 17 Dec 2007 17:25:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932986AbXLQWZB
	(ORCPT <rfc822;git-outgoing>); Mon, 17 Dec 2007 17:25:01 -0500
Received: from smtp-vbr5.xs4all.nl ([194.109.24.25]:4367 "EHLO
	smtp-vbr5.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932175AbXLQWY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 17 Dec 2007 17:24:59 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr5.xs4all.nl (8.13.8/8.13.8) with ESMTP id lBHMMxtx095440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 17 Dec 2007 23:23:03 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <7v8x3t6nq1.fsf@gitster.siamese.dyndns.org>
X-Mailer: Claws Mail 3.2.0 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
Face: iVBORw0KGgoAAAANSUhEUgAAADAAAAAwEAIAAACI8LKTAAAACXBIWXMAAABIAAAASABGyWs+AAAC
 JElEQVRo3u2aMY4CMQxFczZ6RItEzRm4DBINDbRUSPRInIRbsNK6+dJfezN4kokn48IaCSjysL8d
 e9Knoj2fr9f9/gllqQ6U9/vxWK3EdwdIEGjRIVCu18NhuxUfK46SH81+fzrdbuKPx/P5ctHQdAdI
 TKAgpvV6s9ntBEfXEYSGgMQzIHnuFBBjkshCNJ2KtJZ04hHNAugP8bZr3NIHhbcF0AKoK0CoaHXU
 LUWBIs1n+jV+Fl8CVqOApEXAwyMO/DSR4XVntoAYDR7eBjQupuYAYTMph8Rj21D4m7MChN02tpqs
 NSnb/KqU2oHCXu5xDCgflj/RAgBiKBIXnICzAsSjWBsTz5K4/HeXYvb8yK5lY3VGEwPi2aONKT+5
 AlcxrTPOwcTiraGRChgMEKJh0bVVifGVTq6qgBiNVl8QE29EsK6VE+YJAOG2wz5AvsqUS6uqgHCA
 n4NGvBYpnJ64Jgg27sCtxtBk1CJIA4S/GhdWKh07QxUB48jWGhZ4jKamRRr/T8/M0AaEyctry6YB
 4dTGj9iWZNs3DahES5kPCJOu0RQbF/fQOBprsB9gaO9JtPDzII9U5ySXX7AnuIt91y54AAW7rPpT
 LCe5gt3F+CLqr2UarGB3MXvMylWGq4+9RCx3TW1oJq1t3HPQlFs6N1fFNEB4s8dn7Ne7ACSm7TPQ
 I5quAWmw6qBpulHM33B0Csge4Nd8JTTYG2b1XyRe3lH8x34ABJ6aePuQ2N4AAAAASUVORK5CYII=
X-Virus-Scanned: by XS4ALL Virus Scanner
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68638>

On Mon, 17 Dec 2007 13:00:22 -0800, Junio C Hamano <gitster@pobox.com> wrote:

> "H.Merijn Brand" <h.m.brand@xs4all.nl> writes:
> 
> > HP-UX does not have select.h, but it offers all select () functionality.
> > The defines are in <sys/types.h> and <X11/fd.h>
> 
> Will apply the patch as-is for now, only because I do not want major
> surgery during rc period, but I think is can be improved.

Probably. but there is so much to be improved :)

> POSIX.1-2001 expects <sys/select.h> declares select(2).  With earlier
> standards, including <sys/time.h>, <sys/types.h> and <unistd.h> would
> have given it.

Those three are there. I have 10.20 through 11.23 on PA-RISC and
11.23 on Itanium 2.

10.20, 11.00, and 11.11 (11i v1) do not have sys/select.h. 11.23 and
on do have it. The problem for now is that git on HP-UX does not build
with HP's C-ANSI-C compiler. I need to use gcc. Up to and including
11.11, I cannot use 4.x, as that has serious problems when used in 64bit
mode, so I'm stuck with gcc-3.4.6

> HP-UX cannot be the only pre-POSIX system; "#ifndef _HPUX_SOURCE" feels
> very wrong.

HP-UX 11.23/IPC, which is rather recent, does include sys/select.h
I didn't sent my HP-UX patch yet for the Makefile, as that is still
very premature. It is OK for 11.00, but as I need 64bit on 11.23,
because I only have 64bit OpenSSL and other util libraries, the 32bit
addition would not work.

> Besides, isn't _HPUX_SOURCE a feature-test macro?  Feature test macros

That is defined in GNU gcc. I did not pass it with -D...

> are for the application to define, and for the implementation (iow, the
> header files) to find out what set of names the application wants to
> see.  You are making the application examine the symbol to see what
> implementation it is on, which feels backwards to me.

-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
