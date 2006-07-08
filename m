From: Pavel Roskin <proski@gnu.org>
Subject: Re: [RFC/PATCH 14] autoconf: Added --with/--without for openssl,
	curl, expat to ./configure
Date: Sat, 08 Jul 2006 03:33:19 -0400
Message-ID: <1152343999.26627.6.camel@dv>
References: <200606290301.51657.jnareb@gmail.com>
	 <e848pr$cca$1@sea.gmane.org>
	 <20060630233004.7xckw444g4g0gcs8@webmail.spamcop.net>
	 <200607011955.23908.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 08 09:33:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fz7K3-0004CK-FA
	for gcvg-git@gmane.org; Sat, 08 Jul 2006 09:33:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750902AbWGHHdf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 8 Jul 2006 03:33:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750901AbWGHHdf
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Jul 2006 03:33:35 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:40680 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1750824AbWGHHdf
	(ORCPT <rfc822;git@vger.kernel.org>); Sat, 8 Jul 2006 03:33:35 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1Fz7Jl-0003U0-UY
	for git@vger.kernel.org; Sat, 08 Jul 2006 03:33:34 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1Fz7JY-0006vs-1k; Sat, 08 Jul 2006 03:33:20 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <200607011955.23908.jnareb@gmail.com>
X-Mailer: Evolution 2.7.3 (2.7.3-7) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23479>

Hello, Jakub!

On Sat, 2006-07-01 at 19:55 +0200, Jakub Narebski wrote: 
> >> I suspect that AS_HELP_WITH does some strange quoting, or stripping. Both
> >> [=PATH] and [[=PATH]] produces =PATH in ./configure --help output.
> >> When using @<:@=PATH@:>@ I get [=PATH], but the description of option begins
> >> line below.

Sorry, I misunderstood the problem.  I think it's pure cosmetics.
Please don't let it stop you.

> I guess I would just not use AS_HELP_STRING, and format help 
> message "by hand".

Please don't wast time on such minor things.  It's more important to get
the functionality implemented.

> By the way, if you know autoconf well, perhaps you could tell me how to write
> tests for the following programs: ar, tar, rpmbuild, how to write test for
> Python version (or rather for WITH_OWN_SUBPROCESS_PY) and other test autoconf.ac
> lacks now (NEEDS_SSL_WITH_CRYPTO, NEEDS_LIBICONV, NEEDS_SOCKET, NO_MMAP,
> NO_IPV6, NO_ICONV, NO_ACCURATE_DIFF unless that was removed or changed name).

Generally, see the Autoconf manual for the specific test first, then for
more common test.

For ar, use AC_CHECK_TOOL to allow cross-compilation.  For tar and
rpmbiuld, use 
AC_CHECK_PROG.  Python will have to run to find the version, I'm afraid,
which would complicate cross builds.  Fortunately, it's on the way out.

Tests for sockets are described in the Autoconf documentation.  Other
tests should probably be implemented as test programs unless they can be
reduced to checking for a specific symbol in a specific library.

-- 
Regards,
Pavel Roskin
