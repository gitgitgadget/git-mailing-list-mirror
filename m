From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] gitweb: Convert Content-Disposition filenames into qtext
Date: Sat, 7 Oct 2006 13:46:03 +0200
Message-ID: <20061007114602.GX20017@pasky.or.cz>
References: <20061006192006.GW20017@pasky.or.cz> <20061006193059.21334.qmail@web31807.mail.mud.yahoo.com> <7vk63ctq47.fsf@assigned-by-dhcp.cox.net> <eg7u5n$mt9$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Oct 07 13:46:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GWAde-000807-TQ
	for gcvg-git@gmane.org; Sat, 07 Oct 2006 13:46:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWJGLqI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 7 Oct 2006 07:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750979AbWJGLqH
	(ORCPT <rfc822;git-outgoing>); Sat, 7 Oct 2006 07:46:07 -0400
Received: from w241.dkm.cz ([62.24.88.241]:18064 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1750975AbWJGLqF (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 7 Oct 2006 07:46:05 -0400
Received: (qmail 15972 invoked by uid 2001); 7 Oct 2006 13:46:03 +0200
To: Jakub Narebski <jnareb@gmail.com>
Content-Disposition: inline
In-Reply-To: <eg7u5n$mt9$1@sea.gmane.org>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28475>

Dear diary, on Sat, Oct 07, 2006 at 12:06:31PM CEST, I got a letter
where Jakub Narebski <jnareb@gmail.com> said that...
> >>>> +  $str =~ s/\r/\\r/g;
> >>> 
> >>> \r? Not \n?
> >>
> >> Yes, \r, not \n.
> > 
> > \r to \\r? Not to \\\r?
> 
> We want "\r" in suggested filename, not "\
> " I think, so it is "\\r".

Oh, yes. Lubin wants. It looked sane until I've read it as you
explicitly wrote it. ;-)

That's "obviously" wrong. In qtext, \r means just r, no special
interpretation is done. So we indeed _would_ want "\
". Which is of course a nice trap for buggy browsers so in fact we
obviously do not want that. I think it's not wort the potential problems
to try to carry newlines in the header, so I would just replace that
line with

	$str =~ s/[\n\r]/_/g;

as per Junio's suggestion.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
