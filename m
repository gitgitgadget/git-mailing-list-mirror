From: merlyn@stonehenge.com (Randal L. Schwartz)
Subject: Re: fc046a75d539a78e6b2c16534c4078617a69a327 fails on OpenBSD 3.8
Date: 30 Jun 2006 10:09:17 -0700
Message-ID: <86sllmy3ia.fsf@blue.stonehenge.com>
References: <86wtayy42o.fsf@blue.stonehenge.com>
	<7vy7veindn.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 30 19:09:32 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FwMUc-0000fK-5a
	for gcvg-git@gmane.org; Fri, 30 Jun 2006 19:09:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbWF3RJT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Jun 2006 13:09:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751626AbWF3RJT
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Jun 2006 13:09:19 -0400
Received: from blue.stonehenge.com ([209.223.236.162]:41912 "EHLO
	blue.stonehenge.com") by vger.kernel.org with ESMTP
	id S1751815AbWF3RJS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Jun 2006 13:09:18 -0400
Received: from localhost (localhost [127.0.0.1])
	by blue.stonehenge.com (Postfix) with ESMTP id 3E4988EB79;
	Fri, 30 Jun 2006 10:09:18 -0700 (PDT)
Received: from blue.stonehenge.com ([127.0.0.1])
 by localhost (blue.stonehenge.com [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 05025-01-35; Fri, 30 Jun 2006 10:09:17 -0700 (PDT)
Received: by blue.stonehenge.com (Postfix, from userid 1001)
	id 905368EB7B; Fri, 30 Jun 2006 10:09:17 -0700 (PDT)
To: Junio C Hamano <junkio@cox.net>
x-mayan-date: Long count = 12.19.13.7.14; tzolkin = 4 Ix; haab = 7 Tzec
In-Reply-To: <7vy7veindn.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23001>

>>>>> "Junio" == Junio C Hamano <junkio@cox.net> writes:

Junio> merlyn@stonehenge.com (Randal L. Schwartz) writes:
>> gcc -o upload-pack.o -c -g -O2 -Wall -I/usr/local/include -DSHA1_HEADER='<openssl/sha.h>' -DNO_STRCASESTR upload-pack.c
>> In file included from /usr/include/sys/poll.h:54,
>> from upload-pack.c:9:
>> /usr/include/ctype.h:67: error: syntax error before ']' token
>> /usr/include/ctype.h:68: error: syntax error before ']' token
>> /usr/include/ctype.h:70: error: syntax error before ']' token
>> /usr/include/ctype.h:75: error: syntax error before ']' token
>> /usr/include/ctype.h:78: error: syntax error before '(' token
>> /usr/include/ctype.h:79: error: syntax error before '(' token
>> /usr/include/ctype.h:93: error: syntax error before "c"
>> In file included from /usr/include/sys/poll.h:54,
>> from upload-pack.c:9:
>> /usr/include/ctype.h:91:1: unterminated #if
>> /usr/include/ctype.h:40:1: unterminated #ifndef

Junio> Crap.  Including <sys/poll.h> pollutes your namespace with ctype
Junio> macros?

>From /usr/include/sys/poll.h:

    #ifndef _KERNEL
    #include <ctype.h>

So, I guess, it's ... Yes.

This sounds familiar.  Maybe the mailing list archive has me reporting
this bug last time too. :)

-- 
Randal L. Schwartz - Stonehenge Consulting Services, Inc. - +1 503 777 0095
<merlyn@stonehenge.com> <URL:http://www.stonehenge.com/merlyn/>
Perl/Unix/security consulting, Technical writing, Comedy, etc. etc.
See PerlTraining.Stonehenge.com for onsite and open-enrollment Perl training!
