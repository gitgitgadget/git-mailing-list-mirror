From: Eric Wong <normalperson@yhbt.net>
Subject: Re: Help debugging git-svn
Date: Wed, 16 Dec 2015 07:41:58 +0000
Message-ID: <20151216074158.GB28518@dcvr.yhbt.net>
References: <CAOc6etaOKSN0KyB9v2caiQbaQBEGrHxi3NmFy3aJkFxczGdqHA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Edmundo Carmona Antoranz <eantoranz@gmail.com>
X-From: git-owner@vger.kernel.org Wed Dec 16 08:42:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a96ip-0006tI-Fe
	for gcvg-git-2@plane.gmane.org; Wed, 16 Dec 2015 08:42:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932808AbbLPHl7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Dec 2015 02:41:59 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:47527 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932681AbbLPHl7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Dec 2015 02:41:59 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 81A53205BC;
	Wed, 16 Dec 2015 07:41:58 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAOc6etaOKSN0KyB9v2caiQbaQBEGrHxi3NmFy3aJkFxczGdqHA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282539>

Edmundo Carmona Antoranz <eantoranz@gmail.com> wrote:
> 1 [main] perl 5652 cygwin_exception::open_stackdumpfile: Dumping stack
> trace to perl.exe.stackdump
> 
> And then, in the file:
> 
> Exception: STATUS_ACCESS_VIOLATION at rip=0048360C10C
> rax=0000000601E4BFF8 rbx=000000005219E248 rcx=000000060003A590
> rdx=0000000000000000 rsi=000000000000A950 rdi=0000000000000004
> r8 =0000000000000000 r9 =0000000000000000 r10=0000000000230000
> r11=000000048D78607A r12=0000000000000003 r13=000006FFFFF54A98
> r14=0000000601E18030 r15=000006FFFFF54AB0
> rbp=0000000000054A88 rsp=000000000022B810
> program=C:\Program Files\Git\usr\bin\perl.exe, pid 5652, thread main
> cs=0033 ds=002B es=002B fs=0053 gs=002B ss=002B

Any chance you can reproduce this on a Linux system?
I do not use non-Free systems and have no debugging experience
there at all.

> With my very flawed knowledge of perl I have seen that the process is
> getting to Ra.pm around here:

It could also be a bug in the SVN bindings or the port of
Perl.  Which versions are you running?


I've also been wondering about the motivation of SVN developers to do a
good job on maintaining their Perl bindings (given git-svn is likely the
main user of them).
We've certainly had problems in the past with SVN breaking and
causing git-svn to segfault around 2011-2012; but it's been a while...
