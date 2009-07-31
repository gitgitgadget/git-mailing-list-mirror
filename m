From: "George Spelvin" <linux@horizon.com>
Subject: Re: Request for benchmarking: x86 SHA1 code
Date: 31 Jul 2009 08:32:03 -0400
Message-ID: <20090731123203.6160.qmail@science.horizon.com>
References: <40aa078e0907310524x1fe4d84dr858ebc03731ee093@mail.gmail.com>
Cc: git@vger.kernel.org, linux@horizon.com
To: git@drmicha.warpmail.net, kusmabite@googlemail.com
X-From: git-owner@vger.kernel.org Fri Jul 31 14:32:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MWrHR-0001r6-Oz
	for gcvg-git-2@gmane.org; Fri, 31 Jul 2009 14:32:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751668AbZGaMcF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jul 2009 08:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751171AbZGaMcF
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Jul 2009 08:32:05 -0400
Received: from science.horizon.com ([71.41.210.146]:39512 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750966AbZGaMcE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jul 2009 08:32:04 -0400
Received: (qmail 6161 invoked by uid 1000); 31 Jul 2009 08:32:03 -0400
In-Reply-To: <40aa078e0907310524x1fe4d84dr858ebc03731ee093@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124553>

> Now I'm getting a different error:
> $ make
> as   -o sha1-586.o sha1-586.s
> sha1-586.s: Assembler messages:
> sha1-586.s:4: Warning: .type pseudo-op used outside of .def/.endef ignored.
> sha1-586.s:4: Error: junk at end of line, first unrecognized character is `s'
> sha1-586.s:1438: Warning: .size pseudo-op used outside of .def/.endef ignored.
> sha1-586.s:1438: Error: junk at end of line, first unrecognized character is `s'
> 
> make: *** [sha1-586.o] Error 1

> What might be relevant, is that I'm trying this on Windows (Vista
> 64bit). I'd still think GNU as should be able to assemble the source,
> though. I've got an i7, so I thought the result might be interresting.

Ah... what assembler?  the perl proprocessor supports multiple
assemblers:
	elf     - Linux, FreeBSD, Solaris x86, etc.
	a.out   - DJGPP, elder OpenBSD, etc.
	coff    - GAS/COFF such as Win32 targets
	win32n  - Windows 95/Windows NT NASM format
	nw-nasm - NetWare NASM format
	nw-mwasm- NetWare Metrowerks Assembler

Maybe you need to replace "elf" with "coff"?
