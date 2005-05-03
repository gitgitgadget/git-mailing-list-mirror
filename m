From: Bill Davidsen <davidsen@tmr.com>
Subject: Re: Mercurial 0.4b vs git patchbomb benchmark
Date: Tue, 03 May 2005 12:22:06 -0400
Message-ID: <4277A52E.1020601@tmr.com>
References: <E1DSm1T-0002Tc-FV@be1.7eggert.dyndns.org><E1DSm1T-0002Tc-FV@be1.7eggert.dyndns.org> <20050503012921.GD22038@waste.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org>" 
	<7eggert@gmx.de>, Linus Torvalds <torvalds@osdl.org>,
	Ryan Anderson <ryan@michonline.com>,
	Andrea Arcangeli <andrea@suse.de>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 03 18:21:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT08L-0000xt-C9
	for gcvg-git@gmane.org; Tue, 03 May 2005 18:20:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbVECQZp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 12:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261222AbVECQZp
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 12:25:45 -0400
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:49549 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261190AbVECQX0
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 3 May 2005 12:23:26 -0400
Received: from [127.0.0.1] (oddball.prodigy.com [127.0.0.1])
	by oddball.prodigy.com (8.11.6/8.11.6) with ESMTP id j43GM7p06807;
	Tue, 3 May 2005 12:22:16 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050319
X-Accept-Language: en-us, en
To: Matt Mackall <mpm@selenic.com>
In-Reply-To: <20050503012921.GD22038@waste.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Matt Mackall wrote:
> On Tue, May 03, 2005 at 03:16:26AM +0200, Bodo Eggert <harvested.in.lkml@posting.7eggert.dyndns.org> wrote:
> 
>>Linus Torvalds <torvalds@osdl.org> wrote:
>>
>>>On Mon, 2 May 2005, Ryan Anderson wrote:
>>>
>>>>On Mon, May 02, 2005 at 09:31:06AM -0700, Linus Torvalds wrote:
>>
>>>>>That said, I think the /usr/bin/env trick is stupid too. It may be more
>>>>>portable for various Linux distributions, but if you want _true_
>>>>>portability, you use /bin/sh, and you do something like
>>>>>
>>>>>#!/bin/sh
>>>>>exec perl perlscript.pl "$@"
>>>>
>>>>if 0;
>>
>>exec may fail.
>>
>>#!/bin/sh
>>exec perl -x $0 ${1+"$@"} || exit 127
>>#!perl
>>
>>
>>>>You don't really want Perl to get itself into an exec loop.
>>>
>>>This would _not_ be "perlscript.pl" itself. This is the shell-script, and
>>>it's not called ".pl".
>>
>>In this thread, it originally was.
> 
> 
> In this thread, it was originally a Python script. In particular, one
> aimed at managing the Linux kernel source. I'm going to use
> /usr/bin/env, systems where that doesn't exist can edit the source.

On the theory that my first post got lost, why use /usr/bin/env at all, 
when bash already does that substitution? To support people who use 
other shells?

ie.:
    FOO=xx perl -e '$a=$ENV{FOO}; print "$a\n"'
-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
