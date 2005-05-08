From: Petr Baudis <pasky@ucw.cz>
Subject: Re: Make errors
Date: Sun, 8 May 2005 21:46:57 +0200
Message-ID: <20050508194657.GF9495@pasky.ji.cz>
References: <1115580904.5536.28.camel@linux.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 08 21:42:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DUreX-00043H-HR
	for gcvg-git@gmane.org; Sun, 08 May 2005 21:41:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262952AbVEHTr5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 May 2005 15:47:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262964AbVEHTr4
	(ORCPT <rfc822;git-outgoing>); Sun, 8 May 2005 15:47:56 -0400
Received: from w241.dkm.cz ([62.24.88.241]:45276 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S262952AbVEHTq7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 8 May 2005 15:46:59 -0400
Received: (qmail 17586 invoked by uid 2001); 8 May 2005 19:46:57 -0000
To: John Kacur <jkacur@rogers.com>
Content-Disposition: inline
In-Reply-To: <1115580904.5536.28.camel@linux.site>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dear diary, on Sun, May 08, 2005 at 09:35:04PM CEST, I got a letter
where John Kacur <jkacur@rogers.com> told me that...
> gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-convert-cache
> convert-c
> ache.c libgit.a -lz -lssl
> convert-cache.c: In function `write_subdirectory':
> convert-cache.c:102: warning: field precision is not type int (arg 4)

I'm not sure how serious this is in practice.

> gcc -g -O2 -Wall '-DSHA1_HEADER=<openssl/sha.h>' -o git-http-pull
> http-pull.c l
> ibgit.a -lz -lssl -lcurl
> http-pull.c:10:23: curl/curl.h: No such file or directory
> http-pull.c:11:23: curl/easy.h: No such file or directory
> http-pull.c:13: error: parse error before '*' token

You need curl in order to compile http-pull. It is not a core part of
git, so if you just remove it from the makefile, things should work as
long as you don't want to pull over http. (You can pull Linus' and my
trees over rsync, not sure about Junio - I *think* he is http-only.)

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
C++: an octopus made by nailing extra legs onto a dog. -- Steve Taylor
