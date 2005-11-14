From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: ./configure script prototype
Date: Mon, 14 Nov 2005 10:39:26 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511141027380.3263@g5.osdl.org>
References: <43788078.4040403@op5.se> <437880AC.3040101@op5.se>
 <20051114132956.GT30496@pasky.or.cz> <20051114181958.GD20749@ca-server1.us.oracle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Andreas Ericsson <ae@op5.se>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 14 19:40:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EbjFZ-0003bU-J5
	for gcvg-git@gmane.org; Mon, 14 Nov 2005 19:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751230AbVKNSjl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 Nov 2005 13:39:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751233AbVKNSjk
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Nov 2005 13:39:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:57564 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751230AbVKNSjj (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 14 Nov 2005 13:39:39 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAEIdRnO025407
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 14 Nov 2005 10:39:29 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAEIdQkB022154;
	Mon, 14 Nov 2005 10:39:26 -0800
To: Joel Becker <Joel.Becker@oracle.com>
In-Reply-To: <20051114181958.GD20749@ca-server1.us.oracle.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11834>



On Mon, 14 Nov 2005, Joel Becker wrote:

> On Mon, Nov 14, 2005 at 02:29:56PM +0100, Petr Baudis wrote:
> > Dear diary, on Mon, Nov 14, 2005 at 01:18:52PM CET, I got a letter
> > where Andreas Ericsson <ae@op5.se> said that...
> > > 		--prefix=*)
> > > 			prefix=${1##*=}
> 
> 	${i# and ${i% are POSIX, iirc.

They may be in POSIX, but they sure as h*ll aren't portable.

There's a _lot_ of machines out there that don't do POSIX, just because 
those "newfangled" things are so complicated.

Also, even in POSIX, there's tons of different substandards, and you might 
follow one but not the other. 

Finally, even if somebody is certified, they can very well be certified 
with "exceptions", so if they claim POSIX it doesn't necessarily mean that 
they follow all of it.

If you want to do a "configure" script (and I'm not sure it's worth it), 
you should cater to the lowest common denominator for it to be meaningful. 
What the hell that would be, I have no idea, since if you ever want to run 
on native Windows, it won't even be traditional shell. But traditional 
shell is at least a lot closer to that lowest common denominator than 
POSIX shell is.

That said, most of those ${var...} sequences definitely _are_ very 
traditional, and for all I know, ## may be too.

			Linus
