From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Importing Mozilla CVS into git
Date: Sun, 4 Jun 2006 10:55:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0606041050010.5498@g5.osdl.org>
References: <9e4733910606011521n106f8f24s6c7053ce51e3791e@mail.gmail.com>
 <9e4733910606012100s7ace4721le6fbfbcaadfb6c43@mail.gmail.com>
 <46a038f90606012116t478edacex72a441544f395af4@mail.gmail.com>
 <200606040116.38036.robin.rosenberg.lists@dewire.com>
 <Pine.LNX.4.64.0606031631480.5498@g5.osdl.org> <e5u0o0$3rm$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jun 04 19:56:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FmwpT-00062t-5k
	for gcvg-git@gmane.org; Sun, 04 Jun 2006 19:56:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWFDRzu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 4 Jun 2006 13:55:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750839AbWFDRzu
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Jun 2006 13:55:50 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43955 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750819AbWFDRzt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Jun 2006 13:55:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k54Htk2g002043
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 4 Jun 2006 10:55:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k54Htkdt020730;
	Sun, 4 Jun 2006 10:55:46 -0700
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <e5u0o0$3rm$1@sea.gmane.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.75__
X-MIMEDefang-Filter: osdl$Revision: 1.135 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21271>



On Sun, 4 Jun 2006, Jakub Narebski wrote:
> > 
> > And that shouldn't actually be that hard to do. The most trivial approach 
> > is to have just a pre-trigger on commits, but let's face it, that would 
> > not be a good "full" solution. A better one is to just make the whole
> > "git update-index" thing just have a "automatically ignore CR/LF" mode.
> 
> Why wouldn't it be good solution?

The pre-commit filter thing should work fine, and hey, maybe it's worth 
doing that way. I just worry/think that it will result in tons of noise 
when you do a "git diff" and "git update-index --refresh" on a file that 
has been changed, but then the change reverted.

But I didn't really think it through very deeply, it was just an idle "I 
think the pre-commit hook will fall down when X happens that is a 
non-commit event" thought. I suspect this is one of those things where 
somebody actually working in that kind of environment will figure out what 
the problems are, and what the righ solution is.

> BTW. wouldn't Mercurial encode/decode filters
> 
>   http://www.selenic.com/mercurial/wiki/index.cgi/EncodeDecodeFilter
> 
> be a better solution than modifying files by "git update-index", 
> with all problems it can cause (not detected binary files, text files
> which have to be in CR/LF line ending,...).

Please do realize that the patch I sent out was absolutely _not_ meant to 
be taken seriously. It was more a "somebody could try this in a windows 
environment, and if it works as an approach, we can try to do it right".

I'm absolutely _not_ suggesting merging that patch as-is or even in any 
form very close to it. It clearly needs a config file entry with filename 
patterns etc at a minimum.

		Linus
