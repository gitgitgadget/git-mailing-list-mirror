From: Andreas Schwab <schwab@linux-m68k.org>
Subject: Re: [PATCH 1/2] MSVC: Do not close stdout to prevent a crash
Date: Sat, 19 Nov 2011 15:41:38 +0100
Message-ID: <m2sjlkcgyl.fsf@igel.home>
References: <1321710345-2299-1-git-send-email-vfr@lyx.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, msysgit@googlegroups.com, gitster@pobox.com,
	kusmabite@gmail.com, Johannes.Schindelin@gmx.de
To: Vincent van Ravesteijn <vfr@lyx.org>
X-From: git-owner@vger.kernel.org Sat Nov 19 15:41:54 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RRm76-0002eX-Hh
	for gcvg-git-2@lo.gmane.org; Sat, 19 Nov 2011 15:41:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751365Ab1KSOlq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Nov 2011 09:41:46 -0500
Received: from mail-out.m-online.net ([212.18.0.10]:44484 "EHLO
	mail-out.m-online.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751084Ab1KSOlp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Nov 2011 09:41:45 -0500
Received: from frontend1.mail.m-online.net (frontend1.mail.intern.m-online.net [192.168.8.180])
	by mail-out.m-online.net (Postfix) with ESMTP id 1221B188A18B;
	Sat, 19 Nov 2011 15:44:16 +0100 (CET)
Received: from localhost (dynscan1.mnet-online.de [192.168.8.164])
	by mail.m-online.net (Postfix) with ESMTP id 2D2311C000FE;
	Sat, 19 Nov 2011 15:41:40 +0100 (CET)
X-Virus-Scanned: amavisd-new at mnet-online.de
Received: from mail.mnet-online.de ([192.168.8.180])
	by localhost (dynscan1.mail.m-online.net [192.168.8.164]) (amavisd-new, port 10024)
	with ESMTP id IU2zjgQvNt8W; Sat, 19 Nov 2011 15:41:40 +0100 (CET)
Received: from igel.home (ppp-88-217-98-198.dynamic.mnet-online.de [88.217.98.198])
	by mail.mnet-online.de (Postfix) with ESMTP;
	Sat, 19 Nov 2011 15:41:39 +0100 (CET)
Received: by igel.home (Postfix, from userid 501)
	id 2044ACA29C; Sat, 19 Nov 2011 15:41:38 +0100 (CET)
X-Yow: I know th'MAMBO!!  I have a TWO-TONE CHEMISTRY SET!!
In-Reply-To: <1321710345-2299-1-git-send-email-vfr@lyx.org> (Vincent van
	Ravesteijn's message of "Sat, 19 Nov 2011 14:45:44 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.91 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185693>

Vincent van Ravesteijn <vfr@lyx.org> writes:

> When compiled with MSVC, git crashes on Windows when calling
> fstat(stdout) when stdout is closed. fstat is being called at the end of

ITYM fileno(stdout).

> run_builtin and this will thus be a problem for builtin command that close
> stdout. This happens for 'format-patch' which closes stdout after a call to
> freopen which directs stdout to the format patch file.

It shouldn't do that in the first place.  This is an error on any
platform.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
