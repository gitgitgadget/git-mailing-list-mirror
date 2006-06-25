From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 07/12] Git.pm: Better error handling
Date: Sat, 24 Jun 2006 18:30:16 -0700
Message-ID: <7vr71erphz.fsf@assigned-by-dhcp.cox.net>
References: <20060624023429.32751.80619.stgit@machine.or.cz>
	<20060624023442.32751.28342.stgit@machine.or.cz>
	<7vmzc3ymnu.fsf@assigned-by-dhcp.cox.net>
	<20060624131731.GU21864@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Sun Jun 25 03:30:28 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FuJSA-0002j9-L2
	for gcvg-git@gmane.org; Sun, 25 Jun 2006 03:30:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964891AbWFYBaT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 24 Jun 2006 21:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964892AbWFYBaS
	(ORCPT <rfc822;git-outgoing>); Sat, 24 Jun 2006 21:30:18 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:24549 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S964891AbWFYBaR (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 Jun 2006 21:30:17 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060625013017.DAOO8537.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 24 Jun 2006 21:30:17 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <20060624131731.GU21864@pasky.or.cz> (Petr Baudis's message of
	"Sat, 24 Jun 2006 15:17:31 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22563>

Petr Baudis <pasky@suse.cz> writes:

>> --------------------------------
>> 
>> (cd perl && /usr/bin/perl Makefile.PL \
>>                 PREFIX="/home/junio/git-test" \
>>                 DEFINE="-O2 -Wall -Wdeclaration-after-statement
>>                 -g -DSHA1_HEADER='<openssl/sha.h>'
>>                 -DGIT_VERSION=\\\"1.4.1.rc1.gab0df\\\"" \
>>                 LIBS="libgit.a xdiff/lib.a -lz  -lcrypto")
>> Unrecognized argument in LIBS ignored: 'libgit.a'
>> Unrecognized argument in LIBS ignored: 'xdiff/lib.a'
>> 
>> Do you need to pass LIBS, and if so maybe this is not a way
>> Makefile.PL expects it to be passed perhaps?
>
> It is harmless, but this should fix it:
>
> Signed-off-by: Petr Baudis <pasky@suse.cz>

Applied the "EXTLIBS" change in the message.  I did the same
"clean twice" change last night.  Also I will apply the
"PERL_DEFINES_SQ" change as well.  Hopefully this would make
things buildable for more people.

Thanks.
