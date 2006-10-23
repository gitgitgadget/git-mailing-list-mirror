From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] xdiff/xemit.c (xdl_find_func): Elide trailing white space in a context header.
Date: Mon, 23 Oct 2006 23:03:28 +0200
Message-ID: <20061023210327.GT20017@pasky.or.cz>
References: <87y7r63hq6.fsf@rho.meyering.net> <Pine.LNX.4.64.0610231347490.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 23 23:04:24 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Gc6xR-0006YG-R7
	for gcvg-git@gmane.org; Mon, 23 Oct 2006 23:03:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbWJWVDa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Oct 2006 17:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbWJWVDa
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Oct 2006 17:03:30 -0400
Received: from w241.dkm.cz ([62.24.88.241]:3461 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751851AbWJWVD3 (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Oct 2006 17:03:29 -0400
Received: (qmail 24594 invoked by uid 2001); 23 Oct 2006 23:03:28 +0200
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0610231347490.3962@g5.osdl.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29880>

Dear diary, on Mon, Oct 23, 2006 at 10:49:37PM CEST, I got a letter
where Linus Torvalds <torvalds@osdl.org> said that...
> 
> 
> On Mon, 23 Oct 2006, Jim Meyering wrote:
> >
> > This removes trailing blanks from git-generated diff headers
> > the same way a similar patch did that for GNU diff:
> 
> NO!
> 
> This is _wrong_
> 
> You should only remove the space IF IT IS THE ONLY THING ON THE WHOLE 
> LINE!
> 
> You must not remove white-space in general.
> 
> So the patch should check something like
> 
> 	if (len == 1 && rec[0] == ' ')
> 		len = 0;
> 
> and not like you did it.
> 
> Otherwise the patch will simply not even _apply_.

Not really - mind you, this is only about the diff headers. Actually, it
is only about the hunk headers, specifically when we append the function
name to the hunk header. A trailing whitespace can come out of that even
if the source does not have any trailing whitespaces since we trim the
line at 40 bytes.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
