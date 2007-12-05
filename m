From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: [PATCH] Do not rely on the exit status of "unset" for unset
 variables
Date: Wed, 5 Dec 2007 08:01:57 +0000
Message-ID: <20071205080157.5121bfee@pc09.procura.nl>
References: <20071204130922.731c407a@pc09.procura.nl>
 <Pine.LNX.4.64.0712041343040.27959@racer.site>
 <20071204140326.14d9e7a0@pc09.procura.nl>
 <Pine.LNX.4.64.0712041439590.27959@racer.site>
 <20071204150102.7f3ec3e9@pc09.procura.nl>
 <47556EE2.6040105@op5.se>
 <20071204152240.6cb6018e@pc09.procura.nl>
 <Pine.LNX.4.64.0712041536180.27959@racer.site>
 <20071204155655.053f4fb4@pc09.procura.nl>
 <7vve7e49or.fsf@gitster.siamese.dyndns.org>
 <Pine.LNX.4.64.0712042242310.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, Andreas Ericsson <ae@op5.se>,
	git@vger.kernel.org, Sam Vilain <sam@vilain.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 05 09:02:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzpDQ-0006ei-P0
	for gcvg-git-2@gmane.org; Wed, 05 Dec 2007 09:02:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751641AbXLEICQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Dec 2007 03:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbXLEICQ
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Dec 2007 03:02:16 -0500
Received: from smtp-vbr10.xs4all.nl ([194.109.24.30]:4878 "EHLO
	smtp-vbr10.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751422AbXLEICO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Dec 2007 03:02:14 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr10.xs4all.nl (8.13.8/8.13.8) with ESMTP id lB581wf8056998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 5 Dec 2007 09:01:59 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <Pine.LNX.4.64.0712042242310.27959@racer.site>
X-Mailer: Claws Mail 3.1.0cvs51 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67120>

On Tue, 4 Dec 2007 22:45:16 +0000 (GMT), Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> From: H.Merijn Brand <h.m.brand@xs4all.nl>
> 
> POSIX says that exit status "0" means that "unset" successfully unset
> the variable.  However, it is kind of ambiguous if an environment
> variable which was not set could be successfully unset.
> 
> At least the default shell on HP-UX insists on reporting an error in

please, for now make that HP-UX 11.11 and older. I'll check if it also
fails in 11.23/IPF.

On 11.11 HP C-ANSI-C cannot be used either.

And I have to remove "#include <sys/select.h>" from pager.c on HP-UX, I
forgot to tell. With the Makefile change in place, building with 64bit
gcc, 

--8<--- skip this part if you're not interested in 64bit builds on HP-UX
On 64bit gcc on HP-UX, there is no strtoull (). Nowhere! strtoul () is
the same there. But this is only in the 64bit world, so NO_STRTOULL can
not be set to YesPlease unconditionally. When I also set NO_STRTOUMAX,
I get shiploads of warnings like:

    CC commit.o
In file included from cache.h:4,
                 from commit.c:1:
git-compat-util.h:166:1: warning: "strtoumax" redefined
In file included from git-compat-util.h:62,
                 from cache.h:4,
                 from commit.c:1:
/usr/include/inttypes.h:527:1: warning: this is the location of the previous
definition

And that is NOT your fault, as this include file has defines like

** When compiling in ILP32 mode long long will be used for the 64-bit data
** types. This will cause compilation errors if 64-bit data types are
** requested and the compiler in use does not support them.

#define strtoimax(__a, __b, __c) __strtoll(__a, __b, __c)
#define strtoumax(__a, __b, __c) __strtoull(__a, __b, __c)

and that is not guarded with something like

/* LP64 takes precedence */
#if (defined(__STDC_EXT__) || defined(_INCLUDE_LONGLONG))
&& !defined(__LP64__)

so I ended up replacing all strtoumax () to strtoul () in git-fast-import.c

Then I end up with the same error as on 11.00.
-->8---


> such a case, so just ignore the exit status of "unset".
> 
> [Dscho: extended the patch to git-submodule.sh, as Junio realized that
>  this is the only other place where we check the exit status of "unset".]
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
> 
> 	On Tue, 4 Dec 2007, Junio C Hamano wrote:
> 
> 	> "H.Merijn Brand" <h.m.brand@xs4all.nl> writes:
> 	> 
> 	> > On Tue, 4 Dec 2007 15:39:47 +0000 (GMT), Johannes Schindelin
> 	> > ...
> 	> > I found it! unset returns false
> 	> > ...
> 	> > I must leave now.
> 	> 
> 	> Thanks, you two.
> 	> 
> 	> I do not see "unset VAR... &&" outside t0001 test, but there are
> 	> instances of "unset VAR... &&" in git-submodule implementations 
> 	> as well.
> 	> 
> 	> In short, not too many places to fix.
> 
> 	You're right.  I grepped for "unset" in t/*.sh, but that catches 
> 	only false positives other than t0001.
> 
> 	Merijn, maybe you want to have your sign-off in the commit 
> 	message?

Feel free to do so, I don't really care.

Will you also be looking into the install issue?

-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
