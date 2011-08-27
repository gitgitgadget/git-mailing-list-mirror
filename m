From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: obstack fails to compile on OS X 10.7
Date: Sat, 27 Aug 2011 02:21:40 -0400
Message-ID: <4A1A024F-C5D5-4E5F-8474-DA3D87412C8A@gernhardtsoftware.com>
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Aug 27 08:29:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QxCOG-00006H-Vv
	for gcvg-git-2@lo.gmane.org; Sat, 27 Aug 2011 08:29:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751010Ab1H0G3E convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 27 Aug 2011 02:29:04 -0400
Received: from vs072.rosehosting.com ([216.114.78.72]:36773 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750865Ab1H0G3B convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Aug 2011 02:29:01 -0400
X-Greylist: delayed 438 seconds by postgrey-1.27 at vger.kernel.org; Sat, 27 Aug 2011 02:29:01 EDT
Received: by silverinsanity.com (Postfix, from userid 5001)
	id C2C031FFC166; Sat, 27 Aug 2011 06:21:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.9 required=3.5 tests=ALL_TRUSTED,AWL,BAYES_00
	autolearn=ham version=3.2.5
Received: from [10.10.10.10] (cpe-74-65-60-43.rochester.res.rr.com [74.65.60.43])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by silverinsanity.com (Postfix) with ESMTPSA id C8AC21FFC0EE
	for <git@vger.kernel.org>; Sat, 27 Aug 2011 06:21:29 +0000 (UTC)
X-Mailer: Apple Mail (2.1244.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180224>

Some of the errors look like things I could track down, but some just c=
onfuse me.  If anyone else could take a look into this, it would be muc=
h appreciated.

~~ Brian G.

gcc -o compat/obstack.o -c -MF compat/.depend/obstack.o.d -MMD -MP  -Wa=
ll -Wdeclaration-after-statement -Werror -Wno-deprecated-declarations -=
I. -DUSE_ST_TIMESPEC  -DSHA1_HEADER=3D'"block-sha1/sha1.h"'  -DNO_MEMME=
M  compat/obstack.c
In file included from compat/obstack.c:30:
compat/obstack.h:190: error: __block attribute can be specified on vari=
ables only
compat/obstack.c:70: error: expected specifier-qualifier-list before =91=
uintmax_t=92
compat/obstack.c:111:24: error: exitfail.h: No such file or directory
cc1: warnings being treated as errors
compat/obstack.c: In function =91print_and_abort=92:
compat/obstack.c:436: warning: implicit declaration of function =91gett=
ext=92
compat/obstack.c:436: warning: incompatible implicit declaration of bui=
lt-in function =91gettext=92
compat/obstack.c:438: error: =91exit_failure=92 undeclared (first use i=
n this function)
compat/obstack.c:438: error: (Each undeclared identifier is reported on=
ly once
compat/obstack.c:438: error: for each function it appears in.)
compat/obstack.c:439: warning: =91noreturn=92 function does return
make: *** [compat/obstack.o] Error 1

$ gcc --version
i686-apple-darwin11-llvm-gcc-4.2 (GCC) 4.2.1 (Based on Apple Inc. build=
 5658) (LLVM build 2335.15.00)
