From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Introduce Git.pm (v3)
Date: Fri, 23 Jun 2006 08:03:23 +0200
Organization: At home
Message-ID: <e7g079$8qt$1@sea.gmane.org>
References: <20060622220201.19132.67536.stgit@machine.or.cz> <7vlkrohj9p.fsf@assigned-by-dhcp.cox.net> <20060622235017.GH21864@pasky.or.cz> <7v1wtghga6.fsf@assigned-by-dhcp.cox.net> <20060623011205.GJ21864@pasky.or.cz> <7vk678fpqy.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-From: git-owner@vger.kernel.org Fri Jun 23 08:04:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ftem5-00042w-Va
	for gcvg-git@gmane.org; Fri, 23 Jun 2006 08:04:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932416AbWFWGEJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 23 Jun 2006 02:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbWFWGEJ
	(ORCPT <rfc822;git-outgoing>); Fri, 23 Jun 2006 02:04:09 -0400
Received: from main.gmane.org ([80.91.229.2]:5082 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S932416AbWFWGEH (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 23 Jun 2006 02:04:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Ftelf-0003xG-Ei
	for git@vger.kernel.org; Fri, 23 Jun 2006 08:03:47 +0200
Received: from 193.0.122.19 ([193.0.122.19])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Jun 2006 08:03:47 +0200
Received: from jnareb by 193.0.122.19 with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 23 Jun 2006 08:03:47 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: 193.0.122.19
User-Agent: KNode/0.7.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22399>

Junio C Hamano wrote:

> Petr Baudis <pasky@suse.cz> writes:
> 
>>>         cc  -shared -L/usr/local/lib Git.o  -o blib/arch/auto/Git/Git.so ../libgit.a        \
>>>                    -lz -lcrypto     \
>>> 
>>>         /usr/bin/ld: ../libgit.a(exec_cmd.o): relocation R_X86_64_32 against `a local symbol' can not be used when making a shared object; recompile with -fPIC
>>>         ../libgit.a: could not read symbols: Bad value
>>>         collect2: ld returned 1 exit status
>>>         make[1]: *** [blib/arch/auto/Git/Git.so] Error 1
>>> 
>>> This is a real killer.  If we compile everything with -fPIC,
>>> this goes away, but I do not think we want -fPIC for the core
>>> level tools.  At least not until we are ready to do libgit.so.
>>
>> Hmm, I didn't get that; I guess that's x86-64 specific. :/
> 
> So it seems.  Both RH machines I have access at kernel.org and
> Debian machines I have locally exhibit that x86-32 is OK and
> x86-64 is bad.  They all run libc-2.3.6 except RH x86-32 is at
> libc-2.3.4.

Perhaps Git.pm should provide also generic, pure Perl (and slower)
fallback implementation (when for some reason we cannot compile XS).

-- 
Jakub Narebski
Warsaw, Poland
ShadeHawk on #git
