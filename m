From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: PPC SHA-1 Updates in "pu"
Date: Sat, 24 Jun 2006 13:42:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606241338370.6483@g5.osdl.org>
References: <7vzmg376ee.fsf@assigned-by-dhcp.cox.net>
 <20060624012202.4822.qmail@science.horizon.com> <7vfyhv11ej.fsf@assigned-by-dhcp.cox.net>
 <7vwtb6yip5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0606241147480.6483@g5.osdl.org>
 <7vhd2atid1.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Jun 24 22:42:48 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuExo-00086i-41
	for gcvg-git@gmane.org; Sat, 24 Jun 2006 22:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751097AbWFXUmf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 16:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751098AbWFXUmf
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 16:42:35 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7639 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751097AbWFXUmf (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 24 Jun 2006 16:42:35 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k5OKgQUT032046
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 24 Jun 2006 13:42:26 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k5OKgPON003914;
	Sat, 24 Jun 2006 13:42:26 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhd2atid1.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.81__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22545>



On Sat, 24 Jun 2006, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > Also, "pu" in general is totally unusable. It doesn't even compile.
> 
> Care to share problems with Pasky and I to take a look at,
> please?

Don't everybody see them?

	In file included from Git.xs:8:
	../cache.h:6:10: error: #include expects "FILENAME" or <FILENAME>
	In file included from /usr/lib/perl5/5.8.8/ppc-linux-thread-multi/CORE/perl.h:756,
	                 from Git.xs:15:
	/usr/lib/perl5/5.8.8/ppc-linux-thread-multi/CORE/embed.h:4195:1: warning: "die" redefined
	Git.xs:11:1: warning: this is the location of the previous definition
	Git.xs: In function 'boot_Git':
	Git.xs:57: warning: passing argument 1 of 'set_error_routine' from incompatible pointer type
	Git.xs:58: warning: passing argument 1 of 'set_die_routine' makes qualified function pointer from unqualified
	make[1]: *** [Git.o] Error 1
	make[1]: Leaving directory `/home/torvalds/git/perl'
	make: *** [all] Error 2

how does that compile for anybody else, when -DSHA1_HEADER isn't set 
correctly? The quotes have gone missing:

	-DSHA1_HEADER='ppc/sha1.h' 

don't ask me why.

		Linus
