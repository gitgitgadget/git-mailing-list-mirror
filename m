From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: remote#branch
Date: Wed, 31 Oct 2007 08:28:36 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0710310816180.30120@woody.linux-foundation.org>
References: <20071030044026.GA9600@thunk.org>
 <alpine.LFD.0.999.0710292150400.30120@woody.linux-foundation.org>
 <20071030053732.GA16963@hermes.priv> <alpine.LFD.0.999.0710300738550.30120@woody.linux-foundation.org>
 <20071030160232.GB2640@hermes.priv> <alpine.LFD.0.999.0710301037120.30120@woody.linux-foundation.org>
 <vpq8x5kh4rr.fsf@bauges.imag.fr> <alpine.LFD.0.999.0710301056070.30120@woody.linux-foundation.org>
 <4727839B.9070205@obry.net> <alpine.LFD.0.999.0710301232000.30120@woody.linux-foundation.org>
 <20071030235823.GA22747@coredump.intra.peff.net> <fg8h9l$b4n$1@ger.gmane.org>
 <85lk9jzsxb.fsf@lola.goethe.zz>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Wed Oct 31 16:32:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InFYp-00080q-Tm
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 16:32:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760921AbXJaP3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 11:29:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760926AbXJaP3U
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 11:29:20 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:50745 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760921AbXJaP3T (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 31 Oct 2007 11:29:19 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9VFSbfN025727
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 31 Oct 2007 08:28:38 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l9VFSaIp009567;
	Wed, 31 Oct 2007 08:28:37 -0700
In-Reply-To: <85lk9jzsxb.fsf@lola.goethe.zz>
X-Spam-Status: No, hits=-2.431 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_66
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62845>



On Wed, 31 Oct 2007, David Kastrup wrote:
> 
> I can click on links in my mail reader, and the above is not recognized
> as one.  <URL:http://host/git repo with spaces in the path> would likely
> work.

I don't think this whole discussion is relevant at all.

Why?

Because we don't care! This is *exactly* why I brought up the whole 
discussion about "interoperability with a web browser", and pointed out 
that there is no such thing *anyway*, since a GIT URL is generally not 
suitable for browsing _regardless_ of any encoding issues!

So it doesn't matter one whit if a mail client recognizes GIT URL's or 
not! Because the mail client cannot do the right thing with them anyway, 
and would generally think that it's something that it should highlight so 
that you can browse it!

Besides, you generally shouldn't use http for git URL's in the first 
place, and they are very much a secondary citizen. Yes, some people use 
them because they have firewall issues, and they *work*, but giving them 
as examples of GIT URL's and discussing them as it they were a big deal is 
just *stupid* when no other - more realistic - git url works that way 
anyway.

This was the whole and only point of my "interoperability" thing. The GIT 
URL's - even when they are perfectly well-formed URL's (which is basically 
100% of the time, since no current git server tends to put things like 
spaces in the path anyway) - are simply in a different "space" than most 
other URL's.

You cannot feed them to a web browser or a file browser anyway, since the 
URL is actually mal-formed (on purpose) in *another* and more fundamental 
way: it doesn't say what the "application domain" is, since it basically 
just assumes that the application domain is git, and the "scheme" part of 
the URL really talks only about the _protocol_, not about the fact that 
it's a git thing.

So if you wanted to be inter-operable, you'd have add the "git" part to 
the scheme, and do the (insane, in my opinion) cogito thing with 
"git+http://xyz.hjashja/" thing!

See? Otherwise no non-git program could understand *anyway* that it's a 
git address, and not meant to be some html thing.

So to summarise:

 - the only way to make git interoperate would be to be user-UNfriendly 
   with stupid markers that no git program really needs or wants, and by 
   making the escaping depend on the form of the GIT URL.

But hey, if people want to screw up git even more, and make the "git+" 
crap also encode the address, I don't care. I would never *ever* use the 
"git+xyz://" forms anyway. They're stupid and useless, but if you want to 
have programs automatically do something magical about git url's, you'd 
need that "git+" thing.

Personally, I think it's a much better idea to just be git-specific. 
Because realistically, nobody is ever going to really be anything else 
anyway. There is nothing you can sanely do with a git link, unless it's 
something very git specific and conscious in the first place!

			Linus
