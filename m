From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Introduce Git.pm (v3)
Date: Thu, 22 Jun 2006 21:41:09 -0700
Message-ID: <7vk678fpqy.fsf@assigned-by-dhcp.cox.net>
References: <20060622220201.19132.67536.stgit@machine.or.cz>
	<7vlkrohj9p.fsf@assigned-by-dhcp.cox.net>
	<20060622235017.GH21864@pasky.or.cz>
	<7v1wtghga6.fsf@assigned-by-dhcp.cox.net>
	<20060623011205.GJ21864@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 23 06:41:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FtdTo-0001sj-CO
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 06:41:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932235AbWFWElM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 00:41:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932217AbWFWElM
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 00:41:12 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:50852 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S932235AbWFWElL (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Jun 2006 00:41:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060623044110.UEBZ18458.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Fri, 23 Jun 2006 00:41:10 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060623011205.GJ21864@pasky.or.cz> (Petr Baudis's message of
	"Fri, 23 Jun 2006 03:12:05 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22398>

Petr Baudis <pasky@suse.cz> writes:

>>         cc  -shared -L/usr/local/lib Git.o  -o blib/arch/auto/Git/Git.so ../libgit.a	\
>>                    -lz -lcrypto  	\
>> 
>>         /usr/bin/ld: ../libgit.a(exec_cmd.o): relocation R_X86_64_32 against `a local symbol' can not be used when making a shared object; recompile with -fPIC
>>         ../libgit.a: could not read symbols: Bad value
>>         collect2: ld returned 1 exit status
>>         make[1]: *** [blib/arch/auto/Git/Git.so] Error 1
>> 
>> This is a real killer.  If we compile everything with -fPIC,
>> this goes away, but I do not think we want -fPIC for the core
>> level tools.  At least not until we are ready to do libgit.so.
>
> Hmm, I didn't get that; I guess that's x86-64 specific. :/

So it seems.  Both RH machines I have access at kernel.org and
Debian machines I have locally exhibit that x86-32 is OK and
x86-64 is bad.  They all run libc-2.3.6 except RH x86-32 is at
libc-2.3.4.
