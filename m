From: Petr Baudis <pasky@suse.cz>
Subject: Re: gitweb: using quotemeta
Date: Fri, 6 Oct 2006 20:45:37 +0200
Message-ID: <20061006184537.GU20017@pasky.or.cz>
References: <20061006182409.87381.qmail@web31812.mail.mud.yahoo.com> <20061006135019.GN20017@pasky.or.cz> <20061006182105.17519.qmail@web31806.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 06 20:46:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GVuhc-00075Q-Fu
	for gcvg-git@gmane.org; Fri, 06 Oct 2006 20:45:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422835AbWJFSpj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 6 Oct 2006 14:45:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422839AbWJFSpj
	(ORCPT <rfc822;git-outgoing>); Fri, 6 Oct 2006 14:45:39 -0400
Received: from w241.dkm.cz ([62.24.88.241]:52356 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1422835AbWJFSpj (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 6 Oct 2006 14:45:39 -0400
Received: (qmail 31880 invoked by uid 2001); 6 Oct 2006 20:45:37 +0200
To: Luben Tuikov <ltuikov@yahoo.com>
Content-Disposition: inline
In-Reply-To: <20061006182409.87381.qmail@web31812.mail.mud.yahoo.com> <20061006182105.17519.qmail@web31806.mail.mud.yahoo.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28432>

Dear diary, on Fri, Oct 06, 2006 at 08:21:05PM CEST, I got a letter
where Luben Tuikov <ltuikov@yahoo.com> said that...
> > According to RFC2183, the filename is a value. According to RFC2045, a
> > value is either a token (uninteresting) or a quoted-string. According to
> > RFC822:
> > 
> >      quoted-string = <"> *(qtext/quoted-pair) <">; Regular qtext or
> >                                                  ;   quoted chars.
> > 
> >      qtext       =  <any CHAR excepting <">,     ; => may be folded
> >                      "\" & CR, and including
> >                      linear-white-space>
> > 
> >      quoted-pair =  "\" CHAR                     ; may quote any char
> > 
> > So what we emit is completely correct.
> 
> (Your quotations do not seem correct according to 
>   ftp://ftp.rfc-editor.org/in-notes/rfc2045.txt !)

Wow, you caused my GNOME at work to do something totally horrible after
me clicking on that link... ;-)

I'm not sure how is RFC2045 relevant - this is from RFC822, RFC2045 does
not define those non-terminals.

> Petr, I agree with your that what we emit is "completely correct".
> 
> But is is _mangled_.  I.e. why mangle the filename from "a.b" to
> "a\.b" ?  Indeed the latter _is_ qtext but it is not the original name
> given to the file.
..snip..
> Sorry, I ment to say that the latter doesn't appear to be qtext.
> 
> Bottomline is that quotemeta does not convert into qtext, and as thus
> should never have been used.

It's a moot point now, but I don't see that - inside qtext, any
character can be quoted, so what we do is technically ok.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
lK[d2%Sa2/d0$^Ixp"|dc`;s/\W//g;$_=pack('H*',/((..)*)$/)
