From: Dennis Stosberg <dennis@stosberg.net>
Subject: Re: [PATCH 1/3] configure: Add test for Perl
Date: Thu, 6 Jul 2006 17:34:45 +0200
Message-ID: <20060706153445.G424b7ea1@leonov.stosberg.net>
References: <20060706124025.G325584e9@leonov.stosberg.net> <20060706161011.ccc2ea1c.tihirvon@gmail.com> <E1FyUNT-0007Ko-JR@moooo.ath.cx> <20060706172756.a42f1627.tihirvon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthias Lederhofer <matled@gmx.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 06 17:35:07 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FyVsS-00030y-5f
	for gcvg-git@gmane.org; Thu, 06 Jul 2006 17:34:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030342AbWGFPet (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Jul 2006 11:34:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030341AbWGFPet
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Jul 2006 11:34:49 -0400
Received: from ncs.stosberg.net ([89.110.145.104]:39580 "EHLO ncs.stosberg.net")
	by vger.kernel.org with ESMTP id S1030342AbWGFPes (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Jul 2006 11:34:48 -0400
Received: from leonov.stosberg.net (p213.54.86.66.tisdip.tiscali.de [213.54.86.66])
	by ncs.stosberg.net (Postfix) with ESMTP id 6B91EAEBA004;
	Thu,  6 Jul 2006 17:34:39 +0200 (CEST)
Received: by leonov.stosberg.net (Postfix, from userid 500)
	id B2207103D63; Thu,  6 Jul 2006 17:34:45 +0200 (CEST)
To: Timo Hirvonen <tihirvon@gmail.com>
Content-Disposition: inline
In-Reply-To: <20060706172756.a42f1627.tihirvon@gmail.com>
OpenPGP: id=1B2F2863BA13A814C3B133DACC2811F494951CAB; url=http://stosberg.net/dennis.asc
User-Agent: mutt-ng/devel-r802 (Debian)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23394>

Timo Hirvonen wrote:

>         if test -x "$1"
>         then
>                 echo "$1"
>                 return 0
>         fi

When run in the Git source directory, this will find the perl/
subdir.  If the user gives an absolute path to the perl binary,
there will be no auto-detection anyway, so I think we don't need it.

> It is not needed but might be useful if PERL is user configurable
> variable and can contain either full path or basename. For example this
> code
> 
>     test "$PROG" || PROG=prog
>     PROG=`path_find "$PROG"`
> 
> works with these cases
> 
>     $ PROG=/usr/bin/program ./configure
>     $ PROG=program-1.2 ./configure

I will add that.  For the compiler, the script already checks $CC.
I wonder whether

  --with-perl=...
  --with-python=... 

is more common (more similar to autoconf) than

  --perl=
  --python=

Regards,
Dennis
