From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Git 1.3.2 on Solaris
Date: Tue, 23 May 2006 07:53:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0605230744350.5623@g5.osdl.org>
References: <8157.1148359875@lotus.CS.Berkeley.EDU>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stefan Pfetzing <stefan.pfetzing@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 23 16:54:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FiYGo-0000b5-Hx
	for gcvg-git@gmane.org; Tue, 23 May 2006 16:54:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932224AbWEWOyA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 23 May 2006 10:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbWEWOyA
	(ORCPT <rfc822;git-outgoing>); Tue, 23 May 2006 10:54:00 -0400
Received: from smtp.osdl.org ([65.172.181.4]:22680 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932224AbWEWOx7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 23 May 2006 10:53:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k4NErutH008237
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 23 May 2006 07:53:57 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k4NErthG007984;
	Tue, 23 May 2006 07:53:56 -0700
To: Jason Riedy <ejr@EECS.Berkeley.EDU>
In-Reply-To: <8157.1148359875@lotus.CS.Berkeley.EDU>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.74__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/20606>



On Mon, 22 May 2006, Jason Riedy wrote:

> And "Stefan Pfetzing" writes:
>  -   printf ("access: %d\n", access("/etc/motd", X_OK));
> [...]
>  - will return 0 on solaris - when run as root, even though /etc/motd
>  - is not executeable.
> 
> This is explicitly allowed by the SUS, even for non-root:

What kind of CRAP has Solaris become?

Yes, it's allowed. That doesn't mean that a quality implementation should 
do it.

SunOS used to be the best system around - it was, compared to others, 
_nice_ to work with. It wasn't about what was "allowed by the standards", 
that was the HP-SUX and AIX's excuses. It was the highest-quality 
implementation.

Now, Solaris had some serious problems early on (yes, I was there when 
they switched, and yes, I hated it), but I thought they had fixed their 
stuff long long ago.

Have Sun people forgotten the difference between "quality" and "crap that 
passes standards tests"? 

Not doing a reasonable job on "access()" is a joke. It's like VMS being 
"posix". Sure, it's the letter of the law, but it's still not _unix_.

Btw, even SuS says:

    "The sentence concerning appropriate privileges and execute permission 
     bits reflects the two possibilities implemented by historical 
     implementations when checking superuser access for X_OK.

     New implementations are discouraged from returning X_OK unless at 
     least one execution permission bit is set."

which clearly says "Solaris is CRAP" to me.

What the heck is going on? First the totally broken stdio that doesn't 
retry on EINTR, now access(). And these people think they can compete?

Somebody hit some Solaris engineers with a 2x4 clue-stick, please.

		Linus
