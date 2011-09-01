From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: obstack fails to compile on OS X 10.7
Date: Thu, 01 Sep 2011 18:30:50 +0100
Message-ID: <4E5FC14A.8040008@ramsay1.demon.co.uk>
References: <4A1A024F-C5D5-4E5F-8474-DA3D87412C8A@gernhardtsoftware.com> <20110827101418.GA8074@gmail.com> <20110828200846.GA10754@fredrik-Q430-Q530>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: David Aguilar <davvid@gmail.com>,
	Brian Gernhardt <brian@gernhardtsoftware.com>,
	Git List <git@vger.kernel.org>
To: Fredrik Kuivinen <frekui@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 01 19:32:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzB7k-0007Ho-Mc
	for gcvg-git-2@lo.gmane.org; Thu, 01 Sep 2011 19:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756120Ab1IARcJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 13:32:09 -0400
Received: from lon1-post-3.mail.demon.net ([195.173.77.150]:62124 "EHLO
	lon1-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756056Ab1IARcI (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Sep 2011 13:32:08 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by lon1-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1QzB7S-0002qh-eZ; Thu, 01 Sep 2011 17:32:03 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <20110828200846.GA10754@fredrik-Q430-Q530>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180555>

Fredrik Kuivinen wrote:
> On Sat, Aug 27, 2011 at 03:14:43AM -0700, David Aguilar wrote:
>> On Sat, Aug 27, 2011 at 02:21:40AM -0400, Brian Gernhardt wrote:
[snip]
>> I suspect that more exotic platforms may have problems
>> with obstack.h as well.  This probably needs some testing
>> on SunOS, AIX, IRIX, etc.

Just FYI, my cygwin and mingw builds failed in the same way as OS X ...

> Something like this (tested on Linux and SunOS 5.10):
> 
> -- 8< --
> 
> Subject: [PATCH RFC] obstack: Fix portability issues
> 
> i686-apple-darwin10-gcc-4.2.1 (GCC) 4.2.1, SunOS 5.10, and possibly
> others do not have exit.h and exitfail.h. Remove the use of these in
> obstack.c.
> 
> The __block variable was renamed to block to avoid a gcc error:
> 
> compat/obstack.h:190: error: __block attribute can be specified on variables only
> 
> Initial-patch-by: David Aguilar <davvid@gmail.com>
> Reported-by: Brian Gernhardt <brian@gernhardtsoftware.com>
> Signed-off-by: Fredrik Kuivinen <frekui@gmail.com>
> ---

... and this fixes the build(s) just fine[1]. Thanks!

ATB,
Ramsay Jones

[1] Well the build is fine on cygwin, but the mingw build fails for
an unrelated reason; compat/obstack.c compiles just fine.
