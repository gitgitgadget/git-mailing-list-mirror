From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: What will happen to git.git in the near future
Date: Sun, 1 Oct 2006 11:38:06 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0610011132040.3952@g5.osdl.org>
References: <7v7iztbldm.fsf@assigned-by-dhcp.cox.net> <7vd59c2vev.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 01 20:38:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GU6Cp-0007Pa-AC
	for gcvg-git@gmane.org; Sun, 01 Oct 2006 20:38:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbWJASiX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 Oct 2006 14:38:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWJASiX
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Oct 2006 14:38:23 -0400
Received: from smtp.osdl.org ([65.172.181.4]:24196 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751006AbWJASiW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Oct 2006 14:38:22 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k91IcDaX023925
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 1 Oct 2006 11:38:14 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k91Ic7Z8026884;
	Sun, 1 Oct 2006 11:38:11 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd59c2vev.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.448 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28184>



On Sun, 1 Oct 2006, Junio C Hamano wrote:
>
> I've tagged the tip of the master as v1.4.3-rc1 tonight, after
> merging things that I listed in the message last week to be
> merged from "next".
> 
> Have fun.

I hate that perl crud.

	...
	make -C perl
	make[1]: Entering directory `/home/torvalds/git/perl'
	cp private-Error.pm blib/lib/Error.pm
	cp Git.pm blib/lib/Git.pm
	gcc -c   -D_REENTRANT -D_GNU_SOURCE -fno-strict-aliasing -pipe -Wdeclaration-after-statement -I/usr/local/include -D_LARGEFILE_SOURCE -D_FILE_OFFSET_BITS=64 -I/usr/include/gdbm -O2 -g -pipe -Wall -Wp,-D_FORTIFY_SOURCE=2 -fexceptions -fstack-protector --param=ssp-buffer-size=4 -m32   -DVERSION=\"0.01\" -DXS_VERSION=\"0.01\" -fPIC "-I/usr/lib/perl5/5.8.8/ppc-linux-thread-multi/CORE"   Git.c
	In file included from Git.xs:8:
	../cache.h:6:10: error: #include expects "FILENAME" or <FILENAME>
	Git.xs: In function 'XS_Git_xs_version':
	Git.xs:62: error: 'GIT_VERSION' undeclared (first use in this function)
	Git.xs:62: error: (Each undeclared identifier is reported only once
	Git.xs:62: error: for each function it appears in.)
	make[1]: *** [Git.o] Error 1
	make[1]: Leaving directory `/home/torvalds/git/perl'
	make: *** [all] Error 2

I don't like how git now doesn't compile just out of the box on a 
perfectly regular FC5 box.

The whole Git.xs stuff has been buggered from the very beginning, at some 
point somebody needs to just admit it. 

Please?

And how come does this actually work for anybody else? I've got PPC_SHA1 
defined, but I don't see what the difference is..

		Linus
