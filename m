From: "H.Merijn Brand" <h.m.brand@xs4all.nl>
Subject: Why does git depend on two versions of libcrypto?
Date: Fri, 8 Feb 2008 10:46:12 +0100
Message-ID: <20080208104612.724d82ce@pc09.procura.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 08 10:46:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNPow-0007AC-Oo
	for gcvg-git-2@gmane.org; Fri, 08 Feb 2008 10:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbYBHJqY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 04:46:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760813AbYBHJqY
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 04:46:24 -0500
Received: from smtp-vbr1.xs4all.nl ([194.109.24.21]:1575 "EHLO
	smtp-vbr1.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758132AbYBHJqW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 04:46:22 -0500
Received: from pc09.procura.nl (procura.xs4all.nl [82.95.216.29])
	(authenticated bits=0)
	by smtp-vbr1.xs4all.nl (8.13.8/8.13.8) with ESMTP id m189kD7g019645
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <git@vger.kernel.org>; Fri, 8 Feb 2008 10:46:21 +0100 (CET)
	(envelope-from h.m.brand@xs4all.nl)
X-Mailer: Claws Mail 3.2.0cvs74 (GTK+ 2.10.6; x86_64-unknown-linux-gnu)
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73058>

Don't know if this is a git question or a OpenSUSE question, but why does git
depend on libcrypto.so.6 and not on libcrypto.so.0.9.8, like the rest does?

Isn't that asking for trouble?
In my case, they're both linked to the same lib, so I guess I'm safe.

/home/merijn > rpm -q git git-core
git-1.5.4-1
git-core-1.5.4-1
/home/merijn > rpm -qi git-core
Name        : git-core                     Relocations: (not relocatable)
Version     : 1.5.4                             Vendor: (none)
Release     : 1                             Build Date: Sat 02 Feb 2008 05:14:54 CET
Install Date: Fri 08 Feb 2008 10:32:28 CET      Build Host: hera.kernel.org
Group       : Development/Tools             Source RPM: git-1.5.4-1.src.rpm
Size        : 9223129                          License: GPL
Signature   : (none)
URL         : http://kernel.org/pub/software/scm/git/
Summary     : Core git tools
Description :
Git is a fast, scalable, distributed revision control system with an
unusually rich command set that provides both high-level operations
and full access to internals.

These are the core tools with minimal dependencies.
Distribution: (none)
/home/merijn > ll /usr/bin/git
14157168 -rwxr-xr-x 83 root root 769176 2008-02-02 05:14 /usr/bin/git
/home/merijn > file /usr/bin/git
/usr/bin/git: ELF 64-bit LSB executable, AMD x86-64, version 1 (SYSV), for GNU/Linux 2.6.9, dynamically linked (uses shared libs), for GNU/Linux 2.6.9, stripped
/home/merijn > llldd /usr/bin/git
ldd[01] on /usr/bin/git                   <=
ldd[02] on /usr/lib64/libcurl.so.3        <= /usr/bin/git
ldd[03] on /usr/lib64/libidn.so.11        <= /usr/lib64/libcurl.so.3.0.0
ldd[04] on /lib64/libc.so.6               <= /usr/lib64/libidn.so.11.5.22
ldd[03] on /usr/lib64/libssl.so.0.9.8     <= /usr/lib64/libcurl.so.3.0.0
ldd[04] on /usr/lib64/libcrypto.so.0.9.8  <= /usr/lib64/libssl.so.0.9.8
ldd[05] on /lib64/libdl.so.2              <= /usr/lib64/libcrypto.so.0.9.8
ldd[06] on /lib64/libc.so.6               <= /lib64/libdl-2.5.so
ldd[05] on /lib64/libz.so.1               <= /usr/lib64/libcrypto.so.0.9.8
ldd[06] on /lib64/libc.so.6               <= /lib64/libz.so.1.2.3
ldd[05] on /lib64/libc.so.6               <= /usr/lib64/libcrypto.so.0.9.8
ldd[04] on /lib64/libdl.so.2              <= /usr/lib64/libssl.so.0.9.8
ldd[04] on /lib64/libz.so.1               <= /usr/lib64/libssl.so.0.9.8
ldd[04] on /lib64/libc.so.6               <= /usr/lib64/libssl.so.0.9.8
ldd[03] on /usr/lib64/libcrypto.so.0.9.8  <= /usr/lib64/libcurl.so.3.0.0
ldd[03] on /lib64/libdl.so.2              <= /usr/lib64/libcurl.so.3.0.0
ldd[03] on /lib64/libz.so.1               <= /usr/lib64/libcurl.so.3.0.0
ldd[03] on /lib64/libc.so.6               <= /usr/lib64/libcurl.so.3.0.0
ldd[02] on /lib64/libz.so.1               <= /usr/bin/git
ldd[02] on /usr/lib64/libcrypto.so.6      <= /usr/bin/git
ldd[03] on /lib64/libdl.so.2              <= /usr/lib64/libcrypto.so.0.9.8
ldd[03] on /lib64/libz.so.1               <= /usr/lib64/libcrypto.so.0.9.8
ldd[03] on /lib64/libc.so.6               <= /usr/lib64/libcrypto.so.0.9.8
ldd[02] on /lib64/libc.so.6               <= /usr/bin/git
ldd[02] on /usr/lib64/libidn.so.11        <= /usr/bin/git
ldd[02] on /usr/lib64/libssl.so.0.9.8     <= /usr/bin/git
ldd[02] on /lib64/libdl.so.2              <= /usr/bin/git
Lib                                  Real path                            Package                        Size      Date                Refs
------------------------------------ ------------------------------------ ------------------------------ --------- ------------------- ----
/usr/bin/git                         /usr/bin/git                         git-core-1.5.4-1                  769176 2008-02-02 05:14:50    7
/usr/lib64/libcurl.so.3              /usr/lib64/libcurl.so.3.0.0          curl-7.15.5-23                    232480 2006-11-25 13:54:31    6
/usr/lib64/libidn.so.11              /usr/lib64/libidn.so.11.5.22         libidn-0.6.8-11                   204288 2006-11-25 12:45:38    1
/lib64/libc.so.6                     /lib64/libc-2.5.so                   glibc-2.5-34.7                   1595305 2007-11-21 18:29:59    0
/usr/lib64/libssl.so.0.9.8           /usr/lib64/libssl.so.0.9.8           openssl-0.9.8d-23.7               291176 2007-10-18 01:17:18    4
/usr/lib64/libcrypto.so.0.9.8        /usr/lib64/libcrypto.so.0.9.8        openssl-0.9.8d-23.7              1514360 2007-10-18 01:17:19    3
/lib64/libdl.so.2                    /lib64/libdl-2.5.so                  glibc-2.5-34.7                     19896 2007-11-21 18:29:58    1
/lib64/libz.so.1                     /lib64/libz.so.1.2.3                 zlib-1.2.3-33                      85288 2006-11-25 11:56:15    1
/usr/lib64/libcrypto.so.6            /usr/lib64/libcrypto.so.0.9.8        openssl-0.9.8d-23.7              1514360 2007-10-18 01:17:19    3

-- 
H.Merijn Brand         Amsterdam Perl Mongers (http://amsterdam.pm.org/)
using & porting perl 5.6.2, 5.8.x, 5.10.x  on HP-UX 10.20, 11.00, 11.11,
& 11.23, SuSE 10.1 & 10.2, AIX 5.2, and Cygwin.       http://qa.perl.org
http://mirrors.develooper.com/hpux/            http://www.test-smoke.org
                        http://www.goldmark.org/jeff/stupid-disclaimers/
