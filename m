From: "David A. Wheeler" <dwheeler@dwheeler.com>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark (/usr/bin/env again)
Date: Tue, 03 May 2005 22:10:40 -0400
Message-ID: <42782F20.5080401@dwheeler.com>
References: <20050430025211.GP17379@opteron.random> <200505021614.j42GEufG008441@turing-police.cc.vt.edu> <4277B778.5020206@tmr.com>
Reply-To: dwheeler@dwheeler.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Valdis.Kletnieks@vt.edu, Andrea Arcangeli <andrea@suse.de>,
	Matt Mackall <mpm@selenic.com>,
	Linus Torvalds <torvalds@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 04:02:23 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT9DI-0002r6-37
	for gcvg-git@gmane.org; Wed, 04 May 2005 04:02:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261982AbVEDCIP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 22:08:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbVEDCIP
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 22:08:15 -0400
Received: from aibo.runbox.com ([193.71.199.94]:5281 "EHLO cujo.runbox.com")
	by vger.kernel.org with ESMTP id S261980AbVEDCII (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 22:08:08 -0400
Received: from [10.9.9.11] (helo=fifi.runbox.com)
	by greyhound.runbox.com with esmtp (Exim 4.34)
	id 1DT9Iq-0001Fz-4D; Wed, 04 May 2005 04:07:56 +0200
Received: from [70.21.9.158] (helo=[192.168.2.73])
	by fifi.runbox.com with asmtp (uid:258406) (Exim 4.34)
	id 1DT9Ip-0000SN-Nl; Wed, 04 May 2005 04:07:56 +0200
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Bill Davidsen <davidsen@tmr.com>
In-Reply-To: <4277B778.5020206@tmr.com>
X-Sender: 258406@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:
>> Most likely, his python lives elsewhere than /usr/bin, and the 'env' call
>> results in causing a walk across $PATH to find it....

Bill Davidsen wrote:
> Assuming that he has env in a standard place... I hope this isn't going 
> to start some rash of efforts to make packages run on non-standard 
> toolchains, which add requirements for one tool to get around 
> misplacement of another.

The #!/usr/bin/env prefix is, in my opinion, a very good idea.
There are a very few systems where env isn't in /usr/bin, but they
were extremely rare years ago & are essentially extinct now.
Basically, it's a 99% solution; getting the last 1% is really painful,
but since getting the 99% is easy, let's do it and be happy.

There are LOTS of systems where Python, bash, etc., do NOT
live in whatever place you think of as "standard".
I routinely use an OpenBSD 3.1 system; there is no /usr/bin/bash,
but there _IS_ a /usr/local/bin/bash (in my PATH) and a /usr/bin/env.
So this /usr/bin/env stuff REALLY is useful on a lot of systems, such
as OpenBSD.  It's critical to me, at least!

This is actually really useful on ANY system, though.
Even if some interpreter IS where you think it should be,
that is NOT necessarily the interpreter you want to use.
Using "/usr/bin/env" lets you use PATH
to override things, so you don't HAVE to use the interpreter
in some fixed location.  That's REALLY handy for testing... I
can download the whizbang Python 9.8.2, set it on the path,
and see if everything works as expected.  It's also nice
if someone insists on never upgrading a package; you can
install an interpreter "locally".  Yes, you can patch all the
files up, but resetting a PATH is _much_ easier.

--- David A. Wheeler
