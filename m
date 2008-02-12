From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: libcrypto core dump in 64bit
Date: Tue, 12 Feb 2008 17:38:42 +0100
Message-ID: <20080212173842.0a3704b1@pc09.procura.nl>
References: <20080211112822.16b69495@pc09.procura.nl>
	<alpine.LSU.1.00.0802112240280.3870@racer.site>
	<20080212150612.4d28c373@pc09.procura.nl>
	<loom.20080212T152138-849@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michal Rokos <michal@rokos.cz>
X-From: git-owner@vger.kernel.org Tue Feb 12 17:39:58 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOyAQ-0002of-25
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 17:39:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754824AbYBLQi5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 11:38:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756508AbYBLQi5
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 11:38:57 -0500
Received: from smtp-vbr8.xs4all.nl ([194.109.24.28]:4708 "EHLO
	smtp-vbr8.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753690AbYBLQiz (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 11:38:55 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr8.xs4all.nl (8.13.8/8.13.8) with ESMTP id m1CGcqsv015945
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Feb 2008 17:38:52 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <loom.20080212T152138-849@post.gmane.org>
X-Mailer: Claws Mail 3.3.0 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73672>

On Tue, 12 Feb 2008 15:26:16 +0000 (UTC), Michal Rokos <michal@rokos.cz>
wrote:

> Hello,
> 
> H.Merijn Brand <h.m.brand <at> xs4all.nl> writes:
> > On Mon, 11 Feb 2008 22:42:16 +0000 (GMT), Johannes Schindelin
> > <Johannes.Schindelin <at> gmx.de> wrote:
> > > > #0  0xc0000000033c8940:0 in sha1_block_asm_host_order+0x22e0 ()
> > > >    from /usr/local/ssl/lib/libcrypto.so
> > > 
> > > This seems to be an OpenSSL issue, probably in its Itanium-optimised code 
> > > (since Itanium is not _all_ that common, it is quite likely that no many 
> > > people exercise this part of the code).
> > 
> > Now tried with HP C-ANSI-C -O3, -O2, -O1, and -O0 and with GNU gcc 4.2.1 -O3
> > All give the same failure
> > 
> > > Unfortunately, I am not at all an expert in Itanium's assembler, otherwise 
> > > I'd try to help...
> 
> yes, this is OpenSSL issue. I had to recompile OpenSSL myself to make it work
> (with no-asm option)

OK, I did the same now, and the docs tell me to turn down optimization to
+O2 when you choose to do so.

Apart from that, when you create shared libs, the default build creates a
conflicting situation, so you have to throw away the files that cause dup
names: aes-ia64.o rc4-ia64.o bn-ia64.o from libcrypto.a

t5302-pack-index.sh now passes

> I'm using only HP cc for building git (with all the toolchain). (No gcc here)
> 
> # uname -mrs
> HP-UX B.11.23 ia64
> # cc --version
> cc: HP C/aC++ B3910B A.06.14 [Feb 22 2007]

HP-UX 11.23/64 U  rx1620/64 Itanium 2/1600(2) ia64  2037 Mb
cc: HP C/aC++ B3910B A.06.15 [May 16 2007]

Did you get the full test suite to pass?

-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
