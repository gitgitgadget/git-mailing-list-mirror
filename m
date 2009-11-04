From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 1/4] MSVC: Fix an "unresolved symbol" linker error on
 cygwin
Date: Wed, 04 Nov 2009 20:20:13 +0000
Message-ID: <4AF1E1FD.1050102@ramsay1.demon.co.uk>
References: <4AE74408.7080103@ramsay1.demon.co.uk> <4AEFD9E2.6060004@viscovery.net> <7veiogt4g8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	GIT Mailing-list <git@vger.kernel.org>,
	Marius Storm-Olsen <mstormo@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 04 21:22:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5mNR-0008NR-Ev
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 21:22:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbZKDUW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 15:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbZKDUW2
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 15:22:28 -0500
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:42181 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932351AbZKDUW2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 Nov 2009 15:22:28 -0500
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1N5mNE-00044V-oA; Wed, 04 Nov 2009 20:22:33 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <7veiogt4g8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132144>

Junio C Hamano wrote:
> How does Cygwin-ness of the build environment affect the end result when
> you build with MSVC?

Not at all. This is an MSVC/NO_MMAP combo problem. (The "problem" also exists
with the msvc build on msysGit[1])

>                      I am not a Windows person, so I am only guessing,
> but I suspect that the result does not pull any library nor crt0 from what
> people usually consider "Cygwin environment".  It feels that the "default
> configuration of Cygwin" that insists on NO_MMAP is the guilty party here.
> 

See patch #3.

> Shouldn't this be solved by teaching the Makefile about this new "Cygwin
> but using MSVC as compiler toolchain" combination?

Yes. Err... see patch #3 :-P

> [Footnote]
> 
> *1* Notice "if" at the beginning of this sentence---I am not qualified to
> make a judgement without help from area experts here.  Is it a sane thing
> to run Cygwin and still use MSVC as the compiler toolchain?

About as sane as running msysGit and still use MSVC as the compiler! :D

>  Is it
> commonly done?  I have no idea.
> 

Nor me. I just tried it, and it works (after applying these patches!); for
exactly the same reason, and to the same extent, that it works on msysGit.

[Footnote]
*1* I admit to sometimes being a bit sloppy with naming (and maybe confused
also!). Now, IIUC, MinGW is basically gcc + binutils, MSYS is bash + some
unix tools and msysGit is MinGW + MSYS + some additional packages needed to
build and run git (eg perl). So, the "MinGW build" should really be called the
msysGit build ;-) (but the config section specifically picks out the MINGW string
from uname_S)
Also, the "msvc build on MinGW" should really be the "msvc build on msysGit".
Or something like that!

ATB,
Ramsay Jones
