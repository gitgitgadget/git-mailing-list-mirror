From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Remove more gcc extension usage.
Date: Mon, 10 Jul 2006 04:07:11 -0400
Message-ID: <20060710040711.z1h4w0wsgk8sskg4@webmail.spamcop.net>
References: <20060708183402.GA17644@spearce.org>
	<7vy7v4orpt.fsf@assigned-by-dhcp.cox.net>
	<20060708190327.GA17763@spearce.org> <20060709073155.GP22573@lug-owl.de>
	<20060710052255.GA15173@spearce.org> <1152512523.3504.28.camel@dv>
	<20060710062513.GZ22573@lug-owl.de> <1152514328.3504.58.camel@dv>
	<20060710073532.GA22573@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Shawn Pearce <spearce@spearce.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 10 10:07:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fzqnd-0006zQ-Hf
	for gcvg-git@gmane.org; Mon, 10 Jul 2006 10:07:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWGJIHP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Jul 2006 04:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751353AbWGJIHP
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Jul 2006 04:07:15 -0400
Received: from mailgate.cesmail.net ([216.154.195.36]:29325 "HELO
	mailgate.cesmail.net") by vger.kernel.org with SMTP
	id S1751301AbWGJIHO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jul 2006 04:07:14 -0400
Received: (qmail 23392 invoked from network); 10 Jul 2006 08:07:12 -0000
Received: from unknown (HELO gamma.cesmail.net) (192.168.1.20)
  by mailgate.cesmail.net with SMTP; 10 Jul 2006 08:07:12 -0000
Received: (qmail 3796 invoked by uid 99); 10 Jul 2006 08:07:12 -0000
Received: from pool-68-163-29-96.phil.east.verizon.net
	(pool-68-163-29-96.phil.east.verizon.net [68.163.29.96]) by
	webmail.spamcop.net (Horde) with HTTP for <proski@spamcop.net@cesmail.net>;
	Mon, 10 Jul 2006 04:07:11 -0400
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
In-Reply-To: <20060710073532.GA22573@lug-owl.de>
Content-Disposition: inline
User-Agent: Internet Messaging Program (IMP) 4.0-cvs
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23602>

Quoting Jan-Benedict Glaw <jbglaw@lug-owl.de>:

> Why should we jump through the hoops to support an obsolete standard
> because proprietary compilers don't stand today's standards?

Because we want git to run on such systems, and asking to compile gcc first is
too much to ask for.

There are still missing or broken C99 features in the current gcc:
http://gcc.gnu.org/c99status.html

Why do we want to avoid C99 features broken in gcc?  Because we want users to be
able to compile git with today's gcc, and installing a different compiler
(proprietary or even free) to compile git is too much to ask for.

Maybe if cvsup compiled with gcc, we would be using cvsup backend for git now. 
Or maybe cvsup would develop to take the niche currently occupied by git.  But
cvsup was written in Modula 3, perhaps a superior language compared to C.  You
would have to compile a Modula 3 compiler and a Modula 3 library just to be
able to compile cvsup.  The necessary software was free, but compiling it was
not trivial.  Let's see, where is cvsup now?  How popular is it?

After all, it's a trade-off between ease of coding and ease of installing.  Make
coding too hard, and the developers will go elsewhere.  Make installation too
hard, and the project starts losing users.  And who wants to contribute to an
unpopular project?

Going all the way to strict c89 could be too much, but fixing initializers in a
few places is a minor issue.  Users of the Sun's compiler can expect us to do
such changes, just like users of gcc would ask to fix a program that uses c99
features not yet available in gcc.

--
Regards,
Pavel Roskin
