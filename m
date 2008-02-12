From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Re: libcrypto core dump in 64bit
Date: Tue, 12 Feb 2008 15:06:12 +0100
Message-ID: <20080212150612.4d28c373@pc09.procura.nl>
References: <20080211112822.16b69495@pc09.procura.nl>
	<alpine.LSU.1.00.0802112240280.3870@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 12 15:08:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOvmd-0003dI-JD
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 15:06:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759183AbYBLOGS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Feb 2008 09:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758875AbYBLOGR
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Feb 2008 09:06:17 -0500
Received: from smtp-vbr14.xs4all.nl ([194.109.24.34]:1330 "EHLO
	smtp-vbr14.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758619AbYBLOGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Feb 2008 09:06:16 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr14.xs4all.nl (8.13.8/8.13.8) with ESMTP id m1CE6C3N017308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Feb 2008 15:06:13 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
In-Reply-To: <alpine.LSU.1.00.0802112240280.3870@racer.site>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73662>

On Mon, 11 Feb 2008 22:42:16 +0000 (GMT), Johannes Schindelin
<Johannes.Schindelin@gmx.de> wrote:

> Hi,
> 
> On Mon, 11 Feb 2008, H.Merijn Brand wrote:
> 
> > Any hints?
> 
> Yes.
> 
> > #0  0xc0000000033c8940:0 in sha1_block_asm_host_order+0x22e0 ()
> >    from /usr/local/ssl/lib/libcrypto.so
> 
> This seems to be an OpenSSL issue, probably in its Itanium-optimised code 
> (since Itanium is not _all_ that common, it is quite likely that no many 
> people exercise this part of the code).

Now tried with HP C-ANSI-C -O3, -O2, -O1, and -O0 and with GNU gcc 4.2.1 -O3
All give the same failure
 
> Unfortunately, I am not at all an expert in Itanium's assembler, otherwise 
> I'd try to help...

-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
